From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: git push to a non-bare repository
Date: Sun, 18 Mar 2007 18:31:21 +0100
Message-ID: <vpq648ye9w6.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 18:31:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSzEE-0002ye-Or
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 18:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbXCRRbd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 13:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbXCRRbd
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 13:31:33 -0400
Received: from imag.imag.fr ([129.88.30.1]:50696 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687AbXCRRbc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 13:31:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l2IHVL5Q020113
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 18 Mar 2007 18:31:21 +0100 (CET)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HSzE1-00047R-CD
	for git@vger.kernel.org; Sun, 18 Mar 2007 18:31:21 +0100
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HSzE1-0003pX-7i
	for git@vger.kernel.org; Sun, 18 Mar 2007 18:31:21 +0100
Mail-Followup-To: git <git@vger.kernel.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 18 Mar 2007 18:31:21 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42506>

Hi,

I have a repository with a working tree on a machine A, did a clone to
another machine B and commited there locally.

I want my changes to get back into the first repository, so I did a
"push". The new commit is in the history, I can see it with "git log",
but the modifications are not in the working tree.

This time, it's OK: I didn't have any uncommited modifications on A,
so I just did a "git reset --hard HEAD" there.

But if I had some uncommited changes, "git reset --hard HEAD" means
data loss, which is precisely what I want to avoid by using a VCS. It
seems a solution is to do:

$ git reset --soft <commit-id-before-the-push>
$ git merge <commit-id-after-the-push>

But it means I have to remember <commit-id-before-the-push>.


I don't understand the design choice here: git had two options to
avoid this scenario:

1) update the working tree while doing the push. That's feasible with
   good performance since git is present on the server, but leaves the
   problem of possible conflicts.

2) let git remember what the local tree points to (not just the branch
   name, but the commit id itself, stored in a place that "git push"
   won't modify). Then, provide me a way to "update" to the latest
   revision.

Fyi, bzr does this. Indeed, in bzr, a branch (let's say "repository"
in the git vocabulary) with a working tree just means a working tree
(AKA lightweight checkout) located in the same directory as a branch.
The working tree knows which revision it corresponds to, and where to
find its branch. There's a "bzr update" command to get my working tree
to the head of the branch, keeping the uncommited changes.

I believe this idea is very much linked to the "Lightweight Checkout"
idea (listed on the SoC ideas), since, in the case of multiple working
directories sharing the same .git, you don't want a commit in one tree
to affect the others.

So, did I miss something? Is there anything on the todo-list?

Thanks,

-- 
Matthieu
