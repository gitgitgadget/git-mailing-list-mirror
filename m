From: Nix <nix@esperi.org.uk>
Subject: [PATCH 2/2] Support sizes >=2G in various config options accepting 'g' sizes.
Date: Mon,  5 Sep 2011 12:45:55 +0100
Message-ID: <1315223155-4218-2-git-send-email-nix@esperi.org.uk>
References: <1315223155-4218-1-git-send-email-nix@esperi.org.uk>
Cc: Nix <nix@esperi.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 13:56:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Xmq-0006Bh-Vw
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 13:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab1IELqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 07:46:30 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:49596 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab1IELqW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 07:46:22 -0400
Received: from esperi.org.uk (nix@mutilate.wkstn.nix [192.168.16.20])
	by mail.esperi.org.uk (8.14.4/8.14.3) with ESMTP id p85BkIcU005664;
	Mon, 5 Sep 2011 12:46:18 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.14.4/8.12.11/Submit) id p85Bk2iJ004253;
	Mon, 5 Sep 2011 12:46:02 +0100
X-Mailer: git-send-email 1.7.6.1.139.gcb612
In-Reply-To: <1315223155-4218-1-git-send-email-nix@esperi.org.uk>
X-DCC-STAT_FI_X86_64_VIRTUAL-Metrics: spindle 1245; Body=3 Fuz1=3 Fuz2=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180738>

The config options core.packedGitWindowSize, core.packedGitLimit,
core.deltaBaseCacheLimit, core.bigFileThreshold, pack.windowMemory and
pack.packSizeLimit all claim to support suffixes up to and including
'g'.  This implies that they should accept sizes >=2G on 64-bit
systems: certainly, specifying a size of 3g should not silently be
translated to zero or transformed into a large negative value due to
integer overflow. However, due to use of git_config_int() rather than
git_config_ulong(), that is exactly what happens:

% git config core.bigFileThreshold 2g
% git gc --aggressive # with extra debugging code to print out
                      # core.bigfilethreshold after parsing
bigfilethreshold: -2147483648
[...]

This is probably irrelevant for core.deltaBaseCacheLimit, but is
problematic for the other values. (It is particularly problematic for
core.packedGitLimit, which can't even be set to its default value in
the config file due to this bug.)

This fixes things for 32-bit platforms as well. They get the usual bad
config error if an overlarge value is specified, e.g.:

fatal: bad config value for 'core.bigfilethreshold' in /home/nix/.gitconfig

32-bit platforms with no type larger than 'long' cannot detect this
case and will continue to silently misbehave, but the misbehaviour
will be somewhat different and more useful, since bigFileThreshold was
also being mistakenly treated as a signed value when it should have
been unsigned.

Signed-off-by: Nick Alcock <nix@esperi.org.uk>
---
 config.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/config.c b/config.c
index 4183f80..b19df66 100644
--- a/config.c
+++ b/config.c
@@ -333,7 +333,7 @@ static int git_parse_file(config_fn_t fn, void *data)
 	die("bad config file line %d in %s", cf->linenr, cf->name);
 }
 
-static int parse_unit_factor(const char *end, unsigned long *val)
+static int parse_unit_factor(const char *end, uintmax_t *val)
 {
 	if (!*end)
 		return 1;
@@ -356,11 +356,14 @@ static int git_parse_long(const char *value, long *ret)
 {
 	if (value && *value) {
 		char *end;
-		long val = strtol(value, &end, 0);
-		unsigned long factor = 1;
+		intmax_t val = strtoimax(value, &end, 0);
+		uintmax_t factor = 1;
 		if (!parse_unit_factor(end, &factor))
 			return 0;
-		*ret = val * factor;
+		val *= factor;
+		if (val > maximum_signed_value_of_type(long))
+			return 0;
+		*ret = val;
 		return 1;
 	}
 	return 0;
@@ -370,9 +373,11 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 {
 	if (value && *value) {
 		char *end;
-		unsigned long val = strtoul(value, &end, 0);
+		uintmax_t val = strtoumax(value, &end, 0);
 		if (!parse_unit_factor(end, &val))
 			return 0;
+		if (val > maximum_unsigned_value_of_type(long))
+			return 0;
 		*ret = val;
 		return 1;
 	}
@@ -391,6 +396,8 @@ int git_config_int(const char *name, const char *value)
 	long ret = 0;
 	if (!git_parse_long(value, &ret))
 		die_bad_config(name);
+	if (ret > maximum_signed_value_of_type(int))
+		die_bad_config(name);
 	return ret;
 }
 
@@ -550,7 +557,7 @@ static int git_default_core_config(const char *var, const char *value)
 
 	if (!strcmp(var, "core.packedgitwindowsize")) {
 		int pgsz_x2 = getpagesize() * 2;
-		packed_git_window_size = git_config_int(var, value);
+		packed_git_window_size = git_config_ulong(var, value);
 
 		/* This value must be multiple of (pagesize * 2) */
 		packed_git_window_size /= pgsz_x2;
@@ -561,18 +568,17 @@ static int git_default_core_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.bigfilethreshold")) {
-		long n = git_config_int(var, value);
-		big_file_threshold = 0 < n ? n : 0;
+		big_file_threshold = git_config_ulong(var, value);
 		return 0;
 	}
 
 	if (!strcmp(var, "core.packedgitlimit")) {
-		packed_git_limit = git_config_int(var, value);
+		packed_git_limit = git_config_ulong(var, value);
 		return 0;
 	}
 
 	if (!strcmp(var, "core.deltabasecachelimit")) {
-		delta_base_cache_limit = git_config_int(var, value);
+		delta_base_cache_limit = git_config_ulong(var, value);
 		return 0;
 	}
 
-- 
1.7.6.1.139.gcb612
