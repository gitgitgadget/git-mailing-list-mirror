From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-status: show short sequencer state
Date: Tue, 23 Oct 2012 08:05:54 +0200
Message-ID: <vpqsj95soxp.fsf@grenoble-inp.fr>
References: <1350948569-28445-2-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: phil.hord@gmail.com, Junio C Hamano <gitster@pobox.com>,
	konglu@minatec.inpg.fr, Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 08:06:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQXd8-0006lR-W0
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 08:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313Ab2JWGGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 02:06:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37555 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921Ab2JWGGK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 02:06:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q9N5wTge029223
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2012 07:58:29 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TQXcg-0005hh-CF; Tue, 23 Oct 2012 08:05:54 +0200
In-Reply-To: <1350948569-28445-2-git-send-email-hordp@cisco.com> (Phil Hord's
	message of "Mon, 22 Oct 2012 19:29:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Oct 2012 07:58:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q9N5wTge029223
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1351576717.01138@k28UTbN4UfAYDqiiGxkXYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208214>

Phil Hord <hordp@cisco.com> writes:

> +	merge              a git-merge is in progress
> +	am                 a git-am is in progress
> +	rebase             a git-rebase is in progress
> +	rebase-interactive a git-rebase--interactive is in progress
> +	cherry-pick        a git-cherry-pick is in progress
> +	bisect             a git-bisect is in progress

Avoid using git-foo syntax in documentation, it suggests that this is
valid command, which isn't true anymore. `git foo` seems the most common
syntax. Also, git-rebase--interactive is not user-visible => `git rebase
--interactive`.

> -	if (state->am_empty_patch)
> +	if (state->substate==WT_SUBSTATE_NOMINAL)
>  		status_printf_ln(s, color,
>  			_("The current patch is empty."));

This looks weird. First, spaces around == (here and below). Then, the
logic is unintuitive. The "if" suggests everything is allright, and the
message below is very specific. This at least deserves a comment.

>  	if (advice_status_hints) {
> -		if (!state->am_empty_patch)
> +		if (state->substate==WT_SUBSTATE_CONFLICTED)

Spaces around ==.

> +static void wt_print_token(struct wt_status *s, const char *color, const char *token)
> +{
> +	color_fprintf(s->fp, color, "%s", token);
> +	fputc(s->null_termination ? '\0' : '\n', s->fp);
> +}

The output format seems to be meant only for machine-consumption. Is
there any case when we'd want color? I'd say we can disable coloring
completely for this format (normally, color=auto does the right thing,
but I prefer being 100% sure I'll get no color when writing scripts)

> +static void wt_shortstatus_print_sequencer(struct wt_status *s)
[...]
> +void wt_sequencer_print(struct wt_status *s)
> +{
> +	wt_shortstatus_print_sequencer(s);
> +}
> +

Why do you need this trivial wrapper?

Other than that, I like the idea (although I have no concrete use-case
in mind), but I didn't actually test the patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
