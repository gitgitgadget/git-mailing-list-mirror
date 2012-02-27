From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sha-1 check in rev-list --verify-objects redundant?
Date: Sun, 26 Feb 2012 17:23:42 -0800
Message-ID: <7vd391cbmp.fsf@alter.siamese.dyndns.org>
References: <CACsJy8D_BdV14dGc2YsK91FrX8S=70DJOY3cU=oH3y41N2Ar0w@mail.gmail.com>
 <7vk43af14m.fsf@alter.siamese.dyndns.org>
 <CACsJy8BUeedTZSq_ay=JmqUt3wrnm6n1eOcFt0WPkEo2B-1zwA@mail.gmail.com>
 <7v1uphff8o.fsf@alter.siamese.dyndns.org>
 <CACsJy8C9=BJvKvFB3XrSqNXV-y3=o1pTJPtFBXK3jSheBff3Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 02:23:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1pJf-0004AJ-FC
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 02:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab2B0BXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 20:23:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752381Ab2B0BXp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 20:23:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B62C66A03;
	Sun, 26 Feb 2012 20:23:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/yaRLfL+YpMB4gRb2AGMycUKy90=; b=cjw+ma
	TvhCO0PTl31f6w/RXFQX0sxNTt14GRgAQMoVsUBQkTC1V4u+4FKPQM4yndkvFOaz
	ChYCjTh6MeHaLozu4JytdS8kEAahTgi4FrI0HRVqXUwy9vKh/XqQTu5OPSGkPfFZ
	KN3PX/DlcZ1+fR3HjERla+ElKbjaKR3nvcOKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i+XHsp/es/7lxNZXMnRItDWJaX8JExog
	OCLT29bFTpC/dCWiLlW5PrfQhDICC6iL7ERgeDIdYUeUAhws89+isx35b+/zXO2D
	QBgIiBY12S4LZ7WRAEyJiKqZKX13Etr2ObPGsB69bB64g81xnkLYDsfp+YhGWTVh
	E5tvJLraK9o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADE446A02;
	Sun, 26 Feb 2012 20:23:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 423C66A01; Sun, 26 Feb 2012
 20:23:44 -0500 (EST)
In-Reply-To: <CACsJy8C9=BJvKvFB3XrSqNXV-y3=o1pTJPtFBXK3jSheBff3Uw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 27 Feb 2012 07:48:11 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B07E8C06-60E1-11E1-B4F8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191591>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>>  * quickfetch() that is called even before we get any object from the
>>   other end, to optimize the transfer when we already have what we need.
>>
>> The latter is the original use to protect against unconnected island of
>> chain I explained in the previous message, but the former is also abot the
>> same protection, in a different callchain.
>
> I think we can trust what we already have, so in the latter case (and
> the former when the medium is a pack), --objects should suffice.

Hrm, what you seem to be missing is that in the latter case, the objects
we are walking to make sure the connectivity are *not* yet considered as
part of "what we already have" (hence we can trust).  The whole point of
quickfetch is to turn these untrustworthy bits that happen to exist in our
repository into a part of trustable history without having to fetch from
the other side to complete them.  In the former case, when we know that
pack has been indexed with recent index-pack/unpack-objects that are more
picky (didn't Shawn and I recently tighten them?), we may be able to do
without object integrity checks.

>> If we _know_ that we have checked the integrity of all the necessary
>> individual objects before we start reading them in order to check the
>> completeness of the history, there is an opportunity to optimize by
>> teaching --verify-objects paths to optionally be looser than it currently
>> is, to avoid checking the object integrity twice.
>
> Ok, will cook something. The reason I raised it is because
> --verify-objects --all on git.git could take ~1m10s, but if we assume
> object integrity is fine and skip it, it could drop to 10s (I suspect
> --objects gives the same number).

That is a big assumption that I personally do not want to sacrifice the
integrity of my history on.  I would 100% agree with the above with s/if
we assume/if we know/, though.
