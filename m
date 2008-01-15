From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] - git submodule subcommand parsing modified.
Date: Tue, 15 Jan 2008 02:13:50 -0800
Message-ID: <7vzlv7flb5.fsf@gitster.siamese.dyndns.org>
References: <1200280956-19920-1-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 15 11:14:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEioa-000118-B3
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 11:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbYAOKOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 05:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753145AbYAOKOI
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 05:14:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbYAOKOF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 05:14:05 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CE1CF5A3F;
	Tue, 15 Jan 2008 05:14:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 04CBE5A3E;
	Tue, 15 Jan 2008 05:13:56 -0500 (EST)
In-Reply-To: <1200280956-19920-1-git-send-email-imyousuf@gmail.com>
	(imyousuf@gmail.com's message of "Mon, 14 Jan 2008 09:22:36 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70508>

imyousuf@gmail.com writes:

> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>
> - manual page of git-submodule and usage mentioned in git-subcommand.sh
> were not same, thus synchronized them. In doing so also had to change the
> way the subcommands were parsed.
>
> - Previous version did not allow commands such as
> 	git-submodule add init update
> as the command parser incorrectly made subcommand names reserve.
> Thus refusing them to be used as parameters to subcommands. As a result it
> was impossible to add a submodule whose (symbolic) name is "init" and that
> resides at path "update" was refused. For more details the following case
> can be considered -
>
> mkdir g; mkdir f; cd g/
> touch g.txt; echo "sample text for g.txt" >> ./g.txt; git-init;
> git-add g.txt; git-commit -a -m "First commit on g"
> cd ../f/; ln -s ../g/ init
> git-init; git-submodule add init update;
> git-commit -a -m "With module update"
> mkdir ../test; cd ../test
> git-clone ../f/; cd f
> git-submodule init update; git-submodule update update
> cd ../..; rm -rf ./f/ ./test/ ./g/

 - I'd drop everything after "For more details...".  If you feel
   that the part before "For more details" cannot be understood
   without that thick and solid sample script, perhaps that
   description needs to be rewritten to make it easier to
   understand (personally I do not see it as hard to understand,
   modulo grammatical errors).

> This patch fixes this issue and allows it as well.

 - "it" in this sentence can easily be mistaken as referring to
   "this issue".  I'd suggest dropping "and allows...".

> - Status currently is implemented to show list only but later
> implementation might change and list and status could coexists. Thus
> status module is introduced. The module is also used to parse its
> arguments

 - That is probably better in a separate patch, if the purpose
   of the patch is about straightening out the command parser to
   fix existing issues.  Generally it is a good idea to have
   fixes and enhancement as separate patches.

> - Subcommands will also parse their own commands; thus enabling command
> specific arguments to be passed after the command. For example,
> 	git-submodule -q add -b master module_a
> 	git-submodule -q status -c
> It is to be noted that -q or --quiet is specified before the subcommand
> since it is for the submodule command in general rather than the
> subcommand. It is mention worthy that backward compatibility exists and
> thus commands like git submodule --cached status will also work as expected

 - I have a mild distaste against commands that expect the users
   to intimately know what option is command wide and what
   option is subcommand specific.  IOW it is not very nice to
   accept "git submodule -q status" and reject "git submodule
   status -q".

> - Subcommands that currently do not take any arguments (init and update)
> has a case which is introduced just to ensure that no argument is
> deliberately sent as the first argument and also to serve the purpose of
> providing a future extension point for its arguments.

 - As far as I understand what they do, they both do take
   paths arguments to name specific modules, so the above
   sentence is bogus.  Maybe you meant rejecting non-existent
   options, and I'd agree with the intent if that is the case
   (but your implementation around -- is bogus).

> - Though ther was short and long version for quiet (-q or --quiet and
> branch (-b or --branch) but there was no short version for cached. Thus
> it is now introduced (-c or --cached).
>
> - Added 3 specific messages for usage error related to branch and cached
>
> - Simplified subcommand action invocation by simply invoking the action if
> all conditions are fulfilled. Excepting for parsing command line arguments
> case statements are avoided and instead more direct if statement is
> introduced.
> ---

 - Lacks sign-off.

 - The message felt very hard to read.  Perhaps it is just that
   these unindented sentences in bullet-list, together with the
   two displayed command line that are not separated from the
   rest of the text with a blank line, hurts the eyes.

 - Perhaps the patch tries to do too many things.  For example,
   introduction of -c does not have to belong here.  nor
   "status" which currently is the same as "list".  Maybe that
   is why the description needs to talk about too many things,
   which in turn could be the reason why I find the above
   message very hard to read.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index ad9fe62..22e7e5f 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -4,18 +4,23 @@
>  #
>  # Copyright (c) 2007 Lars Hjemli
>  
> -USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
> +# Synopsis of this commands are as follows
> +# git-submodule [-q|--quiet] add [-b|--branch branch] <repository> [<path>]
> +# git-submodule [-q|--quiet] [status] [-c|--cached] [--] [<path>...]
> +# git-submodule [-q|--quiet] init [--] [<path>...]
> +# git-submodule [-q|--quiet] update [--] [<path>...]
> +USAGE='[-q|--quiet] [[[add [-b|--branch branch] <repo>]|[[[status [-c|--cached]]|init|update] [--]]]  [<path>...]]'
>  OPTIONS_SPEC=
>  . git-sh-setup
>  require_work_tree
>  
> +MODULES_LIST='modules_list'
> +

 - What's the purpose of this variable?  If you are planning to
   change the default command by changing the value of this
   variable, then the variable is not about MODULES_LIST, but
   about DEFAULT_COMMAND or something, and should be named as
   such.

>  add=
>  branch=
> -init=
> -update=
> -status=
>  quiet=
>  cached=
> +command=
>  
>  #
>  # print stuff on stdout unless -q was specified
> @@ -114,6 +119,17 @@ module_clone()
>  	die "Clone of '$url' into submodule path '$path' failed"
>  }
>  
> +# Parses the branch name and exits if not present
> +parse_branch_name()
> +{
> +	branch="$1"; 
> +	if test -z "$branch"
> +	then
> +		echo Branch name must me specified	
> +		usage
> +	fi

 - Shouldn't the message go to stderr?

 - If we use "usage", that already tells the user -b is followed
   by branch.  Is the extra message needed in the first place?
   If this patch is about "fixing", perhaps you should not be
   mixing this kind of unnecessary changes in it.

> +}
> +
>  #
>  # Add a new submodule to the working tree, .gitmodules and the index
>  #
> @@ -123,6 +139,16 @@ module_clone()
>  #
>  module_add()
>  {
> +	case "$1" in
> +		-b|--branch)
> +			shift
> +			parse_branch_name "$@" &&
> +			shift
> +			;;
> +		-*)
> +			usage
> +			;;
> +	esac

 - Style.  Please align case arms with "case/esac", like other
   scripts (and the original version of this script) do.  I.e.

	case "$1" in
        -b|--branch)
                ...
	esac

   This comment applies to other parts of the patch as well.

