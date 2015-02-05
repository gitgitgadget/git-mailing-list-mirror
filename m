From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: do not ungetc EOF
Date: Thu, 05 Feb 2015 13:16:36 -0800
Message-ID: <xmqqr3u4jbyj.fsf@gitster.dls.corp.google.com>
References: <20150205065327.GA7807@peff.net> <20150205210024.GA30724@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 22:16:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJTn1-0000Z2-Uw
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 22:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbbBEVQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 16:16:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751511AbbBEVQj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 16:16:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BAFC3691D;
	Thu,  5 Feb 2015 16:16:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9YLXyC6cNxkzjW3a/n75LYbAL7U=; b=dfyVQK
	GyYB2IbRWdzzwlBWDpfyPNuIJuY4PvfWTzHUSlBYgyRiVZzAOxh743qR8K/oiOoH
	5prF9JfPJ0Kr8UAe3a+2Zd7f3Dg5NnSHrtlCS8EM2Lmk6/ntdN+xdvak0kqmyHH3
	ihzCU3yvtE9IUhJ46bh+stvnj7YJmc4aHAhrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fEiy/ga725vx/kTe5N2/bSR/W59BqNjd
	Uih8GJTjgC+x7tyPMSbW8SZYTYMADWX430cNvIdjR1vvElkjPt5TAxBDvBaADUtX
	jyfHgPQzly7m45mr4kd+bwiws0dC8Hmhq62pv2ZbhtVd6SJ8aTumwpCftg61gyto
	LvuLkkhmw80=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 538193691C;
	Thu,  5 Feb 2015 16:16:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CED2E36919;
	Thu,  5 Feb 2015 16:16:37 -0500 (EST)
In-Reply-To: <20150205210024.GA30724@peff.net> (Jeff King's message of "Thu, 5
	Feb 2015 16:00:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4552FD3C-AD7C-11E4-8AAB-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263406>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 05, 2015 at 01:53:27AM -0500, Jeff King wrote:
>
>> I also notice that config_buf_ungetc does not actually ungetc the
>> character we give it; it just rewinds one character in the stream. This
>> is fine, because we always feed the last-retrieved character. I dunno if
>> it is worth fixing (it also would have fixed this infinite loop, but for
>> the wrong reason; we would have stuck "-1" back into the stream, and
>> retrieved it on the next fgetc rather than the same '\r' over and over).
>
> Here's a patch to deal with that. I'm not sure if it's worth doing or
> not.

I am not sure, either.  If this were to become stdio emulator over
random in-core data used throughout the system, perhaps.

But in its current form it is tied to the implementation of config.c
very strongly, so...

> -- >8 --
> Subject: [PATCH] config_buf_ungetc: warn when pushing back a random character
>
> Our config code simulates a stdio stream around a buffer,
> but our fake ungetc() does not behave quite like the real
> one. In particular, we only rewind the position by one
> character, but do _not_ actually put the character from the
> caller into position.
>
> It turns out that this does not matter, because we only ever
> push back the character we just read. In other words, such
> an assignment would be a noop. But because the function is
> called ungetc, and because it takes a character parameter,
> it is a mistake waiting to happen.
>
> Actually assigning the character into the buffer would be
> ideal, but our pointer is actually a "const" copy of the
> buffer. We do not know who the real owner of the buffer is
> in this code, and would not want to munge their contents.
>
> Instead, we can simply add an assertion that matches what
> the current caller does, and will let us know if new callers
> are added that violate the contract.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  config.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/config.c b/config.c
> index 2c63099..b74cc47 100644
> --- a/config.c
> +++ b/config.c
> @@ -73,8 +73,12 @@ static int config_buf_fgetc(struct config_source *conf)
>  
>  static int config_buf_ungetc(int c, struct config_source *conf)
>  {
> -	if (conf->u.buf.pos > 0)
> -		return conf->u.buf.buf[--conf->u.buf.pos];
> +	if (conf->u.buf.pos > 0) {
> +		conf->u.buf.pos--;
> +		if (conf->u.buf.buf[conf->u.buf.pos] != c)
> +			die("BUG: config_buf can only ungetc the same character");
> +		return c;
> +	}
>  
>  	return EOF;
>  }
