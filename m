From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 04/16] refactor skip_prefix to return a boolean
Date: Thu, 19 Jun 2014 22:30:36 -0400
Message-ID: <CAPig+cST9MW2fYgCD3C-3HJQbMLHzBSX7Vxr23ejmVFTmkCj7A@mail.gmail.com>
References: <20140618194117.GA22269@sigill.intra.peff.net>
	<20140618194417.GD22622@sigill.intra.peff.net>
	<CAPig+cTKgrYx1hcO-hV3ZT2sm1rR17bWJC0ktZzFQB=TMr6Xuw@mail.gmail.com>
	<20140620020824.GA31908@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 04:30:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxobC-00030f-5d
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 04:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbaFTCah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 22:30:37 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:52433 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250AbaFTCah (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 22:30:37 -0400
Received: by mail-yh0-f44.google.com with SMTP id f10so2382136yha.17
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 19:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xSk/pMGbw4TxoQSDPPu3meiIcNSDMIcav/86TQyuj9g=;
        b=WyAOXvZ0BhRo5h64PIeWPmi8cGSnoMMFnbb8VR2wwbjpC+dOsNTpYJEK5ov9x6wHal
         69JO8a8ZRkFoaLANK8uT2oTct2DiSF0qur+Ylbg5rlQcQMsftpgdgYQ1gQ+ogcShDoo2
         WgA6B/KJViWMpXMYBsy5w2cevOss5b3W0mlsfWS5SHDsnBFdOWhVT1cu2hp0QXVwvlgv
         AlGYvTjWqPShJI7G8XU1vTjSPUeBs3/8J/di6EMwK+e6+zznutjil+CpjVdykSR6pZeH
         Te5gWXv9acvujbHGWA1SeBK/Scud8TynzrshMKv3DLTfM8/Uqdlidnhag0tWL99ciTzg
         MWUQ==
X-Received: by 10.236.87.129 with SMTP id y1mr640250yhe.121.1403231436314;
 Thu, 19 Jun 2014 19:30:36 -0700 (PDT)
Received: by 10.170.36.80 with HTTP; Thu, 19 Jun 2014 19:30:36 -0700 (PDT)
In-Reply-To: <20140620020824.GA31908@sigill.intra.peff.net>
X-Google-Sender-Auth: Rduc0y2yMijknNmnCkXeALRZxF4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252210>

On Thu, Jun 19, 2014 at 10:08 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 19, 2014 at 09:59:39PM -0400, Eric Sunshine wrote:
>
>> > diff --git a/git-compat-util.h b/git-compat-util.h
>> > index b6f03b3..556c839 100644
>> > --- a/git-compat-util.h
>> > +++ b/git-compat-util.h
>> > @@ -349,13 +349,31 @@ extern void set_die_is_recursing_routine(int (*routine)(void));
>> >  extern int starts_with(const char *str, const char *prefix);
>> >  extern int ends_with(const char *str, const char *suffix);
>> >
>> > -static inline const char *skip_prefix(const char *str, const char *prefix)
>> > +/*
>> > + * If "str" begins with "prefix", return 1. If out is non-NULL,
>> > + * it it set to str + strlen(prefix) (i.e., the prefix is skipped).
>>
>> The documentation claims that 'out' can be NULL, however, the code
>> does not respect this. NULL 'out' seems rather pointless (unless you
>> want an alias for starts_with()), so presumably the documentation is
>> incorrect.
>
> Thanks for catching. My original version (before I sent to the list) did
> allow for a conditional NULL out, but I realized there was exactly one
> caller who wanted this, and that they would be better off using
> starts_with. I added patch 3 ("avoid using skip_prefix as a boolean")
> and stripped the conditional from skip_prefix, but forgot to update the
> comment.
>
> I think we'd just want to squash the patch below (I also took the
> opportunity to fix a typo and clarify the text a bit):
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 556c839..1187e1a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -350,8 +350,9 @@ extern int starts_with(const char *str, const char *prefix);
>  extern int ends_with(const char *str, const char *suffix);
>
>  /*
> - * If "str" begins with "prefix", return 1. If out is non-NULL,
> - * it it set to str + strlen(prefix) (i.e., the prefix is skipped).
> + * If the string "str" begins with the string found in "prefix", return 1.
> + * The "out" parameter is set to "str + strlen(prefix)" (i.e., to the point in
> + * the string right after the prefix).
>   *
>   * Otherwise, returns 0 and out is left untouched.

For consistency with the preceding paragraph:

    Otherwise, return 0 and leave "out" untouched.

>   *
>
> -Peff
