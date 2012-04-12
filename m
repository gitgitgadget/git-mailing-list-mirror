From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] http: handle proxy proactive authentication
Date: Thu, 12 Apr 2012 14:25:12 -0700
Message-ID: <7vpqbc4p8n.fsf@alter.siamese.dyndns.org>
References: <4F5F53CA.7090003@seap.minhap.es>
 <7v398cvb30.fsf@alter.siamese.dyndns.org>
 <7vsjgcs8pq.fsf@alter.siamese.dyndns.org>
 <7vwr5leyj5.fsf@alter.siamese.dyndns.org>
 <20120412205836.GB21018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, sam@vilain.net, spearce@spearce.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 23:25:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIRW9-0001P7-Af
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 23:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934748Ab2DLVZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 17:25:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36277 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755202Ab2DLVZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 17:25:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CFB56081;
	Thu, 12 Apr 2012 17:25:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tn2jKOP0DLFfZna8r7uG1eY2UTw=; b=JHynJd
	VUU2/Uw9k3xGeiyCaCyCekFTiMth3I7tQikQiS5hf/ZmI2fEL7HdKOHUR96SZxH3
	qMN9Y4KvI7mmUKJqL7va9cf1l+yzWx9z7Q/YDra3eHD988Hdci+a6UDOAclFGJ4S
	guqM+XH9zxHZPCgR2WjoHeU+zUg1rQdzscziU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m3xAtAXXEpApIvDu4gMz2EWPFZfXe5Ft
	yKpel9U7sCjeZqfwV0+tDVyhQjbiLT6PHyyh2lR9l8aKFUOBQU5H53ua3ipiXoeM
	iVRDC33cTRPDjGsWJw8g/M1+OGOuHZ6iJuW0ER4f73Sql8jRJzpeNpaO7q6qzrq7
	z4/fbhPqUE0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 000066080;
	Thu, 12 Apr 2012 17:25:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 563F5607B; Thu, 12 Apr 2012
 17:25:15 -0400 (EDT)
In-Reply-To: <20120412205836.GB21018@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 12 Apr 2012 16:58:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FEB7B28A-84E5-11E1-A68D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195374>

Jeff King <peff@peff.net> writes:

> My first instinct was "that is not a URL, and should be handled outside
> this function". In particular, it has no protocol field, and that is an
> important part of the credential-matching process. It would be up to the
> caller to supply something sane in the protocol portion. In this case,
> it would probably be "http"...

Outside git, these actually come from things like these:

	http_proxy=127.0.0.1:1080
        HTTPS_PROXY=127.0.0.1:1080

And http.proxy configuration variable we have is a substitute for
http_proxy.  So if we want to keep the credentials for destination servers
and the credentials for proxies, "http.proxy" codepath should be asking
you with "http".  If we are looking at HTTPS_PROXY, you should get "https".
The patch that broke the unauthenticated proxy access does neither.

> ... (unless we want to distinguish http proxies
> from http end-points in the credential store, but I doubt that is
> useful).

That is something we may want to think carefully about.

If it is better to separate them, then we can easily invent "http-proxy",
"https-proxy" etc. for them, e.g.

	HTTPS_PROXY=http://127.0.0.1:1080
	git fetch https://over.there.xz/repo/sito/ry.git

would ask you for a credential to access 127.0.0.1:1080 in "https-proxy"
domain, and another to access over.there.xz in "https" domain.

In either case, the last example will not use "http" anywhere, even though
the value of the proxy has noiseword "http://" in front of it, which is
ignored.  So in that sense, even if we ignored the breakage for the proxy
specification without noiseword which Shawn noticed, the patch is broken,
as it asks credential for http://127.0.0.1:1080 and you parse it for "http"
protocol.
