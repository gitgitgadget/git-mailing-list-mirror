From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mv: prevent mismatched data when ignoring errors.
Date: Tue, 18 Mar 2014 15:31:26 -0700
Message-ID: <xmqqtxav5ebl.fsf@gitster.dls.corp.google.com>
References: <20140308183501.GH18371@serenity.lan>
	<1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
	<8738ijzbue.fsf@thomasrast.ch>
	<20140316020018.GA20019@sigill.intra.peff.net>
	<7v1ty14z8x.fsf@alter.siamese.dyndns.org>
	<7vtxax2v1q.fsf@alter.siamese.dyndns.org>
	<53270FC2.2030701@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Guillaume Gelin <contact@ramnes.eu>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 18 23:31:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ2Xm-0005fo-Ov
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 23:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756997AbaCRWba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 18:31:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755175AbaCRWb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 18:31:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6636C72E00;
	Tue, 18 Mar 2014 18:31:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=49xS1XJnpIc2Izaer764B7wNBVE=; b=X9jxMP
	9ZkIJob+YbrBzMwHEjoBboXcAdlOi74HPgCX/UDcmws2CCzk2V3+JhY5kPIvn8YF
	E+s5xv5DJI+n3PQHmY2EZe5WJGkS55DOVTLX/u1ytt19Pm7+Xx72j/cQZ97R2Njm
	ulIeyQK+mIPT8ceHlvU9VtXkRyiCsJhZfizro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N/IsuY8M896jHZlwn9yq3eAVnkcT82bz
	CTgfeOrM2FyDyk94UebIhQ4oGuHII2mTrVlbBb4Irr1GlE4sm9K/pzF1wt5O/f5c
	H3wwdpSaSiPg0qKUSDAE7I0AE6uDnfV9EQTI5SxH5CKW2+eKZyulPcqnw12EHccW
	ndCZoi3p9Es=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5379572DFE;
	Tue, 18 Mar 2014 18:31:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 960CB72DFD;
	Tue, 18 Mar 2014 18:31:28 -0400 (EDT)
In-Reply-To: <53270FC2.2030701@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 17 Mar 2014 16:07:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0C3AF5C4-AEED-11E3-A64B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244390>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I had recently been thinking along the same lines.  In many of the
> potential callers that I noticed, ALLOC_GROW() was used immediately
> before making space in the array for a new element.  So I suggest
> something more like
>
> +#define MOVE_DOWN(array, nr, at, count)	\
> +	memmove((array) + (at) + (count),		\
> +		(array) + (at),				\
> +		sizeof((array)[0]) * ((nr) - (at)))
> +#define ALLOC_INSERT_GAP(array, nr, at, count, alloc)		     \
> +	do {							     \
> +		ALLOC_GROW((array), (nr) + (count), (alloc));        \
> +		MOVE_DOWN((array), (nr), (at), (count));	     \
> +	} while (0)
>
> Also, count==1 is so frequent that this special case might deserve its
> own macro pair.

Yeah, probably.

> I'm not inspired by these macro names, though.

Me neither, about ups and downs.

Peff's suggestion to name these around the concept of "gap" sounded
sensible.
