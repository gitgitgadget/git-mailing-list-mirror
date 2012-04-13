From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] http: handle proxy proactive authentication
Date: Fri, 13 Apr 2012 12:35:17 -0700
Message-ID: <7viph32znu.fsf@alter.siamese.dyndns.org>
References: <4F5F53CA.7090003@seap.minhap.es>
 <7v398cvb30.fsf@alter.siamese.dyndns.org>
 <7vsjgcs8pq.fsf@alter.siamese.dyndns.org>
 <7vwr5leyj5.fsf@alter.siamese.dyndns.org>
 <20120412205836.GB21018@sigill.intra.peff.net>
 <7vpqbc4p8n.fsf@alter.siamese.dyndns.org>
 <20120412220516.GG21018@sigill.intra.peff.net>
 <7vd37c4msm.fsf@alter.siamese.dyndns.org>
 <20120412224230.GA22988@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, sam@vilain.net, spearce@spearce.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 21:35:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SImHG-00048b-NH
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 21:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975Ab2DMTfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 15:35:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755914Ab2DMTfV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 15:35:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C86AD7C70;
	Fri, 13 Apr 2012 15:35:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o5TYYH2C4QEMZaJYcyrd6aTo8Kc=; b=x3JmIf
	Cdw4YhUjxQmXIuv34v4ffF02q+RD1I3O6/PEyz8kZsNDegTmnifefC74LAsdxdzD
	3RiQRJIaCQ3IOgBQdp6d4CspJfurlclxPdv1Qgd5KWwvAibyDtQAqBdTT9uM5rSG
	DPqGk4YHLiVVKmg3dlCF0luW6r+4+JA/GA8+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QTm6hViE+Fk7k9peNVpraFUcyprOGwv5
	0yOItKAuQrZ1iP46tQLX25oXKBavyBs1RsE2L4EDHfUrt2v5hLuPr/dne30HDb7e
	1whTSb3nUnuNLtF3zlBSswjAiSHhx8ELr7GGEFtOG+av4jNa+Rjh20MdDz87OKYv
	9QHmrLRsJMs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C01057C6F;
	Fri, 13 Apr 2012 15:35:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4327B7C6E; Fri, 13 Apr 2012
 15:35:19 -0400 (EDT)
In-Reply-To: <20120412224230.GA22988@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 12 Apr 2012 18:42:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD8FBAF8-859F-11E1-B482-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195438>

Jeff King <peff@peff.net> writes:

> But you snipped the later part of my message, which is that the "http"
> in "http_proxy" does _not_ matter. It is about which destinations to
> apply the proxy to, not how you talk to the proxy (and the latter is what
> should matter for the credentials).

Oh, yes, I am in violent agreement. The language the http clients
(browsers etc) talk to the proxy may be part of HTTP specification, but it
is definitely different from the "http" talked with the origin servers.

>> > Not splitting "http" and "http-proxy" does have a slight confusion,...
>> 
>> Ok, so how about this as a replacement patch for what I have had for the
>> past few days?
>
> My other message argued "the http-proxy distinction might be important,
> but probably isn't". But I didn't talk about "the http-proxy distinction
> might break helpers". The stock helpers will be fine; they are totally
> clueless about what the protocol means, and just treat it as a string to
> be matched. But for something like osxkeychain, where it is converting
> the protocol string into some OS-specific magic value, it does matter,
> and http-proxy would cause it to exit in confusion.
>
> It looks like OS X defines a SOCKS type and an HTTPProxy type for its
> keychain API. So in either case, it should probably be updated to handle
> these new types. And I guess that argues for making the distinction,
> since at least one helper does want to care about it.

OK.  Sounds like we are in agreement.

Nelson, care to re-roll the series, with fixes discussed in this thread
rolled into the second patch?
