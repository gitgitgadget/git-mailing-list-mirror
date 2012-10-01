From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: git pull --no-ff documentation
Date: Mon, 1 Oct 2012 20:54:59 +0100
Organization: OPDS
Message-ID: <7EAC0E5241D6431599764E90FA821FCF@PhilipOakley>
References: <CAHtLG6ROuyCg9WK79igJ=a=6pwT+7TjOJLCNwe454oW3hiJETg@mail.gmail.com> <7vsj9yerbh.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	=?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 21:55:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIm5D-0007Or-Bb
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 21:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab2JATzD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Oct 2012 15:55:03 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:8766 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752169Ab2JATzB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2012 15:55:01 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArINAAnkaVBcHmKZ/2dsb2JhbABFhguFP7FnAQECgQuBCYIbBQEBBAEIAQEZDwEFEQUIAQEhBQYCAwUCAQECFAEFAgUhAgIUAQQIEAIGBxcGAQcLCAIBAgMBDASHUgMJCgemHIkbDYlUgSGJHGI4Pik+g1wyYAONaYRPgVyCaooLhQuCaA
X-IronPort-AV: E=Sophos;i="4.80,517,1344207600"; 
   d="scan'208";a="386206834"
Received: from host-92-30-98-153.as13285.net (HELO PhilipOakley) ([92.30.98.153])
  by out1.ip04ir2.opaltelecom.net with SMTP; 01 Oct 2012 20:54:58 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206763>

=46rom: "Junio C Hamano" <gitster@pobox.com>
> =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:
>
>> The order of options in git pull is not clear in the documentation
>> It only says
>> git pull [options] [<repository> [<refspec>...]]
>> So we have no idea which options should come first
>>
>> I tried
>> git pull -v --no-tags --progress --no-ff origin
>> but failed with unknown option 'no-ff'.
>>
>> But if I ran
>> git pull -v --no-ff  --no-tags --progress origin
>> it succeeded.
>
> This actually is not about --no-ff but about --no-tags.  Any option
> that "pull" itself does not care about stops the command line parser
> and the remainder of the command line is fed to underlying "fetch".
>

Should this be said within the documentation's synopsis ?

e.g.
git pull [pull_options] [merge_options] [fetch_options [<repository>=20
[<refspec>=E2=80=A6]]

> Perhaps something like this?  But you should trace the codepath
> involved to see if this covers all uses of the --tags before using
> it for real projects, as I didn't.
>
> git-pull.sh | 21 ++++++++++-----------
> 1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git i/git-pull.sh w/git-pull.sh
> index 2a10047..a53c1e5 100755
> --- i/git-pull.sh
> +++ w/git-pull.sh
> @@ -39,7 +39,7 @@ test -z "$(git ls-files -u)" || die_conflict
> test -f "$GIT_DIR/MERGE_HEAD" && die_merge
>
> strategy_args=3D diffstat=3D no_commit=3D squash=3D no_ff=3D ff_only=3D
> -log_arg=3D verbosity=3D progress=3D recurse_submodules=3D
> +log_arg=3D verbosity=3D progress=3D recurse_submodules=3D fetch_tags=
=3D
> merge_args=3D edit=3D
> curr_branch=3D$(git symbolic-ref -q HEAD)
> curr_branch_short=3D"${curr_branch#refs/heads/}"
> @@ -62,6 +62,8 @@ do
>  progress=3D--no-progress ;;
>  -n|--no-stat|--no-summary)
>  diffstat=3D--no-stat ;;
> + -t|--t|--ta|--tag|--tags|--no-tags)
> + fetch_tags=3D"$1" ;;
>  --stat|--summary)
>  diffstat=3D--stat ;;
>  --log|--no-log)
> @@ -141,15 +143,12 @@ done
>
> error_on_no_merge_candidates () {
>  exec >&2
> - for opt
> - do
> - case "$opt" in
> - -t|--t|--ta|--tag|--tags)
> - echo "Fetching tags only, you probably meant:"
> - echo "  git fetch --tags"
> - exit 1
> - esac
> - done
> + case "$fetch_tags" in
> + -t|--t|--ta|--tag|--tags)
> + echo "Fetching tags only, you probably meant:"
> + echo "  git fetch --tags"
> + exit 1
> + esac
>
>  if test true =3D "$rebase"
>  then
> @@ -213,7 +212,7 @@ test true =3D "$rebase" && {
>  done
> }
> orig_head=3D$(git rev-parse -q --verify HEAD)
> -git fetch $verbosity $progress $dry_run=20
> $recurse_submodules --update-head-ok "$@" || exit 1
> +git fetch $verbosity $progress $dry_run $recurse_submodules=20
> $fetch_tags --update-head-ok "$@" || exit 1
> test -z "$dry_run" || exit 0
>
> curr_head=3D$(git rev-parse -q --verify HEAD)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2012.0.2221 / Virus Database: 2441/5300 - Release Date:=20
> 09/30/12
>=20
