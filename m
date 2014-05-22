From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 7/9] remote-curl: recognize text/plain with a charset parameter
Date: Wed, 21 May 2014 17:07:38 -0700
Message-ID: <90CE006F-EE74-40D2-8847-507E37021D84@gmail.com>
References: <20140521102524.GA30301@sigill.intra.peff.net> <20140521103301.GG30464@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 02:07:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnGY3-0007xd-F7
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 02:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbaEVAHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 20:07:45 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:48713 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbaEVAHk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 20:07:40 -0400
Received: by mail-pd0-f172.google.com with SMTP id x10so1864111pdj.17
        for <git@vger.kernel.org>; Wed, 21 May 2014 17:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=fJwyYkXR2m1pskugya918j9CJGz4Ngwj2Yb83+MkDeU=;
        b=UOSwNrBxDlhns2xR+zhS6XZnqAQEsWx/9iszUbNFV8ZQ6kemw18LpkiFCzlLbkiUOZ
         Sqwd8v5aKxaBXRBwPCP4erym07NooS4T4qQoWbzWLJZZ8PajcSovTbdfUrDF71z7c+/W
         cmwFhnE9ZMqyBQd/DM8cNb6n9TzaWTLOfoKhoC8L/zbHd7D4h2UaMZGYZs5yhWWEvKvW
         eZKVF4gg0IVgBWIyXwHkOLqIR3UDaPZ1U9ySp87y4gpFIIYw8iTbgqR4SwJWQK6i7AJs
         iUbuw+v4N45ue7MqEIWV4mjEKGbuhFe1DwqBhec8RU7lvmRnmcxUCps39Dw9a9xvLOHq
         /EWw==
X-Received: by 10.67.3.229 with SMTP id bz5mr21653073pad.80.1400717260199;
        Wed, 21 May 2014 17:07:40 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id yv7sm111449051pac.33.2014.05.21.17.07.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 17:07:39 -0700 (PDT)
In-Reply-To: <20140521103301.GG30464@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249864>

On May 21, 2014, at 03:33, Jeff King wrote:

> Commit 426e70d (remote-curl: show server content on http
> errors, 2013-04-05) tried to recognize text/plain content
> types, but fails to do so if they have any parameters.
>
> This patches makes our parsing more liberal, though we still
> do not do anything useful with a charset parameter.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> remote-curl.c              | 26 ++++++++++++++++++--------
> t/lib-httpd/error.sh       |  8 +++++++-
> t/t5550-http-fetch-dumb.sh |  5 +++++
> 3 files changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index a5ab977..6d1b206 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -194,20 +194,30 @@ static void free_discovery(struct discovery *d)
> 	}
> }
>
> +/*
> + * We only show text/plain parts, as other types are likely
> + * to be ugly to look at on the user's terminal.
> + */
> +static int content_type_is_terminal_friendly(struct strbuf *type)
> +{
> +	const char *p;
> +
> +	p = skip_prefix(type->buf, "text/plain");
> +	if (!p || (*p && *p != ';'))
> +		return 0;
> +
> +	return 1;
> +}
> +

I think that a strict reading of RFC 2616 allows "text/plain ;  
charset=utf-8" as well as "text/plain;charset=utf-8" and "text/plain;  
charset=utf-8".  So perhaps this if line instead:

+	if (!p || (*p && *p != ';' && *p != ' ' && *p != '\t'))

See RFC 2616 section 2.2 for the definition of linear white space  
(LWS) and the end of section 2.1 for the "implied *LWS" rule that  
allows it.

> static int show_http_message(struct strbuf *type, struct strbuf *msg)
> {
> 	const char *p, *eol;
>
> -	/*
> -	 * We only show text/plain parts, as other types are likely
> -	 * to be ugly to look at on the user's terminal.
> -	 *
> -	 * TODO should handle "; charset=XXX", and re-encode into
> -	 * logoutputencoding
> -	 */
> -	if (strcmp(type->buf, "text/plain"))
> +	if (!content_type_is_terminal_friendly(type))
> 		return -1;
>
> +	/* TODO should record charset and reencode msg to  
> logOutputEncoding */
> +
> 	strbuf_trim(msg);
> 	if (!msg->len)
> 		return -1;
> diff --git a/t/lib-httpd/error.sh b/t/lib-httpd/error.sh
> index 786f281..02e80b3 100755
> --- a/t/lib-httpd/error.sh
> +++ b/t/lib-httpd/error.sh
> @@ -3,6 +3,7 @@
> printf "Status: 500 Intentional Breakage\n"
>
> printf "Content-Type: "
> +charset=iso8859-1
> case "$PATH_INFO" in
> *html*)
> 	printf "text/html"
> @@ -10,8 +11,13 @@ case "$PATH_INFO" in
> *text*)
> 	printf "text/plain"
> 	;;
> +*charset*)
> +	printf "text/plain; charset=utf-8"
> +	charset=utf-8
> +	;;
> esac
> printf "\n"
>
> printf "\n"
> -printf "this is the error message\n"
> +printf "this is the error message\n" |
> +iconv -f us-ascii -t $charset
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index 13defd3..b35b261 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -181,5 +181,10 @@ test_expect_success 'git client does not show  
> html errors' '
> 	! grep "this is the error message" stderr
> '
>
> +test_expect_success 'git client shows text/plain with a charset' '
> +	test_must_fail git clone "$HTTPD_URL/error/charset" 2>stderr &&
> +	grep "this is the error message" stderr
> +'
> +
> stop_httpd
> test_done
> -- 
> 2.0.0.rc1.436.g03cb729
>
