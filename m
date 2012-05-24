From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] vcs-svn: fix clang-analyzer warning
Date: Thu, 24 May 2012 09:33:37 -0500
Message-ID: <20120524143337.GB3732@burratino>
References: <1337868259-45626-1-git-send-email-davidbarr@google.com>
 <1337868259-45626-8-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu May 24 16:33:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXZ6r-0005SA-9A
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 16:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456Ab2EXOdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 10:33:45 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:32981 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab2EXOdo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 10:33:44 -0400
Received: by gglu4 with SMTP id u4so7763376ggl.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=k+Irwgw95zq/aAg3WNGQ4kzZK2YXhMP4DygliuJbpOw=;
        b=qumkZNGmKe+RRWu27ooWbgZ9TiukOe5InGmar7QMX7d1c8oPJaa6F3bOJMXKCATZws
         CyqJI9Z2n+0oZJdRMOOBV4ESHfMdYivsX14yaIjQQh4ZQs5I7MQK7W7/m7geajuA4k8b
         YJn+Odd8Phyrf73o6MVC4wnFEgo8R6SeoY5IUQam1gssTSgfgwAqKzHzq1nqDW2640ZJ
         AmLedx8JAvTtLEOpf6FsMSEsxqqmGHwWvTYbmQNXvpBeSbgqITcjZhpZWb0RYbSrjnb2
         ULhhP3gIFMtVlZnZsocTwo5ppqGhXWquXflq4n+XlDaY0vBLD/9PehLfcIP6+ufkG8GX
         XOvw==
Received: by 10.50.180.225 with SMTP id dr1mr16463282igc.52.1337870023505;
        Thu, 24 May 2012 07:33:43 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ch5sm15478830igb.0.2012.05.24.07.33.40
        (version=SSLv3 cipher=OTHER);
        Thu, 24 May 2012 07:33:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337868259-45626-8-git-send-email-davidbarr@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198386>

David Barr wrote:

> vcs-svn/svndiff.c:278:3: warning: expression result unused [-Wunused-value]
>                 error("invalid delta: incorrect postimage length");
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from vcs-svn/svndiff.c:6:
> vcs-svn/compat-util.h:18:61: note: instantiated from:
> #define error(...) (fprintf(stderr, "error: " __VA_ARGS__), -1)
>                                                             ^~

Yuck.  Would you be ok with an inline variadic function?

 static inline int error(const char *fmt, ...)
 {
	va_list ap;

	fprintf(stderr, "error: ");

	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap)
	va_end(ap);

	fprintf(stderr, "\n");

	return -1;
 }

The error() macro above also seems to leave out a newline.

> --- a/vcs-svn/svndiff.c
> +++ b/vcs-svn/svndiff.c
> @@ -258,6 +258,7 @@ static int apply_window_in_core(struct window *ctx)
[...]
> @@ -275,16 +276,15 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
>  	if (apply_window_in_core(&ctx))
>  		goto error_out;
>  	if (ctx.out.len != out_len) {
> -		error("invalid delta: incorrect postimage length");
> +		rv = error("invalid delta: incorrect postimage length");
>  		goto error_out;
>  	}
>  	if (write_strbuf(&ctx.out, out))
>  		goto error_out;
> -	window_release(&ctx);
> -	return 0;
> +	rv = 0;
>  error_out:
>  	window_release(&ctx);
> -	return -1;
> +	return rv;

That said, if this change is justified by saying that it avoids having
to repeat the cleanup code, it already looks like a good change.  The
commit message could mention that the original motivation and a
side-benefit is to help the standalone version that has a slightly
crazier definition of error().

Jonathan
