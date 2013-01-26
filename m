From: Carsten Fuchs <carsten.fuchs@cafu.de>
Subject: Re: git merge error question: The following untracked working tree
 files would be overwritten by merge
Date: Sat, 26 Jan 2013 11:46:27 +0100
Message-ID: <5103B403.5010206@cafu.de>
References: <5102607E.2070106@cafu.de> <7vehh95e7u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 11:47:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tz3Hr-0001bi-Ge
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 11:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380Ab3AZKqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 05:46:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:54801 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab3AZKqh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 05:46:37 -0500
Received: from [192.168.1.73] (p5B0C5492.dip.t-dialin.net [91.12.84.146])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0M4a7A-1UxT202TQi-00yi38; Sat, 26 Jan 2013 11:46:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vehh95e7u.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:k4g44SYN1bC+nf6suaU3E3CyU4Rq5I+jtjVy5X+lPJL
 s/UeIGYLsor6RMhPapcWilRaKXfetO7KaBx8WJiQCMs/cZzUAi
 AT3UQBEehh8uu7tLOp/OcVmt84vPrT2cBNKBGTTP6EvIVUqgrz
 mKUB5mcIW0XljxtDNYMaP4x77yTgFxjl799tLjbvrus5Icq1zF
 GP+upRNNLU75fmkpP2KgCXC/Of9/JGw1YBsGWmxVk8v46ALj5C
 ZoMbGkIb6xXw5HrsFGav+Kaozii/cEFsJZd0N2h97ukgzag2eK
 20qOE63jgBMg4yKqeyybhPswJNdH1V399g8lIWQn+QRL38MRbf
 rzl88JEnmQisuELR2INU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214619>

Am 2013-01-25 19:07, schrieb Junio C Hamano:
> Carsten Fuchs <carsten.fuchs@cafu.de> writes:
>>>  [...]
>>> $ git merge origin/master --ff-only
>>> Updating f419d57..2da6052
>>> error: The following untracked working tree files would be overwritten by merge:
>>>          obsolete/e107/Readme.txt
>>>          obsolete/e107/article.php
>>>          obsolete/e107/backend.php
>>>          [...]
>> ...
>> Compare with what Subversion did in an analogous case: When I ran "svn
>> update" and the update brought new files for which there already was
>> an untracked copy in the working directory, Subversion:
>>      - started to consider the file as tracked,
>>      - but left the file in the working-copy alone.
>>
>> As a result, a subsequent "svn status" might
>>      a) no longer show the file at all, if the foreign copy in the
>> working directory happened to be the same as the one brought by the
>> "svn update", or
>>      b) flag the file as modified, if different from the one that "svn
>> update" would have created in its place.
>
> Interesting.  So before running "status", the merge is recorded (in this
> particular case you are doing ff-only so there is nothing new to
> record, but if the rest of the tree merges cleanly, the new tree
> that contains "obsolete" from the other branch you just merged will
> be the contents you record in the merge commit), and working tree is
> immediately dirty?

Yes. But I don't think it's the (svn) "status" command that does anything special.

In Git, if I understand it correctly, the final step of a "merge", "checkout", "reset", 
etc. is a move of the HEAD to the resulting or specified commit. I imagine that it is 
here where the diff of the dirty working tree is re-applied to the newly checked out 
commit (and if this is not possible cleanly, probably [a] the whole operation must 
abort, or [b] leave files in the working tree with conflict markers), and where a 
decision must be made about "obstructing paths" (svn lingo): [c] abort the whole 
operation, or [d] "version" them (but don't modify them in any way).

I'm not sure if Subversion does [a] and [c] ("abort") without the --force option, and 
[b] and [d] with --force, or any other combination, but at least TortoiseSVN seems to 
use [d] by default (which seems safe enough).

Despite a thorough search, I've not been able to find much reference about this behaviour:
http://svnbook.red-bean.com/en/1.6/svn.ref.svn.c.switch.html
http://markphip.blogspot.de/2007/01/subversion-15-tolerate-obstructions.html

However, as the blog article mentions, I too have found this treatment of obstructing 
paths very natural and helpful in several occasions.

(Because without it, we must manually rename the obstructing paths, re-start the 
previously aborted operation, and then take diffs or somehow else compare the renamed 
obstructing and newly added paths manually, and possible merge them manually; or at 
least copy the renamed edition over the newly added edition to get back into Git for the 
job.)

>> So my real question is, why does Git not do something analogous?
>
> The answer to that question is "because nobody thought that doing so
> would help users very much and bothered to implement it"; it is not
> "people thought about doing so and found reasons why that would not
> help users".

Thanks, it's very good to hear this!
:-)


Best regards,
Carsten
