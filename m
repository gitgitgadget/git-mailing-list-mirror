From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 4/5] config: improve support for http.<url>.* settings
Date: Mon, 15 Jul 2013 19:12:51 -0400
Message-ID: <CAPig+cQTNXgPyD4qiQPyQeSHWY0Y=_Qnd2i9LfVqQDA1DJNDxg@mail.gmail.com>
References: <506e5f642a838b95e0dd5b1f0fa1cfe@f74d39fa044aa309eaea14b9f57fe79>
	<dcbaa11c8595f48814aa39a75ad18ea@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>, Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 01:12:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyrwv-0004Vr-Rl
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 01:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082Ab3GOXMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 19:12:54 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:49378 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754916Ab3GOXMx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 19:12:53 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so94444lbd.29
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 16:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=yGL2kmj0LHxHKZ7+08NsbuRGvgHeQAbZJD01MyI3P0Y=;
        b=rgrQI2Db70Rj4SPbvW4n27e56j52oKkp/P/gS1JeL84w0nTYjuf1vYK8FyIdsa5avP
         yaLpPObkn6UwXij8Cixd4VMiKDxIzCkP07aOFBBp6KLIpwd9nxzIo35HltY96cKrJdhu
         7NZTflmosWcryk9OXZTcqjhTRjhQvPqsZth1o9SMGdqsLhFxEpjUPEzInq5gcigTszom
         CNEgEPlpQxOrJrBox5RBjd0W00X2XFSJMHqUkacw+sRap0HO4/OFNQuHy2QVZ7poXqlW
         ghwX13ICyIIf8b9Q81kG3Byw5hvZkBjb3wf3Rh5jHu3aRk7pMMMs8pwflCP6sbP6E33r
         AuuA==
X-Received: by 10.152.87.172 with SMTP id az12mr26246371lab.24.1373929971521;
 Mon, 15 Jul 2013 16:12:51 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Mon, 15 Jul 2013 16:12:51 -0700 (PDT)
In-Reply-To: <dcbaa11c8595f48814aa39a75ad18ea@f74d39fa044aa309eaea14b9f57fe79>
X-Google-Sender-Auth: 37-2Ey1pC-cy3ZFk1rmzdvu2gz4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230531>

On Mon, Jul 15, 2013 at 5:51 AM, Kyle J. McKay <mackyle@gmail.com> wrote:
> Improve on the http.<url>.* url matching behavior by first
> normalizing the urls before they are compared.
>
> diff --git a/http.c b/http.c
> index 758e5b1..d04386e 100644
> --- a/http.c
> +++ b/http.c
> @@ -169,6 +169,210 @@ static void process_curl_messages(void)
>  }
>  #endif
>
> +static int append_normalized_escapes(struct strbuf *buf,
> +                                    const char *from,
> +                                    size_t from_len,
> +                                    const char *esc_extra,
> +                                    const char *esc_ok)
> +{
> +       /*
> +        * Append to strbuf buf characters from string from with length from_len

s/from string from/from string/

> +        * while unescaping characters that do not need to be escaped and
> +        * escaping characters that do.  The set of characters to escape (the
> +        * complement of which is unescaped) starts out as the RFC 3986 unsafe
> +        * characters (0x00-0x1F,0x7F-0xFF," <>\"#%{}|\\^`").  If esc_extra
> +        * is not NULL, those additional characters will also always be escaped.
> +        * If esc_ok is not NULL, those characters will be left escaped if found
> +        * that way, but will not be unescaped otherwise (used for delimiters).
> +        * If a %-escape sequence is encountered that is not followed by 2
> +        * hexadecimal digits, the sequence is invalid and false (0) will be
> +        * returned.  Otherwise true (1) will be returned for success.
> +        *
> +        * Note that all %-escape sequences will be normalized to UPPERCASE
> +        * as indicated in RFC 3986.  Unless included in esc_extra or esc_ok
> +        * alphanumerics and "-._~" will always be unescaped as per RFC 3986.
> +        */
