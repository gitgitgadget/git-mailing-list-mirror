From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] errors: "strict subset" -> "ancestor"
Date: Sun, 4 Nov 2007 16:59:47 -0500
Message-ID: <20071104215947.GB22762@fieldses.org>
References: <20071103023944.GA15379@fieldses.org> <A4169B7B-C05B-4CA0-B41B-E1E2D71491B6@zib.de> <ee77f5c20711030014x23ac6206rec81fe5968992147@mail.gmail.com> <2B1935E5-C490-4EB4-9BE6-0DD7F33FFE36@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 23:00:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IonWF-0005Sq-1D
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 23:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbXKDV77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 16:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbXKDV76
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 16:59:58 -0500
Received: from mail.fieldses.org ([66.93.2.214]:45006 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbXKDV75 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 16:59:57 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IonVT-0007Mn-Hz; Sun, 04 Nov 2007 16:59:47 -0500
Content-Disposition: inline
In-Reply-To: <2B1935E5-C490-4EB4-9BE6-0DD7F33FFE36@zib.de>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63449>

From: J. Bruce Fields <bfields@citi.umich.edu>

The term "ancestor" is a bit more intuitive (and more consistent with
the documentation) than the term "strict subset".

Also, remove superfluous "ref", and capitalize, changing:

	error: remote 'refs/heads/master' is not a strict subset of local ref 'refs/heads/master'. maybe you are not up-to-date and need to pull first?
	error: failed to push to 'ssh://linux-nfs.org/~bfields/exports/git.git'

to:

	error: remote 'refs/heads/master' is not an ancestor of
	 local 'refs/heads/master'.
	 Maybe you are not up-to-date and need to pull first?
	error: failed to push to 'ssh://linux-nfs.org/~bfields/exports/git.git'

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 builtin-branch.c |    2 +-
 http-push.c      |    8 ++++----
 send-pack.c      |    6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

On Sat, Nov 03, 2007 at 08:24:29AM +0100, Steffen Prohaska wrote:
> They are not aligned. The second line is indented with one
> space. Look at examples in the commit message. The first line
> starts with "error:", which already destroys the alignment.

Yup, I think that's exactly what happened--I said "hey, maybe I should
try aligning this and see what it looks like?", then saw the problem,
then forgot to revert the extra space from everywhere.... Thanks for
noticing.  Here's an updated patch.--b.

diff --git a/builtin-branch.c b/builtin-branch.c
index 3da8b55..e8de27e 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -142,7 +142,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 
 		if (!force &&
 		    !in_merge_bases(rev, &head_rev, 1)) {
-			error("The branch '%s' is not a strict subset of "
+			error("The branch '%s' is not an ancestor of "
 				"your current HEAD.\n"
 				"If you are sure you want to delete it, "
 				"run 'git branch -D %s'.", argv[i], argv[i]);
diff --git a/http-push.c b/http-push.c
index c02a3af..5960d7c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2241,7 +2241,7 @@ static int delete_remote_branch(char *pattern, int force)
 
 		/* Remote branch must be an ancestor of remote HEAD */
 		if (!verify_merge_base(head_sha1, remote_ref->old_sha1)) {
-			return error("The branch '%s' is not a strict subset of your current HEAD.\nIf you are sure you want to delete it, run:\n\t'git http-push -D %s %s'", remote_ref->name, remote->url, pattern);
+			return error("The branch '%s' is not an ancestor of your current HEAD.\nIf you are sure you want to delete it, run:\n\t'git http-push -D %s %s'", remote_ref->name, remote->url, pattern);
 		}
 	}
 
@@ -2424,9 +2424,9 @@ int main(int argc, char **argv)
 				 * commits at the remote end and likely
 				 * we were not up to date to begin with.
 				 */
-				error("remote '%s' is not a strict "
-				      "subset of local ref '%s'. "
-				      "maybe you are not up-to-date and "
+				error("remote '%s' is not an ancestor of\n"
+				      " local '%s'.\n"
+				      " Maybe you are not up-to-date and "
 				      "need to pull first?",
 				      ref->name,
 				      ref->peer_ref->name);
diff --git a/send-pack.c b/send-pack.c
index 5e127a1..fbf2462 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -297,9 +297,9 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 				 * commits at the remote end and likely
 				 * we were not up to date to begin with.
 				 */
-				error("remote '%s' is not a strict "
-				      "subset of local ref '%s'. "
-				      "maybe you are not up-to-date and "
+				error("remote '%s' is not an ancestor of\n"
+				      " local '%s'.\n"
+				      " Maybe you are not up-to-date and "
 				      "need to pull first?",
 				      ref->name,
 				      ref->peer_ref->name);
-- 
1.5.3.5.475.g477d-dirty
