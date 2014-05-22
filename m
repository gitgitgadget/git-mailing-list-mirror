From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v2 4/8] http: extract type/subtype portion of content-type
Date: Thu, 22 May 2014 15:52:21 -0700
Message-ID: <567F86A0-98E4-49AF-81C8-8D9E1AEC3C5E@gmail.com>
References: <20140522092824.GA14530@sigill.intra.peff.net> <20140522092947.GD15032@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Peter Krefting <peter@softwolves.pp.se>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 23 00:52:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnbqe-00046e-37
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 00:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbaEVWwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 18:52:24 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:43243 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbaEVWwX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 18:52:23 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so3166715pbb.39
        for <git@vger.kernel.org>; Thu, 22 May 2014 15:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=XHxIbu+WBX7mPvjM4m02wxOd4JhbMhbJ9jaMNpg7b+A=;
        b=gl0QBMQ94gMy1g1Jd6gbaj1t/IAbJzzGRPyu86q0yx5EO1Vu3c/IVP+0RsdYx1qsmP
         UswLJs66iHxRpeZM6LE1vr00uwtwwsAYw03vz98MIvp5ia3But5mGjgvva4AT+5cX63C
         3De/yXzHSTZ3Y33kLy7zTQr6qcOVNhfAbpbisrdZ2lNH3HKyvJ50/XPlXhkQtfYKA+jl
         tBTu9vFwmtmCOKIdVIHf4IGFOC1g9h/8M9B6UWI2Q/awAxEK5zjTfQOnfB4iCHLC6grt
         AIyoNymUlV3TVzlSwXxDt5BTKChfCS1qJzWj3Kgb++8R4DI9WGNIueiaLe/ITjVeMJfQ
         +Azw==
X-Received: by 10.66.186.238 with SMTP id fn14mr737769pac.135.1400799142780;
        Thu, 22 May 2014 15:52:22 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id tu3sm4928482pab.1.2014.05.22.15.52.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 15:52:22 -0700 (PDT)
In-Reply-To: <20140522092947.GD15032@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249955>


On May 22, 2014, at 02:29, Jeff King wrote:

> When we get a content-type from curl, we get the whole
> header line, including any parameters, and without any
> normalization (like downcasing or whitespace) applied.
> If we later try to match it with strcmp() or even
> strcasecmp(), we may get false negatives.
>
> This could cause two visible behaviors:
>
>  1. We might fail to recognize a smart-http server by its
>     content-type.
>
>  2. We might fail to relay text/plain error messages to
>     users (especially if they contain a charset parameter).
>
> This patch teaches the http code to extract and normalize
> just the type/subtype portion of the string. This is
> technically passing out less information to the callers, who
> can no longer see the parameters. But none of the current
> callers cares, and a future patch will add back an
> easier-to-use method for accessing those parameters.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> http.c                     | 32 +++++++++++++++++++++++++++++---
> remote-curl.c              |  2 +-
> t/lib-httpd/error.sh       |  8 +++++++-
> t/t5550-http-fetch-dumb.sh |  5 +++++
> 4 files changed, 42 insertions(+), 5 deletions(-)
>
> diff --git a/http.c b/http.c
> index 94e1afd..4edf5b9 100644
> --- a/http.c
> +++ b/http.c
> @@ -906,6 +906,29 @@ static CURLcode curlinfo_strbuf(CURL *curl,  
> CURLINFO info, struct strbuf *buf)
> 	return ret;
> }
>
> +/*
> + * Extract a normalized version of the content type, with any
> + * spaces suppressed, all letters lowercased, and no trailing ";"
> + * or parameters.
> + *
> + * Example:
> + *   "TEXT/PLAIN; charset=utf-8" -> "text/plain"
> + */
> +static void extract_content_type(struct strbuf *raw, struct strbuf  
> *type)
> +{
> +	const char *p;
> +
> +	strbuf_reset(type);
> +	strbuf_grow(type, raw->len);
> +	for (p = raw->buf; *p; p++) {
> +		if (isspace(*p))
> +			continue;
> +		if (*p == ';')
> +			break;
> +		strbuf_addch(type, tolower(*p));
> +	}
> +}
> +

This will parse invalid content types as valid.  Probably not  
important since the producer of an invalid content type shouldn't be  
depending on any particular behavior by the consumer of such a type,  
but I think it warrants a note in the comment block, perhaps something  
like:

   * Note that an invalid content-type may be converted to a valid one

or some such.

--Kyle
