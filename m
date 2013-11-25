From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit-slab: declare functions "static inline"
Date: Mon, 25 Nov 2013 11:36:31 -0800
Message-ID: <xmqqy54cxohs.fsf@gitster.dls.corp.google.com>
References: <cover.1385405977.git.tr@thomasrast.ch>
	<f4d1ff9f487f797da35faa86c72d11832903a50d.1385405977.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Nov 25 20:36:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl1xX-0005OC-Gm
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 20:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820Ab3KYTgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 14:36:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536Ab3KYTge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 14:36:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BA01533CF;
	Mon, 25 Nov 2013 14:36:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iau135SBilNXdo8aPYYBlnu2asY=; b=qsc6C4
	+7MRIXrhQl5fYoDBjws3urAejUavV74D6XKw2PUThtJEPd3dxmLadiyMnKLJl/5S
	UntG02LSTBaCNlCp+WNNtnYv/QUQ0s95khk1JKFBHvAwC28J1mFV4b1H3C3g64+1
	/raS0Jmis0zMjGj052utyqxH0G+ldzS7PNpHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I5F8uWoQU31krOoecQzoM3WtZCuliLdT
	JFBOEB1Ol+H3Lz5SUaqA13LqAON5uOnpYH0E0vhjhnGFKU0LO23HiqPilTBrpjd9
	4PddiAQFvFeOACSf3kMk2pzlsPa3gLu4g9nw2uJZkYXGPjNppoO0i0z8DK+47ytJ
	l4+YR2yuWC4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E92D533CE;
	Mon, 25 Nov 2013 14:36:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CDDA533CD;
	Mon, 25 Nov 2013 14:36:33 -0500 (EST)
In-Reply-To: <f4d1ff9f487f797da35faa86c72d11832903a50d.1385405977.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Mon, 25 Nov 2013 20:02:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E3FB5F00-5608-11E3-9271-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238334>

Thomas Rast <tr@thomasrast.ch> writes:

> This shuts up compiler warnings about unused functions.

Thanks.

> While there, also remove the redundant second declaration of
> stat_##slabname##realloc.

I think the latter was done very much deliberately to allow the
using code to say:

	define_commit_slab(name, type);

by ending the macro with something that requires a terminating
semicolon.  If you just remove it, doesn't it break the compilation
by forcing the expanded source to define a function

	slabname ## _at(...)
        {
        	...
	};

with a trailing and undesired semicolon?

>
> Signed-off-by: Thomas Rast <tr@thomasrast.ch>
> ---
>  commit-slab.h | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/commit-slab.h b/commit-slab.h
> index d77aaea..d5c353e 100644
> --- a/commit-slab.h
> +++ b/commit-slab.h
> @@ -45,8 +45,8 @@ struct slabname {							\
>  };									\
>  static int stat_ ##slabname## realloc;					\
>  									\
> -static void init_ ##slabname## _with_stride(struct slabname *s,		\
> -					    unsigned stride)		\
> +static inline void init_ ##slabname## _with_stride(struct slabname *s,	\
> +						   unsigned stride)	\
>  {									\
>  	unsigned int elem_size;						\
>  	if (!stride)							\
> @@ -58,12 +58,12 @@ struct slabname {							\
>  	s->slab = NULL;							\
>  }									\
>  									\
> -static void init_ ##slabname(struct slabname *s)			\
> +static inline void init_ ##slabname(struct slabname *s)			\
>  {									\
>  	init_ ##slabname## _with_stride(s, 1);				\
>  }									\
>  									\
> -static void clear_ ##slabname(struct slabname *s)			\
> +static inline void clear_ ##slabname(struct slabname *s)		\
>  {									\
>  	int i;								\
>  	for (i = 0; i < s->slab_count; i++)				\
> @@ -73,8 +73,8 @@ struct slabname {							\
>  	s->slab = NULL;							\
>  }									\
>  									\
> -static elemtype *slabname## _at(struct slabname *s,			\
> -				const struct commit *c)			\
> +static inline elemtype *slabname## _at(struct slabname *s,		\
> +				       const struct commit *c)		\
>  {									\
>  	int nth_slab, nth_slot;						\
>  									\
> @@ -94,8 +94,7 @@ struct slabname {							\
>  		s->slab[nth_slab] = xcalloc(s->slab_size,		\
>  					    sizeof(**s->slab) * s->stride);		\
>  	return &s->slab[nth_slab][nth_slot * s->stride];				\
> -}									\
> -									\
> -static int stat_ ##slabname## realloc
> +}
> +
>  
>  #endif /* COMMIT_SLAB_H */
