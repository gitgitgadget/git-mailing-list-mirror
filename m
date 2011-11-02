From: Nick Alcock <nix@esperi.org.uk>
Subject: [PATCH 2/2] Support sizes >=2G in various config options accepting 'g' sizes.
Date: Wed,  2 Nov 2011 15:46:23 +0000
Message-ID: <1320248783-29577-3-git-send-email-nix@esperi.org.uk>
References: <1320248783-29577-1-git-send-email-nix@esperi.org.uk>
Cc: Nick Alcock <nix@esperi.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 17:25:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLdcu-0003qy-FC
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 17:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933398Ab1KBQZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 12:25:11 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:42917 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932431Ab1KBQZH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 12:25:07 -0400
X-Greylist: delayed 2294 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Nov 2011 12:25:03 EDT
Received: from esperi.org.uk (compiler@spindle.srvr.nix [192.168.14.15])
	by mail.esperi.org.uk (8.14.5/8.14.5) with ESMTP id pA2Fkrf1032584;
	Wed, 2 Nov 2011 15:46:53 GMT
Received: (from compiler@localhost)
	by esperi.org.uk (8.14.5/8.14.5/Submit) id pA2FkrBW029633;
	Wed, 2 Nov 2011 15:46:53 GMT
X-Mailer: git-send-email 1.7.6.1.138.g03ab.dirty
In-Reply-To: <1320248783-29577-1-git-send-email-nix@esperi.org.uk>
X-DCC-URT-Metrics: spindle 1060; Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184643>

The config options core.packedGitWindowSize, core.packedGitLimit,
core.deltaBaseCacheLimit, core.bigFileThreshold, pack.windowMemory and
pack.packSizeLimit all claim to support suffixes up to and including
'g'.  This implies that they should accept sizes >=2G on 64-bit
systems: certainly, specifying a size of 3g should not silently be
translated to zero or transformed into a large negative value due to
integer overflow.  However, due to use of git_config_int() rather than
git_config_ulong(), that is exactly what happens:

% git config core.bigFileThreshold 2g
% git gc --aggressive # with extra debugging code to print out
                      # core.bigfilethreshold after parsing
bigfilethreshold: -2147483648
[...]

This is probably irrelevant for core.deltaBaseCacheLimit, but is
problematic for the other values.  (It is particularly problematic for
core.packedGitLimit, which can't even be set to its default value in
the config file due to this bug.)

This fixes things for 32-bit platforms as well.  They get the usual bad
config error if an overlarge value is specified, e.g.:

fatal: bad config value for 'core.bigfilethreshold' in /home/nix/.gitconfig

This is detected in all cases, even if the 32-bit platform has no size
larger than 'long'.  For signed integral configuration values, we also
detect the case where the value is too large for the signed type but
not the unsigned type.

Signed-off-by: Nick Alcock <nix@esperi.org.uk>
---
 config.c |   41 +++++++++++++++++++++++++++++++----------
 1 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/config.c b/config.c
index edf9914..84ca156 100644
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
@@ -356,11 +356,23 @@ static int git_parse_long(const char *value, long *ret)
 {
 	if (value && *value) {
 		char *end;
-		long val = strtol(value, &end, 0);
-		unsigned long factor = 1;
+		intmax_t val;
+		uintmax_t uval;
+		uintmax_t factor = 1;
+
+		errno = 0;
+		val = strtoimax(value, &end, 0);
+		if (errno == ERANGE)
+			return 0;
 		if (!parse_unit_factor(end, &factor))
 			return 0;
-		*ret = val * factor;
+		uval = abs(val);
+		uval *= factor;
+		if ((uval > maximum_signed_value_of_type(long)) ||
+		    (abs(val) > uval))
+			return 0;
+		val *= factor;
+		*ret = val;
 		return 1;
 	}
 	return 0;
@@ -370,9 +382,19 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 {
 	if (value && *value) {
 		char *end;
-		unsigned long val = strtoul(value, &end, 0);
+		uintmax_t val;
+		uintmax_t oldval;
+
+		errno = 0;
+		val = strtoumax(value, &end, 0);
+		if (errno == ERANGE)
+			return 0;
+		oldval = val;
 		if (!parse_unit_factor(end, &val))
 			return 0;
+		if ((val > maximum_unsigned_value_of_type(long)) ||
+		    (oldval > val))
+			return 0;
 		*ret = val;
 		return 1;
 	}
@@ -553,7 +575,7 @@ static int git_default_core_config(const char *var, const char *value)
 
 	if (!strcmp(var, "core.packedgitwindowsize")) {
 		int pgsz_x2 = getpagesize() * 2;
-		packed_git_window_size = git_config_int(var, value);
+		packed_git_window_size = git_config_ulong(var, value);
 
 		/* This value must be multiple of (pagesize * 2) */
 		packed_git_window_size /= pgsz_x2;
@@ -564,18 +586,17 @@ static int git_default_core_config(const char *var, const char *value)
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
1.7.6.1.138.g03ab.dirty
