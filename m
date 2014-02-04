From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 04 Feb 2014 22:09:44 +0100
Message-ID: <87d2j2wpnr.fsf@fencepost.gnu.org>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<87lhxqwse8.fsf@fencepost.gnu.org>
	<xmqq8utq8uxn.fsf@gitster.dls.corp.google.com>
	<xmqq4n4e8uf1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 22:17:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAnNJ-0004pt-QS
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 22:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934780AbaBDVR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 16:17:27 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:53286 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934925AbaBDVRV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 16:17:21 -0500
Received: from localhost ([127.0.0.1]:52329 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WAnMu-0006gV-Ha; Tue, 04 Feb 2014 16:17:20 -0500
Received: by lola (Postfix, from userid 1000)
	id 3CB29E0478; Tue,  4 Feb 2014 22:09:44 +0100 (CET)
In-Reply-To: <xmqq4n4e8uf1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 04 Feb 2014 13:00:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241556>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> David Kastrup <dak@gnu.org> writes:
>>
>>> Whitespace error in line 1778.  Should I be reposting?
>>
>> Heh, let me try to clean it up first and then repost for your
>> review.
>>
>> Thanks.
>
> -- >8 --
> From: David Kastrup <dak@gnu.org>
>
> Making a single preparation run for counting the lines will avoid memory
> fragmentation.  Also, fix the allocated memory size which was wrong
> when sizeof(int *) != sizeof(int), and would have been too small
> for sizeof(int *) < sizeof(int), admittedly unlikely.
>
> Signed-off-by: David Kastrup <dak@gnu.org>
> ---
>
>  One logic difference from what was posted is that sb->lineno[num]
>  is filled with the length of the entire buffer when the file ends
>  with a complete line.

Where's the difference?  This is exactly what will happen with my code
as well.  I _do_ rely on memchr(whatever, '\n', 0) to return NULL
without looking at any memory for that.  If there is a fear of memchr
not being able to deal with a count of 0, this code needs to be somewhat
more complex.

>  I do not remember if the rest of the logic
>  actually depends on it (I think I use lineno[n+1] - lineno[n] to
>  find the end of line,

Well, you do it about _half_ the time.  The other half, you scan for the
'\n' explicitly.

>  The original code dates back to 2006 when the author of the code
>  was not paid for doing anything for Git but was doing it as a
>  weekend and evening hobby, so it may not be so surprising to find
>  this kind of "what was I thinking when I wrote it" inefficiency in
>  such a code with $0 monetary value ;-)

Oh, _this_ patch is not in the "I want to make money from it" range.  If
that were the case, I should not have bothered at all.  This is just the
"this code offends my sense of aesthetics" class.  It's purely optional
to apply.  It's conceivable that it will make a performance difference
on non-glibc (or what it's called) platforms.

-- 
David Kastrup
