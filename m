From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] index-pack, unpack-objects: add --not-so-strict for connectivity check
Date: Wed, 01 May 2013 16:35:10 -0700
Message-ID: <7vvc722s0h.fsf@alter.siamese.dyndns.org>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
	<1367405974-22190-1-git-send-email-pclouds@gmail.com>
	<1367405974-22190-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 01:35:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXgYQ-0001bA-Eb
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 01:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758337Ab3EAXfP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 May 2013 19:35:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41657 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757394Ab3EAXfN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 May 2013 19:35:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C96E1B85B;
	Wed,  1 May 2013 23:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zn/Gs6rHf4RU
	Sw0bK071RypazYU=; b=QXH0q3HcqxQPHGjaB97GP6v+x0h8kD+0dhEbZ/Xli/Zd
	9UMuiVeCpH/dFYilb7ZIBoCczrLfmZBC88yOqIiGtu+rEcy/eIjZ2mAWC8AzhE0N
	u+azzbzLOLvT9Lpazp6SdZOegDF/eb7qYs2AEtPczg+8aYU1iLjTwwhdJ+zswgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=U3PPnh
	P0vdIu7jdNWn/jjhRPDK1BoLlFnOasQxJlt5cmw9RC/UDIHNfgguiiKisC2G4Laa
	ewkiIqR7r2s/6DsygUackKWkj9K7ahsw84of3riqgn/CnoKELljibzPJuJjGRLoT
	3DLNfS+kAchK/RKhcizfcPZ39ADU+6sokMPd0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 702BC1B85A;
	Wed,  1 May 2013 23:35:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2F711B859;
	Wed,  1 May 2013 23:35:11 +0000 (UTC)
In-Reply-To: <1367405974-22190-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 1 May
 2013 17:59:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C46CB5AC-B2B7-11E2-92DE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223167>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> --not-so-strict only checks if all links from objects in the pack
> point to real objects (either in current repo, or from the pack
> itself). It's like check_everything_connected() except that:
>
>  - it does not follow DAG in order
>  - it can detect incomplete object islands

Could you clarify what this second point means?

"rev-list --objects --all --not $this $that" does not detect
"islands" but checking with the updated index-pack does?

>  - it seems to be faster than "rev-list --objects --all"

More important is that it makes sure that it is safe to update our
refs to the new value, just like the check this attempts to replace.
If that is not the case, the speed does not matter.

I am guessing that the code assumes that we are updating our refs to
objects that are in the pack that we are looking at, and I can see
how the new check in sha1_object() may detect an object that points
at another object that is missing.  But that assumption (which I
think is correct) is probably the most important thing to say in the
log message.

> +--not-so-strict::

Perhaps "--check-connectivity" is a better name than this?
