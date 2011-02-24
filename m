From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/8] strbuf: add strbuf_addv
Date: Thu, 24 Feb 2011 14:51:28 -0600
Message-ID: <20110224205128.GD17412@elie>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224142711.GB15477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 21:51:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsiAE-00006z-5s
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 21:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab1BXUvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 15:51:50 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47837 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab1BXUvt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 15:51:49 -0500
Received: by vws12 with SMTP id 12so808667vws.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 12:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SzJXntx40uXg5VHqrzkfX/hd4/n7EePAlRpJy5F5G2g=;
        b=daKNAcad5uTZbLM2NCGXjsUgk3PY/pCxs1P9ggD/oKHIf3bDECuvY2FRFr98Pa+/8l
         vg3dNReUJPkfRh6gsYEvOC1zepCSK39iuF0zHCu7jwUm0fMLgXzHi10qZMHzekhD32vL
         yGKyhTlLl+zFpAg9L8ApZWgtPS1fv16p4B+4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hFBK5MuRG/1LvqCmqHA8A9D1ba/KToX3NUTFCj5TGaUCmPKFSE0c/zj2vgPxCD85qy
         cc6dPB5C65N14w79UsV+lssWx/HZUss/+ndWdJ43xY304+f1hqKt9wRLL4pFHxahuC7g
         tZ0u2Ttxc9J/TuLSCDOCrx04OJ50K63VrWJ4A=
Received: by 10.52.164.103 with SMTP id yp7mr2496841vdb.161.1298580694815;
        Thu, 24 Feb 2011 12:51:34 -0800 (PST)
Received: from elie ([69.209.53.52])
        by mx.google.com with ESMTPS id y15sm823087vch.5.2011.02.24.12.51.32
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 12:51:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110224142711.GB15477@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167861>

Jeff King wrote:

> In a variable-args function, the code for writing into a
> strbuf is non-trivial. We ended up cutting and pasting it in
> several places because there was no vprintf-style function
> for strbufs (which in turn was held up by a lack of
> va_copy).
>
> Now that we have a fallback va_copy, we can add strbuf_addv,
> the strbuf equivalent of vsprintf.

"strbuf_vaddf" would follow the vsnprintf scheme a little better.
(I think strbuf_addv is just as intuitive, though.)

Thanks, I was looking for something like this.

And apparently it has been a wish for 2 years now. :)  See
http://thread.gmane.org/gmane.comp.version-control.git/75250/focus=76396
for amusement.

>  5 files changed, 24 insertions(+), 63 deletions(-)

Nice.

> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -120,6 +120,7 @@ extern void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *
>  
>  __attribute__((format (printf,2,3)))
>  extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
> +extern void strbuf_addv(struct strbuf *sb, const char *fmt, va_list ap);

"__attribute__(format (printf,2,0))" could tell gcc to check that the format
string is well formed and give it a chance to carp if you try

	static inline void foo(struct strbuf *sb, const char *fmt, ...)
	{
		va_list ap;

		va_start(ap, fmt);
		strbuf_addv(sb, fmt, ap);
		va_end(ap);
	}

	...
		foo(some_user_supplied_string);
---
diff --git a/strbuf.h b/strbuf.h
index 65b44a0..0c788d5 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -120,6 +120,7 @@ extern void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *
 
 __attribute__((format (printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+__attribute__((format (printf,2,0)))
 extern void strbuf_addv(struct strbuf *sb, const char *fmt, va_list ap);
 
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
