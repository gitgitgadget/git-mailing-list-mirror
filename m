From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] ls-tree: --name-only
Date: Thu, 01 Dec 2005 14:56:41 -0800
Message-ID: <7v8xv4ctp2.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net>
	<20051201085433.GA7866@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0512011022520.3099@g5.osdl.org>
	<7vlkz4friv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512011354500.3099@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 23:59:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhxMf-0003O3-Hl
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 23:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVLAW4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 17:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVLAW4n
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 17:56:43 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:28115 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932541AbVLAW4n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 17:56:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201225558.WHFD6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 17:55:58 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512011354500.3099@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 1 Dec 2005 13:57:29 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13086>

Fingers of some "git diff" users are trained to do --name-only
which git-ls-tree unfortunately does not take.  With this,

	cd sub/directory && git-ls-tree -r --name-only HEAD -- ..

would show only the paths but not object names nor modes.  I
threw in another synonym --name-status only for usability, but
obviously ls-tree does not do any comparison so what it does is
the same as --name-only.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

  Linus Torvalds <torvalds@osdl.org> writes:

  > That brings up another issue. I typed
  >
  > 	git-ls-tree -r --name-only ..
  >
  > and it obviously didn't work. That's kind of sad. I use that quite a lot 
  > for "git diff", for example, because quite often I want to see the files, 
  > but I don't care about anything else.

 ls-tree.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

c639a5548a5d8414b55202592885449f66ee2f33
diff --git a/ls-tree.c b/ls-tree.c
index 07db863..dae377d 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -12,11 +12,12 @@ static int line_termination = '\n';
 #define LS_RECURSIVE 1
 #define LS_TREE_ONLY 2
 #define LS_SHOW_TREES 4
+#define LS_NAME_ONLY 8
 static int ls_options = 0;
 const char **pathspec;
 
 static const char ls_tree_usage[] =
-	"git-ls-tree [-d] [-r] [-t] [-z] <tree-ish> [path...]";
+	"git-ls-tree [-d] [-r] [-t] [-z] [--name-only] [--name-status] <tree-ish> [path...]";
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
@@ -64,7 +65,8 @@ static int show_tree(unsigned char *sha1
 	else if (ls_options & LS_TREE_ONLY)
 		return 0;
 
-	printf("%06o %s %s\t", mode, type, sha1_to_hex(sha1));
+	if (!(ls_options & LS_NAME_ONLY))
+		printf("%06o %s %s\t", mode, type, sha1_to_hex(sha1));
 	write_name_quoted(base, baselen, pathname, line_termination, stdout);
 	putchar(line_termination);
 	return retval;
@@ -92,6 +94,13 @@ int main(int argc, const char **argv)
 		case 't':
 			ls_options |= LS_SHOW_TREES;
 			break;
+		case '-':
+			if (!strcmp(argv[1]+2, "name-only") ||
+			    !strcmp(argv[1]+2, "name-status")) {
+				ls_options |= LS_NAME_ONLY;
+				break;
+			}
+			/* otherwise fallthru */
 		default:
 			usage(ls_tree_usage);
 		}
-- 
0.99.9.GIT