>  	repo=$1
>  	path=$2
>  
> @@ -176,6 +202,14 @@ module_add()
>  #
>  modules_init()
>  {
> +	# Added here to ensure that no argument is passed to be treated as
> +	# parameter to the sub command. This will be used to parse any 
> +	# to the subcommand
> +	case "$1" in
> +		-*)
> +			usage
> +			;;
> +	esac

 - If I understand correctly, "git submodule init" takes paths
   to submodules as arguments.  Are you disallowing paths that
   begin with '-', even though the body of the command (ls-files
   piped to while loop) is written in such a way that is
   perfectly capable of handling such a path?

>  	git ls-files --stage -- "$@" | grep -e '^160000 ' |
>  	while read mode sha1 stage path
>  	do
> @@ -209,6 +243,14 @@ modules_init()
>  #
>  modules_update()
>  {
> +	# Added here to ensure that no argument is passed to be treated as
> +	# parameter to the sub command. This will be used to parse any 
> +	# to the subcommand
> +	case "$1" in
> +		-*)
> +			usage
> +			;;
> +	esac

 - The same comment as modules_init() above applies here.

>  	git ls-files --stage -- "$@" | grep -e '^160000 ' |
>  	while read mode sha1 stage path
>  	do
> @@ -293,36 +335,69 @@ modules_list()
>  	done
>  }
>  
> +# Delgates to modules_list after parsing its arguments

 - That's "delegates", but typically when we write a sentence
   without the subject like this in the comment, we use the
   imperative mood, so "Delegate to modules_list after ..."
   would be more appropriate.

> +modules_status()
> +{
> +	case "$1" in
> +		-c|--cached)
> +			shift
> +			cached=1
> +			;;
> +		-*)
> +			usage
> +			;;
> +	esac
> +	"$MODULES_LIST" "$@"
> +}

 - The same comment as modules_init() above applies here.

