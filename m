From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Tue, 05 Feb 2013 09:36:40 -0800
Message-ID: <7v4nhqu0gn.fsf@alter.siamese.dyndns.org>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu> <20130205083327.GA4931@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 18:37:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2mST-0004me-Gu
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 18:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130Ab3BERgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 12:36:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43921 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440Ab3BERgn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 12:36:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E3DFCC1E;
	Tue,  5 Feb 2013 12:36:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s5tLu78bWPPBoeR8hP+9/zVrGFU=; b=TLn0Br
	u8Ddk50qpxB50KZVfnSGCbDeoDwO+ne1JHIS+55a3CgsX00ErfQYtm5voEjPteQy
	BVSwFD9NM1du2fkpnzHWmrNpVx8NNgZIEABzl8b+Xv49lE6fUAXB7alHQbyathfD
	EIwdimmN258ksLdfM2X4kk7f5cCg25Q02Pc2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HKoeTq13oWCPI4QKL/6sGNCcZZjluQyu
	tLNF9fDDM+U86c6YgDeeX8fMGH3OXJop60pg34jV4STbp66gKiWv/9Rq7ij3/aor
	WDdlDz29y3WCt1H9tiVEh/fe14ftYjfjOfnU68ZyH2/OAL4vwuT3pMvTZX42n43y
	LfdUy1bQQQk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 027EBCC1D;
	Tue,  5 Feb 2013 12:36:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CE85CC1C; Tue,  5 Feb 2013
 12:36:42 -0500 (EST)
In-Reply-To: <20130205083327.GA4931@elie.Belkin> (Jonathan Nieder's message
 of "Tue, 5 Feb 2013 00:33:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9AB2D3E4-6FBA-11E2-BB42-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215523>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> * I didn't see a response to Peff's convincing arguments that this
>> should be a client-side feature rather than a server-side feature [1].
>
> The client can't control the size of the ref advertisement.  That is
> the main motivation if I understood correctly.

The answer to this question is more nuanced.

With the current protocol, it is upload-pack who speaks first, so
there is no way for the requestor to say "I am from an updated Git
suite and understand how to tell you to give me limited set of
refs", before upload-pack blasts 4MB of ref advertisement to it.

If the side that fetches is potentially interested in finding out
any and all refs, then an alternative solution would be to break
the current protocol, open a separate port and have upload-pack-2
listen to it, sit silently to let the requestor speak first when it
gets connection to that port.

But if the primary thing you are interested in is to hide the
references that:

 (1) the server side needs to keep track of for its own use; but
 (2) the requestors do not have to learn about from upload-pack,

we can do so without breaking older requestors.  That is what the
early part of this series is about.  We can view the last patch to
add the allow-tip-sha1-in-want as an icing on the cake.

It has the side effect of reducing the transfer overhead, because by
hiding the internal refs, the server side will stop blasting 4MB of
ref advertisements the requestors are not interested in, and that
would be the primary observable outcome from the end-user's point of
view (i.e. your "git pull --ff-only" will become a lot faster).
