From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] - Added recurse command to git submodule
Date: Wed, 09 Jan 2008 00:38:22 -0800
Message-ID: <7vmyrfjsw1.fsf@gitster.siamese.dyndns.org>
References: <1199857906-26321-1-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 09 09:39:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCWSq-0000SW-Rb
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 09:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYAIIil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 03:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbYAIIil
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 03:38:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbYAIIik (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 03:38:40 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 735702080;
	Wed,  9 Jan 2008 03:38:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 952BD1C9C;
	Wed,  9 Jan 2008 03:38:29 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69966>

imyousuf@gmail.com writes:

> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>
>
>  - The purpose of the recurse command in the git submodule is to recurse
>  a command in its submodule at depths specified. For example if one wants
>  to do a diff on its project with submodules at once, one can simply do
>  git-submodule recurse diff HEAD and would see the diff for all the modules
>  it contains. If during recursion it is found that a module has not been
>  initialized or updated than the command also initializes and updates them.
>  It is to be noted that argument specification to the command intended (in
>  above example diff) to recurse will be same as its original command (i.e.
>  git diff). If the original command spec changes it will have no effect on
>  the recurse command. Depth of recursion can be specified simply by
>  mentioning the -d <recursion depth> argument to recurse command. If not
>  specified or specified to 0, it will be comprehended to recurse at all
>  depth; if a positive number is specified than maximum recursion depth will
>  never cross that depth. In order to see some information -v option may be
>  used

The indentation style seems, eh, unique.  An overlong single
paragraph with solid run of sentences is somewhat hard to read.

I am not still convinced that a subcommand other than init,
which is started recursively, should initialize and update
submodules that are uninitialized.  Currently there is no way,
other than not having an initialized submodule repository, to
mark that the user is _not_ interested in a particular
submodule, and you will lose that if you make recursing into
uninitialized ones too easy and aggressive.

I suspect that it might be a saner approach to:

 - allow "git submodule recurse init [-d depth]" (although I am
   not sure if limit by depth is so useful in practice -- only
   experience will tell us) to auto-initialize the uninitialized
   submodules;

 - allow any other "git submodule recurse $cmd" to run
   recursively to _any_ depth, but never auto-initialize the
   uninitialized submodules.

In other words, I think it is a very bad idea to rob the
existing mechanism from the user to mark uninteresting
submodules by not initializing them.  An alternative would be to
give them other means to mark "I am not interested in these
submodules", if you insist on this auto-initialization, but I do
not offhand think of a mechanism that is easier to use than what
we already have (i.e. not checking them out).

> @@ -17,6 +17,9 @@ status=
>  quiet=
>  cached=
>  command=
> +recurse_verbose=0
> +recursion_depth=0
> +current_recursion_depth=0

I wonder if we want this "verbose" option to be specific to the
recurse subcommand, or perhaps other subcommands may want to
support more verbose output mode, even if they currently don't.
Perhaps the variable should be just called $verbose?

> +# Initializes the submodule if already not initialized
> +initialize_sub_module() {
> +	if [ ! -d "$1"/.git ]; then
> +		if [ $recurse_verbose -eq 1 ]; then
> +			echo Initializing and updating "$1"

That's a sensible message for the $verbose mode.

> +		fi
> +		git-submodule init "$1"; git-submodule update "$1"

Can init fail for repository "$1"?  Do you want to proceed
updating it if it does?

> +# This actually traverses the module; checks
> +# whether the module is initialized or not.
> +# if not initialized, then done so and then the
> +# intended command is evaluated. Then it
> +# recursively goes into it modules.
> +traverse_module() {
> +	if [ $recurse_verbose -eq 1 ]; then
> +		echo Current recursion depth: "$current_recursion_depth"
> +	fi
> +	initialize_sub_module "$1"
> +	(
> +		submod_path="$1"
> +		shift
> +		cd "$submod_path"
> +		if [ $recurse_verbose -eq 1 ]; then
> +			echo Working in mod "$submod_path" @ `pwd` with "$@" \("$#"\)

Is this a sensible message, I have to wonder...  Saying `pwd`
after already saying "$submod_path" feels more like a debugging
message than just being $verbose.

> +		fi
> +	        git "$@"

Is the user interested in exit status from this command?  Does
the user want to continue on to other submodules if this one
fails?

> +		# Check whether submodules exists only if recursion to that depth
> +		# was requested by user
> +		if test "$recursion_depth" -eq 0 || test "$current_recursion_depth" -lt "$recursion_depth"

Overly long line.  Perhaps...

	if test "$depth" -eq 0 ||
           test "$current_depth" -lt "$depth"
	then
		...

> +		then
> +			if [ -f .gitmodules ]; then
> +		                for mod_path in `sed -n -e 's/path = //p' .gitmodules`; do
> +					export current_recursion_depth=$(echo "$current_recursion_depth+1" | bc)

 (1) I do not think you need to export this variable;

 (2) It was reported some shells that we intend to support
     mishandle "export VAR=VAL" construct and we tend to write
     this "VAR=VAL" followed by "export VAR" as two separate
     commands on two separate lines;

 (3) We do not use "bc" (and traditionally, shell scripts
     outside git don't, either) in scripts.

So, I think:

    current_recursion_depth=$(( $current_recursion_depth + 1 ))

is enough, although the variable name feels overly long.

Probably I would even do:

	if test "$depth -ne 0 && test "$current_depth" -ge "$depth"
	then
        	exit 0
	fi
	if test -f .gitmodules
        then
        	current_recursion_depth=$(( $current_recursion_depth + 1 ))
		for p in $(sed -n -e 's/path = ....)
                do
                	traverse_module "$p" "$@"
		done
	fi

which would avoid one level of nesting (and indentation), and
removes unnecessary increment and decrement inside the loop.
You are in your own subprocess, so your increment will not
affect the process that called you, and after leaving the loop
the only thing you do is just to exit the subprocess.

> +# Propagates or recurses over all the submodules at any
> +# depth with any git command, e.g. git-clone, git-status,
> +# git-commit etc., with the arguments supplied exactly as
> +# it would have been supplied to the command otherwise.
> +# This actually starts the recursive propagation
> +modules_recurse() {
> +	project_home=`pwd`
> +	echo Project Home: "$project_home"

Doesn't this message belong to $verbose mode?

> +	if [ $recurse_verbose -eq 1 ]; then
> +		if [ $recursion_depth = 0 ]; then
> +			echo Recursion will go to all depths
> +		else
> +			echo Recursion depth specified to "$recursion_depth"
> +		fi

These sounds more like debugging message than $verbose.

> +	fi
> +	if [ -d "$project_home"/.git/ ]; then
> +		if [ $recurse_verbose -eq 1 ]; then
> +			echo Command to recurse: git "$@"

Likewise -- you will repeat that inside traverse_module anyway.

> +		fi
> +		git "$@"
> +		if [ -f .gitmodules ]; then
> +			for mod_path in `sed -n -e 's/path = //p' .gitmodules`; do
> +				export current_recursion_depth=1
> +				traverse_module $mod_path "$@"
> +			done
> +		fi

Do I see a code duplication here?  Why isn't this done as the
first level recursion inside traverse_module?  _Even_ _if_ you
insist auto-initializing submodules, by moving the
initialize_sub_module call in traverse_module a bit down
(namely, before it recursively invoke traverse_module itself and
make it auto initialize $submod_path, not "$1"), I think you can
remove this duplication.

> +	else
> +		echo "$project_home" not a git repo thus exiting
> +		exit

And its exit code is 0 which tells the caller that there is no
error?

> +	fi
> +	unset current_recursion_depth

The reason for this unset is...?

> @@ -326,6 +405,37 @@ do
>  	--cached)
>  		command="modules_list"
>  		;;
> +	recurse)
> +		command="modules_$1"
> +		repeat=1
> +		while test $repeat = 1
> +		do

You do not need that $repeat thing.  Just use "break", like this.

	while :
        do
        	case ... in
                ...
                *)
                	break ;;
		esac
	done

> +				-d)
> +					if [ -z $3 ]; then

(minor style)

	if test -z "$3"
        then
        	...

> +						echo No \<recursion depth\> specified
> +						usage
> +					elif [ `expr "$3" : '[1-9][0-9]*.*'` -eq `expr "$3" : '.*'` ]; then
> +						recursion_depth="$3"
> +						shift
> +						shift
> +					else
> +						echo \<recursion depth\> not an integer
> +						usage
> +					fi
> +					;;

Instead of checking integerness by hand, it would probably be
much simpler if you did something like this:

	depth="$3"
        depth=$(( $depth + 0 ))
        if test "$depth" != "$3"
        then
        	die "what's that '$3' for?"
	else
        	: happy
	fi

For a rough guideline of shell constructs we use (and do not
use), please see Documentation/CodingGuidelines.
