From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFCv4 1/2] git-rebase -i: add command "drop" to remove a commit
Date: Wed, 03 Jun 2015 11:02:27 -0700
Message-ID: <xmqq8uc0y8jw.fsf@gitster.dls.corp.google.com>
References: <1433331859-24832-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Galan =?utf-8?Q?R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 03 20:02:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Czr-0002sX-3H
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 20:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbbFCSCb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 14:02:31 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:32790 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863AbbFCSC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 14:02:29 -0400
Received: by igbpi8 with SMTP id pi8so117813581igb.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=LjTrAgDo8xP2kLWXccZ9qgwke97RqUWFxndYAPhbyCs=;
        b=ck+0P5+y5kkJKJmn0SLGZVyC4yVC/VkFo5tctJDK/pw6q5+aZS56sF/G7oIaAKBZme
         5OpoGjnvkL7qPs88ivTYu41KlK9pVL59II24r69w8wSHi0JUY5lAp/2Ej7TwO7AQTeiK
         ufyO79Rt6yLD30404sa9TWTV9YL49k70jQhTsPOlY8kYeUHBgWEzbZtdIiMcgMFO9Z2J
         A3GRUISpgB7KNUKkW0JDZrWyXHiEs/OyngCa91GGFyKrstJ11q9U8WWFmJsmnc0XVAKJ
         Q1oWnOVnWOtHL2CumPo7GobeG9FQtn+zD8uI/UixWZcveNs4zDLpJFs6BTo95TLackEM
         CR9g==
X-Received: by 10.50.61.161 with SMTP id q1mr6804609igr.12.1433354549102;
        Wed, 03 Jun 2015 11:02:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9816:1e41:550:d20e])
        by mx.google.com with ESMTPSA id a139sm15188672ioa.14.2015.06.03.11.02.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jun 2015 11:02:28 -0700 (PDT)
In-Reply-To: <1433331859-24832-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	("Galan =?utf-8?Q?R=C3=A9mi=22's?= message of "Wed, 3 Jun 2015 13:44:18
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270714>

Galan R=C3=A9mi  <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index dc3133f..869cc60 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -152,6 +152,7 @@ Commands:
>   s, squash =3D use commit, but meld into previous commit
>   f, fixup =3D like "squash", but discard this commit's log message
>   x, exec =3D run command (the rest of the line) using shell
> + d, drop =3D remove commit
> =20
>  These lines can be re-ordered; they are executed from top to bottom.
> =20
> @@ -508,6 +509,23 @@ do_next () {
>  	"$comment_char"*|''|noop)
>  		mark_action_done
>  		;;
> +	drop|d)
> +		if test -z $sha1
> +		then
> +			warn "Missing SHA-1 in 'drop' command."
> +			die "Please fix this using 'git rebase --edit-todo'."

Is this a sensible piece of advice, though?  The user edited the
line away and it does not have the commit object name anymore.
How does she "fix" it in the editor?  The same puzzlement applies
to the other message.

> +		sha1_verif=3D"$(git rev-parse --verify --quiet $sha1^{commit})"
> +		if test -z $sha1_verif

As you are not using the returned string at all, instead of wasting
a shell variable, it would be better to decide to come into this
block by using the exit status from rev-parse (it exits with
non-zero status upon failure).

> +		then
> +			warn "'$sha1' is not a SHA-1 or does not represent" \
> +				"a commit in 'drop' command."
> +			die "Please fix this using 'git rebase --edit-todo'."
> +		fi
> +
> +		mark_action_done
> +		;;
>  	pick|p)
>  		comment_for_reflog pick
