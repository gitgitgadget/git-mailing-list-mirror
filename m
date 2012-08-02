From: Adam Butcher <dev.lists@jessamine.co.uk>
Subject: Re: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
Date: Thu, 02 Aug 2012 23:22:50 +0100
Message-ID: <2398996b47dd4f3b12ea73d79297ca98@imap.force9.net>
References: <85f291cec03411c61ddf8808e53621ae@imap.force9.net>
 <20120802213346.GA575@sigill.intra.peff.net>
Reply-To: <dev.lists@jessamine.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:23:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx3nL-0001xC-9q
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 00:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336Ab2HBWW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 18:22:57 -0400
Received: from avasout02.plus.net ([212.159.14.17]:46003 "EHLO
	avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab2HBWW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 18:22:56 -0400
Received: from webmail.plus.net ([212.159.8.87])
	by avasout02 with smtp
	id hyNq1j0081sg6PG01yNrzv; Thu, 02 Aug 2012 23:22:52 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.0 cv=GvbACzJC c=1 sm=1 a=w/v6d3Yw9YqO0eqsxHCYQw==:17
 a=EDeDkkTReK4A:10 a=fIUNk3G47tUA:10 a=ESsPSRNNhagA:10 a=5LfTt-Tm1vgA:10
 a=JRq8KZZ3GZoA:10 a=IkcTkHD0fZMA:10 a=ZBkl__CYAAAA:8 a=mrHjP8x4AAAA:8
 a=D_kZAfWsgvR8lUD4AWsA:9 a=QEXdDO2ut3YA:10 a=aVC6qsWM_lQA:10
 a=w/v6d3Yw9YqO0eqsxHCYQw==:117
X-AUTH: jessaminenet+dev.lists:2501
Received: from munkyhouse.force9.co.uk ([84.92.244.81])
 by webmail.plus.net
 with HTTP (HTTP/1.1 POST); Thu, 02 Aug 2012 23:22:50 +0100
Mail-Reply-To: <dev.lists@jessamine.co.uk>
In-Reply-To: <20120802213346.GA575@sigill.intra.peff.net>
X-Sender: dev.lists@jessamine.co.uk
User-Agent: Roundcube Webmail/0.7.2
X-Originating-IP: [84.92.244.81]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202805>

On 02.08.2012 22:33, Jeff King wrote:
> On Thu, Aug 02, 2012 at 10:11:02PM +0100, Adam Butcher wrote:
>
>> From 01730a741cc5fd7d0a5d8bd0d3df80d12c81fe48 Mon Sep 17 00:00:00 
>> 2001
>> From: Adam Butcher <dev.lists@jessamine.co.uk>
>> Date: Wed, 1 Aug 2012 22:25:09 +0100
>> Subject: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
>
> You can drop these lines from the email body; they are redundant with
> what's in your actual header.
>
I sent via a webmail interface and wasn't sure what format the 
resulting mail would have so decided to paste the entire formatted patch 
in.  Seeing as the webmailer has corrupted my patch with word wrapping 
(which I noticed almost immediately when my post hit gmane and have 
since found out that it apparently cannot be disabled?!) it was a bad 
idea all round.  I could attach as a file but this is cumbersome from a 
review and apply point of view so I think I'll hook up git to gmail's 
tls smtp server so that I can use git send-email direct rather than 
messing about with a GUI.

>> When operating in --break-rewrites (-B) mode on a file with no 
>> newline
>> terminator (and assuming --break-rewrites determines that the diff
>> _is_ a rewrite), git diff previously concatenated the indicator 
>> comment
>> '\ No newline at end of file' directly to the terminating line 
>> rather
>> than on a line of its own.  The resulting diff is broken; claiming
>> that the last line actually contains the indicator text.  Without -B
>> there is no problem with the same files.
>>
>> This patch fixes the former case by inserting a newline into the
>> output prior to emitting the indicator comment.
>
> Makes sense.
>
>> Potential issue: Currently this emits an ASCII 10 newline character
>> only.  I'm not sure whether this will be okay on all platforms; it
>> seems to work fine on Windows and GNU at least.
>
> This should not be a problem. Git always outputs newlines; it is 
> stdio
> who might munge it into CRLF if need be (and your patch uses putc, so 
> we
> should be fine).
>
Great.

>> A couple of tests have been added to the rewrite suite to confirm 
>> that
>> the indicator comment is generated on its own line in both plain 
>> diff
>> and rewrite mode.  The latter test fails if the functional part of
>> this patch (i.e. diff.c) is reverted.
>
> Yay, tests.
>
>> ---
>>  diff.c                  |  1 +
>>  t/t4022-diff-rewrite.sh | 27 +++++++++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/diff.c b/diff.c
>> index 95706a5..77d4e84 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -574,6 +574,7 @@ static void emit_rewrite_lines(struct
>> emit_callback *ecb,
>
> Your patch is line-wrapped and cannot be applied as-is (try turning 
> off
> "flowed text" in your MUA).
>
Indeed.  Grr.  If only I could.  I'll test that whatever solution I 
come up with works before posting again with an update addressing yours 
and Junio's comments.

>>  	if (!endp) {
>>  		const char *plain = diff_get_color(ecb->color_diff,
>>  						   DIFF_PLAIN);
>> +		putc('\n', ecb->opt->file);
>>  		emit_line_0(ecb->opt, plain, reset, '\\',
>>  			    nneof, strlen(nneof));
>>  	}
>
> Looks correct. I was curious how the regular (non-rewrite) code path 
> did
> this, and it just sticks the "\n" as part of the nneof string. 
> However,
> we would not want that here, because each line should have its own
> color markers.
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
> Seq is (unfortunately) not portable. I usually use a perl snippet
> instead, like:
>
>   perl -le 'print for (1..10)'
>
> Though I think we are adjusting that to use $PERL_PATH these days.
>
No probs.  Will change.

Cheers
Adam
