From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can I fetch an arbitrary commit by sha1?
Date: Tue, 07 Oct 2014 09:52:33 -0700
Message-ID: <xmqqwq8bizzi.fsf@gitster.dls.corp.google.com>
References: <CAENte7htO13s91UJFNzW4aBhsGxE=LpnvaZfce+vqQU5+a-cYg@mail.gmail.com>
	<CAPBPrnsA4KxNximtKXcC37kuwBHK0Esytdm4nsgLHkrJSg3Ufw@mail.gmail.com>
	<20141002161006.GB2505@peff.net>
	<CACh33FpWPuyJRryf6hzbAkqWJMwzz1mLLDDRxEQ0niT2CznTRg@mail.gmail.com>
	<CACsJy8B0dbE0C3M0PO-EfaZ_bSxwGJSFVejEGFzjHSOZKOc+Jw@mail.gmail.com>
	<20141007131257.GA24348@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Donnelly <batrick@batbytes.com>, Jeff King <peff@peff.net>,
	Dan Johnson <computerdruid@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 18:52:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbY09-00038V-8k
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 18:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbaJGQwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 12:52:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60770 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753881AbaJGQwg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 12:52:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A1D6D145C5;
	Tue,  7 Oct 2014 12:52:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tzNDfo0wg+FEFd/HRTIeLoqkI+w=; b=XoBlxb
	2JuNesm5/OyI3PXqTBGJu7G64EQxGwPEj/FYK94iRSvb05jtBvRxaDUk012AcjN4
	/+dbb/jmaX47R5EqDP9N8WPJVX3i4bPOIgFI8Oyq1ml2M3zJoA5Id2wyKRU3svvh
	67IYuPjnmIVrZglIk5eZUpy7z6sv5yJ7EgfRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i05jdEjWVEXnfihAGOdiXJ1QXDy4/F2G
	uIAc5BCR9myicJ2oy/9RRyMZ7fST2D0HaC0m3Avh6TFcFYHOFiF9n3Y70aTTzoI/
	9vAx0M4rLPRge78/AAEtXtvnSnp4xNI2nu7hfPOhxvr8492WwBhT0gj5FPkjBq+O
	l5Cet/bEkhY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 98100145C4;
	Tue,  7 Oct 2014 12:52:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00230145C3;
	Tue,  7 Oct 2014 12:52:34 -0400 (EDT)
In-Reply-To: <20141007131257.GA24348@lanh> (Duy Nguyen's message of "Tue, 7
	Oct 2014 20:12:57 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 565396A8-4E42-11E4-809B-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257933>

Duy Nguyen <pclouds@gmail.com> writes:

> Hmm.. Junio already did most of the work in 051e400 (helping
> smart-http/stateless-rpc fetch race - 2011-08-05), so all we need to
> do is enable uploadpack.allowtipsha1inwant and apply this patch

Not that patch, I would think.

I would understand "if !stateless_rpc and !allowtipsha1 then it is
an error", though.

> -- 8< --
> diff --git a/upload-pack.c b/upload-pack.c
> index c789ec0..493f8ee 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -454,10 +454,6 @@ static void check_non_tip(void)
>  	char namebuf[42]; /* ^ + SHA-1 + LF */
>  	int i;
>  
> -	/* In the normal in-process case non-tip request can never happen */
> -	if (!stateless_rpc)
> -		goto error;
> -
>  	cmd.argv = argv;
>  	cmd.git_cmd = 1;
>  	cmd.no_stderr = 1;
> -- 8< --
>
> If we already let smart-http do this, I don't see any harm in letting
> git protocol do the same (even though it's the the original reason why
> this code exists).
> --
> Duy
