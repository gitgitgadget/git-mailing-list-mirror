From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Find out on which branch a commit was originally made
Date: Sun, 19 Sep 2010 19:54:31 -0400
Message-ID: <201009192354.o8JNsVLs018778@no.baka.org>
References: <1jp0h7e.lgk0kp19qe5bbM%lists@haller-berlin.de> <201009192030.21659.robin.rosenberg@dewire.com> <201009192203.o8JM39PE011067@no.baka.org>
        <4C9698C5.70607@gmail.com>
Cc: git@vger.kernel.org
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 01:54:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTiR-0000V7-5e
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab0ISXye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 19:54:34 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:33509 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754263Ab0ISXyd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:54:33 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id o8JNsVo8009342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 Sep 2010 19:54:31 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id o8JNsVLs018778;
	Sun, 19 Sep 2010 19:54:31 -0400
In-reply-to: <4C9698C5.70607@gmail.com>
Comments: In reply to a message from "Artur Skawina <art.08.09@gmail.com>" dated "Mon, 20 Sep 2010 01:12:05 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156538>


In message <4C9698C5.70607@gmail.com>, Artur Skawina writes:

On 09/20/10 00:03, Seth Robertson wrote:
>>>>>                A---B---C topic
>>>>>               /         \
>>>>>          D---E---F---G---H---I---J---K---L---M---N master
>>>>>                                   \         /
>>>>>                                    O---P---Q another-topic
>>
>>>> No, that's not what I need either.  After thinking about it more, I
>>>> think what I want is "of all merges in the ancestry path from B to
>>>> master, show only those whose first parent can't reach B."  The result
>>>> is the list of all merges that were involved in bringing B to master.
>>
>>
>>> This would work, and i don't see a way to optimize it in git-speak,
>>> given that you don't want to see any extra trailing merges. [...]
>>
>> The provided command actually doesn't work for me for all cases.  It
>> works for the simple case of "B", but does not work for "F", because F
>> saw merge H & M.  I think we need --not --first-parent, except that
>
> Well, F was never on a separate branch, so the command returning ""
> is arguably the right thing.

I'd like a command that would tell me the right branch something was
on whether it was on master or topic or whatever.  If instead of
"master" the branch was named "supertopic" and master commit AA had
child D would that make a difference?

>> doesn't actually work in this case either.  However, if we get the
>> full --first-parent rev-list and look for our commit, that works.
>> This is incredibly painful, though.
>> ----------------------------------------------------------------------
>> #!/bin/sh
>> TARGET=`git rev-list -n 1 $1`
>> git branch -a --contains $1 | sed 's/^\** *//' | grep -v ' -> ' |
>> while read br; do
>>  if git rev-list --first-parent $br | grep -q "$TARGET"; then
>>   echo $br
>>  fi
>> done
>> ----------------------------------------------------------------------

> And it does not work if you no longer have the branches around...

If something doesn't have a name I am not very interested in it (for
my purposes, your milage may vary).  Presumably the other code could be
combined with my inner loop.

>But even if you kept all the old refs, this would return
>"another-topic"+"master", which is hardly the right answer.

I'm not sure how you can figure out when a branch was first created.
We might "know" that master is older than the others, but if this
commit was on another-topic and supertopic we cannot use that
intuition..

Returning all possible branch names at least gives the user somewhere
to start and does not give them ones which are obviously insane.

					-Seth Robertson
