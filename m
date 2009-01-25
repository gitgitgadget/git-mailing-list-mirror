From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: refactor request url creation
Date: Sun, 25 Jan 2009 12:35:04 -0800
Message-ID: <7vpribdszr.fsf@gitster.siamese.dyndns.org>
References: <be6fef0d0901242208p635264e5jc1f95d784cd51450@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 21:36:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRBij-00015o-LH
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 21:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbZAYUfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 15:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbZAYUfQ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 15:35:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbZAYUfP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 15:35:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 76B061D472;
	Sun, 25 Jan 2009 15:35:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9DAB11D471; Sun,
 25 Jan 2009 15:35:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A9B55B42-EB1F-11DD-83B5-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107094>

Ray Chuan <rctay89@gmail.com> writes:

> Currently, functions that deal with objects on the remote repository
> have to allocate and do strcpys to generate the URL.
>
> This patch saves them this trouble, by providing a function that
> returns a URL: either the object's 2-digit hex directory (eg.
> /objects/a1/) or the complete object location (eg. /objects/a1/b2).
>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

If you wrote it, and then Johannes vetted it, then these two should be in
the opposite order.

> +static char *get_remote_object_url(const char *url, const char *hex,
> int only_two_digit_prefix) {

Linewrapped.

> +	struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_addf(&buf, "%sobjects/%.*s/", url, 2, hex);
> +	if(!only_two_digit_prefix)

"if (..."

> @@ -304,17 +312,7 @@ static void start_fetch_loose(struct
> transfer_request *request)
>
>  	git_SHA1_Init(&request->c);
>
> -	url = xmalloc(strlen(remote->url) + 50);
> ...
> -	strcpy(request->url, url);
> +	request->url = get_remote_object_url(remote->url, hex, 0);
> ...
> -	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
> +	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);

The original code gave a separate "url" to setop() but this gives the same
string.  Does curl_easy_setop() copies the given string away?  IOW is this
change safe?

> @@ -550,21 +540,11 @@ static void start_put(struct transfer_request *request)
>
>  	request->buffer.buf.len = stream.total_out;
>
> -	request->url = xmalloc(strlen(remote->url) +
> ...
> -	strcpy(posn, request->lock->token);
> +	strbuf_addf(&url_buf, "Destination: %s",
> get_remote_object_url(remote->url, hex, 0));

Linewrapped.

The return value from get_remote_object_url() leaks here.

> +	request->dest = strbuf_detach(&url_buf, NULL);
> +
> +	strbuf_addf(&url_buf, "%s_%s", get_remote_object_url(remote->url,
> hex, 0), request->lock->token);

The return value from get_remote_object_url() leaks here, too.
