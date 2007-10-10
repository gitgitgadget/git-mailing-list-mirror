From: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>
Subject: Re: Problem with git-cvsimport
Date: Wed, 10 Oct 2007 15:05:03 +0200
Message-ID: <F1176033-1C6E-43F3-9F47-3BDD5EC88A14@orakel.ntnu.no>
References: <470B491F.9020306@jentro.com> <200710091447.50501.wielemak@science.uva.nl> <470B8049.1090308@samba.org> <47065A5D-D170-4D11-A802-85376F97F8D2@orakel.ntnu.no> <470C3A3A.2070809@alum.mit.edu>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Thomas Pasch <thomas.pasch@jentro.com>, git@vger.kernel.org,
	Jan Wielemaker <wielemak@science.uva.nl>,
	"Gerald (Jerry) Carter" <jerry@samba.org>,
	dev <dev@cvs2svn.tigris.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 10 15:06:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfbFV-0002aG-68
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 15:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbXJJNFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 09:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbXJJNFI
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 09:05:08 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:56212 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbXJJNFG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 09:05:06 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 63070608B7F;
	Wed, 10 Oct 2007 15:05:04 +0200 (CEST)
In-Reply-To: <470C3A3A.2070809@alum.mit.edu>
X-Mailer: Apple Mail (2.907)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60492>

On 10. okt.. 2007, at 04.34, Michael Haggerty wrote:

[...]

Thanks for the response!  I should have explained that my goal is to  
convince my coworkers that git is worth the effort to learn, and IMO,  
making imported git repositories look as "clean" as possible to  
someone familiar with the CVS repository is an important part of  
that.  My suggestions and complaints should be seen in that light :)

>> * Tags each get a branch with a single commit, with the actual tag
>> pointing to that commit.  This makes it harder than necessary to  
>> figure
>> out what the history looks like; gitk's default view won't show any
>> tags, for example, since it only shows the master branch and not the
>> single-commit tag branches.
>
> I just fixed this in cvs2svn trunk r4213.  Now it reuses a single  
> branch
> called 'refs/heads/TAG.FIXUP' whenever it needs to make a tag fixup
> branch, and it resets that branch when done.  (Resetting the tag fixup
> branch changes it to 0000000000000000000000000000000000000000 but
> doesn't really delete it; I don't know the ramifications of that but  
> at
> least it doesn't appear in gitk output any more.)

Great!  I'll try this out at the first opportunity.

The main problem I have with the current branched-tag behaviour is  
that nothing exists on the branch to show that a tag is branched off,  
so no tags are shown at all when running gitk on a single branch.  A  
git newbie who is familiar with the CVS repository will probably just  
assume that tags haven't been imported, which is unfortunate.

Tagging the branch point is an obvious solution to that problem, but I  
wonder if branching for tag fixups could be made optional.  Instead of  
representing a tag with differences to the commit it's closest to like  
this:

     o--*--o--...
         \--t

(where "*" represents the closest commit on the branch, and "t"  
represents the fixup commit), might the following be possible and/or  
desirable?

     o--*--t--r--o--...

"r" being a commit that reverts the changes in "t".

It might just be me, but I think of a tag as being "on" a branch even  
when it has been messed with (sliding, omitting files, etc), and a  
linear history preserves that illusion.

>> * Branches all get a useless commit at their branch point.  All  
>> branches
>> from the main branch appear to be merged from the vendor branch  
>> (ie, the
>> useless commit has the vendor branch as an extra parent), which might
>> make sense to someone who knows what the vendor branch is for, but  
>> makes
>> no sense to me.  This combined with the previous point makes "gitk
>> --all" look needlessly spaghetti-like if you have a slightly  
>> complicated
>> CVS history.
>
> I assume that the "useless commit" that you are referring to is the  
> one
> with log message "This commit was manufactured by cvs2svn to create
> branch 'BRANCH'."  Is that correct?

Yes.  And I'm regretting my choice of words already.  "Unexpected  
commit" would have been better.

> I'm not a git expert, so I don't know whether these commits are in  
> fact
> useless.  But let me explain the reason I put them in and you can tell
> me whether it is nonsense.

[...]

I know barely enough about git (or CVS, for that matter) to be  
dangerous, but your explanation makes sense to me.

> I imagine that *if* a branch is created with a single parent branch,  
> and
> *if* each and every file from the parent branch is added to the new
> branch, then it is possible that the "useless commit" could be  
> omitted.
> But this decision would require information that cvs2svn doesn't
> currently have at that stage of the conversion, and keeping the
> necessary records would be quite expensive.

Right; that is how I think of a branch, even if CVS doesn't.  To me,  
the extra commit is useless because it should be identical to the  
branch point commit on the parent branch.  I don't think having an  
extra commit there is a huge problem, though.

[...]

> Regarding the superfluous vendorbranch parent: vendor branches are an
> obscure CVS feature for tracking upstream sources.  The file  
> contents on
> the vendorbranch are typically exactly the same as that on trunk,  
> and if
> a branch is created while the vendorbranch is active, CVS doesn't  
> record
> whether the branch's parent was trunk or the vendorbranch.  Haven't  
> yet
> built the heuristics into cvs2svn to make this decision more
> intelligently, so sometimes "vendorbranch" is listed as a branch  
> parent
> when it could be omitted.

I don't think I've ever seen the vendor branch used for anything but  
the initial import (creation) of a repository, and then only because  
it is a required parameter to "cvs import".  Is there any chance you  
could add an option to ignore the vendor branch?

> Thanks for the feedback!

Thanks for making cvs2svn the best CVS-to-git conversion tool :)  Now  
if it would only support incremental importing...

Eyvind Bernhardsen
