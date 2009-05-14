From: Jon Smirl <jonsmirl@gmail.com>
Subject: Teach git how to propagate a fix across a file split
Date: Thu, 14 May 2009 17:00:15 -0400
Message-ID: <9e4733910905141400h735b0897kb4adeec41b0ea398@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 14 23:00:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4i2W-0004MO-V0
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 23:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbZENVAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 17:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbZENVAQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 17:00:16 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:60239 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbZENVAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 17:00:15 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1224747qwd.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 14:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=bFX2X8SHnDospUl15Fa11gY4vuvYjNn006xxDxxz8wI=;
        b=TKYt9+aEoSjxceh5kjUadxauIgf0ivH/FnG2AYKRNdbFXkrmZogGeCTXwIAUE21HJ9
         JNe3CSL+gQS0qOh8zXdc5bzWmNHVFoe4OWamyz18sFCna6C1UZIvX+HkOXMOD93kdvmD
         YVQtitq66JdpJBScWY/ABV057YnTJ8OvpUN/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=c8etw3AfQnhPScasHyYoBMXsLLOAWl8xKVZrnV5vCwH/+VoLQWnNMJzZi57S7O9vBs
         2EV++rKUy5A2L+YfAGK+Q27oj8c5+yRLwYKYd5QLxA3apRldwbUvT9mpX3pkGf36CcjF
         1HVrb4nLzES1k93OlzpS7FCtZWL6TeNG2E3Mo=
Received: by 10.220.73.69 with SMTP id p5mr4322025vcj.11.1242334815655; Thu, 
	14 May 2009 14:00:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119225>

Are there any git merge experts looking for something to do? We just
hit this situation again merging some ALSA branches for 2.6.31.

A basic problem description:
Pending change for 2.6.31 splits file A into A and B
Fix is added to 2.6.30 in file A
The fix in A is in a section that is going to be in file B for 2.6.31

Merge the two branches and note that git totally messes up on the
merge. It can't figure out that the fix needs to go into file B.

On Mon, May 4, 2009 at 10:54 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Jon Smirl venit, vidit, dixit 04.05.2009 15:52:
>> On Mon, May 4, 2009 at 9:49 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Jon Smirl venit, vidit, dixit 04.05.2009 15:42:
>>>> On Mon, May 4, 2009 at 9:27 AM, Michael J Gruber
>>>> <git@drmicha.warpmail.net> wrote:
>>>>> Jon Smirl venit, vidit, dixit 04.05.2009 14:53:
>>>>>> I keep running into this problem, is there anything I can do to make
>>>>>> it better? I'm using stgit but this is a problem in git itself.
>>>>>>
>>>>>> I have a patch that splits file A into two files, A and B.
>>>>>> Now I merge with another tree and bring in a one line fix to A.
>>>>>> The fix touches the pre-split file A in a section that is going to end up in B.
>>>>>> Next I re-apply the patch that splits A into A and B.
>>>>>>
>>>>>> This results in a large conflict in the post split file A.
>>>>>> And no patch being applied to file B which is where the fix belongs.
>>>>>>
>>>>>> Repeat this process with a multi-line fix and the whole automated
>>>>>> merge process breaks down and I have to carefully figure everything
>>>>>> out by hand.
>>>>>>
>>>>>> The merge process seems to be unaware of the newly created file B. No
>>>>>> patches or conflict ever end up in it.
>>>>>>
>>>>>
>>>>> Can you provide a test case or at least a list of commands which you are
>>>>> issuing? You complain about "merge", but you say you are "applying a
>>>>> patch". Are you merging that patch from another branch, or are you
>>>>> really applying it as a patch (git-apply/cherry-pick/rebase/what-not)?
>>>>
>>>> What git command does stgit use internally on push/pop?
>>>>
>>>> It's the stg push of a patch creating a split on top of a change to
>>>> the section that is going to end up in file B that causes the problem.
>>>
>>> I see. So it's really rebasing/applying here rather then merging. I
>>> don't think they have the necessary info in order to do content-based
>>> patching across file boundaries.
>>
>> Are there git commands that can do this properly? stgit is just a
>> bunch of Python executing git commands, they can change which commands
>> are getting called.
>
> OK, I checked the source, and in fact stgit uses git's merge strategies.
>
> I also checked a simple example (splitting `seq 1 20`) in two. It seems
> that git's rename detection does not detect that to be a rename/copy
> (split). As a consequence, the merge strategy performs only a file based
> merge between the versions of A. One would need to teach git about "a
> better split detection" in order to cope with such a situation.
>
> On the other hand, if you know the split, can't you redo that manually?
> I mean, checkout the new version (with the multi-line fixes), split it,
> git-add and git-commit to resolve.
>
> Michael
>



-- 
Jon Smirl
jonsmirl@gmail.com
