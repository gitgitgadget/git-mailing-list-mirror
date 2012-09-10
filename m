From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/14] Change fetch_pack() and friends to take
 string_list arguments
Date: Mon, 10 Sep 2012 13:56:29 -0700
Message-ID: <7vipblmwaq.fsf@alter.siamese.dyndns.org>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
 <1347171589-13327-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 10 22:56:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBB28-0001x3-Ec
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 22:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847Ab2IJU4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 16:56:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48595 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753648Ab2IJU4b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 16:56:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 617C393D0;
	Mon, 10 Sep 2012 16:56:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aeGqmwbsbBH4hwCEXY01utB63Xc=; b=L788nV
	4nZn/kfiB8F/A7M1fDRdkIeu2x1kAM3bOeQf/ixWnssvZsRA63W7qIrOFXSRBe4F
	0LQfc0xxAdRFFdab5/rgJOozNXAh+7ejxcX8W7jVx0si65XVVrXmDsX2WJFhAdLX
	QBk94mrfhpZxUhNiCNEGLOclMoMGta1Q6r78M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kC7buAbck9+LKGeuXeLO0CDYFISGq5al
	oZkxuWTm/YXd7ewS8p2tXAjjqkb8hQ3pvgUxZOYG8zWHAiWw7VeparpAbc5xIIO0
	D1cW3ABJqFB5Yw7vjvndoC7rUNPSfa0n74D2c0YhsvUMNIs6pf689zp5j8tUlKB9
	YYqoeSwLZJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EB5593CF;
	Mon, 10 Sep 2012 16:56:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8C5793CE; Mon, 10 Sep 2012
 16:56:30 -0400 (EDT)
In-Reply-To: <1347171589-13327-6-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Sun, 9 Sep 2012 08:19:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF1CAD1E-FB89-11E1-AD6E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205179>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Instead of juggling <nr_heads,heads> (sometimes called
> <nr_match,match>), pass around the list of references to be sought in
> a single string_list variable called "sought".  Future commits will
> make more use of string_list functionality.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

The earlier bikeshedding-fest on variable names seems to have
produced a winner ;-) I think "sought" captures what it is about
very well.

> diff --git a/fetch-pack.h b/fetch-pack.h
> index 1dbe90f..a6a8a73 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -1,6 +1,8 @@
>  #ifndef FETCH_PACK_H
>  #define FETCH_PACK_H
>  
> +#include "string-list.h"
> +
>  struct fetch_pack_args {
>  	const char *uploadpack;
>  	int unpacklimit;
> @@ -21,8 +23,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
>  		       int fd[], struct child_process *conn,
>  		       const struct ref *ref,
>  		       const char *dest,
> -		       int nr_heads,
> -		       char **heads,
> +		       struct string_list *sought,
>  		       char **pack_lockfile);

This is a tangent, but I _think_ our header files ignore the dogma
some other projects follow that insists on each header file to be
self sufficient, i.e.

	gcc fetch-pack.h

should pass.  Instead, our *.c files that include fetch-pack.h are
responsible for including everything the headers they include need.
So even though fetch-pack.h does not include run-command.h, it
declares a function that takes "struct child_process *" in its
arguments.  The new "struct string_list *" falls into the same camp.

Given that, I'd prefer to see the scope of this patch series shrunk
and have the caller include string-list.h, not here.

Updating the headers and sources so that each to be self sufficient
is a different topic, and I do not think there is a consensus yet if
we want to go that route.
