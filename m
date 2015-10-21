From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] blame: allow blame --reverse --first-parent when it
 makes sense
Date: Wed, 21 Oct 2015 00:29:12 -0400
Message-ID: <CAPig+cQ_cYQ0i8PtidiLJjBr2UqwkPBW5Kv20VeN7AsmeWBsPg@mail.gmail.com>
References: <1445400482-1977-1-git-send-email-max@max630.net>
	<1445400482-1977-3-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 06:35:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zol7g-0000bV-M9
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 06:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbbJUE3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 00:29:14 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35687 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbbJUE3N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 00:29:13 -0400
Received: by vkfw189 with SMTP id w189so22461540vkf.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 21:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=olaCQYc6EDTODkCaCbv8byWO06pSW//3LR8zWORL/ng=;
        b=xEPIw2OI5U+G9mE+zQicAri+C5SYjtFpno6+ie1ZNPJoT2MayZdK4POHlmS658PPSe
         Q+93ZIdKluh/DCxveh71A9INan4l1r0jY0o/R0RjG6KR8+NqIQb8VqFjEb2oKSslznrO
         gcgPQ0G2z+VPNloOUUAxTYJX2Ey9EEbVS5eIzDWbMezTG39AGbIjsA7zNRIhQLiCmV/F
         7p+RO3qIc5JZZfVUlkuO7r7lQxZdE5pm2U0f8cV1NH6CeysoTIzspzeO8ST3Kf6InQyZ
         kJ/DIwiYqC49etYYhmBZkyeydncy7LyhyUrAi1qxINF4ynt1TgxNmjVPdCNzeyDC73Dt
         odUg==
X-Received: by 10.31.153.129 with SMTP id b123mr4393421vke.117.1445401752555;
 Tue, 20 Oct 2015 21:29:12 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Tue, 20 Oct 2015 21:29:12 -0700 (PDT)
In-Reply-To: <1445400482-1977-3-git-send-email-max@max630.net>
X-Google-Sender-Auth: b3pUswwxxctsoZ4FK8ALxavvqvc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279965>

On Wed, Oct 21, 2015 at 12:08 AM, Max Kirillov <max@max630.net> wrote:
> Do not die immediately when the two flags are specified. Instead
> check that the specified range is along first-parent chain.  Explioit

s/Explioit/Exploit/

> how prepare_revision_walk() handles first_parent_only flag: the commits
> outside of first-parent chain are either unknown (and do not have any
> children recorded) or appear as non-first parent of a commit along the
> first-parent chain.
>
> Since the check seems fragile, add test which makes sure that blame dies
> in both cases.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 295ce92..27de544 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2692,8 +2692,6 @@ parse_done:
>         }
>         else if (contents_from)
>                 die("--contents and --children do not blend well.");
> -       else if (revs.first_parent_only)
> -               die("combining --first-parent and --reverse is not supported");
>         else {
>                 final_commit_name = prepare_initial(&sb);
>                 sb.commits.compare = compare_commits_by_reverse_commit_date;
> @@ -2721,6 +2719,15 @@ parse_done:
>         if (prepare_revision_walk(&revs))
>                 die(_("revision walk setup failed"));
>
> +       if (reverse && revs.first_parent_only) {
> +               struct commit_list *final_children = lookup_decoration(&revs.children,
> +                                                                      &sb.final->object);
> +               if (!final_children ||
> +                   hashcmp(final_children->item->parents->item->object.sha1,
> +                           sb.final->object.sha1))
> +                   die("--reverse --first-parent together require range along first-parent chain");
> +       }
> +
>         if (is_null_sha1(sb.final->object.sha1)) {
>                 o = sb.final->util;
>                 sb.final_buf = xmemdupz(o->file.ptr, o->file.size);
> diff --git a/t/t8009-blame-reverse.sh b/t/t8009-blame-reverse.sh
> index 9f40613..042863b 100755
> --- a/t/t8009-blame-reverse.sh
> +++ b/t/t8009-blame-reverse.sh
> @@ -24,11 +24,16 @@ test_expect_failure 'blame --reverse finds B1, not C1' '
>         test_cmp expect actual
>         '
>
> -test_expect_failure 'blame --reverse --first-parent finds A1' '
> +test_expect_success 'blame --reverse --first-parent finds A1' '
>         git blame --porcelain --reverse --first-parent A0..A3 -- file.t >actual_full &&
>         head -1 <actual_full | sed -e "sX .*XX" >actual &&
>         git rev-parse A1 >expect &&
>         test_cmp expect actual
>         '
>
> +test_expect_success 'blame --reverse --first-parse dies if no first parent chain' '
> +       test_must_fail git blame --porcelain --reverse --first-parent B1..A3 -- file.t &&
> +       test_must_fail git blame --porcelain --reverse --first-parent B2..A3 -- file.t
> +       '
> +
>  test_done
> --
> 2.3.4.2801.g3d0809b
