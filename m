From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable info/refs gzip decompression in HTTP client
Date: Wed, 19 Sep 2012 17:43:24 -0700
Message-ID: <7vtxutcymr.fsf@alter.siamese.dyndns.org>
References: <1348096322-21426-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 02:43:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEUrf-0007hF-DR
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 02:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab2ITAn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 20:43:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64133 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180Ab2ITAn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 20:43:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30CA79208;
	Wed, 19 Sep 2012 20:43:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xj2coyAq8VXzFzvGtlgEpgrbMVY=; b=YbFq0R
	0J8OapzDnZ7P1zstEj7Pz62tJ4DwqmPchv7xOskmpBuguD18h/TvE/4T1zrBsj1d
	39F+w5Npc8VJkS5X1PMGNjL6HaLK4kKygMSxwG+R8aiRtJTIMyup1JkX4fez3lqA
	32Uh/3MpSfxZCDMmqtyfFgDTfYQdoMjXbeDn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nbCqx+VvjABjoOAN8EjmhJzFwn74qM3z
	1pj1l+C8TP8Q7dHyQ5qjpJ88Wi4u+FxCHs7FBOOyQgvwrJfVpo7SpyKysEBb3T0y
	wlUQzG218AwlBNC9vAouBdEpz2qBUYRh00IqRrrQjZajpda5MVM2G2No/n3B4Xp7
	t1T63JKoB6U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DD629206;
	Wed, 19 Sep 2012 20:43:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74DD19205; Wed, 19 Sep 2012
 20:43:25 -0400 (EDT)
In-Reply-To: <1348096322-21426-1-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Wed, 19 Sep 2012 16:12:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FE008A4-02BC-11E2-AF99-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206023>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> From: "Shawn O. Pearce" <spearce@spearce.org>
>
> Some HTTP servers try to use gzip compression on the /info/refs
> request to save transfer bandwidth. Repositories with many tags
> may find the /info/refs request can be gzipped to be 50% of the
> original size due to the few but often repeated bytes used (hex
> SHA-1 and commonly digits in tag names).
>
> For most HTTP requests enable "Accept-Encoding: gzip" ensuring
> the /info/refs payload can use this encoding format.
>
> Disable the Accept-Encoding header on probe RPCs as response bodies
> are supposed to be exactly 4 bytes long, "0000". The HTTP headers
> requesting and indicating compression use more space than the data
> transferred in the body.

All of the above sounds very convincing, but ...

> diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
> index 2db5c35..380c175 100755
> --- a/t/t5551-http-fetch.sh
> +++ b/t/t5551-http-fetch.sh
> @@ -32,13 +32,14 @@ setup_askpass_helper
>  cat >exp <<EOF
>  > GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
>  > Accept: */*
> +> Accept-Encoding: gzip
>  > Pragma: no-cache
>  < HTTP/1.1 200 OK
>  < Pragma: no-cache
>  < Cache-Control: no-cache, max-age=0, must-revalidate
>  < Content-Type: application/x-git-upload-pack-advertisement
>  > POST /smart/repo.git/git-upload-pack HTTP/1.1
> -> Accept-Encoding: deflate, gzip
> +> Accept-Encoding: gzip

... was loss of "deflate" intended?  If so why?  Could you explain
it in the log message?

>  > Content-Type: application/x-git-upload-pack-request
>  > Accept: application/x-git-upload-pack-result
>  > Content-Length: xxx
