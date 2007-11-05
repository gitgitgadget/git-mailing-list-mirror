From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] parse-options: abbreviation engine fix.
Date: Mon, 5 Nov 2007 13:15:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711051314350.4362@racer.site>
References: <1194264204-3475-1-git-send-email-madcoder@debian.org>
 <1194264204-3475-2-git-send-email-madcoder@debian.org>
 <Pine.LNX.4.64.0711051230020.4362@racer.site> <Pine.LNX.4.64.0711051237420.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 14:16:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip1oZ-0004df-8n
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 14:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854AbXKENQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 08:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbXKENQN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 08:16:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:38233 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750887AbXKENQM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 08:16:12 -0500
Received: (qmail invoked by alias); 05 Nov 2007 13:16:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 05 Nov 2007 14:16:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/WTqc1we/WFjDdhTWuqubQObiw9MCUHCBWFIopT+
	P/LQVRvXornkUx
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711051237420.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63514>


When an option could be an ambiguous abbreviation of two options, the code
used to error out.  Even if an exact match would have occured later.

Test and original patch by Pierre Habouzit.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 parse-options.c          |   33 +++++++++++++++++++++------------
 t/t0040-parse-options.sh |   13 +++++++++++++
 test-parse-options.c     |    1 +
 3 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index cc09c98..15b32f7 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -119,8 +119,8 @@ static int parse_long_opt(struct optparse_t *p, const char *arg,
                           const struct option *options)
 {
 	const char *arg_end = strchr(arg, '=');
-	const struct option *abbrev_option = NULL;
-	int abbrev_flags = 0;
+	const struct option *abbrev_option = NULL, *ambiguous_option = NULL;
+	int abbrev_flags = 0, ambiguous_flags = 0;
 
 	if (!arg_end)
 		arg_end = arg + strlen(arg);
@@ -137,16 +137,16 @@ static int parse_long_opt(struct optparse_t *p, const char *arg,
 			/* abbreviated? */
 			if (!strncmp(options->long_name, arg, arg_end - arg)) {
 is_abbreviated:
-				if (abbrev_option)
-					return error("Ambiguous option: %s "
-						"(could be --%s%s or --%s%s)",
-						arg,
-						(flags & OPT_UNSET) ?
-							"no-" : "",
-						options->long_name,
-						(abbrev_flags & OPT_UNSET) ?
-							"no-" : "",
-						abbrev_option->long_name);
+				if (abbrev_option) {
+					/*
+					 * If this is abbreviated, it is
+					 * ambiguous. So when there is no
+					 * exact match later, we need to
+					 * error out.
+					 */
+					ambiguous_option = abbrev_option;
+					ambiguous_flags = abbrev_flags;
+				}
 				if (!(flags & OPT_UNSET) && *arg_end)
 					p->opt = arg_end + 1;
 				abbrev_option = options;
@@ -176,6 +176,15 @@ is_abbreviated:
 		}
 		return get_value(p, options, flags);
 	}
+
+	if (ambiguous_option)
+		return error("Ambiguous option: %s "
+			"(could be --%s%s or --%s%s)",
+			arg,
+			(ambiguous_flags & OPT_UNSET) ?  "no-" : "",
+			ambiguous_option->long_name,
+			(abbrev_flags & OPT_UNSET) ?  "no-" : "",
+			abbrev_option->long_name);
 	if (abbrev_option)
 		return get_value(p, abbrev_option, abbrev_flags);
 	return error("unknown option `%s'", arg);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ae49424..462fdf2 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -18,6 +18,7 @@ string options
     -s, --string <string>
                           get a string
     --string2 <str>       get another string
+    --st <st>             get another string (pervert ordering)
 
 EOF
 
@@ -90,4 +91,16 @@ test_expect_failure 'ambiguously abbreviated option' '
         test $? != 129
 '
 
+cat > expect << EOF
+boolean: 0
+integer: 0
+string: 123
+EOF
+
+test_expect_success 'non ambiguous option (after two options it abbreviates)' '
+	test-parse-options --st 123 > output 2> output.err &&
+	test ! -s output.err &&
+	git diff expect output
+'
+
 test_done
diff --git a/test-parse-options.c b/test-parse-options.c
index 277cfe4..4d3e2ec 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -18,6 +18,7 @@ int main(int argc, const char **argv)
 		OPT_GROUP("string options"),
 		OPT_STRING('s', "string", &string, "string", "get a string"),
 		OPT_STRING(0, "string2", &string, "str", "get another string"),
+		OPT_STRING(0, "st", &string, "st", "get another string (pervert ordering)"),
 		OPT_END(),
 	};
 	int i;
-- 
1.5.3.5.1549.g91a3
