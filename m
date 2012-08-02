From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
Date: Thu, 02 Aug 2012 14:52:56 -0700
Message-ID: <7vipd1c66f.fsf@alter.siamese.dyndns.org>
References: <85f291cec03411c61ddf8808e53621ae@imap.force9.net>
 <20120802213346.GA575@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Butcher <dev.lists@jessamine.co.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:53:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx3KL-0000iA-TH
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 23:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258Ab2HBVxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 17:53:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44831 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470Ab2HBVw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 17:52:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDD548374;
	Thu,  2 Aug 2012 17:52:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bPxv4v+Nmm6S3QdndDluGrLen9Y=; b=a5TmqF
	M5HDarXS8qhsaUOZi/AdfTVX+mAcwkyZHTLwZirJUkKGHBW+XpmibRI8AAGHeh0h
	m//Kh74ih7xYbTlaco6Uhwth/yt9FSSwymqNTv2lOOsTFOVjNEjHMx7agou+M0uN
	BZHiE5GJmlO1xyzWwLwhY7CpFu8dgqIYTQQTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=art0eXwNh2xF2rU5H0VTQnq1YAI+zow1
	1dHynGPQiGu2XO2at/HFx2mWqfZ+aSG4ME/LQX9PnJi+cfbVz1kK1FLqRS4f5pzt
	BB/+2tQ1AUx/L/VDYTA+SeTYXUMh4ObPCwfGile5bLkPgOKYEj6EvYj3o5uCpt+6
	XLRHoUH+VCo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBD118373;
	Thu,  2 Aug 2012 17:52:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 131788371; Thu,  2 Aug 2012
 17:52:57 -0400 (EDT)
In-Reply-To: <20120802213346.GA575@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 2 Aug 2012 17:33:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C0ACA30-DCEC-11E1-8379-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202799>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 02, 2012 at 10:11:02PM +0100, Adam Butcher wrote:
>
>> From 01730a741cc5fd7d0a5d8bd0d3df80d12c81fe48 Mon Sep 17 00:00:00 2001
>> From: Adam Butcher <dev.lists@jessamine.co.uk>
>> Date: Wed, 1 Aug 2012 22:25:09 +0100
>> Subject: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
>
> You can drop these lines from the email body; they are redundant with
> what's in your actual header.

s/can/should/ actually, for readability.

>> When operating in --break-rewrites (-B) mode on a file with no newline
>> terminator (and assuming --break-rewrites determines that the diff
>> _is_ a rewrite), git diff previously concatenated the indicator comment
>> '\ No newline at end of file' directly to the terminating line rather
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
> This should not be a problem. Git always outputs newlines; it is stdio
> who might munge it into CRLF if need be (and your patch uses putc, so we
> should be fine).
>
>> A couple of tests have been added to the rewrite suite to confirm that
>> the indicator comment is generated on its own line in both plain diff
>> and rewrite mode.  The latter test fails if the functional part of
>> this patch (i.e. diff.c) is reverted.
>
> Yay, tests.
>
>> ---

Sign-off needed.

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
> Your patch is line-wrapped and cannot be applied as-is (try turning off
> "flowed text" in your MUA).
>
>>  	if (!endp) {
>>  		const char *plain = diff_get_color(ecb->color_diff,
>>  						   DIFF_PLAIN);
>> +		putc('\n', ecb->opt->file);
>>  		emit_line_0(ecb->opt, plain, reset, '\\',
>>  			    nneof, strlen(nneof));
>>  	}
>
> Looks correct. I was curious how the regular (non-rewrite) code path did
> this, and it just sticks the "\n" as part of the nneof string. However,
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

t/perf/perf-lib.sh and t/t5551-http-fetch.sh seem to use "seq";
perhaps we should replace them, then.
