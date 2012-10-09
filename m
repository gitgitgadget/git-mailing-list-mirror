From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: teach "foreach" command a --revision <tree-ish>
 option
Date: Tue, 09 Oct 2012 23:21:50 +0200
Message-ID: <5074956E.3060909@web.de>
References: <1349743810-10753-1-git-send-email-jaysoffian@gmail.com> <7v8vbgi3yz.fsf@alter.siamese.dyndns.org> <7v4nm4i37u.fsf@alter.siamese.dyndns.org> <CAG+J_Dw1iXJfgkmA2V-L11xCOOxO57U4Dh7=h7AzkFUqLc55=w@mail.gmail.com> <7vr4p7fqr2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 23:22:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLhFf-0000EJ-MK
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 23:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732Ab2JIVV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 17:21:58 -0400
Received: from mout.web.de ([212.227.17.11]:53764 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929Ab2JIVV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 17:21:56 -0400
Received: from [192.168.178.41] ([91.3.189.55]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MVu2q-1StBzz1Vnc-00XS8G; Tue, 09 Oct 2012 23:21:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vr4p7fqr2.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:zRAyD7xAbyMR1qREpZHskaYb/nYpFHKO+YXbPqFG1Hn
 EORw112WM7LRLLRPdaJCpjxEShd3v1hjxoaHCI/s3UJ1TRThov
 mvpjBWBdOtOIzBAjEqFjGDRmWNO+YqQo9dDOX3SNbjIGhPKh8S
 FSJOqkzUcoIYqVFoyG0SMQcCa1RGWr/d7K825mtpWLwvfrz1SC
 SabOOl8AFWwBg7gkBtclg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207348>

Am 09.10.2012 20:24, schrieb Junio C Hamano:
> Jay Soffian <jaysoffian@gmail.com> writes:
> 
>> On Tue, Oct 9, 2012 at 2:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Assuming that the above guess is correct (which is a huge
>>>> assumption, given the lack of clarity in the description), I think
>>>> the feature might make sense.  The example would have been a lot
>>>> easier to follow if it were something like this:
>>>>
>>>>     $ git submodule foreach --revision v1.0 'git grep -e frotz $sha1'
>>>
>>> Imagine you have a checkout of v2.0 of the superproject in your
>>> working tree, and you run "git submodule foreach --revision v1.0".
>>> Further imagine a submodule S that used to exist back when the
>>> superproject was at v1.0 no longer exists in the current codebase
>>> (hence there is no such submodule in the working tree).
>>>
>>> Shouldn't the above "foreach ... grep" still try to find 'frotz' in
>>> the submodule S that was bound to v1.0 of the superproject?
>>>
>>> Given that your patch does not touch the part of cmd_foreach where
>>> it decides which submodule to descend into, it still will base its
>>> decision solely on the set of submodules that are bound to and have
>>> been "git submodule init"ed in the version of the superproject that
>>> is _currently_ checked out, no?
>>
>> That's a good observation. My use-case for this (poorly explained in
>> ...
>> As you previously stated, I need to improve the documentation that
>> goes along with this patch, so I'll call-out this limitation. I'm not
>> sure what else can be done. You can't descend into a submodule that
>> isn't there.
> 
> As recent "submodule rm" work by Jens indicates, since 501770e (Move
> git-dir for submodules, 2011-08-15), you should be able to peek into
> submodules that have been "git submodule init"ed but do not exist in
> the current checkout of the superproject.
> 
> I think the right approach to implement this "recurse foreach in the
> superproject tree that is not checkout out to the working tree"
> feature should be:
> 
>  - Advertise it so that it is crystal clear that the command run by
>    "foreach" may have to run in a bare repository of submodule to
>    look at submodule's commit bound to the historical tree of the
>    superproject;

I think we should even try to enforce that the user shouldn't use
the work tree at all (although at the moment I can't come up with
an idea how we could do that), as the work tree *will* be out of
sync almost always when you need this option. Otherwise strange
things would happen when using "git submodule foreach --revision
..." with a command which examines the work tree, as that won't be
updated to the given revision.

>  - Anytime you look at .gitmodules in the superproject, read from
>    the historical tree's .gitmodules instead of from the working
>    tree (I think this is necessary in order to get the $sm_name vs
>    $sm_path mapping right); and

Yes, that is definitely necessary in case submodules are added,
removed or moved.

>  - Locate submodule's $GIT_DIR in $GIT_DIR/modules/$sm_name of the
>    superproject that corresponds to the submodule found in the
>    historical tree in the superproject (or if it is the same
>    repository as that is currently checked out, use $sm_path/.git),
>    and error out when it is not available.

Looking in $GIT_DIR/modules/$sm_name could make sense to tag even
those submodules which aren't currently populated. But IIRC the
tags in such repositories could not be pushed using current git
even when you use the "--recurse-submodules" option because that
only honors populated submodules. So for now it would suffice to
only recurse into populated submodules.

> An implementation that works only when all the submodules necessary
> in the historical tree in the superproject are still in the current
> checkout of the superproject may be fine as a quick throw-away hack,
> and it may even be acceptable as a good first step towards the real
> feature, but at least it needs to be protected by an error checking
> upfront (perhaps running "diff-tree -r" between the index and the
> historical tree to make sure there are no removed submodules that
> existed in the historical tree), if it does not bother to check with
> $GIT_DIR/modules/$sm_name in the superproject.
> 
> Jens, anything I missed?

Nothing I can think of right now, the above is a pretty good summary.
My gut feeling is that having "git submodule foreach --revision ..."
recurse through submodules whose work trees are out of sync is pretty
fragile and could easily lead to inconsistencies. So I tend to think
adding a custom script to the release process Jay uses which does the
tagging itself might be a better solution here. Opinions?
