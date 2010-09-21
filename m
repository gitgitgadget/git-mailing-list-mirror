From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG, PATCH 0/3] Fix {blame,cat-file} --textconv for cases with
 symlinks
Date: Tue, 21 Sep 2010 10:57:56 -0700
Message-ID: <7vaanbuggr.fsf@alter.siamese.dyndns.org>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
 <vpqhbhmx6tg.fsf@bauges.imag.fr> <7vpqwa254i.fsf@alter.siamese.dyndns.org>
 <20100920180046.GA1790@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 21 19:58:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy76p-0006hs-1k
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 19:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757132Ab0IUR6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 13:58:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756603Ab0IUR6T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 13:58:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B9330D7D92;
	Tue, 21 Sep 2010 13:58:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fGQUm4BncCeU2FKdi/42ncTB5+c=; b=NhUL63
	sAxGm4Ddkd/vnJabmp4yvJMXmSOo1GmJzJiTEa7/R29X5C3MMeGyXwwSMzm5SAsK
	SdYXm6MWfUmkKqx5nVCos+i6mI/zX3wqsil91jdLAy0Cf5pQ7xvdZFDeyyGMtswU
	XDdl48k2nM8e1pE1OEkBpw0xzGEhrQ63PjvGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uCZCBx3AGbiIJsnSW9SN7ArxtktWf230
	1vanVvBGpVfgcKgun5FToG37iCvGpVyzHwXRx6jkr94PgdRWK3La0NH8mrIki+Uv
	tN4x2WihCvEhJdT/RJ1Nn6NIzd+Xuf88UEDiLNU+DAtJesK+J4gXhsEOQ5S667uI
	qZ81tY+goTE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 45C10D7D8C;
	Tue, 21 Sep 2010 13:58:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3D7FD7D7B; Tue, 21 Sep
 2010 13:57:58 -0400 (EDT)
In-Reply-To: <20100920180046.GA1790@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 20 Sep 2010 14\:00\:46 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA89C590-C5A9-11DF-83D3-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156736>

Jeff King <peff@peff.net> writes:

> The one thing this does not enable is using a special diff driver on the
> _pathnames_ of symlinks. Since these are by-definition text, I don't
> know why anyone would want to do that. But it is an orthogonal problem,
> anyway.  We would need some way in the .gitattributes or the .gitconfig
> to say "this is the diff driver to use not based on pathname matching,
> but based on the file's mode". E.g., a special "SYMLINK" diff driver
> like:
>
>   [diff "SYMLINK"]
>     textconv = pointless-munge
>
> But again, I have no idea why anyone would want such a feature, so it is
> not worth thinking too hard about it.

I agree with you; pointless-munge would just be 'printf "%s\n"' ;-)
