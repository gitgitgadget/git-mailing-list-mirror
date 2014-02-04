From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 04 Feb 2014 14:06:01 -0800
Message-ID: <xmqqmwi67cty.fsf@gitster.dls.corp.google.com>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
	<874n4ewouz.fsf@fencepost.gnu.org>
	<xmqqr47i7dt4.fsf@gitster.dls.corp.google.com>
	<87zjm6v99y.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 04 23:06:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAo8n-0004kI-39
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934113AbaBDWGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:06:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55385 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932979AbaBDWGL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:06:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48E4E695F9;
	Tue,  4 Feb 2014 17:06:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LSbl+8S9Zetm8i7Sy51DcwPx0B8=; b=yCLEhF
	YnhtEiltCl6xUt40zep6SS2wjk9dDVX9Xo5MIepJuRE4mDiUCHG85IvNGKtFg0LE
	2aG6CN+fyc4ZWUKO+Z5YQWTRnywxpWUnGZ/Kt/dqfNtk5/Umjdjd7STXD9+6aIEQ
	GpilwFjY9iqUgLpTHssNKcnwyQ/gXcHvEa+lE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s5yFJdMcRriOcXrQYFiVczW1mgGJHQ5W
	nMnrvJOuG0ptLhwcfu9IhX4cqgcpkS1tWpwC4UoGgpQaV295rAviBSPvTWUX42Jz
	K7+B5yLeC7De7jGSp4ORET9edsadt6K/aF5fRgQpWNjyo1R1AfjKvVK6P9gQFSy5
	4yo4pC59BdY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D40A0695F7;
	Tue,  4 Feb 2014 17:06:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE090695EC;
	Tue,  4 Feb 2014 17:06:09 -0500 (EST)
In-Reply-To: <87zjm6v99y.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Tue, 04 Feb 2014 22:48:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8D9EFBF4-8DE8-11E3-91AA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241563>

David Kastrup <dak@gnu.org> writes:

>> so something like
>>
>> 	for (p = buf; p < end; p++) {
>>         	p = find the end of this line
>>                 if (!p)
>>                 	break;
>> 		num++;
>> 	}
>>
>> perhaps?
>
> Would crash on incomplete last line.

Hmph, even with "if !p"?   From your other message:

+	for (p = buf;; num++) {
+		p = memchr(p, '\n', end - p);
+		if (p) {
+			p++;
+			continue;
 		}
+		break;
+	}

If you flip the if statement around that would be the same as:

+	for (p = buf;; num++) {
+		p = memchr(p, '\n', end - p);
+		if (!p)
			break;
		p++;
+	}

And with "loop action not in the control part", that would be the
same as:

	for (p = buf; ; p++) {
		p = memchr...
                if (!p)
                	break;
		num++;
	}

no?  Would this crash on incomplete last line?

Ahh, "p < end" in "for (p = buf; p < end; p++) {" is not correct;
you depend on overrunning the end of the buffer to feed length 0 to
memchr and returning NULL inside the loop.  So to be equivalent to
your version, the contination condition needs to be

	for (p = buf; p <= end; p++) {

But that last round of the loop will be no-op, so "p < end" vs "p <=
end" does not make any difference.  It is not even strictly
necessary because memchr() limits the scan to end, but it would
still be a good belt-and-suspenders defensive coding practice, I
would think.

+	for (p = buf;;) {
+		*lineno++ = p - buf;
+		p = memchr(p, '\n', end - p);
+		if (p) {
+			p++;
+			continue;
 		}
+		break;
 	}

Can we do the same transformation here?

	for (p = buf;;) {
        	*lineno++ = p - buf;
                p = memchr...
                if (!p)
                	break;
		p++;
	}

which is the same as

	for (p = buf; ; p++) {
        	*lineno++ = p - buf;
                p = memchr...
                if (!p)
                	break;
	}

and the latter has the loop control p++ at where it belongs to. The
post-condition of one iteration of the body of the loop being "p
points at the terminating LF of this line", incrementing the pointer
is how the loop control advances the pointer to the beginning of the
next line.

If we wanted to have a belt-and-suspenders safety, we need "p <=
end" here, not "p < end", because of how p is used when it is past
the last LF.  As we want to make these two loops look similar, that
means we should use "p <= end" in the previous loop as well.

This was fun ;-)
