From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Fri, 14 Jan 2011 13:49:06 -0800
Message-ID: <7v8vynnokt.fsf@alter.siamese.dyndns.org>
References: <4D0ED5EC.9020402@burntmail.com>
 <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com>
 <4D119015.6020207@burntmail.com> <4D2AB63D.7040803@burntmail.com>
 <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>
 <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guy Rouillier <guyr@burntmail.com>,
	Martin Langhoff <martin@laptop.org>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 22:49:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdrWc-0006zM-Bw
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 22:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab1ANVtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 16:49:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab1ANVtc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 16:49:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DDB8B4A6A;
	Fri, 14 Jan 2011 16:50:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WyQ6pl52kpxCBUgNwG0qxKRopI0=; b=vU6+Pl
	GDQhE6xX8NJtnb8I+cdkcf+f8tMTLD+CSu6Y1n8UbK4XNFh/Zk655HTBqYw+3lq7
	Ri9/BM80ciOjeCBUacVbuz3FhKPUvWOSxkd8V2vaj2duaNmiAMfohha7HYteLjQb
	CacWzkYOqzaTCvImNdgChsqGw3GBNjp5PfB10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xc1aUvUDeQZaIIgrDE2hTrlqC8Ss70bL
	PO2lDmvWMNQiIz/qSCk9TbLRCcctQlJox1pXZz/7M1rhXQAD7cQ52vjRvwvbW3En
	rpoaJ7kakz1xRzMNNcpidcXznMmn2TLcfFyu6wBpFVaVqM3p7kSg/EAentYvDLCi
	O9KyaFctDH8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 761EC4A69;
	Fri, 14 Jan 2011 16:50:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 495864A62; Fri, 14 Jan 2011
 16:49:58 -0500 (EST)
In-Reply-To: <20110114074449.GA11175@burratino> (Jonathan Nieder's message of
 "Fri\, 14 Jan 2011 01\:44\:49 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4086127A-2028-11E0-A5FA-C83E909A2CA0-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165125>

Jonathan Nieder <jrnieder@gmail.com> writes:

> and recommended erroring out if both files exist to make this easier
> to diagnose.
>
> Emil's advice: if this is an important use case to you, maybe it would
> be served better by looking at both files?

Thanks for summarizing two-year's worth of discussion ;-)

Trying both, one after another, in the order that likely favors newer one
over the older one, is a very valid option but is appropriate only under a
very narrow condition.  Picking a wrong one must reliably, silently _and_
quickly fail, and fail without any side effect.  The one in .cvspass may
identify you as a different user from the user .cvs/cvspass identifies you
as, and the two users may have different capabilities or default server
side preferences--in such a case, both may succeed, but in a different and
unexpected way [*1*].

As the general principle, in a "we see two, and we cannot tell which one
the user wants to use" situation like this, I tend to prefer erroring out
to _force_ the user to fix the configuration once and for all.

Unless the "try both" approach is reasonable, we could implement "we read
from one and when we find one we stop, otherwise we read from the other"
and document the order, but it is probably less friendly than the above
two options.


[Footnote]

*1* I know .cvspass is a bad example for this, as it records the password
for the <pserver you are trying to connect to, your user on the server>
tuple.  Once you get in, what you can do is exactly the same because you
are authenticating as the same user, but think of a case like .ssh/config
that is indexed by "Host" and allows you to use "User" to 
