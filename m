From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Verify Content-Type from smart HTTP servers
Date: Sun, 03 Feb 2013 23:17:33 -0800
Message-ID: <7va9rk5z02.fsf@alter.siamese.dyndns.org>
References: <7v38xhf1i3.fsf@alter.siamese.dyndns.org>
 <20130201085248.GA30644@sigill.intra.peff.net>
 <7vip6bc3e1.fsf@alter.siamese.dyndns.org>
 <20130201185827.GA22919@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 08:18:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2GJo-0002lH-OR
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 08:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab3BDHRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 02:17:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39692 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125Ab3BDHRf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 02:17:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 679AD981A;
	Mon,  4 Feb 2013 02:17:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5eBmBj/rV3uAeAxRlN6WLd6M/oU=; b=QBmYfb
	ojAexuk369wLf9tRgrXFmnBqgHNz9M2mBV4mIQLLJUrVTGfeGUBNs0Aa0qOXuk7A
	BcYlsnUE1w7mWRANIznRzz0g7HP1SFZg0YmktjV0jO33qTI4Oo5BIZc5xIRcxRGG
	E/VZHvQ7CSu9FU5IX7jUiRvMCeK/GQSXGGoJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oarILzCFU+XCvh8V9bGHmkcYLycpFDWm
	ariWQsdhNXemtG7NH5NCsUw60xZ+e7DsrnKW15bdH3JJEIV87q1xJ0oUuo6LVXb9
	6xKC0o5jvti6ztxd8xTbKdhFkhjt/TRgo8yJ7fbrlB1Nr4whrwGJOC20/76mxtWv
	QKaDax5H4yo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CD3C9819;
	Mon,  4 Feb 2013 02:17:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8FF89818; Mon,  4 Feb 2013
 02:17:34 -0500 (EST)
In-Reply-To: <20130201185827.GA22919@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Feb 2013 13:58:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F27F86CE-6E9A-11E2-8F51-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215362>

Jeff King <peff@peff.net> writes:

> I was specifically thinking of this (on top of your patch):
>
> diff --git a/remote-curl.c b/remote-curl.c
> index e6f3b63..63680a8 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -134,14 +134,12 @@ static struct discovery* discover_refs(const char *service)
>  	last->buf_alloc = strbuf_detach(&buffer, &last->len);
>  	last->buf = last->buf_alloc;
>  
> -	if (maybe_smart && 5 <= last->len && last->buf[4] == '#') {
> +	strbuf_addf(&exp, "application/x-%s-advertisement", service);
> +	if (maybe_smart && !strbuf_cmp(&exp, &type)) {
>  		/*
>  		 * smart HTTP response; validate that the service
>  		 * pkt-line matches our request.
>  		 */
> -		strbuf_addf(&exp, "application/x-%s-advertisement", service);
> -		if (strbuf_cmp(&exp, &type))
> -			die("invalid content-type %s", type.buf);
>  		if (packet_get_line(&buffer, &last->buf, &last->len) <= 0)
>  			die("%s has invalid packet header", refs_url);
>  		if (buffer.len && buffer.buf[buffer.len - 1] == '\n')
>
> To just follow the dumb path if we don't get the content-type we expect.
> We may want to keep the '#' format check in addition (packet_get_line
> will check it and die, anyway, but we may want to drop back to
> considering it dumb, just to protect against a badly configured dumb
> server which uses our mime type, but I do not think it likely).

Yeah, but it doesn't cost anything to check, so let's do so.

Does this look good to both of you (relative to Shawn's patch)?

 remote-curl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index e6f3b63..933c69a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -134,14 +134,14 @@ static struct discovery* discover_refs(const char *service)
 	last->buf_alloc = strbuf_detach(&buffer, &last->len);
 	last->buf = last->buf_alloc;
 
-	if (maybe_smart && 5 <= last->len && last->buf[4] == '#') {
+	strbuf_addf(&exp, "application/x-%s-advertisement", service);
+	if (maybe_smart &&
+	    (5 <= last->len && last->buf[4] == '#') &&
+	    !strbuf_cmp(&exp, &type)) {
 		/*
 		 * smart HTTP response; validate that the service
 		 * pkt-line matches our request.
 		 */
-		strbuf_addf(&exp, "application/x-%s-advertisement", service);
-		if (strbuf_cmp(&exp, &type))
-			die("invalid content-type %s", type.buf);
 		if (packet_get_line(&buffer, &last->buf, &last->len) <= 0)
 			die("%s has invalid packet header", refs_url);
 		if (buffer.len && buffer.buf[buffer.len - 1] == '\n')
