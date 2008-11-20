From: Andreas Ericsson <ae@op5.se>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 16:37:05 +0100
Message-ID: <49258421.5090308@op5.se>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com> <20081120112708.GC22787@ravenclaw.codelibre.net> <492560C5.5070308@op5.se> <20081120141533.GC6023@codelibre.net> <49257949.4070308@op5.se> <20081120151925.GE6023@codelibre.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian MICHON <christian.michon@gmail.com>, git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:38:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Bc6-0005EP-0z
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 16:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210AbYKTPhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 10:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755140AbYKTPhL
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 10:37:11 -0500
Received: from mail.op5.se ([193.201.96.20]:35019 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755479AbYKTPhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 10:37:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8E85D24B0006;
	Thu, 20 Nov 2008 16:32:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1JjximTJXDIM; Thu, 20 Nov 2008 16:32:08 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 958101B8005E;
	Thu, 20 Nov 2008 16:32:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081120151925.GE6023@codelibre.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101455>

Roger Leigh wrote:
> On Thu, Nov 20, 2008 at 03:50:49PM +0100, Andreas Ericsson wrote:
>> Roger Leigh wrote:
>>> On Thu, Nov 20, 2008 at 02:06:13PM +0100, Andreas Ericsson wrote:
>>>> Roger Leigh wrote:
>>>>> On Wed, Nov 19, 2008 at 05:18:16PM +0100, Christian MICHON wrote:
>>>>>> On Wed, Nov 19, 2008 at 12:37 PM, Roger Leigh <rleigh@codelibre.net> wrote:
>>>>>>> Would it be possible for git to store the mtime of files in the tree?
>>>>>>>
>>>>>>> This would make it possible to do this type of work in git, since it's
>>>>>>> currently a bit random as to whether it works or not.  This only
>>>>>>> started when I upgraded to an amd64 architecture from powerpc32,
>>>>>>> I guess it's maybe using high-resolution timestamps.
>>>>>>>
>>>> Caring about meta-data the way you mean it would mean that
>>>>
>>>>  git add foo.c; git commit -m "kapooie"; touch foo.c; git status
>>>>
>>>> would show "foo.c" as modified. How sane is that?
>>> I've never come close to suggesting we do anything so insane.
>>>
>>> What I am suggesting is that on add/commit, the inode metadata
>>> be recorded in the tree (like we already store perms), so that
>>> it can be (**optionally**) reused/restored on checkout.
>>>
>>> Whether it's stored in the tree or not is a separate concern from
>>> whether to *use* it or not.  For most situations, it won't be
>>> useful, as has been made quite clear from all of the replies, and I
>>> don't disagree with this.  However, for some, the ability to have
>>> this information to hand to make use of would be invaluable.
>>>
>> Then write a hook for it. You agree that for most users this will be
>> totally insane, and yet you request that it's added in a place where
>> everyone will have to pay the performance/diskspace penalty for it
>> but only a handful will get any benefits. That's patently absurd.
> 
> The cost is tiny.  The extra space would be smaller than a single
> SHA1 hash.
> 
>> Especially since there are such easy workarounds that you can put in
>> place yourself instead.
> 
> 
>>> There have been quite a few suggestions to look into using hooks,
>>> and I'll investigate this.  However, I do have some concerns
>>> about *where* I would store this "extended tree" data, since it
>>> is implicitly tied to a single tree object, and I wouldn't
>>> want to store it directly as content.
>> Store it as a blob targeted by a lightweight tag named
>> "metadata.$sha1" and you'll have the easiest time in the world when
>> writing the hooks. Also, the tags won't be propagated by default,
>> which is a good thing since your timestamps/uid's whatever almost
>> certainly will not work well on other developers repositories.
> 
> And yet the fact that it won't propagate makes it totally useless:
> all the other people using the repo won't get the extra metadata
> that will prevent build failures.  Having the extra data locally
> is nice, but not exactly what I'd call a solution.  The whole point
> of what I want is to have it as an integral part of the repo.
> 

Then make it signed tags and ship them along.

Or do this properly and simply put in your buildsystem that some
targets never need to be rebuilt. That's (by far) the simplest
solution.

On a sidenote, I fail to see how the pre-generated stuff can avoid
getting updated unless also the sources for that stuff was updated,
in which case either of the following is true:
a) You really do need to rebuild, because upstream fucked up.
b) The pre-generated stuff should *also* be checked out and get new
   timestamps.

Either way, to me it sounds like your buildsystem needs some love.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
