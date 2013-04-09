From: Junio C Hamano <gitster@pobox.com>
Subject: Re: write() _will_ fail on Mac OS X/XNU if nbytes > INT_MAX
Date: Tue, 09 Apr 2013 15:50:42 -0700
Message-ID: <7v4nffpbct.fsf@alter.siamese.dyndns.org>
References: <CAEDE852zw9EhmnVaWb_oa_BX_d_--TZoTcs1kgkMPHooM_E6Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: Filipe Cabecinhas <filcab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 00:50:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPhNL-0000IK-6D
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 00:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147Ab3DIWuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 18:50:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759595Ab3DIWup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 18:50:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2572C15157;
	Tue,  9 Apr 2013 22:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tE1r3eDTYYA2qSJ2gScklDBDKnA=; b=q0UKv5
	KS9TuMotlivSPD+9T6qP82cyU6EXM8A01e6kbw9FH/3WjSuLerQEsGZ7il7FAJUt
	j/8iQPysSUWy5q9c8svYOAGqMiLPJFF9W+dVOWIbvUusFcKFRPU2biFsWa3AV9vH
	ia81YluGDL3w8wSokaLRMhEe+Y3V81GrGe3ik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rHc0uDaF91NltTMg6rBlnSAeZFDUtCkF
	Hu5iThDSZHxLssLR0hqSdaJeeHSt8KhoeKGeJ63AR8JMWNraH24s5ZeiSlTmfBK4
	HQxtW1DuRawbQO3qVNnukG54oBNPgXGNSgUF2WiOpmGd2Mokuo+K8pxz8iIoESMk
	2SI0D+bvgTY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 183BF15156;
	Tue,  9 Apr 2013 22:50:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29C9D15154; Tue,  9 Apr
 2013 22:50:44 +0000 (UTC)
In-Reply-To: <CAEDE852zw9EhmnVaWb_oa_BX_d_--TZoTcs1kgkMPHooM_E6Cw@mail.gmail.com> (Filipe
 Cabecinhas's message of "Tue, 9 Apr 2013 15:31:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E944932E-A167-11E2-B674-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220649>

Filipe Cabecinhas <filcab@gmail.com> writes:

>
> Testing with dd bs=INT_MAX+1 count=1 also gets me an “Invalid
> argument” error, while bs=INT_MAX will do what's expected.
>
> I have a preliminary patch that fixes it, but it may not be the
> preferred way. The code is not ifdef'ed out and I'm doing the fix in
> write_in_full(), while it may be preferred to do the fix in xwrite().
>
> A radar bug has been submitted to Apple about this, but I think git
> could tolerate the bug while it isn't fixed, by working around it.
>
> Thank you,
>
>   Filipe
>
> diff --git a/wrapper.c b/wrapper.c
> index bac59d2..474d760 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -187,7 +187,12 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
>  	ssize_t total = 0;
>  
>  	while (count > 0) {
> -		ssize_t written = xwrite(fd, p, count);
> +		ssize_t written = 0;
> +        if (count >= INT_MAX)
> +			written = xwrite(fd, p, INT_MAX-1);
> +        else
> +			written = xwrite(fd, p, count);

I think it is better to fix it in much lower level of the stack, as
other codepaths would call write(2), either thru xwrite() or
directly.

Ideally the fix should go to the lowest level, i.e. the write(2).  I
do not care if it is done in the kernel or in the libc wrapping
code; the above does not belong to our code (in an ideal world, that
is).

Otherwise you would have to patch everything in /usr/bin, no?

But you do not live in an ideal world and neither do we.  I think
the least ugly way may be to add compat/clipped-write.c that
implements a loop like the above in a helper function:

	ssize_t clipped_write(int, const void *, size_t);

and have a

	#ifdef NEED_CLIPPED_WRITE
	#define write(x,y,z) clipped_write((x),(y),(z))
        #endif

in git-compat-util.h, or something.  Makefile needs to get adjusted
to link with compat/clipped-write.o when NEED_CLIPPED_WRITE is
defined as well.
