From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Using a bit more decoration
Date: Tue, 09 Apr 2013 13:06:21 -0700
Message-ID: <7v8v4rqxj6.fsf@alter.siamese.dyndns.org>
References: <20130408210903.GC9649@sigill.intra.peff.net>
 <1365462114-8630-1-git-send-email-gitster@pobox.com>
 <20130409035126.GA17319@sigill.intra.peff.net>
 <7vsj30tk0p.fsf@alter.siamese.dyndns.org>
 <20130409043938.GA31447@sigill.intra.peff.net>
 <7vk3octiat.fsf@alter.siamese.dyndns.org>
 <20130409065256.GA20115@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 22:06:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPeoI-0006Aw-Ey
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 22:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936122Ab3DIUGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 16:06:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59022 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934655Ab3DIUGY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 16:06:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C76615775;
	Tue,  9 Apr 2013 20:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v4tP3NmEyX8Xa/G3MKYUJnryA18=; b=kNEGgf
	lffJB+wM8/S486x5Qt0hTe4B2uNCW61zX9w+JSRBD2Eh25hvAPoTX22i2v0BkBTb
	EPwcZWkRyjBzehSf+aNIXUP7fzaiGvyx3IyUXgkNlNday46WMjYqwH5XDBxiPLDf
	0LBHxcF79huY1sy5ameG05A4VrVOGq/IKOINw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BAdJ9sbCYtQQdjaGPhhPyQiEYkECRDy3
	saPn3l2lXDsaXIl/rHONHsAVFq7AhGLCrF2uBbtd+Vs6/4Ru71yfhh7Xjl548cKM
	PS/2WAhM0Zt734Hr6f2/uuXVqqYFrmMNusnYYTK7VaRniPEEPJF9bd1xBCZY/0cM
	pQ4V+LwzKh4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93E8D15774;
	Tue,  9 Apr 2013 20:06:23 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FF0015772; Tue,  9 Apr
 2013 20:06:22 +0000 (UTC)
In-Reply-To: <20130409065256.GA20115@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 9 Apr 2013 02:52:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F358791E-A150-11E2-B1D6-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220626>

Jeff King <peff@peff.net> writes:

> +static inline int *slab_at(struct commit_slab *s, const struct commit *c)
> +{
> +	if (s->alloc <= c->index) {
> +		int new_alloc = alloc_nr(s->alloc);
> +		if (new_alloc <= c->index)
> +			new_alloc = c->index + 1;
> +
> +		s->buf = xrealloc(s->buf, new_alloc * sizeof(*s->buf));
> +		memset(s->buf + s->alloc, 0, new_alloc - s->alloc);
> +		s->alloc = new_alloc;
> +	}
> +	return s->buf + c->index;
> +}

This will hurt more as the number of objects we deal with grows (our
ALLOC_GROW() shares the same).

I wonder if it might be a good idea to do

	struct commit_slab {
        	int piece_size;
		int piece_count;
		struct commit_slab_piece {
                	int *buf;
		} *piece;
	};

and then make the look-up logic like this:

	int nth_piece, nth_slot;

	nth_piece = c->index / s->piece_size;
        nth_slot = c->index % s->piece_size;
        if (s->piece_count <= nth_piece) {
		/* xrealloc s->piece to grow, update s->piece_count */
        }
        if (!s->piece[nth_piece]) {
		/* xcalloc s->piece[nth_piece] to allocate */
	}
        return s->piece[nth_piece]->buf + nth_slot;

Other than that, looks like a good technology demonstration.
