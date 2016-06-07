From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/38] resolve_gitlink_ref(): avoid memory allocation in many cases
Date: Tue, 07 Jun 2016 10:29:21 -0700
Message-ID: <xmqq37oosya6.fsf@gitster.mtv.corp.google.com>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
	<c126a2bf5e1f48faf48b3b4ee7cc599313a76b99.1464983301.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:29:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAKoj-0001mn-Ey
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 19:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552AbcFGR3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 13:29:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754679AbcFGR3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 13:29:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F66720E93;
	Tue,  7 Jun 2016 13:29:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ukLFUdRbE3jLP4Mt0/P2sIrZl+0=; b=IiRnrr
	xXc9TVtku+H2HdzvzpEkuIHNughhanDCuJSZnrbv1rg8tKWhL82JWgjcUpU6bILb
	QcCDlPiQNbjmB8ebm68xTceqXfIiMAW5IfiY9qVnXnQ87IjEvKGPpo1vcFpL6RPD
	DLpDN8ibHkE1xGX9iIWtPkFZeykPJy9KW20s4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aoegS2hnDEC2F32lBmA40JnBeMSMYqS7
	OhJIMzDn6a3b1fatgbEGLZFokx73WyqDDuMV6PNWccBcrE8IOSFhPjWV3UJPT+x9
	eTnF3l8H8AZUG7AAo411TYNZoGD9ZKt/HI0irW55h7T/gQ0W50nEaNiTuX52cABC
	s7s2tdQzucA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 86DA820E92;
	Tue,  7 Jun 2016 13:29:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A4FB20E91;
	Tue,  7 Jun 2016 13:29:23 -0400 (EDT)
In-Reply-To: <c126a2bf5e1f48faf48b3b4ee7cc599313a76b99.1464983301.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Fri, 3 Jun 2016 23:03:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5FF8AF5E-2CD5-11E6-A757-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296700>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If we don't have to strip trailing '/' from the submodule path, then
> don't allocate and copy the submodule name.

Makes sense.

>  int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
>  {
> -	int len = strlen(path);
> -	struct strbuf submodule = STRBUF_INIT;
> +	size_t len, orig_len = strlen(path);
>  	struct ref_store *refs;
>  	int flags;
>  
> -	while (len && path[len-1] == '/')
> -		len--;
> +	for (len = orig_len; len && path[len - 1] == '/'; len--)
> +		;
> +
>  	if (!len)
>  		return -1;
>  
> -	strbuf_add(&submodule, path, len);
> -	refs = get_ref_store(submodule.buf);
> -	strbuf_release(&submodule);
> +	if (len == orig_len) {

You can keep the original while (), without introducing orig_len,
and check if path[len] is NUL, which would probably be an end result
that is easier to read.

> +		refs = get_ref_store(path);
> +	} else {
> +		char *stripped = xmemdupz(path, len);
> +
> +		refs = get_ref_store(stripped);
> +		free(stripped);

An alternative might be to add get_ref_store_counted() that takes
(path, len) instead of NUL-terminated path, which does not look too
bad looking at the state after applying all 38 patches.

> +	}
> +
>  	if (!refs)
>  		return -1;
