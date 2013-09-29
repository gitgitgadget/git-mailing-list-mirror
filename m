From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/9] http: update base URLs when we see redirects
Date: Sun, 29 Sep 2013 15:50:29 -0400
Message-ID: <CAPig+cQzStMzjONbxm3bhSYZ0AG+67ViQR1UBdqAYnvEnLyWGA@mail.gmail.com>
References: <20130928082956.GA22610@sigill.intra.peff.net>
	<20130928083405.GA2782@sigill.intra.peff.net>
	<CAPig+cQVQ6iY8onvb--88W0XHofC815NZHTb=L744hANtT8mVQ@mail.gmail.com>
	<20130929193245.GB17644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, "Kyle J. McKay" <mackyle@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 29 21:50:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQN0x-0005WJ-77
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 21:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358Ab3I2Tug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 15:50:36 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44326 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723Ab3I2Tub (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 15:50:31 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so3765183lbh.5
        for <git@vger.kernel.org>; Sun, 29 Sep 2013 12:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XE32b9M51Tj0eZ3yUbhzPhwBMjOkcbX3G8MIb9gtHNg=;
        b=nNvI/pJCdTPwJBsGBp45hXLzRdBOaO+SfFLoGVlmotkP1sJ19Vl9QJSHQuo+t8DoB8
         9qsuE6txpkWtaZ/EyVCqoVZn/xs5JXcUl6tAsl4QNEWj/DN0P7/U+KXDJtjtbfE7yPUZ
         hhlZwspSme3Hx5SumECa6XSkcoHSyt5nOqrJKWKaC9ebxJhmwtVX3fYPd3+wnj2c43Qr
         27OJjM5Kg2BTBQluamNW1rOf0+zmbFzh7iDrMxWeJ9CU2ZTkNy7EznQ1l8Sgb+9j1tWZ
         vNzLssotAPZLzqnDM4mTcXYYFi5vZnCgYj5oixRuJujrUFde//ngCCxtOaQiu3figRcW
         EpfA==
X-Received: by 10.152.120.73 with SMTP id la9mr16322937lab.3.1380484230013;
 Sun, 29 Sep 2013 12:50:30 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 29 Sep 2013 12:50:29 -0700 (PDT)
In-Reply-To: <20130929193245.GB17644@sigill.intra.peff.net>
X-Google-Sender-Auth: n4Po-sYygcJ6czRtvTErdUQ9RCY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235606>

On Sun, Sep 29, 2013 at 3:32 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Sep 29, 2013 at 03:26:45PM -0400, Eric Sunshine wrote:
>
>> On Sat, Sep 28, 2013 at 4:34 AM, Jeff King <peff@peff.net> wrote:
>> > diff --git a/http.c b/http.c
>> > index 65a0048..8775b5c 100644
>> > --- a/http.c
>> > +++ b/http.c
>> > @@ -921,11 +921,71 @@ static int http_request_reauth(const char *url,
>> > +static int update_url_from_redirect(struct strbuf *base,
>> > +                                   const char *asked,
>> > +                                   const struct strbuf *got)
>> > +{
>> > +       const char *tail;
>> > +       size_t tail_len;
>> > +
>> > +       if (!strcmp(asked, got->buf))
>> > +               return 0;
>> > +
>> > +       if (strncmp(asked, base->buf, base->len))
>> > +               die("BUG: update_url_from_redirect: %s is not a superset of %s",
>> > +                   asked, base->buf);
>>
>> Is there something non-obvious going on here? die(...,base->buf) takes
>> advantage of the terminating NUL promised by strbuf, but then
>> strncmp(...,base->buf,base->len) is used rather than the simpler
>> strcmp(...,base->buf).
>
> Yes, we are not checking for equality, but rather making sure that
> "asked" begins with "base->buf". It might be more clearly written as:

Ah right, I knew that that was the intention but had a synapse
misfire. Sorry for the noise.

>
>   if (prefixcmp(asked, base->buf))
>
> I was trying to take advantage of the fact that we know base->len
> already, but this it not a particularly performance-critical code path.
> We can afford the extra strlen that prefixcmp will do.
>
> -Peff
