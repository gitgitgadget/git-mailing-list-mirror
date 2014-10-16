From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 21/25] rev-list: add --index-objects option
Date: Thu, 16 Oct 2014 11:41:35 -0700
Message-ID: <xmqqiojjuaao.fsf@gitster.dls.corp.google.com>
References: <20141015223244.GA25368@peff.net>
	<20141015224430.GU25630@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 20:41:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xepzi-0004zD-35
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 20:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbaJPSli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 14:41:38 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751810AbaJPSlh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 14:41:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF5C616E01;
	Thu, 16 Oct 2014 14:41:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jo31DTcTwXnVji8TV9gu8n6tYlc=; b=nPlS1I
	O+elfZwn3pEkGOOFKO2DI6k6jCTgJR8UDiHurfQnc04LAFO4o0NPCjyPA99jeYTS
	fCIY41KICbRLfh5BPwq8zhZBCDbS6dCUq7ZnPeROOlTRU3qhbFtKz2NzveRAU6g8
	JQnZnLSIY59/uviFq9qKFkvX6rQj8l6PHxWH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ehfWLzHo3sUEYO1jdDZcmg4V9jxihsYS
	a5KfGmIROMnoak9jvG1Qf104rioaUeDCjyqUS1E+6MaRkV+QZv3Z4SvN5R5tYxyg
	XVlLfLJPmBnKZzg0WMiyKEI8338NeXBema+FDS0MBnCnOCKNgUObntNIa1QOZu4R
	k9OW+35xpk8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6D1916E00;
	Thu, 16 Oct 2014 14:41:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4188616DFD;
	Thu, 16 Oct 2014 14:41:36 -0400 (EDT)
In-Reply-To: <20141015224430.GU25630@peff.net> (Jeff King's message of "Wed,
	15 Oct 2014 18:44:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0EE322CE-5564-11E4-9999-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There is currently no easy way to ask the revision traversal
> machinery to include objects reachable from the index (e.g.,
> blobs and trees that have not yet been committed). This
> patch adds an option to do so.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I was tempted to call this just "--index", because I could not think of
> what else "--index" would mean in the context of rev-list. But I also
> worried about weird interactions with other commands that take revision
> arguments. And since this is mostly for internal use anyway, I figured
> the more verbose name is not too bad. I could be convinced otherwise,
> though.

I agree that "--index" is a bad name as it usually is used in a
particular context: the command can work on various combination of
working tree and the index, and I am asking it to work on both
(e.g. "apply --index" as opposed to "apply --cached").

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 4cf94c6..03ab343 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -172,6 +172,13 @@ explicitly.
>  	Pretend as if all objects mentioned by reflogs are listed on the
>  	command line as `<commit>`.
>  
> +--index-objects::

This risks "index" getting misunderstood as a verb, e.g. "please
enumerate the objects and assign labels to later refer to them",
doesn't it?

"--indexed-objects" (short for "--show-objects-in-the-index") or
something?

> +	Pretend as if all objects used by the index (any blobs, and any
> +	trees which are mentioned by the index's cache-tree extension)
> +	ad listed on the command line. Note that you probably want to

s/ad/are/, probably?

> +	use `--objects`, too, as there are by definition no commits in
> +	the index.

For gitlinks/submodules, the index records names of the commit
objects, they are not listed, and that is the right behaviour, but
this description invites some confusion.
