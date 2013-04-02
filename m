From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be depth-first,
 --parent option to execute command in supermodule as well
Date: Tue, 02 Apr 2013 22:14:06 +0200
Message-ID: <515B3C0E.9000802@web.de>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com> <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org> <20130305075901.GB4677@sandbox-ub> <7vhakpvnex.fsf@alter.siamese.dyndns.org> <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com> <7vboaxu23y.fsf@alter.siamese.dyndns.org> <51365AB6.2010602@web.de> <CABURp0psgofX=ean+KKooN74pF4Ns-gDGt68vc5Exs6NmDRUyw@mail.gmail.com> <513B7D08.20406@web.de> <CABURp0qBA6myf7_SuaxJSrePJHmh2v-nmtLRzKTtgAJxLkJ-tQ@mail.gmail.com> <51416E9F.7000604@gmail.com> <5147863B.8010104@web.de> <51511E04.6070504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Cousineau <eacousineau@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 22:15:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7c0-00040i-8m
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 22:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247Ab3DBUOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 16:14:51 -0400
Received: from mout.web.de ([212.227.15.3]:49210 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933238Ab3DBUOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 16:14:50 -0400
Received: from [192.168.178.41] ([91.3.136.234]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0Ma2V5-1U3enQ0jAl-00LRQw; Tue, 02 Apr 2013 22:14:07
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <51511E04.6070504@gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:vUguYjyFmzWXlGaT+Ft45qVVRq8evNjJDmvYLIoBOvH
 rEzPK59Jl+FEL0skBgTZw7QSqbwpFOx1j1rLoCD4Yndpqf544E
 yi2xuIAXPeqQdieK+8DQlT8SUxHiuLaoAJK1kDRW2VHS/iN7Fn
 ZCLHP3spulwkmqOp2w6RvkwqkpZcuoZpdj8PdPF8xQDz2Bc5Do
 xk+DX4zr6P0Eh78Put/IQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219876>

Seems were getting closer, some comments from a quick read of your
patch below.

Am 26.03.2013 05:03, schrieb Eric Cousineau:
> From 2c2923ada809d671828aa58dcda05a1b71222b70 Mon Sep 17 00:00:00 2001
> From: Eric Cousineau <eacousineau@gmail.com>
> Date: Mon, 25 Mar 2013 22:27:06 -0500
> Subject: [PATCH] submodule-foreach: Added in --post-order=<command> and
>  adjusted code per Jens Lehmann's suggestion
> 
> Signed-off-by: Eric Cousineau <eacousineau@gmail.com>
> ---
> Updated the usage line.
> I had put the locals in there before because I think I was having trouble with resolving some
> of the variables in nested submodules, but now that I've taken them out they seem to work fine.
> I also changed the message for the post-order to say "Exiting".

That's better than "Stopping", but while I'm not a native speaker
I'd propose to use "Leaving" as the opposite of "Entering".

> I did not have a chance to look into why I couldn't group the --post-order stuff into a string
> when passing it on to submodule. I can look at it later on though.
> 
> Now the output is as follows:
> 
> $ git submodule foreach --recursive --post-order 'echo Post $name' 'echo Pre $path'
> Entering 'b'
> Pre b
> Entering 'b/d'
> Pre d
> Exiting 'b/d'
> Post d
> Exiting 'b'
> Post b
> Entering 'c'
> Pre c
> Exiting 'c'
> Post c
> 
>  git-submodule.sh |   35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 004c034..4c9923a 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -10,7 +10,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
>     or: $dashless [--quiet] init [--] [<path>...]
>     or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
> -   or: $dashless [--quiet] foreach [--recursive] <command>
> +   or: $dashless [--quiet] foreach [--recursive] [--post-order <command>] <command>
>     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
>  OPTIONS_SPEC=
>  . git-sh-setup
> @@ -434,6 +434,8 @@ Use -f if you really want to add it." >&2
>  cmd_foreach()
>  {
>      # parse $args after "submodule ... foreach".
> +    recursive=
> +    post_order=

I'm still not sure we need that here, in fact the problem you have
with the cmd_foreach invocation below might just be because you
reset these variables here instead of once at the top of this file.

>      while test $# -ne 0
>      do
>          case "$1" in
> @@ -443,6 +445,15 @@ cmd_foreach()
>          --recursive)
>              recursive=1
>              ;;
> +        --post-order)
> +            test "$#" = "1" && usage
> +            post_order="$2"
> +            shift
> +            ;;
> +        --post-order=*)
> +            # Will skip empty commands
> +            post_order=${1#*=}
> +            ;;
>          -*)
>              usage
>              ;;
> @@ -465,7 +476,9 @@ cmd_foreach()
>          die_if_unmatched "$mode"
>          if test -e "$sm_path"/.git
>          then
> -            say "$(eval_gettext "Entering '\$prefix\$sm_path'")"
> +            enter_msg="$(eval_gettext "Entering '\$prefix\$sm_path'")"
> +            exit_msg="$(eval_gettext "Exiting '\$prefix\$sm_path'")"
> +            die_msg="$(eval_gettext "Stopping at '\$sm_path'; script returned non-zero status.")"
>              name=$(module_name "$sm_path")
>              (
>                  prefix="$prefix$sm_path/"
> @@ -473,13 +486,25 @@ cmd_foreach()
>                  # we make $path available to scripts ...
>                  path=$sm_path
>                  cd "$sm_path" &&
> -                eval "$@" &&
> +                say "$enter_msg" &&
> +                eval "$@" || die "$die_msg" &&
>                  if test -n "$recursive"
>                  then
> -                    cmd_foreach "--recursive" "$@"
> +                    if test -n "$post_order"
> +                    then
> +                        # tried keeping flags as a variable, but was having difficulty
> +                        cmd_foreach --recursive --post-order "$post_order" "$@"
> +                    else
> +                        cmd_foreach --recursive "$@"
> +                    fi
> +                fi &&
> +                if test -n "$post_order"
> +                then
> +                    say "$exit_msg" &&
> +                    eval "$post_order" || die "$die_msg"
>                  fi
>              ) <&3 3<&- ||
> -            die "$(eval_gettext "Stopping at '\$sm_path'; script returned non-zero status.")"
> +            die "$die_msg"
>          fi
>      done
>  }
