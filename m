From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/7] vcs-svn: fix signedness warnings
Date: Thu, 24 May 2012 09:48:47 -0500
Message-ID: <20120524144847.GC3732@burratino>
References: <1337868259-45626-1-git-send-email-davidbarr@google.com>
 <1337868259-45626-4-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu May 24 16:49:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXZLV-0004dY-Qo
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 16:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580Ab2EXOsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 10:48:53 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:54914 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756192Ab2EXOsw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 10:48:52 -0400
Received: by qabj40 with SMTP id j40so351843qab.1
        for <git@vger.kernel.org>; Thu, 24 May 2012 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LxYjGinbMBBXWFJddzq46givE05e2exu/zpkm5wonnQ=;
        b=uFgmI9l263nC15ydMz6ZR0cjyRgaqlRdUKdCI0vc7IGpEqme8je/T4V+ModQe/0sh8
         73krJc3S8i///6jZf9ayg+xEbeUpjAxwSk8Xrx3WzpS3Z0YRVFxuVZWrpS3JXFAZQDDE
         GimxqyC/HdA4Zb39rGx1KGu4cabY2MXpxIk6yTMfJgQ60ccMiX5n9p5R6EeF9eECHLtA
         yi1s5/BPTyxI9wxlSdBcZfpaBTNCNihrRPFKXJ+8mXQvoTEY3oYG2c2uwPV1vE/UcdT1
         BFUiPbQAzgDwn/gVJfFmY9eNnwSy3DBdiSAHcP/JS5ZYr9t/upW8fqqjNc+bp96roq02
         FsGw==
Received: by 10.50.140.4 with SMTP id rc4mr16940863igb.68.1337870931434;
        Thu, 24 May 2012 07:48:51 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id yg9sm15509233igb.15.2012.05.24.07.48.50
        (version=SSLv3 cipher=OTHER);
        Thu, 24 May 2012 07:48:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337868259-45626-4-git-send-email-davidbarr@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198388>

David Barr wrote:

> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -259,7 +259,7 @@ static int parse_ls_response(const char *response, uint32_t *mode,
>  	}
>  
>  	/* Mode. */
> -	if (response_end - response < strlen("100644") ||
> +	if (response_end - response < (off_t) strlen("100644") ||

I wish the static analyzer could notice that "response_end - response"
is always nonnegative and stop worrying.  If we want to appease it,
I guess I'd mildly prefer something like

	if (response_end - response < (signed) strlen("100644") ||

which expresses the intent more directly.

[...]
> --- a/vcs-svn/line_buffer.c
> +++ b/vcs-svn/line_buffer.c
> @@ -91,8 +91,7 @@ char *buffer_read_line(struct line_buffer *buf)
>  	return buf->line_buffer;
>  }
>  
> -size_t buffer_read_binary(struct line_buffer *buf,
> -				struct strbuf *sb, size_t size)
> +off_t buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, off_t size)
>  {
>  	return strbuf_fread(sb, size, buf->infile);
>  }

On systems with larger off_t than size_t (think "typical 32-bit PC,
since file offsets tend to be 64 bits"), this silently throws away
bits.  I think the cure is worse than the disease.

[...]
> --- a/vcs-svn/sliding_window.c
> +++ b/vcs-svn/sliding_window.c
> @@ -43,11 +43,11 @@ static int check_offset_overflow(off_t offset, uintmax_t len)
>  	return 0;
>  }
>  
> -int move_window(struct sliding_view *view, off_t off, size_t width)
> +int move_window(struct sliding_view *view, off_t off, off_t width)
>  {

Likewise.  I'd rather the caller know that the window has to fit in an
address space which can be smaller than the maximum file size.

Is this to avoid having two different functions that parse a
variable-length integer, or is there some other reason?

Hope that helps,
Jonathan
