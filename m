Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59FE11FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 14:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935157AbcLTORW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 09:17:22 -0500
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:47467 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934774AbcLTORU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 09:17:20 -0500
Received: (qmail 5691 invoked from network); 20 Dec 2016 14:17:18 -0000
Received: (qmail 1552 invoked from network); 20 Dec 2016 14:17:18 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 20 Dec 2016 14:17:18 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1482243418.2029.10.camel@sapo.pt>
Subject: Re: Bug report: $program_name in error message
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     Josh Bleecher Snyder <josharian@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <xmqqfuljod70.fsf@gitster.mtv.corp.google.com>
References: <CAFAcib8yauNRB6UbO8qS2_Ff4fDt-7mMsmgop8d1V0j=RoTBSA@mail.gmail.com>
         <CAGZ79kZ=QK5s0_94+4GNs3M5oo49GLm-KkT5K=yZktxX8C4UCw@mail.gmail.com>
         <CAFAcib9-rUSqyBRpauw3pTf9OPTKLYNf7bdh2gyykBNtJTZKGg@mail.gmail.com>
         <CAGZ79ka=RzAjrb=7u7p5xnveo=kcNCoGn=TC=0j-CBp8Oby7OA@mail.gmail.com>
         <xmqqk2avodi1.fsf@gitster.mtv.corp.google.com>
         <xmqqfuljod70.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 20 Dec 2016 13:16:58 -0100
Mime-Version: 1.0
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the report and letting me know.
Yes, these were mistakes and lack of attention mine. It was supposed to
call 'eval_gettext' rather than 'gettext' when \$variable interpolation
is needed. Junio Hamano has the right answer for these errors.

A Seg, 19-12-2016 às 12:50 -0800, Junio C Hamano escreveu:
> Subject: rebase -i: fix mistaken i18n
> 
> f2d17068fd ("i18n: rebase-interactive: mark comments of squash for
> translation", 2016-06-17) attempted to apply sh-i18n and failed to
> use $(eval_gettext "string with \$variable interpolation").
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  git-rebase--interactive.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 41fd374c72..96865b2375 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -437,7 +437,8 @@ update_squash_messages () {
>                         }' <"$squash_msg".bak
>                 } >"$squash_msg"
>         else
> -               commit_message HEAD > "$fixup_msg" || die "$(gettext "Cannot write \$fixup_msg")"
> +               commit_message HEAD >"$fixup_msg" ||
> +               die "$(eval_gettext "Cannot write \$fixup_msg")"
>                 count=2
>                 {
>                         printf '%s\n' "$comment_char $(gettext "This is a combination of 2 commits.")"

I agree with this fix. Perhaps indent the second line to be easier on
the eyes?:

> +               commit_message HEAD >"$fixup_msg" ||
> +               	die "$(eval_gettext "Cannot write \$fixup_msg")"
