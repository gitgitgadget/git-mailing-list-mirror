From: linux@horizon.com
Subject: Re: [PATCH 1/7] Remove ranges from switch statements.
Date: 19 Jun 2006 05:17:24 -0400
Message-ID: <20060619091724.23377.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Mon Jun 19 11:17:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsFsv-0003cM-8L
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 11:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWFSJRZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 05:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWFSJRZ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 05:17:25 -0400
Received: from science.horizon.com ([192.35.100.1]:54327 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751260AbWFSJRZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 05:17:25 -0400
Received: (qmail 23378 invoked by uid 1000); 19 Jun 2006 05:17:24 -0400
To: git@vger.kernel.org, octo@verplant.org, tihirvon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22123>

> Yes, but isalnum(ch) even better ;)

And if you want to get fancy, there's plenty of room in git's sane_ctype
array for an additional punctuation bit to catch the [./-] cases.

Note also that technically the set of unreserved characters in URIs
(according to rfc2396 section 2.3) is

      unreserved  = alphanum | mark

      mark        = "-" | "_" | "." | "!" | "~" | "*" | "'" | "(" | ")"

The complementary set of characters that should be quoted is defined as well:

(2.2)
   Many URI include components consisting of or delimited by, certain
   special characters.  These characters are called "reserved", since
   their usage within the URI component is limited to their reserved
   purpose.  If the data for a URI component would conflict with the
   reserved purpose, then the conflicting data must be escaped before
   forming the URI.

   reserved = ";" | "/" | "?" | ":" | "@" | "&" | "=" | "+" |
                    "$" | ","

(2.4.3)
   The angle-bracket "<" and ">" and double-quote (") characters are
   excluded because they are often used as the delimiters around URI in
   text documents and protocol fields.  The character "#" is excluded
   because it is used to delimit a URI from a fragment identifier in URI
   references (Section 4). The percent character "%" is excluded because
   it is used for the encoding of escaped characters.

   delims      = "<" | ">" | "#" | "%" | <">

   Other characters are excluded because gateways and other transport
   agents are known to sometimes modify such characters, or they are
   used as delimiters.

   unwise      = "{" | "}" | "|" | "\" | "^" | "[" | "]" | "`"

E.g. (the following change is placed in the public domain):

diff --git a/ctype.c b/ctype.c
index 56bdffa..01724d1 100644
--- a/ctype.c
+++ b/ctype.c
@@ -8,16 +8,17 @@ #include "cache.h"
 #define SS GIT_SPACE
 #define AA GIT_ALPHA
 #define DD GIT_DIGIT
+#define MM GIT_URIMARK	/* Legal URI "marks", RFC2396 section 2.3, plus / */
 
 unsigned char sane_ctype[256] = {
 	 0,  0,  0,  0,  0,  0,  0,  0,  0, SS, SS,  0,  0, SS,  0,  0,		/* 0-15 */
 	 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,		/* 16-15 */
-	SS,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,		/* 32-15 */
+	SS, MM,  0,  0,  0,  0,  0, MM, MM, MM, MM,  0,  0, MM, MM, MM,		/* 32-15 */
 	DD, DD, DD, DD, DD, DD, DD, DD, DD, DD,  0,  0,  0,  0,  0,  0,		/* 48-15 */
 	 0, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 64-15 */
-	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,  0,  0,  0,  0,  0,		/* 80-15 */
+	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,  0,  0,  0,  0, MM,		/* 80-15 */
 	 0, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 96-15 */
-	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,  0,  0,  0,  0,  0,		/* 112-15 */
+	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,  0,  0,  0, MM,  0,		/* 112-15 */
 	/* Nothing in the 128.. range */
 };
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 5d543d2..7b4feae 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -138,11 +138,14 @@ extern unsigned char sane_ctype[256];
 #define GIT_SPACE 0x01
 #define GIT_DIGIT 0x02
 #define GIT_ALPHA 0x04
+#define GIT_URIMARK 0x08
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
 #define isspace(x) sane_istest(x,GIT_SPACE)
 #define isdigit(x) sane_istest(x,GIT_DIGIT)
 #define isalpha(x) sane_istest(x,GIT_ALPHA)
 #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
+/* Git extension - is character okay in URI (rfc2396, section 2.3), plus / */
+#define isuri(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT | GIT_URIMARK)
 #define tolower(x) sane_case((unsigned char)(x), 0x20)
 #define toupper(x) sane_case((unsigned char)(x), 0)
 
