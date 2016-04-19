From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 4/6] verify-tag: prepare verify_tag for libification
Date: Tue, 19 Apr 2016 15:05:01 -0400
Message-ID: <CAPig+cTO_vC1_N79G9yMkiyjYtEeBdsivz-A4jOMw0r-vRWWaw@mail.gmail.com>
References: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
	<1461088041-19264-5-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Tue Apr 19 21:05:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asaxU-00006V-Uf
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 21:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944AbcDSTFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 15:05:05 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34723 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913AbcDSTFD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 15:05:03 -0400
Received: by mail-io0-f194.google.com with SMTP id z133so3946386iod.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=TMFc8Tp+wlm7IA4D/SepzNbm4YgVnAn9+uhnlSr73HY=;
        b=xpAu0GHO9lS1Psg8g0aTQGwtTtU0xYqVwCi1kNTT7w59mwWxgYQltrSDNyZi1JIxYp
         33OJHo1vS+tpad/miVfzCHOhNFeQEMmesj/9NxM/Qw2Vjfyf1Y3yXPKPJl7OAG0HMXSk
         DyKSzsZaSSxBam85WgWE51jyfkUZX/iZq4Zxbne1ZqguQm18HLlf0s74mr8WtCuj2wx1
         m7gr/p1aENjOCz/WQfFh+2KtrTZ3qSb5MNTGUiMZFZj+4ba2/h8RPsidqHy3/n5kDzU9
         erPCqnzuAR74KHfMD/TGfwOa9AgorMjQFeW4wwNBe4p5QORYm6zITMImDUpV5HKpRrDT
         edEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=TMFc8Tp+wlm7IA4D/SepzNbm4YgVnAn9+uhnlSr73HY=;
        b=EwDr7ySzOKsSk1+wfEI6pMHgcW7MsxuOm9aGIUUu1RAaFTPASDdkpTPIHXRqp8yxZw
         zrtpExt/gptMwa+bk8dzu2WcUMB9yIsDL9ICRPU+7iDUJf5dZ8AF+lUL2u6kwBkpzaz+
         A4DGBTP/GxI6Gznst64BqOFPh56g1AVjWktEVgxGC4euk+UBKzC16G7kub5v7U3pK1sq
         bbtZW1cXlVblhUWyfU+6mjnLpw3Epmw5XF1R3UrH8t8Qsva5cWWcxzU2dxBOGg7G+RQ2
         z/fmrW/sf/90KS2d+V0TLO3hBPQP+QM+1qtaHS2JQmaXB7jEYsRXaIBoLTBO212WAyl1
         VUCA==
X-Gm-Message-State: AOPr4FUmj9FapYQYUA3jl34eowt6IZgVKo93m20VZZgx0r+R+xDIREdkYknEQ5mGlnUi9phhWZvCODkhcbk0Yg==
X-Received: by 10.107.8.141 with SMTP id h13mr6113597ioi.34.1461092701962;
 Tue, 19 Apr 2016 12:05:01 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 19 Apr 2016 12:05:01 -0700 (PDT)
In-Reply-To: <1461088041-19264-5-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: sG5VzLWX2O9BzAG3Gcvc197dCR0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291906>

On Tue, Apr 19, 2016 at 1:47 PM,  <santiago@nyu.edu> wrote:
> The current interface of verify_tag() resolves reference names to SHA1,
> however, the plan is to make this functionality public and the current
> interface is cumbersome for callers: they are expected to supply the
> textual representation of a sha1/refname. In many cases, this requires
> them to turn the sha1 to hex representation, just to be converted back
> inside verify_tag.
>
> Add a SHA1 parameter to use instead of the name parameter, and rename
> the name parameter to "name_to_report" for reporting purposes only.

I'd have probably called this "display_name", but then I suppose it
suffers the same issue Junio mentioned previously about it sounding
like a boolean. Anyhow, as long as Junio is happy with it, that's what
matters.

This version of the patch is nicely improved. One nit below.

> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> @@ -80,6 +83,8 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  {
>         int i = 1, verbose = 0, had_error = 0;
>         unsigned flags = 0;
> +       unsigned char sha1[20];
> +       const char *name;

Mentioned previously[1]: These two declarations could be moved inside
the while-loop scope (below).

[1]: http://article.gmane.org/gmane.comp.version-control.git/291813

>         const struct option verify_tag_options[] = {
>                 OPT__VERBOSE(&verbose, N_("print tag contents")),
>                 OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
> @@ -96,8 +101,12 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>         if (verbose)
>                 flags |= GPG_VERIFY_VERBOSE;
>
> -       while (i < argc)
> -               if (verify_tag(argv[i++], flags))
> +       while (i < argc) {
> +               name = argv[i++];
> +               if (get_sha1(name, sha1))
> +                       had_error = !!error("tag '%s' not found.", name);
> +               else if (verify_tag(sha1, name, flags))
>                         had_error = 1;
> +       }
>         return had_error;
>  }
> --
> 2.8.0
