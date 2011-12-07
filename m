From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Auto update submodules after merge and reset
Date: Wed, 07 Dec 2011 23:23:24 +0100
Message-ID: <4EDFE75C.5050201@web.de>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de> <jbnadt$hf8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
X-From: git-owner@vger.kernel.org Wed Dec 07 23:23:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYPtk-00019C-VH
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 23:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758490Ab1LGWX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 17:23:28 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:47043 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757988Ab1LGWX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 17:23:27 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate03.web.de (Postfix) with ESMTP id AC7881AB3EB86
	for <git@vger.kernel.org>; Wed,  7 Dec 2011 23:23:26 +0100 (CET)
Received: from [192.168.178.25] ([80.187.110.206]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MPY5x-1RTl3k2IzJ-004kRX; Wed, 07 Dec 2011 23:23:26
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <jbnadt$hf8$1@dough.gmane.org>
X-Provags-ID: V02:K0:0XDnKHzi5Y4l4lvBHCI5p5EVtn1OODwX+ib5N06DEsD
 6al7ybckdpC63Vk0V1qrbMe+goOzQprNVoYyxvXFjptNvsbQwb
 1FS94eF7WQjbok7+a/1dUjTBEFNUvS9vVB4hdnYiVuMPzjN+8/
 SNlzYVDvmdZvLN0nied/3MzxUthN9X5XZxhQrvBgo8MFatVILI
 SrTsq/TrYXjnr9iWQKn9Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186512>

Am 07.12.2011 10:07, schrieb Andreas T.Auer:
> Jens Lehmann wrote:
> 
>> Am 30.11.2011 01:55, schrieb Max Krasnyansky:
>> I'm working on a patch series to teach Git to optionally update the
>> submodules work trees on checkout, reset merge and so on, but I'm not
>> there yet.
>>
>>> I'm thinking about adding a config option that would enable automatic
>>> submodule update but wanted to see if there is some fundamental reason
>>> why it would not be accepted.
> Because there is no good way to do so. It would be fine when you just track 
> the submodules "read-only", but if you are actually working on submodules, 
> it is a bad idea to always get a detached HEAD.

YMMV. We get along *really* well with this because all developers know that
if they want to hack on a submodule, they have to create a branch in there
first (and if they forget to do that, git status and friends will tell them).
What bugs us is that submodule HEADs don't follow what is checked out (or
merged, or reset ...) in the superproject. We had some really nasty
mismerges because of that, so we need the option to enable it.

> It is also a bad idea to
> merge or rebase on the currently checkedout branch.

As I'm no user of update=merge|rebase, I have no first hand experience on
that. But people do use those settings, no?

> Because if you are
> working on a maint branch in the submodule and then you checkout a pu branch 
> in the superproject, because you have forgotten that maint branch in the 
> submodule then all the proposed updates go to the maintenance branch -> bad. 

Nope, checkout will fail and not do anything as it will detect changes in
the submodule to be updated by the checkout (just as it would do with a
regular file).

> So auto-update is not easy.

No, it is, and it works really well. But it might not fit your use case.

> But below I describe an idea that might solve
> these issues and help auto-udpate to work in a sane way.
>  
>> I think adding something like an "submodule.autoupdate" config makes lots
>> of sense, but IMO it should affect all work tree updating porcelain
>> commands, not just merge.
> 
> I was thinking about submodule integration and had the idea to bind a 
> submodule to the superproject by having special references in the submodule 
> like refs/super/master, refs/super/featureX... So these references are like 
> tracking branches for the refs/heads/* of the superproject.

Having stuff in the submodule reference branches in the superproject
sounds upside down, as a superproject has (and should have) zero knowledge
about the superproject (as it could have many different of them).

> If you have tracking branches, the supermodule can just update the 
> corresponding branch. If this branch is currently checkedout and the work 
> area is clean, then the work area is updated, too. If there is currently a 
> local branch or a diffent super-branch checked out then the working area 
> should be considered "detached" from the superproject and not updated. 

This sounds a lot like the "follow branch tip" model we discussed
recently (which could be configured via .gitmodules), but I'm not sure
you really are in the same boat here.

> With this concept you could even switch branches in the superproject and the 
> attached submodules follow - still having no detached HEAD. When you want to 
> do some local work on the submodule you checkout a local branch and merge 
> back into the super branch later.

You lost me here. How can you merge a submodule branch into one of the
superproject?

> The head of that super branch might have 
> changed by the update procedure meanwhile, but that is fine, then you just 
> have a merge instead of a fast-forward.
> 
> Another nice feature would be a recursive commit. So all changed index files 
> in the _attached_ submodules would first be committed in their submodules 
> and then the superproject commits too - all with one command. Currently it 
> feels a little bit like CVS - commit one file(submodule), commit the other 
> file(submodule) and then apply a label(commit the superproject) to keep the 
> changes together. 
> 
> If the submodule is not attached the commit in the superproject can still 
> detect changes that have been made to the corresponding tracking branch and 
> pick these up.
> 
> As a summary: Tracking submodule branches in the superproject instead of 
> only the current HEAD of the submodule gives you more freedom to install 
> sane auto-update procedures.

But we would want to have a deterministic update procedure, no? (And what
has more freedom than a detached HEAD? ;-)

> Even though it will raise a lot of detailed
> questions like "should the refs/super/* be pushed/pulled when syncing the 
> submodule repositories".

I doubt that is a good idea, as that might conflict with the same submodule
sitting in a different superproject. But I'm interested to hear how you
want to solve that.
