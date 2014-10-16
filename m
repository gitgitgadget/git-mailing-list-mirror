From: Johan Herland <johan@herland.net>
Subject: Re: fsck option to remove corrupt objects - why/why not?
Date: Thu, 16 Oct 2014 11:04:04 +0200
Message-ID: <CALKQrgda8mVbqP5=Ag8juN9HMQp7iQ9eDJETfRJe1b0taAFGkg@mail.gmail.com>
References: <20141015234637.9B4FC781EFB@mail110.syd.optusnet.com.au>
	<543F0DAE.2050205@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Ben Aveling <bena.001@optusnet.com.au>
X-From: git-owner@vger.kernel.org Thu Oct 16 11:04:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xegyp-00034R-AH
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 11:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbaJPJEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 05:04:15 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:35304 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbaJPJEO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 05:04:14 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Xegyh-0005Ah-TT
	for git@vger.kernel.org; Thu, 16 Oct 2014 11:04:11 +0200
Received: from mail-oi0-f53.google.com ([209.85.218.53])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Xegyh-0002Yx-8g
	for git@vger.kernel.org; Thu, 16 Oct 2014 11:04:11 +0200
Received: by mail-oi0-f53.google.com with SMTP id v63so2280930oia.26
        for <git@vger.kernel.org>; Thu, 16 Oct 2014 02:04:04 -0700 (PDT)
X-Received: by 10.60.177.137 with SMTP id cq9mr1179651oec.45.1413450244308;
 Thu, 16 Oct 2014 02:04:04 -0700 (PDT)
Received: by 10.182.1.137 with HTTP; Thu, 16 Oct 2014 02:04:04 -0700 (PDT)
In-Reply-To: <543F0DAE.2050205@optusnet.com.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 16, 2014 at 2:13 AM, Ben Aveling <bena.001@optusnet.com.au> wrote:
> On 14/10/2014 19:21, Jeff King wrote:
>> On Mon, Oct 13, 2014 at 09:37:27AM +1100, Ben Aveling wrote:
>>> A question about fsck - is there a reason it doesn't have an option to
>>> delete bad objects?
>>
>> If the objects are reachable, then deleting them would create other big
>> problems (i.e., we would be breaking the object graph!).
>
>
> The man page for fsck advises:
>
>    "Any corrupt objects you will have to find in backups or other
>    archives (i.e., you can just remove them and do an /rsync/ with some
>    other site in the hopes that somebody else has the object you have
>    corrupted)."
>
>
> And that seems sensible to me - the object is corrupt, it is unusable, the
> object graph is already broken, we already have big problems, removing the
> corrupt object(s) doesn't create any new problems, and it allows the
> possibility that the damaged objects can be restored.
>
> I ask because I have a corrupt repository, and every time I run fsck, it
> reports one corrupt object, then stops. I could write a script to repeatedly
> call fsck and then remove the next corrupt object, but it raises the
> question for me; could it make sense to extend fsck with the option to do to
> the removes?

I am positive to this idea. Yesterday a colleague of mine came to me
with a repo containing a single corrupt object (in a 1.2GB packfile).
We were lucky, since we had a copy of the repo with a good copy of the
same object. However, we were lucky in a couple of other respects, as
well:

I simply copied the packfile containing the good copy into the
corrupted repo, and then ran a "git gc", which "happened" to use the
good copy of the corrupted object and complete successfully (instead
of barfing on the bad copy). The GC then removed the old
(now-obsolete) packfiles, and thus the corruption was gone.

However, exactly _why_ git happened to prefer the good copy in my
copied packfile instead of the bad copy in the existing packfile, I do
not know. I suspect some amount of pure luck was involved. Indeed, I
feared I would have to explode the corrupt pack, then manually replace
the )(now-loose) bad copy with a good copy (from a similarly exploded
pristine pack), and then finally repack everything again. That said,
I'm not at all sure that Git would be able to successfully explode a
pack containing corrupt objects...

I think a better solution would be to tell fsck to remove the corrupt
object(s), as you suggest above, and then copy in the good pack. In
that case, there would be no question that the good copy would be used
in the subsequent GC.

> Or even better, do the removes and then do the necessary
> [r]sync, assuming the user has another repository that has a good copy of
> the bad objects, which in this case I do.

Hmm. I am not sure we want to automate the syncing step. First, git
cannot know _which_ remote is likely to have a good copy of the bad
object. Second, we do not necessarily know what caused the corruption
in the first place, and whether syncing with a remote (which will
create certain amount of write activity on a possibly dying disk
drive) is a good idea at all. Finally, this syncing step will have to
bypass Git's usual reachability analysis (which easily skips fetching
a corrupt blob from otherwise-reachable history), is more involved
than simply calling out to "git fetch"...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
