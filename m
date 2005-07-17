From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] rev-parse --sq bugfixes.
Date: Sun, 17 Jul 2005 01:06:15 -0700
Message-ID: <7vslyd3lhk.fsf@assigned-by-dhcp.cox.net>
References: <7vmzol29zm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 10:06:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Du4AN-00032O-Da
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 10:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVGQIGS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 04:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVGQIGS
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 04:06:18 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:35782 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261169AbVGQIGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 04:06:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050717080615.JHFU19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Jul 2005 04:06:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzol29zm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat, 16 Jul 2005 23:59:57 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

We expect --sq output to be used to construct a string to be
"eval"ed in shell scripts, so we should not be separating the
parameter with LF, which would cause the current command to be
ended.

Also there was a silly thinko for doing the shell quoting.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** This is a fix on top of the "git-rev-parse vs IFS" RFC
*** patch.

 rev-parse.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

bf5a2b2f3cd5693560ab72974f9956c76a8fd667
diff --git a/rev-parse.c b/rev-parse.c
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -50,18 +50,6 @@ static int is_rev_argument(const char *a
 	}
 }
 
-static void show_rev(int type, const unsigned char *sha1)
-{
-	if (no_revs)
-		return;
-	output_revs++;
-
-	/* Hexadecimal string plus possibly a carret;
-	 * this does not have to be quoted even under output_sq.
-	 */
-	printf("%s%s\n", type == show_type ? "" : "^", sha1_to_hex(sha1));
-}
-
 static void show(const char *arg)
 {
 	if (output_sq) {
@@ -75,16 +63,31 @@ static void show(const char *arg)
 				fputs(arg, stdout);
 				break;
 			}
+			while (arg < next)
+				putchar(*arg++);
 			fputs("'\\''", stdout);
 			arg = next + 1;
 		}
 		putchar(sq);
-		putchar('\n');
+		putchar(' ');
 	}
 	else
 		puts(arg);
 }
 
+static void show_rev(int type, const unsigned char *sha1)
+{
+	if (no_revs)
+		return;
+	output_revs++;
+
+	/* Hexadecimal string plus possibly a carret;
+	 * this does not have to be quoted even under output_sq.
+	 */
+	printf("%s%s%c", type == show_type ? "" : "^", sha1_to_hex(sha1),
+	       output_sq ? ' ' : '\n');
+}
+
 static void show_rev_arg(char *rev)
 {
 	if (no_revs)
