From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] status: factor two rebase-related messages together
Date: Mon, 08 Jun 2015 15:00:14 -0700
Message-ID: <xmqqbngp97yp.fsf@gitster.dls.corp.google.com>
References: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Guillaume =?utf-8?Q?Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 09 00:00:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z255j-00041u-1k
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 00:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbbFHWAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2015 18:00:18 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34290 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbbFHWAR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 18:00:17 -0400
Received: by iebmu5 with SMTP id mu5so2706319ieb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 15:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=l1e+zrrM+wv1rqVdaNa7MMPAZk4khKM431jThI+NrcM=;
        b=cxQ+kUX4K1AxDE9bEqL0Gsn2zr86lI0WKndb3AgcBQhW/Jo4gZKGdtyybWK7bSVrrE
         lDY0h8CBZXM/YkTCcAk+5+Fmy5f1i4F81yKOtApi820yQQXuXmW0pHZBk4WbnzhIghOG
         Wq6xssobF1Zu6ggVlRUhwwej+ZRHaPtrDiE+O6NaCGmrxNHOsZChj/A9WPxGHI+eBDnn
         c++ECvo70FQWDBGLgPUDsZ7FQ2/Z07l0a4KUNl/AWhiY00Q/PMPzh5J4dQ27Fw0kJC8O
         FAt7wbq1rEkdbFe2Gz8WLFGVhGsh4h7Oj7TcwabRNTMo117a0c/iQUznQT20GAPkzFlF
         tBFg==
X-Received: by 10.42.142.66 with SMTP id r2mr13415083icu.87.1433800816525;
        Mon, 08 Jun 2015 15:00:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id d4sm1256874igl.1.2015.06.08.15.00.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 15:00:15 -0700 (PDT)
In-Reply-To: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	("Guillaume =?utf-8?Q?Pag=C3=A8s=22's?= message of "Thu, 4 Jun 2015
 00:00:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271137>

Guillaume Pag=C3=A8s  <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> ---
>  wt-status.c | 30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)


Hmmm, it obviously does not break anything but it is not obvious why
this is a good change.

Is it that you wanted to have a single instance of "if on a branch,
we say 'you are rebasing that branch', otherwise we say 'you are
rebasing'"?  Even then, I am not sure if this code movement was the
best way to do so (an obvious alternative is to use a shared helper
function and call from the two arms of if/elseif/... chain).

>
> diff --git a/wt-status.c b/wt-status.c
> index 33452f1..fec6e85 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1032,7 +1032,7 @@ static void show_rebase_in_progress(struct wt_s=
tatus *s,
>  {
>  	struct stat st;
> =20
> -	if (has_unmerged(s)) {
> +	if (has_unmerged(s) || state->rebase_in_progress || !stat(git_path(=
"MERGE_MSG"), &st)) {
>  		if (state->branch)
>  			status_printf_ln(s, color,
>  					 _("You are currently rebasing branch '%s' on '%s'."),
> @@ -1042,25 +1042,17 @@ static void show_rebase_in_progress(struct wt=
_status *s,
>  			status_printf_ln(s, color,
>  					 _("You are currently rebasing."));
>  		if (s->hints) {
> -			status_printf_ln(s, color,
> -				_("  (fix conflicts and then run \"git rebase --continue\")"));
> -			status_printf_ln(s, color,
> -				_("  (use \"git rebase --skip\" to skip this patch)"));
> -			status_printf_ln(s, color,
> -				_("  (use \"git rebase --abort\" to check out the original branc=
h)"));
> +			if (has_unmerged(s)) {
> +				status_printf_ln(s, color,
> +					_("  (fix conflicts and then run \"git rebase --continue\")"));
> +				status_printf_ln(s, color,
> +					_("  (use \"git rebase --skip\" to skip this patch)"));
> +				status_printf_ln(s, color,
> +					_("  (use \"git rebase --abort\" to check out the original bran=
ch)"));
> +			} else
> +				status_printf_ln(s, color,
> +					_("  (all conflicts fixed: run \"git rebase --continue\")"));
>  		}
> -	} else if (state->rebase_in_progress || !stat(git_path("MERGE_MSG")=
, &st)) {
> -		if (state->branch)
> -			status_printf_ln(s, color,
> -					 _("You are currently rebasing branch '%s' on '%s'."),
> -					 state->branch,
> -					 state->onto);
> -		else
> -			status_printf_ln(s, color,
> -					 _("You are currently rebasing."));
> -		if (s->hints)
> -			status_printf_ln(s, color,
> -				_("  (all conflicts fixed: run \"git rebase --continue\")"));
>  	} else if (split_commit_in_progress(s)) {
>  		if (state->branch)
>  			status_printf_ln(s, color,
