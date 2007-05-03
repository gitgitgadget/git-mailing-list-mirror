From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make xstrndup common
Date: Thu, 3 May 2007 11:06:05 +0200
Message-ID: <81b0412b0705030206u3a6b8a46qfd98ccf597d3c96e@mail.gmail.com>
References: <Pine.LNX.4.64.0705022248040.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 03 11:06:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjXGP-0007il-8S
	for gcvg-git@gmane.org; Thu, 03 May 2007 11:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbXECJGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 05:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030634AbXECJGJ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 05:06:09 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:23413 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030501AbXECJGH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 05:06:07 -0400
Received: by an-out-0708.google.com with SMTP id b33so420171ana
        for <git@vger.kernel.org>; Thu, 03 May 2007 02:06:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d7qJAjLmIFw7rr95h7vGxQEQdwd9Ck62WWeSxw9dP9T6dQrRLnh0LJqNANpXpVneJkIdZmyYxRORArig1B7IYSHPs4VqcXiYxC9jB3PPTyYTRjB/AWiX33VI3ChO9dFg57mtUFVupfyS9mbBmRvfhjF/dhdMMGB8U3XhxYO0o/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a0KW6/VJ7jq7dh0omsYAeTErhUTvCc3Bn1HMJ2D3ymc+Q+tixM0WuSajI9kk9/PaJFoP7csy2DYloX0KtjT9oWDQlWk1nF/D19qnci/wCZ0BlkgeZmgg/gKY9M1+aUnt5JB+llahSiHrLQMKi/SWpw3VFftAV1FiO3Tsz/r3xeg=
Received: by 10.100.139.9 with SMTP id m9mr1318376and.1178183165804;
        Thu, 03 May 2007 02:06:05 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Thu, 3 May 2007 02:06:05 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705022248040.28708@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46076>

On 5/3/07, Daniel Barkalow <barkalow@iabervon.org> wrote:
> +static inline char *xstrndup(const char *str, int len)
> +{
> +       char *ret;
> +       int i;
> +       for (i = 0; i < len && str[i]; i++)
> +               ;
> +       ret = xmalloc(i + 1);
> +       strncpy(ret, str, i);
> +       ret[i] = '\0';
> +       return ret;
> +}

I'd suggest using platform-optimized memchr:

static inline char *xstrndup(const char *s, int len)
{
    char *p = memchr(s, 0, len);
    int n = p ? p - s: len;
    p = xmalloc(n + 1);
    memcpy(p, s, n);
    p[n] = '\0';
    return p;
}
