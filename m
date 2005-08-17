From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add --symbolic flag to git-rev-parse.
Date: Tue, 16 Aug 2005 22:33:03 -0700
Message-ID: <7v8xz13z74.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Aug 17 07:33:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5GYM-0005Jr-CW
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 07:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVHQFdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 01:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbVHQFdG
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 01:33:06 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:27116 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750856AbVHQFdF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 01:33:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817053304.OSPM550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 01:33:04 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is most useful with --all, --revs-only, --no-flags and --verify.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

    With this, "git-rev-parse --symbolic master pu" would output
    "master pu".  Why would this be useful?  The next one uses it.

 rev-parse.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

c7e32319f6c9338f186b62fe05919f0bc5ae7405
diff --git a/rev-parse.c b/rev-parse.c
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -16,6 +16,7 @@ static int output_revs = 0;
 static int flags_only = 0;
 static int no_flags = 0;
 static int output_sq = 0;
+static int symbolic = 0;
 
 #define NORMAL 0
 #define REVERSED 1
@@ -69,17 +70,18 @@ static void show(const char *arg)
 		puts(arg);
 }
 
-static void show_rev(int type, const unsigned char *sha1)
+static void show_rev(int type, const unsigned char *sha1, const char *name)
 {
 	if (no_revs)
 		return;
 	output_revs++;
 
-	/* Hexadecimal string plus possibly a carret;
-	 * this does not have to be quoted even under output_sq.
-	 */
-	printf("%s%s%c", type == show_type ? "" : "^", sha1_to_hex(sha1),
-	       output_sq ? ' ' : '\n');
+	if (type != show_type)
+		putchar('^');
+	if (symbolic && name)
+		show(name);
+	else
+		show(sha1_to_hex(sha1));
 }
 
 static void show_rev_arg(char *rev)
@@ -117,7 +119,7 @@ static void show_default(void)
 
 		def = NULL;
 		if (!get_sha1(s, sha1)) {
-			show_rev(NORMAL, sha1);
+			show_rev(NORMAL, sha1, s);
 			return;
 		}
 		show_arg(s);
@@ -126,7 +128,7 @@ static void show_default(void)
 
 static int show_reference(const char *refname, const unsigned char *sha1)
 {
-	show_rev(NORMAL, sha1);
+	show_rev(NORMAL, sha1, refname);
 	return 0;
 }
 
@@ -186,6 +188,10 @@ int main(int argc, char **argv)
 				show_type ^= REVERSED;
 				continue;
 			}
+			if (!strcmp(arg, "--symbolic")) {
+				symbolic = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--all")) {
 				for_each_ref(show_reference);
 				continue;
@@ -209,8 +215,8 @@ int main(int argc, char **argv)
 					if (no_revs)
 						continue;
 					def = NULL;
-					show_rev(NORMAL, end);
-					show_rev(REVERSED, sha1);
+					show_rev(NORMAL, end, n);
+					show_rev(REVERSED, sha1, arg);
 					continue;
 				}
 			}
@@ -220,14 +226,14 @@ int main(int argc, char **argv)
 			if (no_revs)
 				continue;
 			def = NULL;
-			show_rev(NORMAL, sha1);
+			show_rev(NORMAL, sha1, arg);
 			continue;
 		}
 		if (*arg == '^' && !get_sha1(arg+1, sha1)) {
 			if (no_revs)
 				continue;
 			def = NULL;
-			show_rev(REVERSED, sha1);
+			show_rev(REVERSED, sha1, arg+1);
 			continue;
 		}
 		show_default();
