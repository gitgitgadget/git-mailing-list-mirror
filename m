From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule foreach: Added in --post-order=<command> and
 adjusted code per Jens Lehmann's suggestions
Date: Sun, 14 Apr 2013 20:52:08 +0200
Message-ID: <516AFAD8.2010207@web.de>
References: <515B3C0E.9000802@web.de> <1365825865-12858-1-git-send-email-eacousineau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: phil.hord@gmail.com, gitster@pobox.com, hvoigt@hvoigt.net,
	git@vger.kernel.org
To: eacousineau <eacousineau@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 20:52:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URS2H-00041O-TL
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 20:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab3DNSwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 14:52:18 -0400
Received: from mout.web.de ([212.227.15.3]:60292 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121Ab3DNSwR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 14:52:17 -0400
Received: from [192.168.178.41] ([91.3.175.163]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LzsC7-1Ue7Ej2YZ1-014gvA; Sun, 14 Apr 2013 20:52:15
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <1365825865-12858-1-git-send-email-eacousineau@gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:Xlt2UwOeSvoakfKkFnjMwyAn09OQrxsCIt+z4A6WZO9
 1N8s4o0MKpYXYJVHmomHd/VsMdWUeskL5U7awkK1v7j1PY0ka0
 Rhz4/EcFdbekq/aDtbga6JICJvPFLP4VJdrv0+/EsMxqc6NIwC
 DeiggOrG6pMQYktug7VaP3AXac3pJ4PspGFDSm2gwxrj3Dojxw
 9CdGHX5YQzni0FKQ1Hinw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221149>

Am 13.04.2013 06:04, schrieb eacousineau:
> Signed-off-by: eacousineau <eacousineau@gmail.com>
> ---
> I see what you meant by the extra variables, so I've fixed that so the
> original flags aren't needed with recursion.

Thanks, the code is looking much better now and you nicely
described the changes you made since the last version. A few
comments though:

I think the subject line should read:

   [PATCH v2] submodule foreach: Add --post-order option

We use the imperative form, also the adjustments are a normal part
of the review process and don't need to be mentioned explicitly in
the title, just show the version of your iteration by adding "v2"
after the word "PATCH" (and of course the next iteration will be
"v3" ;-).

The commit message is not explaining what you did and why you did
it, please see the "Describe your changes well." section in
Documentation/SubmittingPatches on how to do that.

And you'll also want to add the new option to the man page in
Documentation/git-submodule.txt.

> Also updated it to not
> print the entering command if there is only a post-order command.

Good idea.

> Examples:
> 
> $ git submodule foreach --recursive --post-order 'echo Goodbye' "echo \"'ello\""
> Entering 'b'
> 'ello
> Entering 'b/d'
> 'ello
> Leaving 'b/d'
> Goodbye
> Leaving 'b'
> Goodbye
> Entering 'c'
> 'ello
> Leaving 'c'
> Goodbye
> 
> $ git submodule foreach --recursive --post-order :
> Leaving 'b/d'
> Leaving 'b'
> Leaving 'c'

Makes sense to me. These two examples should be getting a test
case each in t/t7407-submodule-foreach.sh.

>  git-submodule.sh | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 79bfaac..e08a724 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -11,7 +11,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
>     or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
>     or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
> -   or: $dashless [--quiet] foreach [--recursive] <command>
> +   or: $dashless [--quiet] foreach [--recursive] [--post-order <command>] <command>
>     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
>  OPTIONS_SPEC=
>  . git-sh-setup
> @@ -449,6 +449,15 @@ cmd_foreach()
>  		--recursive)
>  			recursive=1
>  			;;
> +		--post-order)
> +			test "$#" = "1" && usage
> +			post_order="$2"
> +			shift
> +			;;
> +		--post-order=*)
> +			# Will skip empty commands
> +			post_order=${1#*=}
> +			;;
>  		-*)
>  			usage
>  			;;
> @@ -471,7 +480,9 @@ cmd_foreach()
>  		die_if_unmatched "$mode"
>  		if test -e "$sm_path"/.git
>  		then
> -			say "$(eval_gettext "Entering '\$prefix\$sm_path'")"
> +			enter_msg="$(eval_gettext "Entering '\$prefix\$sm_path'")"
> +			leave_msg="$(eval_gettext "Leaving '\$prefix\$sm_path'")"

I don't think we gain much by putting enter_msg and leave_msg into
their own variables as they are only used once, I'd prefer to see
these messages inlined.

> +			die_msg="$(eval_gettext "Stopping at '\$sm_path'; script returned non-zero status.")"

I think there is a \$prefix missing in front of the \$sm_path here
(see enter_msg and leave_msg). As you only copied that message you
can simply say in the commit message "While at it also fix a missing
prefix in the die message" at the end of the last paragraph.

>  			name=$(module_name "$sm_path")
>  			(
>  				prefix="$prefix$sm_path/"
> @@ -479,13 +490,23 @@ cmd_foreach()
>  				# we make $path available to scripts ...
>  				path=$sm_path
>  				cd "$sm_path" &&
> -				eval "$@" &&
> +				if test $# -gt 0 -o -z "$post_order"
> +				then
> +					say "$enter_msg" &&
> +					eval "$@" || die "$die_msg"
> +				fi &&
>  				if test -n "$recursive"
>  				then
> -					cmd_foreach "--recursive" "$@"
> +					# subshell will use parent-scoped values
> +					cmd_foreach "$@"

You should at least state that you dropped the --recursive here
on purpose, just add that to the "While at it ..." sentence. And I
suspect the comment above is more a reminder for yourself, we
could drop that too.

> +				fi &&
> +				if test -n "$post_order"
> +				then
> +					say "$leave_msg" &&
> +					eval "$post_order" || die "$die_msg"
>  				fi
>  			) <&3 3<&- ||
> -			die "$(eval_gettext "Stopping at '\$sm_path'; script returned non-zero status.")"
> +			die "$die_msg"
>  		fi
>  	done
>  }
> 
