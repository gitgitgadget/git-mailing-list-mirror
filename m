From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 26/67] replace trivial malloc + sprintf /strcpy calls to xstrfmt
Date: Wed, 16 Sep 2015 00:24:38 -0400
Message-ID: <CAPig+cQTGbE4jC2o8zta0HR3ske3y3MoFTd7zBvwMTg6vp3Vag@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915154510.GZ29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 06:24:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc4Gy-0006do-38
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 06:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbbIPEYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 00:24:39 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35414 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbbIPEYi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 00:24:38 -0400
Received: by vkao3 with SMTP id o3so81317306vka.2
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 21:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cijXi3LTnqIht3dF+rjWXNFjGPl3Bk3GRBoZf+WFZNs=;
        b=GLqnz5X3ORbWg4mIIOvn6BbjyjprbI1U5PkUHESb0obwhv/lVuiuN9rxEH0reTLJDc
         JAhhpCbpemeY5CirwYfFuNFJ+o2B0Bb8v8kZYncRQo87hzUUlXMiXr66egrsQt1VK2ZJ
         qmlOKKmn9J1iNfmseX4vJ7yCRFgyJDzupOWedT66tHkpXzEkAG6PM3/ckJnFvxvqF+vq
         iSsHwlSLSOxTwOlnE13TAe90Y2+KnlflimPDyNBEdXOLx9Z4asBVzPWPNDxvpnX7htH9
         LlHZtTDls0hO5qHM31WT7Ny58BPqrbJbu09NoO09Q9jGw9qGaIzmvYIGJC5fHkYobu3d
         ySoQ==
X-Received: by 10.31.151.84 with SMTP id z81mr14766395vkd.14.1442377478214;
 Tue, 15 Sep 2015 21:24:38 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Tue, 15 Sep 2015 21:24:38 -0700 (PDT)
In-Reply-To: <20150915154510.GZ29753@sigill.intra.peff.net>
X-Google-Sender-Auth: ML0MRJ4OpMK6_bLUtv9PX033PQ0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278000>

On Tue, Sep 15, 2015 at 11:45 AM, Jeff King <peff@peff.net> wrote:
> replace trivial malloc + sprintf /strcpy calls to xstrfmt

s/to/with/

Also, do you want either to add a space after '/' or drop the one before it?

> It's a common pattern to do:
>
>   foo = xmalloc(strlen(one) + strlen(two) + 1 + 1);
>   sprintf(foo, "%s %s", one, two);
>
> (or possibly some variant with strcpy()s or a more
> complicated length computation).  We can switch these to use
> xstrfmt, which is shorter, involves less error-prone manual
> computation, and removes many sprintf and strcpy calls which
> make it harder to audit the code for real buffer overflows.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -889,9 +889,8 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
>         }
>
>         /* response: "<user> <digest in hex>" */
> -       resp_len = strlen(user) + 1 + strlen(hex) + 1;
> -       response = xmalloc(resp_len);
> -       sprintf(response, "%s %s", user, hex);
> +       response = xstrfmt("%s %s", user, hex);
> +       resp_len = strlen(response);
>
>         response_64 = xmalloc(ENCODED_SIZE(resp_len) + 1);

The original resp_len calculation included the NUL but the revised
does not. If I'm reading this correctly, the revised calculation is
correct, and the original was over-allocating response_64, right?

>         encoded_len = EVP_EncodeBlock((unsigned char *)response_64,
