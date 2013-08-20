From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] teach git-config to output large integers
Date: Tue, 20 Aug 2013 18:47:10 -0400
Message-ID: <20130820224710.GB24766@sigill.intra.peff.net>
References: <20130820223953.GA3429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 00:47:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBuht-0006z5-Da
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 00:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773Ab3HTWrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 18:47:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:41092 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750Ab3HTWrO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 18:47:14 -0400
Received: (qmail 13732 invoked by uid 102); 20 Aug 2013 22:47:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 17:47:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 18:47:10 -0400
Content-Disposition: inline
In-Reply-To: <20130820223953.GA3429@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232663>

Internally we use "unsigned long" to represent large config
values like packed window memory sizes, packfile size
limits, etc.  On 32-bit systems, this limits these config
options to 4G (and we detect and complain about overflow).
On 64-bit systems, they get the full 64-bit range.

However, there is no way for script callers of git-config to
see the numeric values (they cannot treat them as pure
strings, since they would want git-config to process "3g"
into "3221225472").

This patch teaches git-config a "--ulong" type that can
output these unsigned long values, allowing scripts to
examine the values as the internal code would.

Signed-off-by: Jeff King <peff@peff.net>
---
I kind of hate the name "--ulong". I wanted to call it "--size" or
something and abstract away the actual platform representation, and just
make it "big enough for file sizes". But internally, the git options
for dealing with such things use "unsigned long". We could change that
(we are limiting sizes to 4GB on 32-bit systems, while most modern
32-bit systems can handle >4GB files), but I don't know if anybody
actually cares, and it would be a lot of error-prone work (we have to
change the type to off_t or similar, but then try to handle all of the
fallout throughout the code where we use "unsigned long").

So rather than try for something abstract, I tried to keep it to what
git does internally, which works pretty well in practice. As with --int,
you'll get an error if you try to use too large an integer.

 Documentation/git-config.txt | 6 ++++++
 builtin/config.c             | 8 ++++++++
 t/t1300-repo-config.sh       | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 2dbe486..a8b6626 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -165,6 +165,12 @@ See also <<FILES>>.
 	'git config' will ensure that the output matches the format of
 	either --bool or --int, as described above.
 
+--ulong::
+	As with `--int`, 'git config' will ensure that the output is a
+	simple decimal number, and will respect value suffixes. Unlike
+	`--int`, the range of acceptable integers will be non-negative
+	and go higher (depending on your platform, but at least 2^32-1).
+
 --path::
 	'git-config' will expand leading '{tilde}' to the value of
 	'$HOME', and '{tilde}user' to the home directory for the
diff --git a/builtin/config.c b/builtin/config.c
index 4010c43..f7a46bf 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -47,6 +47,7 @@ static int respect_includes = -1;
 #define TYPE_INT (1<<1)
 #define TYPE_BOOL_OR_INT (1<<2)
 #define TYPE_PATH (1<<3)
+#define TYPE_ULONG (1<<4)
 
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
@@ -73,6 +74,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "bool", &types, N_("value is \"true\" or \"false\""), TYPE_BOOL),
 	OPT_BIT(0, "int", &types, N_("value is decimal number"), TYPE_INT),
 	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
+	OPT_BIT(0, "ulong", &types, N_("value is large unsigned decimal number"), TYPE_ULONG),
 	OPT_BIT(0, "path", &types, N_("value is a path (file or directory name)"), TYPE_PATH),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOLEAN('z', "null", &end_null, N_("terminate values with NUL byte")),
@@ -129,6 +131,8 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 	}
 	if (types == TYPE_INT)
 		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
+	else if (types == TYPE_ULONG)
+		sprintf(value, "%lu", git_config_ulong(key_, value_ ? value_ : ""));
 	else if (types == TYPE_BOOL)
 		vptr = git_config_bool(key_, value_) ? "true" : "false";
 	else if (types == TYPE_BOOL_OR_INT) {
@@ -268,6 +272,10 @@ static char *normalize_value(const char *key, const char *value)
 			int v = git_config_int(key, value);
 			sprintf(normalized, "%d", v);
 		}
+		else if (types == TYPE_ULONG)
+			sprintf(normalized, "%lu",
+				git_config_ulong(key, value));
+
 		else if (types == TYPE_BOOL)
 			sprintf(normalized, "%s",
 				git_config_bool(key, value) ? "true" : "false");
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3c5ec4b..f57fb27 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -669,6 +669,13 @@ test_expect_success 'invalid unit' '
 	test_cmp actual expect
 '
 
+test_expect_success 'large numbers via --ulong' '
+	git config big.file 3g &&
+	echo 3221225472 >expect &&
+	git config --ulong big.file >actual &&
+	test_cmp expect actual
+'
+
 cat > expect << EOF
 true
 false
-- 
1.8.4.rc2.28.g6bb5f3f
