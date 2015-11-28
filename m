From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCHv3] ident.c: add support for IPv6
Date: Sat, 28 Nov 2015 21:48:27 +0100
Message-ID: <CA+EOSB=i3973MAj1Ti4tbQY23Hq=SDy8zoFLJQ4r1xm7hmZACQ@mail.gmail.com>
References: <1448633307-43339-1-git-send-email-gitter.spiros@gmail.com>
	<20151128172341.GE27264@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 28 21:49:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2mQX-0005AO-Ex
	for gcvg-git-2@plane.gmane.org; Sat, 28 Nov 2015 21:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbbK1Usa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2015 15:48:30 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34864 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbbK1Us2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2015 15:48:28 -0500
Received: by vkha189 with SMTP id a189so83428836vkh.2
        for <git@vger.kernel.org>; Sat, 28 Nov 2015 12:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OaP0HabaRdeFN8cBBh9Z7R8eHkwSL9YBaBjZuPqKmX8=;
        b=wmDtTnSNjb/quPKBbERBEjzO1XCm/+o5uwBUCQDDHN0Bd7BOZWF//p+FznH1Vhw8px
         AquOKFkK9Q2HVU5k1Jii6qk00EJmftTnHqenW1D0JZJXPZdpXBgg4XpRqGzdviHfRb2V
         AmrD9FaIHZ11uZ04pQ68Ilqd6lyyM89/xzvKiovR4dq7PyJ+eGj2kto0b8WxWl/qV4IH
         nWFhaB6IjfrKtCU9OJCUDlQOSpbRf6AVHWaTbODXXUSCpuK81z/a2E76Y5DhWi5GX7qj
         azt9TRRsxhJ6pT5d32HP2m8y6IO1NgUe9iqSrAONE5pEXzL5vaa+XJvWmdMbeS1qF517
         b05w==
X-Received: by 10.31.52.211 with SMTP id b202mr47057156vka.82.1448743707419;
 Sat, 28 Nov 2015 12:48:27 -0800 (PST)
Received: by 10.31.140.74 with HTTP; Sat, 28 Nov 2015 12:48:27 -0800 (PST)
In-Reply-To: <20151128172341.GE27264@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281795>

2015-11-28 18:23 GMT+01:00, Jeff King <peff@peff.net>:
> On Fri, Nov 27, 2015 at 02:08:27PM +0000, Elia Pinto wrote:
>
>> This is the third version of the patch ($gmane/280488)
>> Changes from previous:
>>
>> - Simplified the implementation, adding the new
>> function canonical_name (Jeff King) ($gmane/281479).
>> Fixed a new typo introduced in the second version.
>
> Thanks, I think this keeps add_domainname() a lot cleaner. There are a
> few problems:
>
>> +static int canonical_name(const char *host, struct strbuf *out)
>> +{
>> +       int status=-1;
>
> Our style is to put whitespace between operators (so "int status = -1;",
> and other places below).
>
> This line (and the others) was also indented with spaces, not tabs.
>
>> +#ifndef NO_IPV6
>> +       struct addrinfo hints, *ai;
>> +       memset (&hints, '\0', sizeof (hints));
>> +       hints.ai_flags = AI_CANONNAME;
>> +       int gai = getaddrinfo(host, NULL, &hints, &ai);
>
> We do C89-style no-decl-after-statement. But this "gai" is only
> used once, so we can just lump it into the next conditional.
>
>> +       if (!gai) {
>> +               if (ai && strchr(ai->ai_canonname, '.')) {
>> +                       strbuf_addstr(out, ai->ai_canonname);
>> +                       status=0;
>> +               }
>> +               freeaddrinfo(ai);
>> +       }
>> +#else
>> +       struct hostent *he = gethostbyname(buf);
>> +       if (he && strchr(he->h_name, '.')) {
>> +                       strbuf_addstr(out, he->h_name);
>> +                       status=0;
>> +       }
>> +#endif /* NO_IPV6 */
>> +}
>
> I think you are missing a "return status" here.
>
>> @@ -82,10 +105,9 @@ static void add_domainname(struct strbuf *out)
>>  	}
>>  	if (strchr(buf, '.'))
>>  		strbuf_addstr(out, buf);
>> -	else if ((he = gethostbyname(buf)) && strchr(he->h_name, '.'))
>> -		strbuf_addstr(out, he->h_name);
>> -	else
>> -		strbuf_addf(out, "%s.(none)", buf);
>> +	else {
>> +		 if (canonical_name(buf,out) != 0) strbuf_addf(out, "%s.(none)", buf);
>> +	}
>
> We always put conditional bodies on the next line, even if they are
> one-liners.
>
> Here's what I've queued, addressing those. No need to re-send if you're
> happy with it:
Ok for me. Thank you very much
>
> -- >8 --
> From: Elia Pinto <gitter.spiros@gmail.com>
> Subject: [PATCH] ident.c: add support for IPv6
>
> Add IPv6 support by implementing name resolution with the
> protocol agnostic getaddrinfo(3) API. The old gethostbyname(3)
> code is still available when git is compiled with NO_IPV6.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  ident.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/ident.c b/ident.c
> index 5ff1aad..4e7f99d 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -70,10 +70,35 @@ static int add_mailname_host(struct strbuf *buf)
>  	return 0;
>  }
>
> +static int canonical_name(const char *host, struct strbuf *out)
> +{
> +	int status = -1;
> +
> +#ifndef NO_IPV6
> +	struct addrinfo hints, *ai;
> +	memset (&hints, '\0', sizeof (hints));
> +	hints.ai_flags = AI_CANONNAME;
> +	if (!getaddrinfo(host, NULL, &hints, &ai)) {
> +		if (ai && strchr(ai->ai_canonname, '.')) {
> +			strbuf_addstr(out, ai->ai_canonname);
> +			status = 0;
> +		}
> +		freeaddrinfo(ai);
> +	}
> +#else
> +	struct hostent *he = gethostbyname(buf);
> +	if (he && strchr(he->h_name, '.')) {
> +		strbuf_addstr(out, he->h_name);
> +		status = 0;
> +	}
> +#endif /* NO_IPV6 */
> +
> +	return status;
> +}
> +
>  static void add_domainname(struct strbuf *out)
>  {
>  	char buf[1024];
> -	struct hostent *he;
>
>  	if (gethostname(buf, sizeof(buf))) {
>  		warning("cannot get host name: %s", strerror(errno));
> @@ -82,9 +107,7 @@ static void add_domainname(struct strbuf *out)
>  	}
>  	if (strchr(buf, '.'))
>  		strbuf_addstr(out, buf);
> -	else if ((he = gethostbyname(buf)) && strchr(he->h_name, '.'))
> -		strbuf_addstr(out, he->h_name);
> -	else
> +	else if (canonical_name(buf, out) < 0)
>  		strbuf_addf(out, "%s.(none)", buf);
>  }
>
> --
> 2.6.3.636.g1460207
>
>
