From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH v3] path.c enter_repo(): fix unproper strbuf unwrapping
 and memory leakage
Date: Mon, 28 Mar 2016 23:59:54 +0800
Message-ID: <CAKqreuzoQmkUwyYiAt_GhoHyaCz=WoNshOkhH=D3orNZEG2ayQ@mail.gmail.com>
References: <20160325175947.GC10563@sigill.intra.peff.net>
	<1459180638-6034-1-git-send-email-huiyiqun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Your friend <pickfire@riseup.net>, Jeff King <peff@peff.net>,
	Hui Yiqun <huiyiqun@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 28 18:00:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akZaC-0002W8-UQ
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 18:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbcC1P75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 11:59:57 -0400
Received: from mail-ob0-f195.google.com ([209.85.214.195]:34589 "EHLO
	mail-ob0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbcC1P7z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 11:59:55 -0400
Received: by mail-ob0-f195.google.com with SMTP id c10so6274269obp.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Z21d5p2UomUwJfEW6crBPd7dVyK5OCJgKfnzWs6asbY=;
        b=e3sRFbs4VvYUKVvOog9w30jweLmeQPGgmSLKd7kEAehZStBPOVQK9yeqcfAhN38U/l
         R2lx+GBcOHym223wYjvmFnlVRQ4W9CRo4fRv+sJNK7GZntw1qqX1NB+wCw+P1MAuZJMn
         LOehWZ3x9CxWZ9H52JxukpcVztOL0YdupqptOeNwfYuNbwsbDgnKvakSX1uJVwYXG/m5
         Es92kGJF/FcnnvHUn/HWmdkOu6Qetdc+wx32ylIoNtkdE4uNSpipEke9Xy0sHsNUOKF2
         1i1LgToxRLJ7K/+I4h0nTDTTuS/yOSRdxHAiuCcq27+Gqbxpde6r5HqDbQrMILWHBAoH
         7ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Z21d5p2UomUwJfEW6crBPd7dVyK5OCJgKfnzWs6asbY=;
        b=ZP5gmDXXSka/LPXgyBSC8gBaWGrCx/QOU1BWTEV9W09Mo+H9blzYoDE1X2+PUJ9EYg
         mSE2Xwn+yKMjEOnL8g8KopDLdXZn7wfYoqwAMoGHSn6M+nNKxNRdJnXN9JUnX6fmS2Sx
         MTjR9BMY5SYWftj+9lnxgNF81VKhZ+VKiJhR/a4tUuWdjemZ7raTpTJNEMbyMBJV9sut
         WQoA078mTyBr9ScY8UGXZqYjOfctKDuM7yAtFuHpF9LAb0SuukgTP09diXwtx3x5sTzc
         4BkQrODw0g2yMLU4mXsCmPqazwQ/DMySER9QVTaj3rw4jI/e7pvLmvsP73AFPi4BXkso
         Y4ww==
X-Gm-Message-State: AD7BkJLVdiZmFsoOWsl4c082i7UYZWm7tuWMk9aPO/jX1wnCcSwtxdag7Dx90MKGlN+Z7ylftJhQjOHbGDV1aA==
X-Received: by 10.60.147.228 with SMTP id tn4mr12077451oeb.33.1459180794667;
 Mon, 28 Mar 2016 08:59:54 -0700 (PDT)
Received: by 10.157.12.170 with HTTP; Mon, 28 Mar 2016 08:59:54 -0700 (PDT)
In-Reply-To: <1459180638-6034-1-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290044>

Sorry, I sent the patch repeatedly to fix a wrongly indent with space.

2016-03-28 23:57 GMT+08:00 Hui Yiqun <huiyiqun@gmail.com>:
> According to strbuf.h, strbuf_detach is the sole supported method
> to unwrap a memory buffer from its strbuf shell.
>
> So we should not return the pointer of strbuf.buf directly.
>
> What's more, some memory leakages are solved.
> ---
>  path.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/path.c b/path.c
> index 969b494..9801617 100644
> --- a/path.c
> +++ b/path.c
> @@ -625,6 +625,7 @@ const char *enter_repo(const char *path, int strict)
>  {
>         static struct strbuf validated_path = STRBUF_INIT;
>         static struct strbuf used_path = STRBUF_INIT;
> +       char * dbuf = NULL;
>
>         if (!path)
>                 return NULL;
> @@ -654,7 +655,7 @@ const char *enter_repo(const char *path, int strict)
>                 if (used_path.buf[0] == '~') {
>                         char *newpath = expand_user_path(used_path.buf);
>                         if (!newpath)
> -                               return NULL;
> +                               goto return_null;
>                         strbuf_attach(&used_path, newpath, strlen(newpath),
>                                       strlen(newpath));
>                 }
> @@ -671,22 +672,22 @@ const char *enter_repo(const char *path, int strict)
>                         strbuf_setlen(&used_path, baselen);
>                 }
>                 if (!suffix[i])
> -                       return NULL;
> +                       goto return_null;
>                 gitfile = read_gitfile(used_path.buf);
>                 if (gitfile) {
>                         strbuf_reset(&used_path);
>                         strbuf_addstr(&used_path, gitfile);
>                 }
>                 if (chdir(used_path.buf))
> -                       return NULL;
> -               path = validated_path.buf;
> +                       goto return_null;
> +               path = dbuf = strbuf_detach(&validated_path, NULL);
>         }
>         else {
>                 const char *gitfile = read_gitfile(path);
>                 if (gitfile)
>                         path = gitfile;
>                 if (chdir(path))
> -                       return NULL;
> +                       goto return_null;
>         }
>
>         if (is_git_directory(".")) {
> @@ -695,6 +696,10 @@ const char *enter_repo(const char *path, int strict)
>                 return path;
>         }
>
> +return_null:
> +       free(dbuf);
> +       strbuf_release(&used_path);
> +       strbuf_release(&validated_path);
>         return NULL;
>  }
>
> --
> 2.7.4
>
