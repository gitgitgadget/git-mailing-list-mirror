From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] patch-id: make it stable against hunk reordering
Date: Fri, 28 Mar 2014 15:12:17 -0700
Message-ID: <xmqqzjka7z26.fsf@gitster.dls.corp.google.com>
References: <1396009159-2078-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 23:12:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTf0m-0005b2-2J
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 23:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbaC1WMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 18:12:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbaC1WMV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 18:12:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFD0D78205;
	Fri, 28 Mar 2014 18:12:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0cxhZHcFUu+f4fxY828lBqHr6Dg=; b=CLv1oy
	vCH3i0+JIJGRl5k+Kq7N0pTU8JaWrpxRqklAvxDNuGHcYc2yCUAMa4h7y0rvBNOC
	zoIiy2cJI4U8ed1PqZIONoN8Tbs/Qh9CfoV7Kdu9aXA1wvjoFI57fyOJv2Xzr3wI
	r7gAlES8rZzD65XErLu3+qwVMVmsJUOppTr8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YecdS/2RPxfobIZi/Vfa9yNBM6KjaDt4
	DxF6lntrzgyJCyGh0ES2swHVwnpC3Yn5VHNkQrBRxZEaCHCs79tnuaiFpniLUa3T
	dkgZgGX07OqRMOr47A7BJp69HmUCpOjP2Qu6ktf22vcZNyIkc1xiwz2yhgn6XtCR
	eYsPYjnca+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE12E78204;
	Fri, 28 Mar 2014 18:12:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB5B678203;
	Fri, 28 Mar 2014 18:12:19 -0400 (EDT)
In-Reply-To: <1396009159-2078-1-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Fri, 28 Mar 2014 14:30:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 07985B0C-B6C6-11E3-83C3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245427>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> +static void flush_one_hunk(unsigned char *result, git_SHA_CTX *ctx)
>  {
> -	int patchlen = 0, found_next = 0;
> +	unsigned char hash[20];
> +	unsigned short carry = 0;
> +	int i;
> +
> +	git_SHA1_Final(hash, ctx);
> +	git_SHA1_Init(ctx);
> +	/* 20-byte sum, with carry */
> +	for (i = 0; i < 20; ++i) {
> +		carry += result[i] + hash[i];
> +		result[i] = carry;
> +		carry >>= 8;
> +	}

Was there a reason why bitwise xor is not sufficient for mixing
these two indenendent hashes?  If the 20-byte sums do not offer
benefit over that, the code for bitwise xor would be certainly be
simpler, I would imagine?

> +}
> +static int get_one_patchid(unsigned char *next_sha1, unsigned char *result,
> +			   struct strbuf *line_buf, int stable)
> +{
> +	int patchlen = 0, found_next = 0, hunks = 0;
>  	int before = -1, after = -1;
> +	git_SHA_CTX ctx, header_ctx;
> +
> +	git_SHA1_Init(&ctx);
> +	hashclr(result);
>  
>  	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
>  		char *line = line_buf->buf;
> @@ -99,6 +116,18 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
>  			if (!memcmp(line, "@@ -", 4)) {
>  				/* Parse next hunk, but ignore line numbers.  */
>  				scan_hunk_header(line, &before, &after);
> +				if (stable) {
> +					if (hunks) {
> +						flush_one_hunk(result, &ctx);
> +						memcpy(&ctx, &header_ctx,
> +						       sizeof ctx);
> +					} else {
> +						/* Save ctx for next hunk.  */
> +						memcpy(&header_ctx, &ctx,
> +						       sizeof ctx);
> +					}
> +				}
> +				hunks++;
>  				continue;
>  			}
>  
> @@ -107,7 +136,10 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
>  				break;
>  
>  			/* Else we're parsing another header.  */
> +			if (stable && hunks)
> +				flush_one_hunk(result, &ctx);
>  			before = after = -1;
> +			hunks = 0;
>  		}
>  
>  		/* If we get here, we're inside a hunk.  */
> @@ -119,39 +151,46 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
>  		/* Compute the sha without whitespace */
>  		len = remove_space(line);
>  		patchlen += len;
> -		git_SHA1_Update(ctx, line, len);
> +		git_SHA1_Update(&ctx, line, len);
>  	}
>  
>  	if (!found_next)
>  		hashclr(next_sha1);
>  
> +	flush_one_hunk(result, &ctx);

What I read from these changes is that you do not do anything
special about the per-file header, so two no overlapping patches
with a single hunk each that touches the same path concatenated
together would not result in the same patch-id as a single-patch
that has the same two hunks.  Which would break your earlier 'Yes,
reordering only the hunks will not make sense, but before each hunk
you could insert the same "diff --git a/... b/..." to make them a
concatenation of patches that touch the same file', I would think.

Is that what we want to happen?  Or is my reading mistaken?
