From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] fetch: opportunistically update tracking refs
Date: Tue, 06 Aug 2013 09:28:28 -0700
Message-ID: <7vsiymhjgz.fsf@alter.siamese.dyndns.org>
References: <20130511161320.GA14990@sigill.intra.peff.net>
	<20130511161652.GD3270@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 06 18:28:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6k7m-00010n-OA
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 18:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab3HFQ2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Aug 2013 12:28:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38837 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755062Ab3HFQ2h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Aug 2013 12:28:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4086636F6A;
	Tue,  6 Aug 2013 16:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=b8UXRYiEufOI
	fwwNre6lQA//OK4=; b=w2pH4uBdWUHGzHoydWEIGlgZYfoaJha0TfPi1V8x/zeT
	lthRIk4RcPHGJuN0aSVwOnEyLqGIK75UR6Rx/Cdfds/EREC7hfCU5MX83fEu2gtw
	hasGUFLkeLCn8oZxo+KCRxv9d+WjxpxCOp/rIeUH66zGkNS4t+baxVRteGpOOp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iFK/lb
	DJGUvW0lv8pyZPWjKZli7vQrStL3K9cQ57TpoStWbcY1hso6ZUoecr9Wb2kFjj4F
	ga5SKlk8WYBfF0e1jtKvzFcKRQtVKAYLn0ihpjGgAcuANP2eHPeT9QPYMb2fkg2X
	jDHdOqS4+YwwBflY0vIJ6qtVwbWO0t2FtDLog=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D1E336F69;
	Tue,  6 Aug 2013 16:28:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6853536F68;
	Tue,  6 Aug 2013 16:28:30 +0000 (UTC)
In-Reply-To: <20130511161652.GD3270@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 11 May 2013 18:16:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AD934C4-FEB5-11E2-8EC8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231759>

Jeff King <peff@peff.net> writes:

> @@ -170,6 +172,20 @@ static struct ref *get_ref_map(struct transport =
*transport,
>  			rm->fetch_head_status =3D FETCH_HEAD_MERGE;
>  		if (tags =3D=3D TAGS_SET)
>  			get_fetch_map(remote_refs, tag_refspec, &tail, 0);
> +
> +		/*
> +		 * For any refs that we happen to be fetching via command-line
> +		 * arguments, take the opportunity to update their configured
> +		 * counterparts. However, we do not want to mention these
> +		 * entries in FETCH_HEAD at all, as they would simply be
> +		 * duplicates of existing entries.
> +		 */
> +		old_tail =3D tail;
> +		for (i =3D 0; i < transport->remote->fetch_refspec_nr; i++)
> +			get_fetch_map(ref_map, &transport->remote->fetch[i],
> +				      &tail, 0);
> +		for (rm =3D *old_tail; rm; rm =3D rm->next)
> +			rm->fetch_head_status =3D FETCH_HEAD_IGNORE;

Was there a reason why this change was done by appending new ref at
the tail of the ref_map list?  I would have expected that a na=C3=AFve
and obvious implementation would be to iterate existing refs over
ref_map to find refs with an empty RHS whose LHS is configured to
usually store the fetched result to somewhere and to update their
RHS in place.

Being curious.
