From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] verify-tag: check sig of all tags to given object
Date: Fri, 03 Feb 2012 19:16:18 -0800
Message-ID: <7v8vkjl24d.fsf@alter.siamese.dyndns.org>
References: <1328318751-4470-1-git-send-email-tom.grennan@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jasampler@gmail.com
To: Tom Grennan <tom.grennan@ericsson.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 04:16:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtW71-0007nG-59
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 04:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab2BDDQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 22:16:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47419 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753727Ab2BDDQV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 22:16:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75CF57222;
	Fri,  3 Feb 2012 22:16:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4fUxau9Eofb1dCGHqtzPOoEqTjE=; b=Z7yD02
	Y1RuuArQqz8kxhzVrq0z9tZoVreFx1h0LQXW2laL8jAL0cCZYBce38o40Odi90B+
	2vYMGreB0eA7UrgQCxfre8sFfnG5/VpMlSmdr2lj4j83MA4ZCJkjewguhXMNnJJ/
	QQJnJ1Ghv7SaslCqN2rZ6C4vhaBqciDsij6tA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yQJHp3JYXmQXiFaYUQFVPXP/FKCxAEvt
	XMb2ldlSVi3Bfw3dwBs1ns9pg+sjgMMVLTr6F5wOElL2dbYePEY+2qp+t5PAVxzz
	cJOW1/+OZLqsyu3lK4hkvgOwd8kirPd4KnFB1bC6/CPGII9tx1GjOIvI1o374fnd
	WRRu4kIEvZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CF1E7221;
	Fri,  3 Feb 2012 22:16:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB9307220; Fri,  3 Feb 2012
 22:16:19 -0500 (EST)
In-Reply-To: <1328318751-4470-1-git-send-email-tom.grennan@ericsson.com> (Tom
 Grennan's message of "Fri, 3 Feb 2012 17:25:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BA992E0-4EDE-11E1-8003-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189838>

Tom Grennan <tom.grennan@ericsson.com> writes:

> If the command argument is a non-tag object, scan and verify all tags to
> the given object; for example:
>
> john$ git tag -s -m "I approve" john-README master:README
> ...
> john$ git tag -s -m "I recommend" john-HEAD HEAD
> ...
> john$ git push <url> tag john-README
> john$ git push <url> tag john-HEAD
>
> jane$ git fetch --tags <url>
> jane$ git tag -s -m "I also approve" jane-README master:README
> ...
> jane$ git push <url> tag jane-README
>
> jeff$ git fetch --tags <url>
> jeff$ git verify-tag master:README
> tag john-README: OK
> tag jane-README: OK
> jeff$ git verify-tag HEAD
> tag john-HEAD: OK
>
> Signed-off-by: Tom Grennan <tom.grennan@ericsson.com>

You did not describe what problem you are trying to solve, but the above
tells me that the design of this feature has a lot of room to be improved
to be useful for even a single trivial use scenario I can think of off the
top of my head.

Let's say after tagging v1.7.10, for some reason (as I do not know what
problem you are trying to solve), I decided to ask my back-up maintainers,
let's call them Shawn and Jeff, to sign that tag.  Shawn is expected to do
this:

    spearce$ git fetch tag v1.7.10
    spearce$ git tag -s -m "This tag is Gitster's" v1.7.10-spearce v1.7.10
    spearce$ git push http://example.com/spearce/git tags/v1.7.10-spearce

Jeff will do the same, and I'll fetch v1.7.10-spearce and v1.7.10-peff
tags from them.

It is natural for me to be able to ask "I want to verify all tags that
point at the object I asked to be signed, namely, v1.7.10" from this
feature.

But

    gitster$ git verify-tag v1.7.10

would not be a way to do so, as that would check my signature in v1.7.10
tag itself.

It gets even worse.  Suppose Jeff does this instead by mistake:

    peff$ git fetch v1.7.10
    peff$ git tag v1.7.10-peff v1.7.10
    peff$ git push http://example.com/peff/git tags/v1.7.10-peff

Even if you added "git verify-tag --pointed v1.7.10" to disambiguate the
request to use the new feature, the result is unusable, as I would see:

    gitster$ git verify-tag --pointed v1.7.10
    v1.7.10-spearce: OK
    v1.7.10-peff: OK

v1.7.10-spearce and v1.7.10-peff both resolve to my v1.7.10, and they both
are signed by known key, but v1.7.10-peff is a lightweight tag that points
directly at my v1.7.10 and I would be seeing a signature of my own as "OK".
