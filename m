From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git workflow: Managing topic branches.
Date: Tue, 25 Aug 2009 09:07:37 +0200
Message-ID: <4A938DB9.6030907@viscovery.net>
References: <18071eea0908240744g359f8b1ey622259e89ac7592a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 09:07:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfq8H-0003TX-4M
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 09:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbZHYHHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 03:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753583AbZHYHHj
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 03:07:39 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:54886 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbZHYHHi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 03:07:38 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mfq82-0001Sb-2G; Tue, 25 Aug 2009 09:07:38 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CAF674E4; Tue, 25 Aug 2009 09:07:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <18071eea0908240744g359f8b1ey622259e89ac7592a@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127012>

Thomas Adam schrieb:
> We have a work-flow such as this:
> 
> 
>          o---o---o---o--o--o (stable)
>         /
> o---o---o---o---o---o---o  (master)
>      \
>       o---o--o---o---o---o (featureA)
> 
> 
> Master is where all our stable code lives after a release -- and also where
> bug-fixes for released code is put.  When we're working on a new feature,
> almost all developers here will push (in this case) to "featureA" ---
> eventually this branch will get merged into master, tagged and the code
> released.  Then a new branch, "featureB" is created off it, and process
> continues.  (Yes, we're using Git in a very CVS-like way, alas.)
> 
> Periodically though we need to release updates for our product.  This the
> area which is where my question lies about whether the workflow is good or
> not.  Here's how we do that:
> 
> We have a branch called "stable" which contains all of our released code
> plus any updates release.  When we wish to create a new update, we create a
> new branch off the tip of stable:
> 
> 
>                             o---o---o---o (updateN)
>                            /
>          o---o---o---o--o--o (stable)
>         /
> o---o---o---o---o---o---o  (master)
>      \
>       o---o--o---o---o---o (featureA)
> 
> 
> Because bug-fixes happen on Master, we now want those fixes to appear on the
> updateN branch so we can create a tarball from them (to release to our
> customers).  We're using "git cherry" to get a list of SHA1s that are
> relevant between updateN and master, as in:
> 
> git cherry updateN master
> 
> ... and then manually deciding (based on it's "+"/"-" output whether that
> SHA1 needs to be used and then:
> 
> git cherry-pick SHA1
> 
> ... onto updateN as appropriate.

Your workflow looks quite reasonable except for this last part. You should
make your history look like this:

          o--o--o--o--o         stable
         /       \     \
--o--B--o--o--o---o--o--o--o    master
      \
       o--o--o--o--o--o         featureA

Instead of cherry-picking commits onto updateN (or stable), your
developers should think which branches need the change that they are about
to commit. If it is a serious bug-fix, then it should be enter the picture
on stable, not on master or feature branches. The important part is that
branch stable is merged into branch master (at least after each release,
but perhaps even more often).

Now assume that your developer discovers a bug while she was developing on
featureA that must go into stable. Previously you would have done it this
way (I presume):

--o--B--o--o--o---o--o--o--o--o    master
     |   \       /     /     /
     |    o--o--o--o--o-----F'     stable
      \
       o--o--o--o--o--o--F         featureA

That is, the fix F was committed on the feature branch and later was
cherry-picked onto stable as F' and then merged into master. But she
should have done this instead:

--o--B--o--o--o---o--o--o--o--o    master
     |   \       /     /     /
     |    o--o--o--o--o-----o      stable
     |\                    /
     | F------------------<        fixF
      \                    \
       o--o--o--o--o--o-----o      featureA

That is, fix F should go on its own bugfix-branch and that branch is
merged into stable as well as into featureA (but only if the fix is really
needed there); stable is in turn merged into master again. The new branch
grows from a commit that is in common to all the branches that need the
fix. Since the fix is needed on featureA as well as on stable, the lastest
possible branch point is B (where feature A was branch off of master/stable).

Side note: An even better branch point would be the commit that introduced
the bug, which must have been B or a commit before it; otherwise the bug
would not have shown up during the development of featureA. This way you
could make the decision anytime later whether you want to merge the fix
into older releases as well.

-- Hannes
