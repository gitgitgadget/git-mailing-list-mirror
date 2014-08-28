From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] merge, pull: stop advising 'commit -a' in case of conflict
Date: Thu, 28 Aug 2014 11:46:58 +0200
Message-ID: <1409219218-9475-1-git-send-email-Matthieu.Moy@imag.fr>
References: <xmqq4mwxeqr7.fsf@gitster.dls.corp.google.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 28 11:47:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMwIZ-0006Di-Ex
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 11:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936290AbaH1JrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 05:47:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54028 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934650AbaH1JrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 05:47:09 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s7S9l2rN006760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Aug 2014 11:47:02 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s7S9l2Fk006418;
	Thu, 28 Aug 2014 11:47:02 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1XMwII-00030a-Hw; Thu, 28 Aug 2014 11:47:02 +0200
X-Mailer: git-send-email 2.0.2.737.gfb43bde
In-Reply-To: <xmqq4mwxeqr7.fsf@gitster.dls.corp.google.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 28 Aug 2014 11:47:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s7S9l2rN006760
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1409824022.99496@yTQoRd0cQ9aS23zGpBliTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256076>

'git commit -a' is rarely a good way to mark conflicts as resolved: the
user anyway has to go manually through the list of conflicts to do the
actual resolution, and it is usually better to use "git add" on each
files after doing the resolution.

On the other hand, using 'git commit -a' is potentially dangerous, as it
makes it very easy to mistakenly commit conflict markers without
noticing.

While we're there, synchronize the 'git pull' and 'git merge' messages:
the first was ending with '...  and make a commit.', but not the later.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
>  - Hasty-and-careless new users will be incorrectly enticed to type
>    the command given by "or use 'git commit -a'" at the end of this
>    advice message without thinking.  Perhaps it is safer to stop the
>    sentence at "... and make a commit." and drop that last bit while
>    there are conflicts still in the working tree files.  We should
>    use the current end-of-message only when all the conflicts have
>    been resolved in the working tree.

It was already on my todo-list, as a friend of mine semi-beginner with
Git complained about the mis-advice the other day, and I had to agree.

Eventually, git could detect that conflicts have been resolved, but
then that would be a different message, as not only "use git commit
-a" could be resurected, but "Fix them up in the work tree" should be
dropped when it is the case.

> I am not doing this myself soon, though.  Hint, hint...

I guess I'm just taking the low hanging fruit here ;-).

 advice.c    | 3 +--
 git-pull.sh | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/advice.c b/advice.c
index 9b42033..3b8bf3c 100644
--- a/advice.c
+++ b/advice.c
@@ -86,8 +86,7 @@ int error_resolve_conflict(const char *me)
 		 * other commands doing a merge do.
 		 */
 		advise(_("Fix them up in the work tree, and then use 'git add/rm <file>'\n"
-			 "as appropriate to mark resolution and make a commit, or use\n"
-			 "'git commit -a'."));
+			 "as appropriate to mark resolution and make a commit."));
 	return -1;
 }
 
diff --git a/git-pull.sh b/git-pull.sh
index 18a394f..4d4fc77 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -20,7 +20,7 @@ die_conflict () {
     if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
 	die "$(gettext "Pull is not possible because you have unmerged files.
 Please, fix them up in the work tree, and then use 'git add/rm <file>'
-as appropriate to mark resolution, or use 'git commit -a'.")"
+as appropriate to mark resolution and make a commit.")"
     else
 	die "$(gettext "Pull is not possible because you have unmerged files.")"
     fi
-- 
2.0.2.737.gfb43bde
