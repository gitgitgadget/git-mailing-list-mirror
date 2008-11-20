From: Andreas Ericsson <ae@op5.se>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 15:50:49 +0100
Message-ID: <49257949.4070308@op5.se>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com> <20081120112708.GC22787@ravenclaw.codelibre.net> <492560C5.5070308@op5.se> <20081120141533.GC6023@codelibre.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian MICHON <christian.michon@gmail.com>, git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 15:53:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Aud-0008NC-Jn
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 15:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757543AbYKTOvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 09:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757235AbYKTOvW
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 09:51:22 -0500
Received: from mail.op5.se ([193.201.96.20]:60564 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756642AbYKTOvT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 09:51:19 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BD4D31B8006D;
	Thu, 20 Nov 2008 15:46:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K6ailpzZoIyQ; Thu, 20 Nov 2008 15:45:53 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id C881F1B8005E;
	Thu, 20 Nov 2008 15:45:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081120141533.GC6023@codelibre.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101444>

Roger Leigh wrote:
> On Thu, Nov 20, 2008 at 02:06:13PM +0100, Andreas Ericsson wrote:
>> Roger Leigh wrote:
>>> On Wed, Nov 19, 2008 at 05:18:16PM +0100, Christian MICHON wrote:
>>>> On Wed, Nov 19, 2008 at 12:37 PM, Roger Leigh <rleigh@codelibre.net> wrote:
>>>>> Would it be possible for git to store the mtime of files in the tree?
>>>>>
>>>>> This would make it possible to do this type of work in git, since it's
>>>>> currently a bit random as to whether it works or not.  This only
>>>>> started when I upgraded to an amd64 architecture from powerpc32,
>>>>> I guess it's maybe using high-resolution timestamps.
>>>>>
>>>> beside the obvious answer it comes back often as a request, it is
>>>> possible in theory to create a shell script which, for each file
>>>> present in the sandbox in the current branch, would find the mtime of
>>>> the last commit on that file (quite an expensive operation) and apply
>>>> it.
>>> Surely this is only expensive because you're not already storing the
>>> information in the tree; if it was there, it would be (relatively)
>>> cheap?
>> No, it's because git is *snapshot* based and doesn't care about anything
>> but contents. Storing filestate information in the tree would be a
>> backwards incompatible change that would require a major version change.
> 
> It's not strictly true that it's only caring about contents.  The
> contents are of course in the blobs, but the tree is already
> effectively storing inode data, since it's a directory of
> filenames/subtrees, just one that only cares to store the
> permissions part of the total inode data.
> 
> I understand that git stored the permissions tacked onto the hash;
> would it be feasable to tack on the other bits as well.

No, that would break backwards compatibility with cross-repo
transfers.

> If I understand correctly, it's binary encoded in the pack format,
> and that would require updating the format to hold the additional
> data?
> 
>> Caring about meta-data the way you mean it would mean that
>>
>>  git add foo.c; git commit -m "kapooie"; touch foo.c; git status
>>
>> would show "foo.c" as modified. How sane is that?
> 
> I've never come close to suggesting we do anything so insane.
> 
> What I am suggesting is that on add/commit, the inode metadata
> be recorded in the tree (like we already store perms), so that
> it can be (**optionally**) reused/restored on checkout.
> 
> Whether it's stored in the tree or not is a separate concern from
> whether to *use* it or not.  For most situations, it won't be
> useful, as has been made quite clear from all of the replies, and I
> don't disagree with this.  However, for some, the ability to have
> this information to hand to make use of would be invaluable.
> 

Then write a hook for it. You agree that for most users this will be
totally insane, and yet you request that it's added in a place where
everyone will have to pay the performance/diskspace penalty for it
but only a handful will get any benefits. That's patently absurd.
Especially since there are such easy workarounds that you can put in
place yourself instead.

> 
> There have been quite a few suggestions to look into using hooks,
> and I'll investigate this.  However, I do have some concerns
> about *where* I would store this "extended tree" data, since it
> is implicitly tied to a single tree object, and I wouldn't
> want to store it directly as content.
> 

Store it as a blob targeted by a lightweight tag named
"metadata.$sha1" and you'll have the easiest time in the world when
writing the hooks. Also, the tags won't be propagated by default,
which is a good thing since your timestamps/uid's whatever almost
certainly will not work well on other developers repositories.

That's what I'd do anyways.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
