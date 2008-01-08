From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added recurse command to git submodule
Date: Mon, 07 Jan 2008 21:44:19 -0800
Message-ID: <7v3at8yiq4.fsf@gitster.siamese.dyndns.org>
References: <7bfdc29a0801071914s207be500veae8e507d7d9d29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 06:45:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC7Gn-00047B-3C
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 06:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbYAHFod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 00:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752840AbYAHFod
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 00:44:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbYAHFoc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 00:44:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 11897C8BD;
	Tue,  8 Jan 2008 00:44:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B919FC8BB;
	Tue,  8 Jan 2008 00:44:26 -0500 (EST)
In-Reply-To: <7bfdc29a0801071914s207be500veae8e507d7d9d29@mail.gmail.com>
	(Imran M. Yousuf's message of "Tue, 8 Jan 2008 09:14:19 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69840>

"Imran M Yousuf" <imyousuf@gmail.com> writes:

> Following is the diff with git-submdoule version 1.5.3.7. I also
> attached the diff and the modified file in the attachment.

Please do not do this when the submission is for real (I think
you did not mean this for inclusion but for comment so it is Ok
this time around), as such a message cannot be processed with
our automated tools but need to be applied by hand.

Just send a non whitespace-corrupted, plain text patch.  A
corrupt text patch followed by an attachment is the worst of
both worlds.

> @@ -251,6 +252,78 @@ modules_list()
>  	done
>  }
>
> +# Simply checks whether the submodule is initialized
> +# or not. If not initialized it does so.
> +initializeSubModule() {
> +	if [ ! -d "$1"/.git ]; then
> +		if [ $recurse_verbose -eq 1 ]; then
> +			echo Initializing and updating "$1"
> +		fi
> +		git-submodule init "$1"; git-submodule update "$1"
> +	fi
> +}

The comment above sounds quite wrong, isn't it?  It is not just
"simply check" but actively makes sure it is initialized.

Do we use CamelCase in our shell script?

Making -r to always recurse _fully_ feels quite wrong.  It is
one thing to allow "git submodule init --recursive" to recurse
fully and initialize everything, but it is another thing to
force full instantiation of submodules that the user _chose_ not
to check out, when the user has checkout of some but not all
submodules and asks "git submodule update --recursive".

> +# This actually traverses the module; checks
> +# whether the module is initialized or not.
> +# if not initialized, then done so and then the
> +# intended command is evaluated. Then it
> +# recursively goes into it modules.
> +traverseModule() {
> +	current_dir=`pwd`
> +	dir_path="$current_dir:$dir_path"
> +	initializeSubModule "$1"
> +        cd "$1"
> +	if [ $recurse_verbose -eq 1 ]; then
> +		echo Working in mod $1 @ `pwd` with $2
> +	fi

Always quote variable references unless you mean you want field
splitting.  Even when you know $1 and $2 do not have IFS
characters, to make it easier to readers.

> +        eval "$2"
> +	if [ -f .gitmodules ]; then
> +                for mod_path in `grep "path =" .gitmodules | awk
> '{print $3}'`; do
> +                        traverseModule "$mod_path" "$2"
> +                done
> +        fi
> +	old_dir=$(echo $dir_path | cut -d':' -f1-1)
> +	length_old_dir=`expr "$old_dir" : '.*'`
> +	cd $old_dir
> +	index=$(echo "$length_old_dir+2" | bc)
> +	dir_path=`echo $dir_path $index | awk '{print substr($1, $2)}'`

This dir_path separated with ":" and shuffling the $cwd with
chdir'ing around makes me say "Yuck".  Is it essential that
these operation in the submodule happen in the same process?
IOW, wouldn't it be enough to do something like:


	initialize_submodule "$1"
        (
        	cd "$1"
                if test -n "$recursive_verbose"
                then
                	echo "Working in module $1 with $2"
		fi
                eval "$2"
		if test -f .gitmodules
                then
                	for p in `sed -n -e 's/^path = //p' .gitmodules`
			do
                        	traverse_module "$p" "$2"
			done
		fi
	)

> +}
> +
> +# Propagates or recurses over all the submodules at any
> +# depth with any git command, e.g. git-clone, git-status,
> +# git-commit etc., with the arguments supplied exactly as
> +# it would have been supplied to the command otherwise.
> +# This actually starts the recursive propagation
> +propagate() {
> +	project_home=`pwd`
> +	echo Project Home: $project_home
> +	if [ -d $project_home/.git/ ]; then
> +		git_command=$1
> +		shift
> +		command_arguments=""
> +		for arg in "$@"; do

That 'in "$@"' is distracting.

	for arg
        do
		...

is enough.

> +			if [ `expr index "$arg" ' '` -gt 0 ]; then

Do we ever use `expr index` anywhere else?  I thought we fixed
that non-portability.

> +				arg="\"$arg\""
> +			fi
> +			command_arguments="$command_arguments $arg"
> +		done
> +		if [ $recurse_verbose -eq 1 ]; then
> +			echo GIT Command git-$git_command with arguments\($#\) "$command_arguments"
> +		fi
> +		main_command="git-$git_command $command_arguments"
> +		eval $main_command

This feels like a sloppy quoting, although I haven't looked at
the code very deeply.  Does it work when $arg has funny letters
like backslash, double-quote and or backquote?

> @@ -286,6 +359,17 @@ do
>  	-*)
>  		usage
>  		;;
> +	recurse)
> +		recurse=1
> +		case "$2" in
> +			-v)
> +				recurse_verbose=1
> +				shift
> +				;;
> +		esac
> +		shift
> +		break
> +		;;

I was ahead of myself earlier but I think it makes more sense to
pretend (at the command line syntax level) that --recursive is
an option to other commands.

> @@ -303,17 +387,21 @@ case "$add,$branch" in
>  	;;
>  esac
>
> -case "$add,$init,$update,$status,$cached" in
> -1,,,,)
> +
> +case "$add,$init,$update,$recurse,$status,$cached" in
> +1,,,,,)
>  	module_add "$@"
>  	;;
> -,1,,,)
> +,1,,,,)
>  	modules_init "$@"
>  	;;
> -,,1,,)
> +,,1,,,)
>  	modules_update "$@"
>  	;;
> -,,,*,*)
> +,,,1,,)
> +	propagate "$@"
> +	;;
> +,,,,*,*)
>  	modules_list "$@"
>  	;;
>  *)

I've always hated this part of the script.  How about a bit of
clean-up patch first before adding $recurse or anything else, to
introduce command variable and do:

	case "$command" in
        add)
        	module_add "$@"
                ;;
	init)
        	module_init "$@"
                ;;
                ...
	*)
        	modules_list "$@"
                ;;
	esac

or even just a single:

	"module_$command" "$@"
