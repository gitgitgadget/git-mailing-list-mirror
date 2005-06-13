From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Support commit_format fully in diff-tree
Date: Sun, 12 Jun 2005 17:44:21 -0700
Message-ID: <7vslzngk62.fsf@assigned-by-dhcp.cox.net>
References: <20050612093413.GR20432@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 02:40:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dhd00-0005gp-7U
	for gcvg-git@gmane.org; Mon, 13 Jun 2005 02:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVFMAov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 20:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVFMAoe
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 20:44:34 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:9199 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261297AbVFMAoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2005 20:44:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050613004421.QWGG8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Jun 2005 20:44:21 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050612093413.GR20432@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Sun, 12 Jun 2005 11:34:13 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

TG> Hello,
TG> what option to I have to tweak to get timestamps human understandable
TG> again:

TG> git-whatchanged | head -5

------------
This steals --pretty command line option from rev-list and
teaches diff-tree to do the same.  With this change,

    $ git-whatchanged --pretty

would work as expected.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Sorry, but this patch does not include documentation updates
*** or additional tests like my usual ones.  I would appreciate
*** it if others on the list give help with them.  I will be
*** offline for about a week or so, and trying to clean my stack
*** as much as possible before I have to leave.

cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff : diff-tree.c
# - linus: git-apply: ignore empty git headers
# + (working tree)
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -398,7 +398,20 @@ static int diff_tree_stdin(char *line)
 }
 
 static char *diff_tree_usage =
-"git-diff-tree [-p] [-r] [-z] [--stdin] [-M] [-C] [-R] [-S<string>] [-O<orderfile>] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish>";
+"git-diff-tree [-p] [-r] [-z] [--stdin] [-M] [-C] [-R] [-S<string>] [-O<orderfile>] [-m] [-s] [-v] [--pretty] [-t] <tree-ish> <tree-ish>";
+
+static enum cmit_fmt get_commit_format(const char *arg)
+{
+	if (!*arg)
+		return CMIT_FMT_DEFAULT;
+	if (!strcmp(arg, "=raw"))
+		return CMIT_FMT_RAW;
+	if (!strcmp(arg, "=medium"))
+		return CMIT_FMT_MEDIUM;
+	if (!strcmp(arg, "=short"))
+		return CMIT_FMT_SHORT;
+	usage(diff_tree_usage);
+}
 
 int main(int argc, const char **argv)
 {
@@ -492,6 +505,11 @@ int main(int argc, const char **argv)
 			header_prefix = "diff-tree ";
 			continue;
 		}
+		if (!strncmp(arg, "--pretty", 8)) {
+			verbose_header = 1;
+			commit_format = get_commit_format(arg+8);
+			continue;
+		}
 		if (!strcmp(arg, "--stdin")) {
 			read_stdin = 1;
 			continue;

Compilation finished at Sun Jun 12 17:39:24

