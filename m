From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Better errors when trying to merge a submodule
Date: Mon, 10 Dec 2007 11:22:05 -0800
Message-ID: <7vsl2al5ia.fsf@gitster.siamese.dyndns.org>
References: <20071210124435.GA4788@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 20:22:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1oD9-0002C1-Bm
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 20:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbXLJTWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 14:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbXLJTWP
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 14:22:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbXLJTWP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 14:22:15 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CF953369E;
	Mon, 10 Dec 2007 14:22:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A3E93694;
	Mon, 10 Dec 2007 14:22:08 -0500 (EST)
In-Reply-To: <20071210124435.GA4788@pvv.org> (Finn Arne Gangstad's message of
	"Mon, 10 Dec 2007 13:44:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67746>

Finn Arne Gangstad <finnag@pvv.org> writes:

> Instead of dying with weird errors when trying to merge submodules from a
> supermodule, emit errors that show what the problem is.

Thanks.

Your change to merge-one-file.sh is Ok, although I'd reword the message
a bit, and fold it as a new case arm to the existing case statement
immediately above.

Your change to merge-recursive is not quite right, although you spotted
correctly what codepath needs to be fixed.  merge_file() should not die
in such a case but set result.clean to 0 to signal that the result has
conflicts and cannot be merged, pick the sha1 from the current tree
(i.e. side A), and let the caller deal with the conflict.  If you die
there, the user cannot resolve a merge if this happens while building a
virtual ancestor commit during a recursive merge of two crisscrossing
histories.

Perhaps something like this...

-- >8 --
Support a merge with conflicting gitlink change

merge-recursive did not support merging trees that have conflicting
changes in submodules they contain, and died.  Support it exactly the
same way as how it handles conflicting symbolic link changes --- mark it
as a conflict, take the tentative result from the current side, and
letting the caller resolve the conflict, without dying in merge_file()
function.

Also reword the error message issued when merge_file() has to die
because it sees a tree entry of type it does not support yet.

---

 git-merge-one-file.sh |    4 ++++
 merge-recursive.c     |   10 ++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 1e7727d..9ee3f80 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -80,6 +80,10 @@ case "${1:-.}${2:-.}${3:-.}" in
 		echo "ERROR: $4: Not merging symbolic link changes."
 		exit 1
 		;;
+	*,160000,*)
+		echo "ERROR: $4: Not merging conflicting submodule changes."
+		exit 1
+		;;
 	esac
 
 	src2=`git-unpack-file $3`
diff --git a/merge-recursive.c b/merge-recursive.c
index 9a1e2f2..2a58dad 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1046,14 +1046,16 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
 
 			free(result_buf.ptr);
 			result.clean = (merge_status == 0);
-		} else {
-			if (!(S_ISLNK(a->mode) || S_ISLNK(b->mode)))
-				die("cannot merge modes?");
-
+		} else if (S_ISGITLINK(a->mode)) {
+			result.clean = 0;
+			hashcpy(result.sha, a->sha1);
+		} else if (S_ISLNK(a->mode)) {
 			hashcpy(result.sha, a->sha1);
 
 			if (!sha_eq(a->sha1, b->sha1))
 				result.clean = 0;
+		} else {
+			die("unsupported object type in the tree");
 		}
 	}
 
