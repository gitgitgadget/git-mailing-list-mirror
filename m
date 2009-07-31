From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Teach git how to propagate a fix across a file split
Date: Fri, 31 Jul 2009 11:19:28 -0400
Message-ID: <9e4733910907310819x1c6fe089l75ae619b31f9feda@mail.gmail.com>
References: <9e4733910905141400h735b0897kb4adeec41b0ea398@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 31 17:19:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWttR-0004Ey-WF
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 17:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbZGaPT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 11:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZGaPT3
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 11:19:29 -0400
Received: from mail-yw0-f183.google.com ([209.85.211.183]:37214 "EHLO
	mail-yw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbZGaPT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 11:19:28 -0400
Received: by ywh13 with SMTP id 13so1821290ywh.15
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=kgS3KCl4qq0xENp+2zf6kF0RHESAhX0ox0Ia6qRM+/E=;
        b=TyZkZIG3W9iIpfnGoP5WHIK/FzaUJT/ARh+YTLUwCek4nJWM3esVgUXOx7/zJ03qI8
         6ylrPW7iCdY4MjtFODWwWU8WiLtYsqza9F4uHU/B2vOq/YIUKhpS5rtTMp8PU9bLqusX
         VCR4eqml0k/0jDVHyD1XolTgVZstWZV4GD/+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Tdi1PWoKeTwL2iRRuEvAnyu1XduD/lzmI2DT9lldhI1nWOZmQ1OSSijVBMQBBK0B4w
         LJIwiD9wkD/uJKi+NVGtzUdgPBbacliF6qjnnIJZrbMINCWB6iHTUzWvayUNJQonFY1y
         OA1bJb87yCxsgWBMEmK8BnLPB3pfp63igPg0Q=
Received: by 10.100.95.15 with SMTP id s15mr3517246anb.88.1249053568661; Fri, 
	31 Jul 2009 08:19:28 -0700 (PDT)
In-Reply-To: <9e4733910905141400h735b0897kb4adeec41b0ea398@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124567>

On Thu, May 14, 2009 at 5:00 PM, Jon Smirl<jonsmirl@gmail.com> wrote:
> Are there any git merge experts looking for something to do? We just
> hit this situation again merging some ALSA branches for 2.6.31.
>
> A basic problem description:
> Pending change for 2.6.31 splits file A into A and B
> Fix is added to 2.6.30 in file A
> The fix in A is in a section that is going to be in file B for 2.6.31
>
> Merge the two branches and note that git totally messes up on the
> merge. It can't figure out that the fix needs to go into file B.

I just hit this problem again.

It can happen in other forms. In this case I'm trying to rebase three
year old patches forward (good old embedded vendor port and forget
behavior). Part of these patches made a four line change to one file.
About a year latter a 1,000 line section from this file was moved to
another pre-existing file. When I rebase the four line change forward
it generates a merge conflict over the entire 1,000 line section that
was moved. This conflict is in the file the section was moved out of
which is not what you want.

To fix this I have to search for where the 1,000 lines section was
moved to. After I find it I can redo the four line patch.

Doesn't rebase need to be smarter about processing the intervening
deltas in order to track the block of code being changed? Diff isn't
recognizing that the block of code it wants to diff against to is no
longer in the original file.

Maybe there is another way to do this? I'll try commuting the patch to
the old version in a temp tree and then merge in the newer code. Then
generate a new diff at the end.


>
> On Mon, May 4, 2009 at 10:54 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Jon Smirl venit, vidit, dixit 04.05.2009 15:52:
>>> On Mon, May 4, 2009 at 9:49 AM, Michael J Gruber
>>> <git@drmicha.warpmail.net> wrote:
>>>> Jon Smirl venit, vidit, dixit 04.05.2009 15:42:
>>>>> On Mon, May 4, 2009 at 9:27 AM, Michael J Gruber
>>>>> <git@drmicha.warpmail.net> wrote:
>>>>>> Jon Smirl venit, vidit, dixit 04.05.2009 14:53:
>>>>>>> I keep running into this problem, is there anything I can do to make
>>>>>>> it better? I'm using stgit but this is a problem in git itself.
>>>>>>>
>>>>>>> I have a patch that splits file A into two files, A and B.
>>>>>>> Now I merge with another tree and bring in a one line fix to A.
>>>>>>> The fix touches the pre-split file A in a section that is going to end up in B.
>>>>>>> Next I re-apply the patch that splits A into A and B.
>>>>>>>
>>>>>>> This results in a large conflict in the post split file A.
>>>>>>> And no patch being applied to file B which is where the fix belongs.
>>>>>>>
>>>>>>> Repeat this process with a multi-line fix and the whole automated
>>>>>>> merge process breaks down and I have to carefully figure everything
>>>>>>> out by hand.
>>>>>>>
>>>>>>> The merge process seems to be unaware of the newly created file B. No
>>>>>>> patches or conflict ever end up in it.
>>>>>>>
>>>>>>
>>>>>> Can you provide a test case or at least a list of commands which you are
>>>>>> issuing? You complain about "merge", but you say you are "applying a
>>>>>> patch". Are you merging that patch from another branch, or are you
>>>>>> really applying it as a patch (git-apply/cherry-pick/rebase/what-not)?
>>>>>
>>>>> What git command does stgit use internally on push/pop?
>>>>>
>>>>> It's the stg push of a patch creating a split on top of a change to
>>>>> the section that is going to end up in file B that causes the problem.
>>>>
>>>> I see. So it's really rebasing/applying here rather then merging. I
>>>> don't think they have the necessary info in order to do content-based
>>>> patching across file boundaries.
>>>
>>> Are there git commands that can do this properly? stgit is just a
>>> bunch of Python executing git commands, they can change which commands
>>> are getting called.
>>
>> OK, I checked the source, and in fact stgit uses git's merge strategies.
>>
>> I also checked a simple example (splitting `seq 1 20`) in two. It seems
>> that git's rename detection does not detect that to be a rename/copy
>> (split). As a consequence, the merge strategy performs only a file based
>> merge between the versions of A. One would need to teach git about "a
>> better split detection" in order to cope with such a situation.
>>
>> On the other hand, if you know the split, can't you redo that manually?
>> I mean, checkout the new version (with the multi-line fixes), split it,
>> git-add and git-commit to resolve.
>>
>> Michael
>>
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



-- 
Jon Smirl
jonsmirl@gmail.com
