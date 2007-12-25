From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Improve error messages when int/long cannot be parsed from config
Date: Tue, 25 Dec 2007 02:18:05 -0500
Message-ID: <20071225071805.GA13552@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 25 08:18:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J743j-0008Fb-VG
	for gcvg-git-2@gmane.org; Tue, 25 Dec 2007 08:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbXLYHSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Dec 2007 02:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbXLYHSM
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Dec 2007 02:18:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53144 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbXLYHSL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Dec 2007 02:18:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J743C-0005ER-F6; Tue, 25 Dec 2007 02:18:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 21E7120FBAE; Tue, 25 Dec 2007 02:18:05 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69228>

If a config file has become mildly corrupted due to a missing LF
we may discover some other option joined up against the end of a
numeric value.  For example:

	[section]
	number = 1auto

where the "auto" flag was meant to occur on the next line, below
"number", but the missing LF has caused it to no longer be its
own option.  Instead the word "auto" is parsed as a 'unit factor'
for the value of "number".

Before this change we got the confusing error message:

  fatal: unknown unit: 'auto'

which told us nothing about where the problem appeared.  Now we get:

  fatal: bad config value for 'aninvalid.unit'

which at least points the user in the right direction of where to
search for the incorrectly formatted configuration file.

Noticed by erikh on #git, which received the original error from
a simple `git checkout -b` due to a midly corrupted config.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 config.c               |   31 +++++++++++++++++++++----------
 t/t1300-repo-config.sh |   17 +++++++++++++++++
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/config.c b/config.c
index 22ff4ce..fa56c70 100644
--- a/config.c
+++ b/config.c
@@ -234,17 +234,23 @@ static int git_parse_file(config_fn_t fn)
 	die("bad config file line %d in %s", config_linenr, config_file_name);
 }
 
-static unsigned long get_unit_factor(const char *end)
+static int parse_unit_factor(const char *end, unsigned long *val)
 {
 	if (!*end)
 		return 1;
-	else if (!strcasecmp(end, "k"))
-		return 1024;
-	else if (!strcasecmp(end, "m"))
-		return 1024 * 1024;
-	else if (!strcasecmp(end, "g"))
-		return 1024 * 1024 * 1024;
-	die("unknown unit: '%s'", end);
+	else if (!strcasecmp(end, "k")) {
+		*val *= 1024;
+		return 1;
+	}
+	else if (!strcasecmp(end, "m")) {
+		*val *= 1024 * 1024;
+		return 1;
+	}
+	else if (!strcasecmp(end, "g")) {
+		*val *= 1024 * 1024 * 1024;
+		return 1;
+	}
+	return 0;
 }
 
 int git_parse_long(const char *value, long *ret)
@@ -252,7 +258,10 @@ int git_parse_long(const char *value, long *ret)
 	if (value && *value) {
 		char *end;
 		long val = strtol(value, &end, 0);
-		*ret = val * get_unit_factor(end);
+		unsigned long factor = 1;
+		if (!parse_unit_factor(end, &factor))
+			return 0;
+		*ret = val * factor;
 		return 1;
 	}
 	return 0;
@@ -263,7 +272,9 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 	if (value && *value) {
 		char *end;
 		unsigned long val = strtoul(value, &end, 0);
-		*ret = val * get_unit_factor(end);
+		if (!parse_unit_factor(end, &val))
+			return 0;
+		*ret = val;
 		return 1;
 	}
 	return 0;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index e894629..42eac2a 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -448,6 +448,23 @@ test_expect_success numbers '
 	test z1048576 = "z$m"
 '
 
+cat > expect <<EOF
+fatal: bad config value for 'aninvalid.unit' in .git/config
+EOF
+
+test_expect_success 'invalid unit' '
+
+	git config aninvalid.unit "1auto" &&
+	s=$(git config aninvalid.unit) &&
+	test "z1auto" = "z$s" &&
+	if git config --int --get aninvalid.unit 2>actual
+	then
+		echo config should have failed
+		false
+	fi &&
+	cmp actual expect
+'
+
 cat > expect << EOF
 true
 false
-- 
1.5.4.rc1.1119.g1e6bc
