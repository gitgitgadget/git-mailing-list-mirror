From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 10/67] mailsplit: make PATH_MAX buffers dynamic
Date: Tue, 15 Sep 2015 20:51:26 -0400
Message-ID: <CAPig+cQ+TvT2_ZrbbYFQOdjDNs+b-ADJb+EbKVTP-HaCghjCow@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915152806.GJ29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 02:51:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc0wd-0003xJ-CW
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 02:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbbIPAv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 20:51:27 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33765 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbbIPAv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 20:51:26 -0400
Received: by vkgd64 with SMTP id d64so91528133vkg.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 17:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MuYkfMmjpoM+zZ9i2a+MFIwM4pNFuFzzd/PfPui47o4=;
        b=VCmPlQ2ujFlfucOiASfdinPVF2iNt58TplOXixE+CbppWnMbKBku0liZxrKjmwzCvX
         fVnsj3VHxsS3e8AHoHgh3Mxs1LQpCw0Atzq+y7ioTyd6rE+0ZlYyBhSz+OZEQwtkeSyq
         Ks2hIMrogTXRpqDN7sFzCgjqmDs6cuQQ6zbajVP4/mRyE/ijZkXAF81nVb5edQMcezR7
         LPvM1wxv2CdzMlgq6tJkCskDLwiHSbyYMDH7UDawlI8Omo5YB7ooZc4c2tFTwU8lDJpG
         ksGG1eLrAEOVxJOlmg//a8MTyf2Scef65CCTqxUrV3H2qGGqK9HpMusXjI1P+WlDSq5P
         6TCg==
X-Received: by 10.31.131.141 with SMTP id f135mr25450276vkd.37.1442364686215;
 Tue, 15 Sep 2015 17:51:26 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Tue, 15 Sep 2015 17:51:26 -0700 (PDT)
In-Reply-To: <20150915152806.GJ29753@sigill.intra.peff.net>
X-Google-Sender-Auth: oHKQTz6QW_m8hA7gkvQB1ODbFjM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277988>

On Tue, Sep 15, 2015 at 11:28 AM, Jeff King <peff@peff.net> wrote:
> There are several static PATH_MAX-sized buffers in
> mailsplit, along with some questionable uses of sprintf.
> These are not really of security interest, as local
> mailsplit pathnames are not typically under control of an
> attacker.  But it does not hurt to be careful, and as a
> bonus we lift some limits for systems with too-small
> PATH_MAX varibles.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> index 9de06e3..fb0bc08 100644
> --- a/builtin/mailsplit.c
> +++ b/builtin/mailsplit.c
> @@ -148,8 +155,7 @@ static int maildir_filename_cmp(const char *a, const char *b)
>  static int split_maildir(const char *maildir, const char *dir,
>         int nr_prec, int skip)
>  {
> -       char file[PATH_MAX];
> -       char name[PATH_MAX];
> +       struct strbuf file = STRBUF_INIT;
>         FILE *f = NULL;
>         int ret = -1;
>         int i;
> @@ -161,20 +167,25 @@ static int split_maildir(const char *maildir, const char *dir,
>                 goto out;
>
>         for (i = 0; i < list.nr; i++) {
> -               snprintf(file, sizeof(file), "%s/%s", maildir, list.items[i].string);
> -               f = fopen(file, "r");
> +               char *name;
> +
> +               strbuf_reset(&file);
> +               strbuf_addf(&file, "%s/%s", maildir, list.items[i].string);
> +
> +               f = fopen(file.buf, "r");
>                 if (!f) {
> -                       error("cannot open mail %s (%s)", file, strerror(errno));
> +                       error("cannot open mail %s (%s)", file.buf, strerror(errno));
>                         goto out;
>                 }
>
>                 if (strbuf_getwholeline(&buf, f, '\n')) {
> -                       error("cannot read mail %s (%s)", file, strerror(errno));
> +                       error("cannot read mail %s (%s)", file.buf, strerror(errno));
>                         goto out;
>                 }
>
> -               sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
> +               name = xstrfmt("%s/%0*d", dir, nr_prec, ++skip);
>                 split_one(f, name, 1);
> +               free(name);

Hmm, why does 'file' become a strbuf which is re-used each time
through the loop, but 'name' is treated differently and gets
re-allocated upon each iteration? Why doesn't 'name' deserve the same
treatment as 'file'?

>                 fclose(f);
>                 f = NULL;
> @@ -184,6 +195,7 @@ static int split_maildir(const char *maildir, const char *dir,
>  out:
>         if (f)
>                 fclose(f);
> +       strbuf_release(&file);
>         string_list_clear(&list, 1);
>         return ret;
>  }
> @@ -191,7 +203,6 @@ out:
>  static int split_mbox(const char *file, const char *dir, int allow_bare,
>                       int nr_prec, int skip)
>  {
> -       char name[PATH_MAX];
>         int ret = -1;
>         int peek;
>
> @@ -218,8 +229,9 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
>         }
>
>         while (!file_done) {
> -               sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
> +               char *name = xstrfmt("%s/%0*d", dir, nr_prec, ++skip);
>                 file_done = split_one(f, name, allow_bare);
> +               free(name);

Same question, pretty much: Why not make 'name' a strbuf which is
re-used in the loop? (I don't have a strong preference; I'm just
trying to understand the apparent inconsistency of treatment.)

>         }
>
>         if (f != stdin)
> --
> 2.6.0.rc2.408.ga2926b9
