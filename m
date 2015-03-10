From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] reset: enable '-' short-hand for previous branch
Date: Tue, 10 Mar 2015 15:18:32 -0400
Message-ID: <CAPig+cQdSHQTVwOwb9hee6On_Bv4qrh0MhiR-aRDMXqhw5L9wQ@mail.gmail.com>
References: <1425984728-27996-1-git-send-email-sudshekhar02@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Sudhanshu Shekhar <sudshekhar02@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 20:18:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVPg0-0006cY-3E
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 20:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbbCJTSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 15:18:36 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:44214 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbbCJTSd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 15:18:33 -0400
Received: by yhzz6 with SMTP id z6so1936958yhz.11
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gSJR0tJ1prvH/t4pPsNxd6RsjYs6zfec0/3h4q7/evk=;
        b=tLoAb2DKth3/4Gb7bQ2BoDajVWNDuZ5Ensz4gMQJ9Hr3TxiFWgX7HhUo2QRY31wiMW
         8wAsE+L/E+dTpcIOJYhDipM+lW5l+o4exDWSMRGc794QtjRHZE9VPKbuf1SgGqTwXDM2
         O0fMBteaTzPfoyMyv+om+rt9uV+MV7GAJg/dBIvU1afApF1mkxxhzNJIZT9yqo5o82zh
         GbmCROaoxeK0UY/X9/z3Tt/kC+XaSHH71Zid0cBlKFCTzhgIKYxVvgotiiwdKjcekKg8
         qDDRS8kGINHBoN8iR431INb0qklPaE83e1OX/1ZmxSUQc/S50uiGGo4qJzq/CVgKdyyJ
         phvA==
X-Received: by 10.170.134.198 with SMTP id a189mr25884371ykc.103.1426015112760;
 Tue, 10 Mar 2015 12:18:32 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Tue, 10 Mar 2015 12:18:32 -0700 (PDT)
In-Reply-To: <1425984728-27996-1-git-send-email-sudshekhar02@gmail.com>
X-Google-Sender-Auth: OI4onhxgkxBIE6YvZnc9un3KaIc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265255>

On Tue, Mar 10, 2015 at 6:52 AM, Sudhanshu Shekhar
<sudshekhar02@gmail.com> wrote:
> 'git reset -' will reset to the previous branch. It will behave similar
> to @{-1} except when a file named '@{-1}' is present. To refer to a file
> named '-', use ./- or the -- flag.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
> ---
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 4c08ddc..8abd300 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -205,6 +206,10 @@ static void parse_args(struct pathspec *pathspec,
>          */
>
>         if (argv[0]) {
> +               if (!strcmp(argv[0], "-")) {
> +                       argv[0] = "@{-1}";

It's somewhat ugly to modify an element of argv[] since you don't own
the array and the contract does not particularly suggest that is
modifiable by you. A more serious concern is that doing so creates a
tighter binding between parse_args() and its caller since parse_args()
doesn't know how the caller will be disposing of argv[] when finished
with it. Say, for instance, that the caller disposes of each argv[]
element by invoking free(argv[n]). The literal "@{-1}" you've assigned
here is not allocated on the heap, so free()ing it would be wrong.

However, some of the other commands which alias "-" to "@{-1}" also
modify argv[] in this way, so we'll let it slide for the moment.

> +                       substituted_minus = 1;
> +               }
>                 if (!strcmp(argv[0], "--")) {
>                         argv++; /* reset to HEAD, possibly with paths */
>                 } else if (argv[1] && !strcmp(argv[1], "--")) {
> @@ -222,15 +227,21 @@ static void parse_args(struct pathspec *pathspec,
>                          * Ok, argv[0] looks like a commit/tree; it should not
>                          * be a filename.
>                          */
> +                       if (substituted_minus)
> +                               argv[0] = "-";
>                         verify_non_filename(prefix, argv[0]);
> +                       if (substituted_minus)
> +                               argv[0] = "@{-1}";

Do you find it ugly that you have to undo and then redo your argv[]
change from a few lines above? Rather than jumping through such hoops,
can't you instead define a new variable which holds the appropriate
value ("@{-1}"), or rework the logic to avoid such kludges altogether?

>                         rev = *argv++;
>                 } else {
> +                       /* We were treating "-" as a commit and not a file */
> +                       if (substituted_minus)
> +                               argv[0] = "-";
>                         /* Otherwise we treat this as a filename */
>                         verify_filename(prefix, argv[0], 1);
>                 }
>         }
>         *rev_ret = rev;
> -

Mentioned by Matthieu: Don't sneak in unrelated changes. This change
was probably unintentional, but serves as a good reminder that you
should review the patch yourself before sending it. (And, if you do
have a need to make cleanups, it's typically best to do so as a
separate preparatory patch.)

>         if (read_cache() < 0)
>                 die(_("index file corrupt"));
>
> --
> 2.3.1.279.gd534259