> +# If there is '--' as the first argument simply ignores it and thus shifts
> +check_for_terminator()
> +{
> +	if test -n "$1" && test "$1" = "--"
> +	then
> +		shift
> +	fi
> +}

 - That 'test -n "$1" && test "$1" = "--"' feels stupid; if "$1"
   is equal to "--", it certainly will be -n (i.e. not empty).
   Perhaps 'test $# -ge 1 && test "$1" = "--"' or even just
   'test "$1" = "--"'.

 - I do not think the 'shift' does anything useful.  It does not
   shift the positional parameters of the caller of this shell
   function, and would be a noop from the caller's point of
   view.  It only shifts the positional parameters inside this
   function (study e.g. "2.9.5 Function Definition Command",
   http://www.opengroup.org/onlinepubs/000095399/utilities/xcu_chap02.html).

> +# Command synopsis clearly shows that all arguments after
> +# subcommand are arguments to the command itself. Thus
> +# there lies no command that has configuration argument
> +# after the mention of the subcommand. Thus once the
> +# subcommand is found and the separator ('--') is ignored
> +# rest can be safely sent the subcommand action

 - That's a valid justification but I think it is enough to say
   what it does (i.e. "Arguments after the subcommand name are
   given to the subcommand").  How you arrived to that design
   decision (i.e. your justification based on the synopsis) does
   not belong here.  It could however be part of the commit log
   message.

 - I do not agree with the (attempted) stripping of -- you talk
   about here (that is done in the loop below).

> +# It is to be noted that pre-subcommand arguments are parsed
> +# just to have backward compatibility.

 - Because we might want to deprecate and remove forms like "-b
   branch add" later, this is a good comment to have here.  It
   makes it clear that these oddballs are purely for backward
   compatibility.

>  while test $# != 0
>  do
>  	case "$1" in
>  	add)
>  		add=1
> +		command="module_$1"
> +		shift
> +		break
>  		;;
> -	init)
> -		init=1
> -		;;
> -	update)
> -		update=1
> -		;;
> -	status)
> -		status=1
> +	init|update|status)
> +		command="modules_$1"
> +		shift
> +		check_for_terminator "$1"
> +		break
>  		;;

 - Aside from my earlier comment that the code would become
   simpler if you consistently renamed the shell functions to
   module_$foo (or cmd_$foo) so that the dispatcher can follow a
   simple rule "subcommand $foo is handled by shell function
   cmd_$foo", which you seem to have ignored, and also aside
   from that your check_for_terminator does not do what you seem
   to have intended (see above), I think this handling of -- is
   wrong.  By stripping -- here, you are making the following
   two behave exactly the same:

   $ git submodule update -- $other_args
   $ git submodule update    $other_args

   The whole point of -- is so that you can tell the command
   that the argument at the beginning of $other_args that
   happens to begin with a dash is _not_ an option but is a
   literal path (or whatever).  Think of the case in which you
   had '-foo' and 'bar' in place of $other_args above.  The
   first one tells the command to update two modules ('-foo' and
   'bar'), the second one tells the command to update 'bar'
   module but the update operation needs to be done with -foo
   option (whatever that option means to 'update' command).

   By checking and shifting -- out, you are making it impossible
   for the implementation of the command (i.e. your
   "modules_update") to tell which case it is dealing with.

>  	-q|--quiet)
>  		quiet=1
>  		;;
>  	-b|--branch)
> -		case "$2" in
> -		'')
> -			usage
> -			;;
> -		esac
> -		branch="$2"; shift
> +		shift
> +		parse_branch_name "$@"
>  		;;
> -	--cached)
> +	-c|--cached)
>  		cached=1
>  		;;
>  	--)
> +		# It is shifted so that it is not passed
> +		# as an argument to the default subcommand
> +		shift
>  		break
>  		;;
>  	-*)
> @@ -335,30 +410,25 @@ do
>  	shift
>  done
>  
> -case "$add,$branch" in
> -1,*)
> -	;;
> -,)
> -	;;
> -,*)
> +# Throws usage error if branch is not used with add command
> +if test -n "$branch" &&
> +   test -z "$add"
> +then
> +	echo Branch can not be specified without add subcommand
>  	usage
> -	;;
> -esac
> -
> -case "$add,$init,$update,$status,$cached" in
> -1,,,,)
> -	module_add "$@"
> -	;;
> -,1,,,)
> -	modules_init "$@"
> -	;;
> -,,1,,)
> -	modules_update "$@"
> -	;;
> -,,,*,*)
> -	modules_list "$@"
> -	;;
> -*)
> +fi
> +
> +# If no command is specified then default command
> +# is - git submodule status
> +test -z "$command" && command="modules_status"
> +
> +# Throws usage if --cached is used by other than status, init or update
> +# that is used with add command
> +if test -n "$cached" &&
> +   test "$command" != "modules_status"
> +then
> +	echo Cached can only be used with the status subcommand
>  	usage
> -	;;
> -esac
> +fi
> +
> +"$command" "$@"
> -- 
> 1.5.3.7
