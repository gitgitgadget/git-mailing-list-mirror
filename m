From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Fri, 04 Sep 2015 11:34:08 -0700
Message-ID: <xmqqk2s6f2zj.fsf@gitster.mtv.corp.google.com>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
	mikachu@gmail.com, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, mfwitten@gmail.com,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: =?utf-8?B?R8OhYm9yIEJlcm7DoXQ=?= <bernat@primeranks.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 20:34:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXvoZ-0000IQ-3K
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 20:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760268AbbIDSeN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2015 14:34:13 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33700 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488AbbIDSeK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 14:34:10 -0400
Received: by pacex6 with SMTP id ex6so31605094pac.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=eaGJsu+5oqkt25osQHnaP3p9uYT44wClAmuvlnigd6U=;
        b=qzPDyewAeJcQkYhUj1DhDZgDwG/+IanZLkCBpzwp8CNy0bK73jmiZxjDafiiIa/y8/
         YIH4WHLfrY34Mm7eDCIfZEmAtG/5RUMvKV884zv+2Bu6DxLOFOwOh+gk8Nn6AODMJGh5
         dfE26uE+AnMC+jk2eQEyQ0vBrQQfCe5CuNURlDPuTcebn0Fwx47/7WkObZmak2WYWpr0
         lWMQUsmxYBZRGenR53th197/Kt8cMt5GWsPYHYdImFHRmLTsEqB9okklLpEFkoHS3K8D
         bA0Yx3CQkd/BGUrHGDev/LL5htF/nUPHiBI3fmbVzl7pVRJKNSlHSrT/3xJd0bi6KFfq
         aF5Q==
X-Received: by 10.66.190.99 with SMTP id gp3mr10889828pac.113.1441391650192;
        Fri, 04 Sep 2015 11:34:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2198:98f:3bb3:46bb])
        by smtp.gmail.com with ESMTPSA id u6sm3294876pds.69.2015.09.04.11.34.09
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 11:34:09 -0700 (PDT)
In-Reply-To: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
 (=?utf-8?Q?=22G=C3=A1bor=09Bern=C3=A1t=22's?= message of "Fri, 4 Sep 2015
 17:16:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277328>

G=C3=A1bor Bern=C3=A1t <bernat@primeranks.net> writes:

> @@ -277,9 +277,43 @@ test $commits -eq 0 && die "Found nothing to rew=
rite"
>  # Rewrite the commits
> =20
>  git_filter_branch__commit_count=3D0

This is not a new problem, but I wonder why we need such a
cumbersomely long variable name.  It is not like this is a part of
some shell script library that needs to be careful about namespace
pollution.

> +echo $(date +%s) | grep -q '^[0-9]+$';  2>/dev/null && show_seconds=3D=
t

That is very strange construct.  I think you meant to say something
like

	if date '+%s' 2>/dev/null | grep -q '^[0-9][0-9]*$'
	then
		show_seconds=3Dt
	else
        	show_seconds=3D
	fi

A handful of points:

 * "echo $(any-command)" is suspect, unless you are trying to let
   the shell munge output from any-command, which is not the case.

 * "grep" without -E (or "egrep") takes BRE, which "+" (one or more)
   is not part of.

 * That semicolon is a syntax error.  I think whoever suggested you
   to use it meant to squelch possible errors from "date" that does
   not understand the "%s" format.

 * I do not think you are clearing show_seconds to empty anywhere,
   so an environment variable the user may have when s/he starts
   filter-branch will seep through and confuse you.

> +case "$show_seconds" in
> +	t)
> +		start_timestamp=3D$(date +%s)
> +		next_sample_at=3D0
> +		;;
> +	'')
> +		progress=3D""
> +		;;
> +esac

In our codebase case labels and case/esac align, like you did in the
later part of the patch.
> +
>  while read commit parents; do
>  	git_filter_branch__commit_count=3D$(($git_filter_branch__commit_cou=
nt+1))
> -	printf "\rRewrite $commit ($git_filter_branch__commit_count/$commit=
s)"
> +
> +	case "$show_seconds" in
> +	t)
> +		if test $git_filter_branch__commit_count -gt $next_sample_at
> +		then
> +			now_timestamp=3D$(date +%s)
> +			elapsed_seconds=3D$(($now_timestamp - $start_timestamp))
> +			remaining_second=3D$(( ($commits - $git_filter_branch__commit_cou=
nt) * $elapsed_seconds / $git_filter_branch__commit_count ))
> +			if test $elapsed_seconds -gt 0
> +			then
> +				next_sample_at=3D$(( ($elapsed_seconds + 1) * $git_filter_branch=
__commit_count / $elapsed_seconds ))
> +			else
> +				next_sample_at=3D$(($next_sample_at + 1))
> +			fi
> +			progress=3D" ($elapsed_seconds seconds passed, remaining $remaini=
ng_second predicted)"
> +		fi
> +		;;
> +	'')
> +		progress=3D""
> +		;;
> +	esac
> +
> +	printf "\rRewrite $commit ($git_filter_branch__commit_count/$commit=
s)$progress"

It would be easier to follow the logic of this loop whose _primary_
point is to rewrite one commit if you moved this part into a helper
function.  Then the loop would look more like:

	while read commit parents
        do
        	: $(( $git_filter_branch__commit_count++ ))
		report_progress

                case "$filter_subdir" in
                ...

		# all the work that is about rewriting this commit
		# comes here.

	done
