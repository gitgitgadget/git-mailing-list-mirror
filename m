From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailinfo: resolve -Wstring-plus-int warning
Date: Mon, 22 Sep 2014 10:41:28 -0700
Message-ID: <xmqqk34vlfhz.fsf@gitster.dls.corp.google.com>
References: <1411290838-45622-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 19:41:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW7cF-0004gj-Pu
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 19:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbaIVRlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 13:41:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52015 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592AbaIVRlb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 13:41:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DBAC23C329;
	Mon, 22 Sep 2014 13:41:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5qeDsEpPqemE5xb1L1WLWV92db4=; b=GyYAW9
	M7in2PFIBzN7k176DbH2FWe5mxdrzITh9LcRtrAoZWsaDJOVrcRA+BR8sC1OjVOv
	BxKVeHOexAYEuOdHrnEt0R6EfVISAB6JLt7b6mp/GN6XT5ScvZITfRB5p2auinHq
	SH1yPs9jD7i+VgvrII0zJuSl54cK7AZsNbP2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pk/AQVIg7tZsSpQmr3tZwHbvN6ZrnOCo
	TCFmppwZnb3FFggYkUfb/r3gkuNvCIvcPLrclzVlGIIm/NRoVDqtjoMgdKh6oP8p
	6JZaBxX4qHpdGCpLybBFQCnmBLdVTA4jrvQcL4hTwQGqZzlyUu/ssoy0iaDZ9zZ3
	en+1Yjvfokc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D0EC83C328;
	Mon, 22 Sep 2014 13:41:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 53E2D3C327;
	Mon, 22 Sep 2014 13:41:30 -0400 (EDT)
In-Reply-To: <1411290838-45622-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Sun, 21 Sep 2014 05:13:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AFAC5F74-427F-11E4-9635-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257371>

Eric Sunshine <sunshine@sunshineco.com> writes:

> The just-released Apple Xcode 6.0.1 has -Wstring-plus-int enabled by
> default which complains about pointer arithmetic applied to a string
> literal:
>
>     builtin/mailinfo.c:303:24: warning:
>         adding 'long' to a string does not append to the string
>             return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) ...
>                            ~~~~~~~^~~~~~~~~~~~~

And why is that a warning-worthy violation?  Can we have them fix
their compiler instead?

>
> Resolve this issue.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> This is atop 2da1f366 (mailinfo: make ">From" in-body header check more
> robust; 2014-09-13) in 'next'.
>
> In addition to the above diagnostic, the Apple compiler also helpfully
> recommends &SAMPLE[cp - line] as a replacement to avoid the warning,
> however, the solution in this patch allows us drop a couple strlen()s in
> favor of sizeof()s.
>
>  builtin/mailinfo.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index 2632fb0..b6b1c19 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -288,19 +288,20 @@ static inline int cmp_header(const struct strbuf *line, const char *hdr)
>  			line->buf[len] == ':' && isspace(line->buf[len + 1]);
>  }
>  
> -#define SAMPLE "From e6807f3efca28b30decfecb1732a56c7db1137ee Mon Sep 17 00:00:00 2001\n"
>  static int is_format_patch_separator(const char *line, int len)
>  {
> +	static const char SAMPLE[] =
> +		"From e6807f3efca28b30decfecb1732a56c7db1137ee Mon Sep 17 00:00:00 2001\n";
>  	const char *cp;
>  
> -	if (len != strlen(SAMPLE))
> +	if (len != sizeof(SAMPLE) - 1)
>  		return 0;
>  	if (!skip_prefix(line, "From ", &cp))
>  		return 0;
>  	if (strspn(cp, "0123456789abcdef") != 40)
>  		return 0;
>  	cp += 40;
> -	return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) - (cp - line));
> +	return !memcmp(SAMPLE + (cp - line), cp, sizeof(SAMPLE) - 1 - (cp - line));
>  }
>  
>  static int check_header(const struct strbuf *line,
