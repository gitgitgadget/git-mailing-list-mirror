From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 4 Feb 2014 22:28:01 -0000
Organization: OPDS
Message-ID: <79CA69ED4EBA4271A40DE714AEEA5424@PhilipOakley>
References: <1391544367-14599-1-git-send-email-dak@gnu.org><87lhxqwse8.fsf@fencepost.gnu.org><xmqq8utq8uxn.fsf@gitster.dls.corp.google.com><xmqq4n4e8uf1.fsf@gitster.dls.corp.google.com> <87d2j2wpnr.fsf@fencepost.gnu.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "David Kastrup" <dak@gnu.org>, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 23:28:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAoTS-0006jp-F9
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933692AbaBDW2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:28:05 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:39179 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755201AbaBDW2D (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Feb 2014 17:28:03 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Anw6AAVp8VICYJR6/2dsb2JhbABZgww4EAOJA7VTAQMBAQIBAQeBBxd0giAFAQEEAQgBAR0RHgEBIQUGAgMFAgEDDgMEAQEKJRQBBBoGBw8IBgESCAIBAgMBh2wMCc4ujnU1gnaBFASJEYYYijSJHYdSgy08
X-IPAS-Result: Anw6AAVp8VICYJR6/2dsb2JhbABZgww4EAOJA7VTAQMBAQIBAQeBBxd0giAFAQEEAQgBAR0RHgEBIQUGAgMFAgEDDgMEAQEKJRQBBBoGBw8IBgESCAIBAgMBh2wMCc4ujnU1gnaBFASJEYYYijSJHYdSgy08
X-IronPort-AV: E=Sophos;i="4.95,782,1384300800"; 
   d="scan'208";a="600327712"
Received: from host-2-96-148-122.as13285.net (HELO PhilipOakley) ([2.96.148.122])
  by out1.ip06ir2.opaltelecom.net with SMTP; 04 Feb 2014 22:28:00 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241578>

From: "David Kastrup" <dak@gnu.org>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
Sent: Tuesday, February 04, 2014 9:09 PM
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for 
every line


> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> David Kastrup <dak@gnu.org> writes:
>>>
>>>> Whitespace error in line 1778.  Should I be reposting?
>>>
>>> Heh, let me try to clean it up first and then repost for your
>>> review.
>>>
>>> Thanks.
>>
>> -- >8 --
>> From: David Kastrup <dak@gnu.org>
>>
>> Making a single preparation run for counting the lines will avoid 
>> memory
>> fragmentation.  Also, fix the allocated memory size which was wrong
>> when sizeof(int *) != sizeof(int), and would have been too small
>> for sizeof(int *) < sizeof(int), admittedly unlikely.
>>
>> Signed-off-by: David Kastrup <dak@gnu.org>
>> ---
>>
>>  One logic difference from what was posted is that sb->lineno[num]
>>  is filled with the length of the entire buffer when the file ends
>>  with a complete line.
>
> Where's the difference?  This is exactly what will happen with my code
> as well.  I _do_ rely on memchr(whatever, '\n', 0) to return NULL
> without looking at any memory for that.  If there is a fear of memchr
> not being able to deal with a count of 0, this code needs to be 
> somewhat
> more complex.

A bit of googling found http://marc.info/?l=gnulib-bug&m=130108029329021 
which suggests that behaviour can't be relied upon, and that perhaps 
some code is 'buggy' relative to expectations (hence the patch it 
proposed).

It suggests that one can't properly reference a zero length object.

>
>>  I do not remember if the rest of the logic
>>  actually depends on it (I think I use lineno[n+1] - lineno[n] to
>>  find the end of line,
>
> Well, you do it about _half_ the time.  The other half, you scan for 
> the
> '\n' explicitly.
>
>>  The original code dates back to 2006 when the author of the code
>>  was not paid for doing anything for Git but was doing it as a
>>  weekend and evening hobby, so it may not be so surprising to find
>>  this kind of "what was I thinking when I wrote it" inefficiency in
>>  such a code with $0 monetary value ;-)
>
> Oh, _this_ patch is not in the "I want to make money from it" range. 
> If
> that were the case, I should not have bothered at all.  This is just 
> the
> "this code offends my sense of aesthetics" class.  It's purely 
> optional
> to apply.  It's conceivable that it will make a performance difference
> on non-glibc (or what it's called) platforms.
>
> -- 
> David Kastrup
> --

Philip 
