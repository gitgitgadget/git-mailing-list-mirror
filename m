From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/17] commit-slab: provide a static initializer
Date: Thu, 12 Jun 2014 11:15:49 -0700
Message-ID: <xmqq7g4m6lka.fsf@gitster.dls.corp.google.com>
References: <20140610213509.GA26979@sigill.intra.peff.net>
	<20140610214251.GO19147@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 20:16:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv9Xd-0003f0-Hg
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 20:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbaFLSP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 14:15:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64911 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbaFLSP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 14:15:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 933071DC12;
	Thu, 12 Jun 2014 14:15:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cGzhePJ3Z8BcU2RmBrJErfXxzbk=; b=nzm9Jc
	uDxMhNryKPVCla5SY++WFQQBsMhktTAq2wTvsWdkcbipYSzWnqgO8cAj50ZbwRPn
	HpUT2WySjihF0USGXZEoS8yw+c3G31DZuMRqEOnmRqhEL0li7q61Zfk4BgB2w4mI
	xJj/+l5UFBmxayZCjoV66JevSN7+32JQMw+lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i+wgoj3kTG/BU0qI58oxdWbi830pMIKX
	fJMEOhHQkxM1bB/0yyXRMDNwr/BQR8glifJ4NgehaU5Ax4QKs3I8R8EzCvDdd3o5
	v7jL7nIYbt2crGsZAPEc9iUiI3KmfrSRCBAo43fbGUbiPreaiFRCocO7x3GBMzyx
	3AM11hnKshk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 886C91DC11;
	Thu, 12 Jun 2014 14:15:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 83EC71DC0C;
	Thu, 12 Jun 2014 14:15:51 -0400 (EDT)
In-Reply-To: <20140610214251.GO19147@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 10 Jun 2014 17:42:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 961C1D00-F25D-11E3-818E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251470>

Jeff King <peff@peff.net> writes:

> Callers currently must use init_foo_slab() at runtime before
> accessing a slab. For global slabs, it's much nicer if we
> can initialize them in BSS, so that each user does not have
> to add code to check-and-initialize.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> There was no comment on this one in v1. I'd be curious if anyone has
> comments on what I wrote in:
>
>   http://article.gmane.org/gmane.comp.version-control.git/251099

Why do we need an initialiser at this point (in other words, how
have other existing slab users coped without having one)?

I think they call init_*_slab() when the slab is needed/used the
first time (e.g. it is not even worth initialising indegree slab
unless we are sorting in topo order).

Unlike the author-date and indegree slabs, there are too many entry
points that may want access to the buffer slab (save_commit_buffer's
default being on does not help us either), so it would be much less
error prone to always initialise a static slab like this patch does,
I guess.


>  commit-slab.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/commit-slab.h b/commit-slab.h
> index cc114b5..375c9c7 100644
> --- a/commit-slab.h
> +++ b/commit-slab.h
> @@ -117,4 +117,16 @@ static int stat_ ##slabname## realloc
>   * catch because GCC silently parses it by default.
>   */
>  
> +/*
> + * Statically initialize a commit slab named "var". Note that this
> + * evaluates "stride" multiple times! Example:
> + *
> + *   struct indegree indegrees = COMMIT_SLAB_INIT(1, indegrees);
> + *
> + */
> +#define COMMIT_SLAB_INIT(stride, var) { \
> +	COMMIT_SLAB_SIZE / sizeof(**((var).slab)) / (stride), \
> +	(stride), 0, NULL \
> +}
> +
>  #endif /* COMMIT_SLAB_H */
