From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v2] git-rebase-interactive: do not squash commits on abort
Date: Wed, 10 Sep 2008 00:50:36 +0400
Message-ID: <20080909205036.GD28210@dpotapov.dyndns.org>
References: <1220906569-26878-1-git-send-email-dpotapov@gmail.com> <7v7i9mdvyr.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0809091616200.13830@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 22:52:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdABj-0004Kl-T9
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 22:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbYIIUuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 16:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753303AbYIIUuo
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 16:50:44 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:59860 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbYIIUuo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 16:50:44 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1230911yxm.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+6Sfx0DhCEyEwTawplqmwElxN8BtfeW46kUKQru8OMQ=;
        b=pLiEuD0SH2hJxmbCk1kYo+zH4ehG0BSLQ7D/8Sx+m8WReWr8osfkj9HwZWYcORmsAN
         6NWcm5dJ0X7HZqZLA6M5kYjPazgqVVwbb8BcrevFR8skJOHVWJYyrk6UwWOmkjfawfeR
         G/bPpG0REExLEMqSniRJWMQV0hc7/FVPbQDqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nYYOLiPVO3fXTJUMJNV4RcBjBh9ruTllGJ5MtzLc4s2drXXHpxeTo44bz+x4k4sW/e
         qDu7esha8huCIYKcyuSYfXgkG6fBVyNGPRRVOnRRzx38voCuhxwKrompf4t7NtHAG/nM
         bzwBzxzqYGoT1e651rR3j3Jpo38Vvax9BTcus=
Received: by 10.86.71.1 with SMTP id t1mr276424fga.36.1220993440957;
        Tue, 09 Sep 2008 13:50:40 -0700 (PDT)
Received: from localhost ( [85.141.189.164])
        by mx.google.com with ESMTPS id 4sm7501247fgg.4.2008.09.09.13.50.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 13:50:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0809091616200.13830@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95429>

If git rebase interactive is stopped by "edit" command and then the user
said "git rebase --continue" while having some stage changes, git rebase
interactive is trying to amend the last commit by doing:
  git --soft reset && git commit

However, the user can abort commit for some reason by providing an empty
log message, and that would leave the last commit undone, while the user
being completely unaware about what happened. Now if the user tries to
continue, by issuing "git rebase --continue" that squashes two previous
commits.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

On Tue, Sep 09, 2008 at 04:17:36PM +0200, Johannes Schindelin wrote:
>_
> It might be safer to set the variable "amend" to empty before the "if".

OK. I have added it.

 git-rebase--interactive.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 929d681..aaca915 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -427,14 +427,18 @@ do
 		else
 			. "$DOTEST"/author-script ||
 				die "Cannot find the author identity"
+			amend=""
 			if test -f "$DOTEST"/amend
 			then
+				amend=$(git rev-parse --verify HEAD)
 				git reset --soft HEAD^ ||
 				die "Cannot rewind the HEAD"
 			fi
 			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
-			git commit --no-verify -F "$DOTEST"/message -e ||
-			die "Could not commit staged changes."
+			git commit --no-verify -F "$DOTEST"/message -e || {
+				test -n "$amend" && git reset --soft $amend
+				die "Could not commit staged changes."
+			}
 		fi
 
 		require_clean_work_tree
-- 
1.6.0
