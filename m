From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v2 4/8] http: extract type/subtype portion of content-type
Date: Fri, 23 May 2014 15:00:43 -0700
Message-ID: <D9EE35E5-A76C-4C3C-9A50-42822165964F@gmail.com>
References: <20140522092824.GA14530@sigill.intra.peff.net> <20140522092947.GD15032@sigill.intra.peff.net> <567F86A0-98E4-49AF-81C8-8D9E1AEC3C5E@gmail.com> <20140523201245.GE19088@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Peter Krefting <peter@softwolves.pp.se>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 24 00:00:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnxWF-0004PE-7Y
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 00:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbaEWWAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 18:00:48 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:63029 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbaEWWAr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 18:00:47 -0400
Received: by mail-pb0-f48.google.com with SMTP id rr13so4692545pbb.7
        for <git@vger.kernel.org>; Fri, 23 May 2014 15:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=E78m1fLmge64xtEb0YO2YIOM5XyThV1XPB6KGzXP/3I=;
        b=CR+m2mgFkPQzn18CZT4DowzOKALgCYVJPQCH45g5JMg3qRJ0nvrY7fHredwBPfY8XU
         PVKEhEiIq0/JmvlAyF1NhZwOuaVN8HRMTFP0fYrVA38QgXnSLqJp8UbWuOZhhl0w9YlG
         NGpqswy+wL5ODu+DfLlzW841eOMEU51C/udQ1ZV+klwg5JHJ3zCVx4yi/1iaVuUeY+l5
         7vPImFR/K3NNqbhQHgoM7TOtKlEBOp/ukpif/AElsXaNlepx07N9cJQqL/3VF8odoUkE
         JlUENdS/+5UQ+t9C2UzgMKDxAhc6VGpX1Eyb8+MzD20gw08y3NiEic+vV0f6tR6czwui
         7bqA==
X-Received: by 10.66.66.135 with SMTP id f7mr9646219pat.22.1400882446113;
        Fri, 23 May 2014 15:00:46 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id zq5sm6216216pbb.37.2014.05.23.15.00.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 23 May 2014 15:00:45 -0700 (PDT)
In-Reply-To: <20140523201245.GE19088@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250039>

On May 23, 2014, at 13:12, Jeff King wrote:
> On Thu, May 22, 2014 at 03:52:21PM -0700, Kyle J. McKay wrote:
>
>>> +static void extract_content_type(struct strbuf *raw, struct  
>>> strbuf *type)
>>> +{
>>> +	const char *p;
>>> +
>>> +	strbuf_reset(type);
>>> +	strbuf_grow(type, raw->len);
>>> +	for (p = raw->buf; *p; p++) {
>>> +		if (isspace(*p))
>>> +			continue;
>>> +		if (*p == ';')
>>> +			break;
>>> +		strbuf_addch(type, tolower(*p));
>>> +	}
>>> +}
>>> +
>>
>> This will parse invalid content types as valid.  Probably not  
>> important
>> since the producer of an invalid content type shouldn't be  
>> depending on any
>> particular behavior by the consumer of such a type, but I think it  
>> warrants
>> a note in the comment block, perhaps something like:
>>
>>  * Note that an invalid content-type may be converted to a valid one
>>
>> or some such.
>
> Yeah, that is intentional based on our earlier discussion (this  
> function
> started as "normalize_content_type" :) ). I think it's not a big deal,
> but agree it's worth a comment. Like:
>
> diff --git a/http.c b/http.c
> index 4edf5b9..6bfd093 100644
> --- a/http.c
> +++ b/http.c
> @@ -911,8 +911,14 @@ static CURLcode curlinfo_strbuf(CURL *curl,  
> CURLINFO info, struct strbuf *buf)
>  * spaces suppressed, all letters lowercased, and no trailing ";"
>  * or parameters.
>  *
> + * Note that we will silently remove even invalid whitespace. For
> + * example, "text / plain" is specifically forbidden by RFC 2616,
> + * but "text/plain" is the only reasonable output, and this keeps
> + * our code simple.

Very nice.  :)

> + *
>  * Example:
>  *   "TEXT/PLAIN; charset=utf-8" -> "text/plain"
> + *   "text / plain" -> "text/plain"
>  */
> static void extract_content_type(struct strbuf *raw, struct strbuf  
> *type)
> {
>
> -Peff
