From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 12/17] strbuf: add strbuf_replace()
Date: Thu, 30 Jan 2014 22:11:48 -0500
Message-ID: <CAPig+cRd4nTwt1T5GH5qZ04vhUQHbDCNGuO2aZ=DBHDLRQ6pDQ@mail.gmail.com>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.3401.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jan 31 04:11:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W94WH-0001am-HH
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 04:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbaAaDLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 22:11:50 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:46402 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbaAaDLt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 22:11:49 -0500
Received: by mail-yk0-f178.google.com with SMTP id 79so21003872ykr.9
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 19:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kO0lGy+jEL8YV5i0/UvBsWlDzZ9KUFhiOQeXGT8lG88=;
        b=svQXedZYtZDZ3LvQxHyei253lbgtkDF4EVCgotZMfSgUrwqs8Lcp+2sidtrAsfDaIm
         c9XAhnhUHDzaoT28dfOTtE/CZ6ZvPEElqSeYEaHLpcJwfxV+lBB5GMnymBFzT/Lsb4Tp
         PzjeyrQLjgir8KfG2/1Ow3uWiY1SzTiWQlpLVpkV0iGPHA8EfBXlT7CHDMoq3qbMhQa1
         WugXdqs35nB9iHDC9GOb03AA2fw6MEAxggZzQopYpOKSRfcgaCuXmqdp9vl1zhq65c7a
         xr0peHcwfdtzwii0Hsb4oLhivctRLDZAplk/81VNk2v7M06n9eb8YR1pCca5YSGwfWCT
         Is8Q==
X-Received: by 10.236.105.236 with SMTP id k72mr17130849yhg.30.1391137908855;
 Thu, 30 Jan 2014 19:11:48 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Thu, 30 Jan 2014 19:11:48 -0800 (PST)
In-Reply-To: <20140130064921.7504.3401.chriscool@tuxfamily.org>
X-Google-Sender-Auth: AFtlqo8hLe7XBFFGRqCuOgrIUbg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241291>

On Thu, Jan 30, 2014 at 1:49 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/strbuf.c b/strbuf.c
> index 2124bb8..e45e513 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -197,6 +197,13 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
>         strbuf_setlen(sb, sb->len + dlen - len);
>  }
>
> +void strbuf_replace(struct strbuf *sb, const char *a, const char *b)
> +{
> +       char *ptr = strstr(sb->buf, a);

This could be 'const char *'.

> +       if (ptr)
> +               strbuf_splice(sb, ptr - sb->buf, strlen(a), b, strlen(b));
> +}
> +
>  void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len)
>  {
>         strbuf_splice(sb, pos, 0, data, len);
> diff --git a/strbuf.h b/strbuf.h
> index 02bff3a..38faf70 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -111,6 +111,9 @@ extern void strbuf_remove(struct strbuf *, size_t pos, size_t len);
>  extern void strbuf_splice(struct strbuf *, size_t pos, size_t len,
>                            const void *, size_t);
>
> +/* first occurence of a replaced with b */
> +extern void strbuf_replace(struct strbuf *, const char *a, const char *b);

Updating Documentation/technical/api-strbuf.txt to mention this new
function would be appropriate.

>  extern void strbuf_add_commented_lines(struct strbuf *out, const char *buf, size_t size);
>
>  extern void strbuf_add(struct strbuf *, const void *, size_t);
