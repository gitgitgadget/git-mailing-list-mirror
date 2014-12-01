From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat: convert modes to use portable file type values
Date: Sun, 30 Nov 2014 19:11:39 -0800
Message-ID: <xmqq8uisrrmc.fsf@gitster.dls.corp.google.com>
References: <87vblxl8ah.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 04:11:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvHOs-00034k-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 04:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbaLADLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 22:11:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752294AbaLADLm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 22:11:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A16623D8C;
	Sun, 30 Nov 2014 22:11:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jtbksBQ12KaAxB+fjBRIK8sWsbo=; b=ILGqaM
	SZFE7i5aFlFASj2VPrcEfjiEiEbuxM7LhAZlxgjPpNGdqxjtpHhnUmen+HTU5Ccd
	ZTEl6xijnDb7Nd58Jt6xUee4qHjmypvbxdCGu6SftfFm9PGW9XkkPrfHFY1j98DS
	a+bHnZzRwZnP+MqJqc7HkSpDLfS1HztPVBxUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IBwpHNKthwCtN9GXFE1WvT+IfLnrpERm
	rHlvs8TlRYN3spirJR/NRsGtRy13CD0ld9xw7Vtq6EIRWMHOnCU/DqFnLktz/Im8
	pmg/qmvWpNWq2TtW19QWZtVwvgEyPzxMHIkZRLcQZ+LOqkgkdJEYxwjOeNJEFy2E
	Hxxo52lXFJA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F4A123D8B;
	Sun, 30 Nov 2014 22:11:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4E1923D88;
	Sun, 30 Nov 2014 22:11:40 -0500 (EST)
In-Reply-To: <87vblxl8ah.fsf@gmail.com> (David Michael's message of "Sat, 29
	Nov 2014 21:41:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C52989BC-7907-11E4-9F4A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260465>

David Michael <fedora.dm0@gmail.com> writes:

> This is my most recent attempt at solving the problem of z/OS using
> different file type values than every other OS.  I believe it should be
> safe as long as the file type bits don't ever need to be converted back
> to their native values (and I didn't see any instances of that).
>
> I've been testing it by making commits to the same repositories on
> different operating systems and pushing those changes around, and so far
> there have been no issues.
>
> Can anyone foresee any problems with this method?

I cannot offhand comment on the last question above, but the
reliance on exact S_IFxxx bit assignment was identified as a
potential problem from very early days of Git that we have known
about but didn't have need to address on any system that mattered.

This is a long overdue issue and I am happy to see it getting
tackled.  The patch seems to be a sensible implementation of your
design decision to use the one-way conversion.

> diff --git a/compat/stat.c b/compat/stat.c
> new file mode 100644
> index 0000000..0ff1f2f
> --- /dev/null
> +++ b/compat/stat.c
> @@ -0,0 +1,49 @@
> +#define _POSIX_SOURCE
> +#include <stddef.h>    /* NULL         */
> +#include <sys/stat.h>  /* *stat, S_IS* */
> +#include <sys/types.h> /* mode_t       */
> +
> +static inline mode_t mode_native_to_git(mode_t native_mode)
> +{
> +	if (S_ISREG(native_mode))
> +		return 0100000 | (native_mode & 07777);
> +	else if (S_ISDIR(native_mode))
> +		return 0040000 | (native_mode & 07777);
> +	else if (S_ISLNK(native_mode))
> +		return 0120000 | (native_mode & 07777);
> +	else if (S_ISBLK(native_mode))
> +		return 0060000 | (native_mode & 07777);
> +	else if (S_ISCHR(native_mode))
> +		return 0020000 | (native_mode & 07777);
> +	else if (S_ISFIFO(native_mode))
> +		return 0010000 | (native_mode & 07777);
> +	else /* Non-standard type bits were given. */
> +		return native_mode & 07777;
> +}
