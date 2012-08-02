From: Adam Butcher <dev.lists@jessamine.co.uk>
Subject: Re: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
Date: Thu, 02 Aug 2012 23:58:56 +0100
Message-ID: <551f7f77570c84017ae93988f9202854@imap.force9.net>
References: <85f291cec03411c61ddf8808e53621ae@imap.force9.net>
 <7vehnpc5ti.fsf@alter.siamese.dyndns.org>
Reply-To: <dev.lists@jessamine.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:59:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx4MH-00046F-LW
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 00:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab2HBW7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 18:59:05 -0400
Received: from avasout02.plus.net ([212.159.14.17]:59236 "EHLO
	avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787Ab2HBW7D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 18:59:03 -0400
Received: from webmail.plus.net ([212.159.8.87])
	by avasout02 with smtp
	id hyyw1j0041sg6PG01yyxyF; Thu, 02 Aug 2012 23:59:01 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.0 cv=GvbACzJC c=1 sm=1 a=w/v6d3Yw9YqO0eqsxHCYQw==:17
 a=EDeDkkTReK4A:10 a=fIUNk3G47tUA:10 a=ESsPSRNNhagA:10 a=5LfTt-Tm1vgA:10
 a=JRq8KZZ3GZoA:10 a=IkcTkHD0fZMA:10 a=ZBkl__CYAAAA:8 a=mrHjP8x4AAAA:8
 a=czapQEhnBYNTdsdclgMA:9 a=QEXdDO2ut3YA:10 a=aVC6qsWM_lQA:10
 a=7vmKudMcu_zC-rek:21 a=jJunMPMUqpLxXNYa:21 a=w/v6d3Yw9YqO0eqsxHCYQw==:117
X-AUTH: jessaminenet+dev.lists:2501
Received: from munkyhouse.force9.co.uk ([84.92.244.81])
 by webmail.plus.net
 with HTTP (HTTP/1.1 POST); Thu, 02 Aug 2012 23:58:56 +0100
Mail-Reply-To: <dev.lists@jessamine.co.uk>
In-Reply-To: <7vehnpc5ti.fsf@alter.siamese.dyndns.org>
X-Sender: dev.lists@jessamine.co.uk
User-Agent: Roundcube Webmail/0.7.2
X-Originating-IP: [84.92.244.81]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202812>

On 02.08.2012 23:00, Junio C Hamano wrote:
> Adam Butcher <dev.lists@jessamine.co.uk> writes:
>
>> +# create a file containing numbers with no newline at
>> +# the end and modify it such that the starting 10 lines
>> +# are unchanged, the next 101 are rewritten and the last
>> +# line differs only in that in is terminated by a newline.
>> +seq 1 10 > seq
>> +seq 100 +1 200 >> seq
>> +printf 201 >> seq
>> +(git add seq; git commit seq -m seq) >/dev/null
>> +seq 1 10 > seq
>> +seq 300 -1 200 >> seq
>
> We would prefer to have these set-up steps in test_expect_success.
> That way, we will have more chance to catch potential and unintended
> breakage to "git add" and "git commit" when people attempt to update
> them.
>
Cool, no probs.  I had originally put them at the start of the first 
test that I added but decided to pull them out as prep.  I think that 
msysGit or something about my Windows shell session may have played a 
part in my not chaining them with && also (see below).  I'll clean them 
up and wrap them in a test_expect_success.

> Also, the redirect target sticks to redirect operator in our
> scripts, i.e. "cmd >seq" not "cmd > seq".
>
Okay, will change.

>> +test_expect_success 'no newline at eof is on its own line without 
>> -B'
>> +
>> +	(git diff seq; true) > res &&
>
> What is this subshell and true about?  A git diff does not exit with
> non zero to signal differences,
>
Hmm, (?confused?) yeah actually I didn't think it did -- I was 
surprised when git returned 1 for this line.  I think it must have been 
an issue with the version msysGit I was using or something sticking 
errorlevel in my Windows shell.  Git seemed to return 1 ALWAYS!  I 
usually use gnu/linux but on this occasion I wrote the fix and tests 
blind on a Windows machine testing the logic manually with msysGit.  I 
ran the tests on a linux machine at work and they did what I expected so 
I left them as was without rechecking this.

I'm glad that this can be simplified.  It felt wrong -- similar lines 
elsewhere in the script didn't do it so I wasn't really happy with it.  
Turns out it looks to be a Windows/environment issue.  I cannot 
reproduce it now.

> and even if it did, the right way to
> write it would be
>
> 	test_might_fail git cmd >res &&
>
Fair enough.  Good to know that's available.

> to allow us to make sure that the git command that may or may not
> exit with zero still does not die an uncontrolled death (e.g. segv).
>
>> +	grep "^\\\\ No newline at end of file$" res &&
>> +	grep -v "^.\\+\\\\ No newline at end of file" res &&
>> +	grep -v "\\\\ No newline at end of file.\\+$" res
>> +'
>
> It is preferrable not to spell "No newline at ..." part out, so that
> we won't have to worry about future rewords and i18n.
>
Okay no probs.  I was originally going to spell it out only once and 
use parameter expansion.  However I understand the point of not spelling 
it out at all.  The only reason I did so was to catch other potential 
errors where text may have been 'attached' to either side of the 
annotation string by some future (or other) bug.

> There are older
> tests that predate i18n and they do spell these out, but that is not
> a good reason to make things worse than they already are.
>
Agreed.  Should I just test for this prefix case (i.e. the bug at hand) 
only and not preempt future potential issues?  Or should I just stick 
the current string in a variable and keep the logic as is; at least then 
there would only be one place requiring a fix in the reword case (but 
still additional rework in the i18n case -- though I assume the test 
could force a particular locale to evade this).

> "git apply" only looks at the backslash-space at the beginning of
> line anyway.
>
Okay.

>> +test_expect_success 'no newline at eof is on its own line with -B' 
>> '
>> +
>> +	(git diff -B seq; true) > res &&
>> +	grep "^\\\\ No newline at end of file$" res &&
>> +	grep -v "^.\\+\\\\ No newline at end of file" res &&
>> +	grep -v "\\\\ No newline at end of file.\\+$" res
>> +'
>
> Likewise.
>
>>  test_done
>
> Thanks.

No probs.  I will address both your and Jeff's comments sometime 
tomorrow and hopefully send a well formatted patch in next time.

Cheers,
Adam
