From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 9/9] remote-curl: reencode http error messages
Date: Wed, 21 May 2014 17:07:40 -0700
Message-ID: <EF689296-BB9E-4734-A044-25DEF1874884@gmail.com>
References: <20140521102524.GA30301@sigill.intra.peff.net> <20140521103353.GI30464@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 02:07:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnGY2-0007xd-V7
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 02:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbaEVAHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 20:07:46 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:43236 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbaEVAHm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 20:07:42 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so1853740pdi.41
        for <git@vger.kernel.org>; Wed, 21 May 2014 17:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=M/8V15EqLnpWIv+qJF+jDjg5jLVZRnvysSWPJRegk94=;
        b=rGM5SEpxN3XWd2exPkP5JYfMbo8kskNvO+S/TAn4404X0sf4SJw25CN5RiM5VBKN1Q
         nOPphUUw3mstSwpkEmtkb0BHZLyX1Ormj2UhDiTAKdBXyIl71boiTPogA6nb8rRYKjUr
         S5xUB5MrkrzT9uRRqMnjtw1u7l6xW7BikA+xGrTbuNjchwLrwdGvcTAoPmNboNYIJT9J
         xVL0inDiyeFSh2ocgzsEK+cIiJi/jlWltVj9bYkj8Ib+yzHl2/ZNrr1IsiFEriKh3WhR
         prucowrPfS+nKRC1kT7fPS2m8B7kyWAKgTQvAKoygq141wffDY3Ojv/PPwBjUYjDES02
         9GtQ==
X-Received: by 10.66.148.70 with SMTP id tq6mr62662828pab.56.1400717262442;
        Wed, 21 May 2014 17:07:42 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id yv7sm111449051pac.33.2014.05.21.17.07.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 17:07:42 -0700 (PDT)
In-Reply-To: <20140521103353.GI30464@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249865>

On May 21, 2014, at 03:33, Jeff King wrote:

> As of the last commit, we now recognize an error message
> with a content-type "text/plain; charset=utf-16" as text,
> but we ignore the charset parameter entirely. Let's encode
> it to log_output_encoding, which is presumably something the
> user's terminal can handle.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> remote-curl.c              | 37 +++++++++++++++++++++++++++++++++----
> t/lib-httpd/error.sh       |  4 ++++
> t/t5550-http-fetch-dumb.sh |  5 +++++
> 3 files changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 6d1b206..1dc90d7 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -194,11 +194,34 @@ static void free_discovery(struct discovery *d)
> 	}
> }
>
> +static char *find_param(const char *str, const char *name)
> +{
> +	int len = strlen(name);
> +
> +	for (; *str; str++) {
> +		const char *p;
> +
> +		if (*p++ != ' ')
> +			continue;
> +
> +		if (strncmp(p, name, len))
> +			continue;
> +		p += len;
> +
> +		if (*p++ != '=')
> +			continue;
> +
> +		return xstrndup(p, strchrnul(p, ' ') - p);
> +	}
> +
> +	return NULL;
> +}
> +
> /*
>  * We only show text/plain parts, as other types are likely
>  * to be ugly to look at on the user's terminal.
>  */
> -static int content_type_is_terminal_friendly(struct strbuf *type)
> +static int content_type_is_terminal_friendly(struct strbuf *type,  
> char **charset)
> {
> 	const char *p;
>
> @@ -206,17 +229,23 @@ static int  
> content_type_is_terminal_friendly(struct strbuf *type)
> 	if (!p || (*p && *p != ';'))
> 		return 0;
>
> +	*charset = find_param(p, "charset");
> +	/* default charset from rfc2616 */
> +	if (!*charset)
> +		*charset = xstrdup("iso8859-1");

Actually the name should be "ISO-8859-1".  See RFC 2616 section  
3.7.1.  Since it's case insensitive "iso-8859-1" would be fine too.

> +
> 	return 1;
> }
>
> static int show_http_message(struct strbuf *type, struct strbuf *msg)
> {
> 	const char *p, *eol;
> +	char *charset;
>
> -	if (!content_type_is_terminal_friendly(type))
> +	if (!content_type_is_terminal_friendly(type, &charset))
> 		return -1;
> -
> -	/* TODO should record charset and reencode msg to  
> logOutputEncoding */
> +	strbuf_reencode(msg, charset, get_log_output_encoding());
> +	free(charset);
>
> 	strbuf_trim(msg);
> 	if (!msg->len)
> diff --git a/t/lib-httpd/error.sh b/t/lib-httpd/error.sh
> index 02e80b3..4efbce7 100755
> --- a/t/lib-httpd/error.sh
> +++ b/t/lib-httpd/error.sh
> @@ -15,6 +15,10 @@ case "$PATH_INFO" in
> 	printf "text/plain; charset=utf-8"
> 	charset=utf-8
> 	;;
> +*utf16*)
> +	printf "text/plain; charset=utf-16"
> +	charset=utf-16
> +	;;
> esac
> printf "\n"
>
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index b35b261..01b8aae 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -186,5 +186,10 @@ test_expect_success 'git client shows text/ 
> plain with a charset' '
> 	grep "this is the error message" stderr
> '
>
> +test_expect_success 'http error messages are reencoded' '
> +	test_must_fail git clone "$HTTPD_URL/error/utf16" 2>stderr &&
> +	grep "this is the error message" stderr
> +'
> +
> stop_httpd
> test_done
> -- 
> 2.0.0.rc1.436.g03cb729
