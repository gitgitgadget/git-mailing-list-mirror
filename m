From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: describe XMALLOC_POISON
Date: Wed, 13 Jan 2016 10:23:09 -0800
Message-ID: <xmqqwprdnxte.fsf@gitster.mtv.corp.google.com>
References: <1452686255-8757-1-git-send-email-kuleshovmail@gmail.com>
	<1452704204-1928-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 19:23:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJQ4n-0007hO-Ly
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 19:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908AbcAMSXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 13:23:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752652AbcAMSXR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 13:23:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DFBC43A72F;
	Wed, 13 Jan 2016 13:23:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4g2nhTqCHk/g7MBKKDA77vvMv5k=; b=j8k4xD
	n2Nk4No63Q3aVQokJYiJVSDkkjFHY9HD8S6MFR/y0lP1VVTXQwj0i6FaijSfDH0j
	kDdFc4ZyGGdLm5d5QkfrBiCOtQdjUyY+lVAWfYt59TpFXXF4Du4n7d0Lgblljf/m
	9h5qVzm4s39ntMokoY6depwJeEJzxfs4DTmlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EG/ymmZC50Pk6bE+D8NMTJEoiqJyH2C6
	RvnGkaHNXek+wA/ShuQXzW/obZKYo0c47+3NqOvDM/lJ3RpqcB1COQ7gQpz1luni
	GmoL0N5cU98i/AQehMWRLYRp0/f/klUL7AH4AOQSl5vW5WP65VHyBrcPAVl0sIiX
	xa2XDIeOmPQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D7A2E3A72E;
	Wed, 13 Jan 2016 13:23:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 440793A72D;
	Wed, 13 Jan 2016 13:23:10 -0500 (EST)
In-Reply-To: <1452704204-1928-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Wed, 13 Jan 2016 22:56:44 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B334E9D8-BA22-11E5-9D72-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283961>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> The do_xmalloc() functions may fill an allocated buffer with the
> known value (0xA5) for debugging if we will pass the XMALLOC_POISON
> option during build.
>
> This patch adds description of this option to the Makefile and
> adds it to BASIC_CFLAGS if it was provided.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---

I am guessing that the message this one is a response to is
(incomplete) v1 that I shouldn't look at, and this is v2 that is
expected to be useful.

XMALLOC_POISON is not about "if you are debugging the xmalloc()",
though.  By filling the memory returned with a non-NUL byte, what we
get is to catch callers that depended on the region of memory being
NUL-filled (often happens in early in a short-lived program), so it
is about catching more bugs in the callers of xmalloc() [*1*].

>  Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index f3325de..3f942b5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -367,6 +367,10 @@ all::
>  # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
>  #
>  # Define HAVE_GETDELIM if your system has the getdelim() function.
> +#
> +# Define XMALLOC_POISON if you are debugging the xmalloc(). In a XMALLOC_POISON
> +# build, each allocated buffer by the xmalloc() will be in known state. After
> +# memory allocation, a buffer will be filled with '0xA5' values.

"will be in known state" is not an interesting bit, and I do not
think we want people relying on the exact contents of the
uninitialized bytes.

Personally, I feel that XMALLOC_POISON outlived its usefulness, with
the availability of --valgrind tests and other forms of checks
(including static analyzers) in the modern world.  While I do not
think it hurts to allow people who know what they are doing to say
"make XMALLOC_POISON=YesPlease", I suspect it would cause more harm
to have a wrong description on what it is about here than the new
makefile knob helps them.  Because of the above, this change is
somewhere between "Meh" and "Perhaps a bad idea" to me.

If you have a more compelling story to tell ("XMALLOC_POISON-enabled
build allowed me to hunt down this and that kind of bug because I
can scan the entire address space looking for regions filled with
0xA5 to do X") and description based on that story is in the log
message and also in the Makefile comment, on the other hand, my
above assessment may become vastly move positive, though.  During
the course of running the project since the XMALLOC_POISON was added
in April 2006, I didn't encounter any such interesting debugging
session that helped me myself.

Thanks.

>  
> +ifdef XMALLOC_POISON
> +	BASIC_CFLAGS += -DXMALLOC_POISON
> +endif
> +


[Footnote]

*1* Another reason for choosing 0xA5 is because it is 'odd' and more
likely to cause bus errors on architectures that do not allow
unaligned access when the uninitialized value is used as a pointer,
but its value is fairly limited.
