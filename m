From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Sun, 30 Mar 2008 21:50:24 +0200
Message-ID: <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com> <47EECF1F.60908@vilain.net> <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no> <47EFD253.6020105@vilain.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Mar 30 21:51:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg3Yo-0000GC-4I
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 21:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbYC3Tu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 15:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbYC3Tu2
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 15:50:28 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:49317 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbYC3Tu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 15:50:27 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id F103A1598B1;
	Sun, 30 Mar 2008 21:50:25 +0200 (CEST)
In-Reply-To: <47EFD253.6020105@vilain.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78509>

On 30. mars. 2008, at 19.48, Sam Vilain wrote:
> Eyvind Bernhardsen wrote:
>> I solved that by adding a "submodule push" that pushes the detached  
>> head
>> of each submodule to its own ref ("refs/submodule-update/commit- 
>> $sha1",
>> imaginatively).  I also made "submodule update" try to fetch that ref
>> when looking for a sha1.
>
> Hmm, a reasonable decision, but I think it would be better to force  
> the
> user to choose which branch they want to push to.  Leaving breadcrumbs
> in the refs/ space like that is best avoided.

Well, the point of "submodule push" was to avoid having to push in  
each submodule manually; not enforcing the requirement that commits in  
submodules must be publicly available before pushing from the main  
module is a recipe for disaster, or at least annoyance.  And nobody  
likes an annoying git.

Pushing to a branch works except that I couldn't figure out what to do  
if the push doesn't succeed, ie, the branch has advanced on the remote  
end.  That's a problem if more than one module references the  
submodule or there are multiple branches in the main module.

One solution that occurred to me was to have a branch in each  
submodule for every main module and branch.  A branch name would be  
provided for each submodule in .gitmodules, used by "submodule push"  
but not "submodule update".  In this case, if the push to the branch  
fails, the main module branch is probably behind too.

This seemed like a good idea, but it's racy.  If two simultaneous  
"submodule push"es try to push to the same branch on a submodule, one  
of them will be rejected, but it might already have updated branches  
on other submodules.  Ick.

I briefly toyed with creating tags named after the main module and its  
branch, with the submodule sha1 included for good measure, but that  
leaves a _real_ mess in refs/tags.  Figuring out that I could use refs/ 
submodule-push instead seemed like an epiphany at the time.


As an aside, my mental model of what the submodule needs is a  
fetchable reflog for every main module and branch that uses it,  
containing the history of commits used by that module/branch.

It's a reflog, not a branch, because a submodule can be changed to a  
different branch, rewound, etc between commits in the main module;  
there's no requirement that the old commit is in the new commit's  
history.  You actually don't want to fetch the whole thing, but you  
have to be able to fetch every sha1 contained in it, by sha1.

...so that's what refs/submodule-push is supposed to look like.  You  
might need to squint a bit.

> Indeed - it can only become "fit for public consumption" if people
> submit their usability enhancements!

True :)  I still have no idea how to figure out which submodules are  
dirty, though.  Solving that will enable a safe "submodule update",  
which I think is more important than "submodule push".
-- 
Eyvind Bernhardsen
