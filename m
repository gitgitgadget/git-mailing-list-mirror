From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be depth-first,
 --parent option to execute command in supermodule as well
Date: Mon, 18 Mar 2013 22:25:15 +0100
Message-ID: <5147863B.8010104@web.de>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com> <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org> <20130305075901.GB4677@sandbox-ub> <7vhakpvnex.fsf@alter.siamese.dyndns.org> <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com> <7vboaxu23y.fsf@alter.siamese.dyndns.org> <51365AB6.2010602@web.de> <CABURp0psgofX=ean+KKooN74pF4Ns-gDGt68vc5Exs6NmDRUyw@mail.gmail.com> <513B7D08.20406@web.de> <CABURp0qBA6myf7_SuaxJSrePJHmh2v-nmtLRzKTtgAJxLkJ-tQ@mail.gmail.com> <51416E9F.7000604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Cousineau <eacousineau@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 22:26:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHhZ3-0008QC-M8
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 22:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131Ab3CRVZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 17:25:24 -0400
Received: from mout.web.de ([212.227.17.12]:65502 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933126Ab3CRVZV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 17:25:21 -0400
Received: from [192.168.178.41] ([91.3.185.39]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0Lp7HY-1Uu4hk0puu-00fEdA; Mon, 18 Mar 2013 22:25:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <51416E9F.7000604@gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:9un2I2GTOufvphXSdB8dlrzSGR8P9tJQ60SLNaDvQHF
 9NOIy6K6G4hwNmLgAcAAnyvq53LwI+pRVur/NMXp5jRUbTsSh5
 0FCHPbB6zNfzrxSZriuyz/EtxKS3M6cnZisYpQRcmPwb8G3Xw8
 hzJGUMZHbuYI+MHbZZgPSZ05PxtJAuglvLufN+xymf9sT7nKmJ
 RGDlSWaxlgL2X38KV5Czg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218455>

Thanks, just a quick review before I find some time do take a
deeper look.

Am 14.03.2013 07:30, schrieb Eric Cousineau:
> From 59fb432e17a1aae9de26bbaaca7f09cc7f03b471 Mon Sep 17 00:00:00 2001
> From: Eric Cousineau <eacousineau@gmail.com>
> Date: Thu, 14 Mar 2013 01:19:53 -0500
> Subject: [PATCH] submodule-foreach: Added in --post-order=<command> per Jens
>  Lehmann's suggestion
> 
> Signed-off-by: Eric Cousineau <eacousineau@gmail.com>
> ---
> Made the scope of the patch only relate to --post-order.
> Would we want to rename this to just --post=<command> ?

Hmm, while having no strong preference on that, "post order"
looks more like the correct term describing what we do here.

> Anywho, here it is running in a test setup, where the structure is:
> a
> - b
> - - d
> - c
> 
> $ git submodule foreach --recursive --post-order 'echo Post $name' 'echo Pre $path'
> Entering 'b'
> Pre b
> Entering 'b/d'
> Pre d
> Entering 'b/d'
> Post d
> Entering 'b'
> Post b
> Entering 'c'
> Pre c
> Entering 'c'
> Post c

Looking good.

> An interesting note is that it fails with 'git submodule foreach --post-order', but not 'git submodule foreach --post-order=', since it simply interprets that as an empty command.
> If that is important, I could add in a check for $# when parsing the argument for --post-order=*.
> 
>  git-submodule.sh | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 004c034..9b70bc2 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -10,7 +10,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
>     or: $dashless [--quiet] init [--] [<path>...]
>     or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
> -   or: $dashless [--quiet] foreach [--recursive] <command>
> +   or: $dashless [--quiet] foreach [--recursive] [--post-order=<command>] <command>

Maybe drop the '=' from the description (see --reference for an example)?

>     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
>  OPTIONS_SPEC=
>  . git-sh-setup
> @@ -434,6 +434,8 @@ Use -f if you really want to add it." >&2
>  cmd_foreach()
>  {
>      # parse $args after "submodule ... foreach".
> +    # Gratuitous (empty) local's to prevent recursive bleeding
> +    local recursive= post_order=

Wouldn't it be sufficient to add "post_order=" to the top of the
file where "recursive" is already initialized? Or am I missing
something here?

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
> @@ -453,7 +464,7 @@ cmd_foreach()
>          shift
>      done
> 
> -    toplevel=$(pwd)
> +    local toplevel=$(pwd)

Why do you have to add the "local" keyword here?

>      # dup stdin so that it can be restored when running the external
>      # command in the subshell (and a recursive call to this function)
> @@ -465,18 +476,36 @@ cmd_foreach()
>          die_if_unmatched "$mode"
>          if test -e "$sm_path"/.git
>          then
> -            say "$(eval_gettext "Entering '\$prefix\$sm_path'")"
> +            local name prefix path message epitaph

Same here?

> +            message="$(eval_gettext "Entering '\$prefix\$sm_path'")"
> +            epitaph="$(eval_gettext "Stopping at '\$sm_path'; script returned non-zero status.")"
>              name=$(module_name "$sm_path")
>              (
>                  prefix="$prefix$sm_path/"
>                  clear_local_git_env
>                  # we make $path available to scripts ...
>                  path=$sm_path
> +
> +                sm_eval() {
> +                    say "$message"
> +                    eval "$@" || die "$epitaph"
> +                }
> +
>                  cd "$sm_path" &&
> -                eval "$@" &&
> +                sm_eval "$@" &&
>                  if test -n "$recursive"
>                  then
> -                    cmd_foreach "--recursive" "$@"
> +                    if test -n "$post_order"
> +                    then
> +                        # Tried keeping flags as a variable, but was having difficulty

Maybe because you set the "post_order" variable to empty at the
beginning of this function? If I read that right moving that
initialization to the top of the file could get rid of the if
here?

> +                        cmd_foreach --recursive --post-order "$post_order" "$@"
> +                    else
> +                        cmd_foreach --recursive "$@"
> +                    fi
> +                fi &&
> +                if test -n "$post_order"
> +                then
> +                    sm_eval "$post_order"
>                  fi
>              ) <&3 3<&- ||
>              die "$(eval_gettext "Stopping at '\$sm_path'; script returned non-zero status.")"
