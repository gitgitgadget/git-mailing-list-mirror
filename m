From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Sun, 06 Sep 2015 11:13:58 -0700
Message-ID: <xmqqpp1va00p.fsf@gitster.mtv.corp.google.com>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
	<1441545064-3126-1-git-send-email-bernat@primeranks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
	mikachu@gmail.com, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, mfwitten@gmail.com,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: =?utf-8?B?R8OhYm9yIEJlcm7DoXQ=?= <bernat@primeranks.net>
X-From: git-owner@vger.kernel.org Sun Sep 06 20:14:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYeST-0000X7-P6
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 20:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbbIFSOE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Sep 2015 14:14:04 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35453 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbbIFSOC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 14:14:02 -0400
Received: by pacfv12 with SMTP id fv12so74845963pac.2
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=V7XcUlnGejTWdhHbx3Azbe6PKsWyfoqowdaLkDvAI2A=;
        b=mOlDAAQ4/DNd6o7cmRQL0dm5MuE59SaZukEkf9n7PED+YnU8Z7aKLIKbLSe0AiRnqx
         MbUqzIyr+h3ntDdNp876WV3PSFjgi8Q8TFPO3Q2BtmCvTltcJuCqoebgUHyfsULaJ36+
         /7nLdZ1eptMeQu/0svx+oJNGgDLYU9iDC8HHk4KeIjYvsXEcpTCytoR+1rwFWMI1syWf
         LcyGzRJ1b8JzoyP8a8hlM56TdDmlcEmoQGh+owx/svwEthEWHQC+q7SF2GQiNaa1Dw1r
         q1rHG75fcnFfCirFd/66hkMHBtdOyacSknwJchmBTMHNQEf593Ny4Iac0G2DNSgpsZKg
         2RVQ==
X-Received: by 10.68.195.74 with SMTP id ic10mr35578734pbc.68.1441563241269;
        Sun, 06 Sep 2015 11:14:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:91db:290:be53:1b89])
        by smtp.gmail.com with ESMTPSA id p4sm9242819pdh.44.2015.09.06.11.13.59
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Sun, 06 Sep 2015 11:13:59 -0700 (PDT)
In-Reply-To: <1441545064-3126-1-git-send-email-bernat@primeranks.net>
 (=?utf-8?Q?=22G=C3=A1bor=09Bern=C3=A1t=22's?= message of "Sun, 6 Sep 2015
 15:11:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277434>

G=C3=A1bor Bern=C3=A1t <bernat@primeranks.net> writes:

> +if date '+%s' 2>/dev/null | grep -q '^[0-9][0-9]*$'
> +then
> +	show_seconds=3Dt
> +else
> +	show_seconds=3D
> +fi
> +
> +case "$show_seconds" in
> +t)
> +	start_timestamp=3D$(date +%s)
> +	next_sample_at=3D0
> +	;;
> +'')
> +	progress=3D""
> +	;;
> +esac

Why the case statement here?

=46or that matter, you probably do not need $show_seconds and use the
fact that start_timestamp and progress are only set to a non-empty
string when we measure progress, i.e. making all of the above
something more like this:

        progress=3D start_timestamp=3D
        if date '+%s' 2>/dev/null | grep -q '^[0-9][0-9]*$'
        then
                next_sample_at=3D0
                progress=3D"dummy to ensure this is not empty"
                start_timestamp=3D$(date '+%s')
        fi

If you are more efficiency-minded, I think you could even do with a
single call to /bin/date, perhaps like so:

        next_sample_at=3D progress=3D
        start_timestamp=3D$(date '+%s' 2>/dev/null)=20
        case "$start_timestamp" in
        *[!0-9]* | "")
                # not a "digit only" output
                ;;
        ?*)
                progress=3D"dummy to ensure this is not empty"
                next_sample_at=3D0
                ;;
        esac

but I suspect that may be going a bit too far ;-).

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
> =20
>  	case "$filter_subdir" in
>  	"")

It would be easier to follow the logic of this loop whose _primary_
point is to rewrite one commit if you moved this part into a helper
function.  As written above, the deeply nested case statement whose
purpose is only to show the progress is very distracting.

Then the loop would read like:

        while read commit parents
        do
                : $(( $git_filter_branch__commit_count++ ))
                report_progress

                case "$filter_subdir" in
                ...

                # all the work that is about rewriting this commit
                # comes here.

        done

which would be much less noisy and helpful to people who are
interested in learning what it is doing.

As I said earlier in this message, the report_progress helper
function can use the fact that $progress or $start_timestamp are
non-empty if and only if you need to compute and tack $progress at
the end of the output, i.e.

        report_progress ()
        {
                if test -n "$progress"
                then
                        ... do rate computation here ...
                        progress=3D" ($elapsed_seconds seconds passed,.=
=2E."
                fi
                printf "\rRewrite $commit (...)$progress"
        }
