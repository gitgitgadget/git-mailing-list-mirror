From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree -z HEAD | git-diff-helper -z fails for me
Date: Mon, 23 May 2005 12:07:55 -0700
Message-ID: <7v7jhp3gms.fsf@assigned-by-dhcp.cox.net>
References: <20050523090206.GJ23388@cip.informatik.uni-erlangen.de>
	<7vwtpp6goy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505231119570.2307@ppc970.osdl.org>
	<7vpsvh3hp0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 21:08:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaIGH-000340-I9
	for gcvg-git@gmane.org; Mon, 23 May 2005 21:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVEWTIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 15:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVEWTIM
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 15:08:12 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:26095 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261934AbVEWTH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 15:07:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523190757.SMPG20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 15:07:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vpsvh3hp0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 23 May 2005 11:44:59 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
LT> How about instead making sure that any "extra" text be NUL-terminated and
LT> never start with ':' after a NUL (which will automatically be true, since
LT> it's either "diff-tree " + ascii for the verbose case, or just the tree
LT> name).

JCH> Makes much more sense although it has certain amount of Yuck
JCH> factor ;-).

------------
NUL terminate diff-tree header lines under -z.

Thomas Glanzmann noticed that diff-tree -z HEAD piped to
diff-helper -z did not work.  Since diff-helper -z expects NUL
terminated lines, we should generate such.

The output side of the diff-helper should always be using '\n'
termination; earlier it used the same line_termination used for
the input side, which was a mistake.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Against your head, not my head that already has the
*** rename/copy fix.
*** Only rightly tested with the exact command line Thomas used.

cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff
# - linus: Don't care about st_dev in the index file
# + (working tree)
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -121,7 +121,7 @@ int main(int ac, const char **av) {
 		if (status) {
 		unrecognized:
 			diff_flush(diff_output_style);
-			printf("%s%c", sb1.buf, line_termination);
+			printf("%s\n", sb1.buf);
 		}
 	}
 	if (detect_rename)
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -277,7 +277,18 @@ static int call_diff_flush(void)
 	if (nr_paths)
 		diffcore_pathspec(paths);
 	if (header) {
-		printf("%s", header);
+		if (diff_output_format == DIFF_FORMAT_MACHINE) {
+			const char *ep, *cp;
+			for (cp = header; *cp; cp = ep) {
+				ep = strchr(cp, '\n');
+				if (ep == 0) ep = cp + strlen(cp);
+				printf("%.*s%c", ep-cp, cp, 0);
+				if (*ep) ep++;
+			}
+		}
+		else {
+			printf("%s", header);
+		}
 		header = NULL;
 	}
 	diff_flush(diff_output_format);


