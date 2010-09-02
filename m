From: Nick <oinksocket@letterboxes.org>
Subject: cherry-picking a commit clobbers a file which is a directory in the
 target commit
Date: Thu, 02 Sep 2010 17:17:43 +0100
Message-ID: <4C7FCE27.7000500@letterboxes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 18:54:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrD3T-0004XP-Kp
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 18:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015Ab0IBQyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 12:54:21 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:36946 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab0IBQyU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 12:54:20 -0400
X-Greylist: delayed 2208 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Sep 2010 12:54:20 EDT
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.102])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <oinksocket@letterboxes.org>)
	id 1OrCTj-0007Fy-Tw
	for git@vger.kernel.org; Thu, 02 Sep 2010 17:17:31 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100713 Lightning/1.0b1 Thunderbird/3.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155147>

This was seen on git version 1.7.0.4 on Ubuntu Lucid.

Basically, cherry-picking a commit from a branch where a file in the current
branch has been replaced by a directory, git clobbers the file and the
cherry-pick fails reporting conflicts.

To replicate:

   $ mkdir clobber
   $ cd clobber/
   $ git init
   $ touch sausage
   $ git add sausage
   $ git commit -m "added sausage"
   $ git checkout -b branch1
   $ mv sausage sausage1
   $ mkdir sausage
   $ mv sausage1 sausage/roll
   $ git add sausage/roll
   $ git commit -m "renamed sausage as sausage/roll"
   $ touch falafel
   $ git add falafel
   $ git commit -m "added falafel"
   $ git checkout master

Now if you try to cherry pick the commit just added to branch1 onto master:

    $ git cherry-pick branch1
    Automatic cherry-pick failed.  After resolving the conflicts,
    mark the corrected paths with 'git add <paths>' or 'git rm <paths>'
    and commit the result with:

            git commit -c branch1

    $ git status
    # On branch master
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #       renamed:    sausage -> falafel
    #
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       sausage~HEAD

Not what I expected at all. I'd not expect the file 'sausage' to be modified,
just the new file 'falafel' added, as I did in the original commit.

I know I can recover from this by moving sausage~HEAD back to sausage, or delete
it and check out sausage again, but I suspect it just shouldn't happen at all.


Is this a bug?

N
