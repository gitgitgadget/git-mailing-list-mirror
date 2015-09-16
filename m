From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 11/67] trace: use strbuf for quote_crnl output
Date: Tue, 15 Sep 2015 20:55:58 -0400
Message-ID: <CAPig+cS3WFg1JtN7WU-SFSbT3a2L3o7wiZr8OMGJ5E3As00q3w@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915152843.GK29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 02:56:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc112-0001g2-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 02:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbbIPAz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 20:55:59 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35941 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbIPAz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 20:55:58 -0400
Received: by vkfp126 with SMTP id p126so91137599vkf.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 17:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DJRLj1MsQbTukdpzkwF0hK+fmT8KmgtesXSqlAC7xj4=;
        b=jmP5ElGyTe2n6VHsNwpWHVZdbTv400SaNbbBcBioPNGtipfazpKb5uJOBKuiwDU3jq
         yL8aVCAdttTcvqtOlyQ5+xkSniqgw0mBWCzk+KkKrOsjB3Cby3NS1yXejmhwwXbT8SV+
         kadTxOeu84U8jdjbKpsnnlFagkEfg2c0eIB7iyQZluwgOID3dwXWk649bqfxJ0MAQumw
         a+Bs7lOdzp6tGO8v9SyEoiDEdTgO30BEPUDOBhZKGE1wwxNVFh8GD65jYET1hZkXiQ9t
         48yzk1yfg+Q19MMtIWIYRyM9xWNE7GWXI0yaBgxRVQFCRzh2/1QMZNs1hr7G1ugfw7CO
         MS0g==
X-Received: by 10.31.6.20 with SMTP id 20mr25725048vkg.151.1442364958165; Tue,
 15 Sep 2015 17:55:58 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Tue, 15 Sep 2015 17:55:58 -0700 (PDT)
In-Reply-To: <20150915152843.GK29753@sigill.intra.peff.net>
X-Google-Sender-Auth: pQ4MfznFwqyg-N-y3aWnRYf_Nzg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277989>

On Tue, Sep 15, 2015 at 11:28 AM, Jeff King <peff@peff.net> wrote:
> When we output GIT_TRACE_SETUP paths, we quote any
> meta-characters. But our buffer to hold the result is only
> PATH_MAX bytes, and we could double the size of the input
> path (if every character needs quoted). We could use a

s/quoted/to be &/ ...or... s/quoted/quoting/

> 2*PATH_MAX buffer, if we assume the input will never be more
> than PATH_MAX. But it's easier still to just switch to a
> strbuf and not worry about whether the input can exceed
> PATH_MAX or not.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/trace.c b/trace.c
> index 7393926..0c06d71 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -277,25 +277,25 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
>
>  static const char *quote_crnl(const char *path)
>  {
> -       static char new_path[PATH_MAX];
> +       static struct strbuf new_path = STRBUF_INIT;
>         const char *p2 = path;
> -       char *p1 = new_path;

It's a little sad that this leaves a variable named 'p2' when there is
no corresponding 'p1'. Would this deserve a cleanup patch which
renames 'p2' to 'p' or do we not care enough?

>         if (!path)
>                 return NULL;
>
> +       strbuf_reset(&new_path);
> +
>         while (*p2) {
>                 switch (*p2) {
> -               case '\\': *p1++ = '\\'; *p1++ = '\\'; break;
> -               case '\n': *p1++ = '\\'; *p1++ = 'n'; break;
> -               case '\r': *p1++ = '\\'; *p1++ = 'r'; break;
> +               case '\\': strbuf_addstr(&new_path, "\\\\"); break;
> +               case '\n': strbuf_addstr(&new_path, "\\n"); break;
> +               case '\r': strbuf_addstr(&new_path, "\\r"); break;
>                 default:
> -                       *p1++ = *p2;
> +                       strbuf_addch(&new_path, *p2);
>                 }
>                 p2++;
>         }
> -       *p1 = '\0';
> -       return new_path;
> +       return new_path.buf;
>  }
>
>  /* FIXME: move prefix to startup_info struct and get rid of this arg */
> --
> 2.6.0.rc2.408.ga2926b9
