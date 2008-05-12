From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH v2 2/5] git-submodule.sh: Add recurse subcommand with
 basic options
Date: Sun, 11 May 2008 18:20:55 -0700
Message-ID: <7vprrs1fns.fsf@gitster.siamese.dyndns.org>
References: <1209978582-5785-1-git-send-email-imyousuf@gmail.com>
 <1209978582-5785-2-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Mon May 12 03:22:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvMjr-0003Eq-Dn
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 03:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbYELBVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 21:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbYELBVI
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 21:21:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbYELBVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 21:21:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 920804657;
	Sun, 11 May 2008 21:21:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1BD7A4655; Sun, 11 May 2008 21:20:57 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0C56596-1FC1-11DD-8D72-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81827>

imyousuf@gmail.com writes:

> The recurse commands behavior can be customized with several arguments
> that it accepts. The synopsis for the recurse command is:
>
> 	git-submodule recurse [-q|--quiet] [-e|--exit-after-error]
> 	[-d|--depth <recursion depth>] [-b|--breadth-first]
> 	<git command> [<arguments> ...]

Is there a reason to limit the command that can be run per submodule to
only "git" commands?  To me, this "recurse" looks like a glorified "find"
command that can trigger its action only to submodule directories, but
limits what can be given to its -exec option to "git" commands.  While it
would not make sense to give certain git command to recurse (e.g. neither
"git show 65ea3b8" nor "git clone $there" would make any sense), it would
be handy if we can give certain non-git commands to it (e.g. "du -sh").

> @@ -580,6 +585,129 @@ cmd_status()
>  	done
>  }
>  
> +# Check whether the submodule is initialized or not
> +initialize_sub_module()

Everybody else seems to spell "<do-something>_submodule"; should this be
any different?

> +{
> +	if test ! -d "$1"/.git
> +	then
> +		say "Submodule $1 is not initialized and skipped"
> +		return 1
> +	# Returns true if submodule is already initialized

Micronit; s/Returns/Return/.  A sentence that begins with a capitalized
verb in comments is almost always in imperative mood, not third-person
singular present.

> +	elif test -d "$1"/.git
> +	then
> +		return 0
> +	fi
> +}

Otherwise, what does it return?  Do you need elif there, or just "else"?

> +# This function simply checks whether the depth is traverseable in terms of
> +# depth and if so then it sequentially traverses its submodules
> +traverse_submodules()
> +{
> +	# If current depth is the range specified than it will continue
> +	# else return with success
> +	if test "$depth" -gt 0 &&
> +		test "$current_depth" -ge "$depth"
> +	then
> +		return 0;
> +	fi
> +	# If submodules exists than it will traverse over them
> +	if test -f .gitmodules
> +	then
> +		# Incrementing the depth for the next level of submodules
> +		current_depth=$(($current_depth + 1))
> +                for mod_path in `sed -n -e 's/path = //p' .gitmodules`; do
> +                        traverse_module "$mod_path" "$@"
> +                done
> +		# Decremented the depth to bring it back to the depth of
> +		# the current submodule
> +		current_depth=$(($current_depth - 1))
> +	fi
> +}

This makes me wonder if you should be iterating over .gitmodules, or
perhaps you may want to iterate over output of git-ls-files (picking
entries of gitlink type).  How should a local change that adds a new
submodule or removes an existing submodule, or moves an existing submodule
interact with "submodule recurse"? 

Also the same micronits (s/Incrementing/Increment/; s/Decremented/Decrement/).

Even if iterating over .gitmodules entries is a good idea, I suspect that
sed script is too fragile.  Doesn't .gitmodules use the same format as git
configuration files, allowing spaces around values, value quoting and
trailing comments on the same line?

> +# This actually traverses a submodule; checks whether the its initialized
> +# or not, does nothing if not initialized.

s/the //;?

> +traverse_module()
> +{
> +	# Will work in the submodule if and only if its initialized
> +	initialize_sub_module "$1" &&

"initialize_sub_module" does not sound like a function that checks if it
is initialized, but more like a function to, eh, initialize the submodule.
Perhaps the function should be renamed to make it clearer that it is a
predicate?

> +	(
> +		submod_path="$1"
> +		shift
> +		cd "$submod_path"
> +		# If depth-first is specified in that case submodules are
> +		# are traversed before executing the command on this submodule
> +		test -n "$depth_first" && traverse_submodules "$@"
> +		# pwd is mentioned in order to enable the ser to distinguish
> +		# between same name modules, e.g. a/lib and b/lib.
> +		say "git submodule recurse $submod_path $*"
> +		git "$@"
> +		# if exit on error is specifed than script will exit if any
> +		# command fails. As there is no transaction there will be
> +		# no rollback either

s/than/then/;?

> +		# TODO - If possible facilitate transaction
> +		if test "$?" -ne 0 && test -n "$on_error"
> +		then
> +			die "FAILED: git submodule $submod_path $*"

Dying before doing further damage to the repository tree may be a good
idea, but I did not see the calling loop in traverse_submodules pay
attention to the exit code from here.

> +		fi
> +		# If depth-first is not specified in that case submodules are
> +		# are traversed after executing the command on this submodule
> +		test -z "$depth_first" && traverse_submodules "$@"
> +	)
> +}
> +
> +# Propagates or recurses over all the submodules at any depth with any
> +# git command, e.g. git-clone, git-status, git-commit etc., with the
> +# arguments supplied exactly as it would have been supplied to the command
> +# otherwise. This actually starts the recursive propagation.

Is "git-clone" a good example to give here?  What would that mean to
recurse into each submodule directories in a superproject to run "clone"?

> +cmd_recurse() {
> +	while :
> +	do
> +		case "$1" in
> +		-q|--quiet)
> +			quiet=1
> +			;;
> +		-d|--depth)
> +			shift
> +			if test -z "$1"
> +			then
> +				echo "No <recursion depth> specified"
> +				usage
> +			# Arithmatic operation will give an error if depth is not number
> +			# thus chose to check intergerness with regular expression.
> +			# $1 is underquoted becuase the expr is in quotation
> +			elif test "$(expr $1 : '[1-9][0-9]*')" -eq "$(expr $1 : '.*')"

Huh?

	$ a='1 2 3'
        $ expr $a : '[1-9]'
	expr: syntax error
	$ expr "$a" : '[1-9]'
        1
        $ z=$(expr $a : '[1-9]')
	expr: syntax error
	$ z=$(expr "$a" : '[1-9]')
        $ echo $z
        1
        $ echo "$(expr $a : '[1-9]')"
	expr: syntax error
        $ echo "$(expr "$a" : '[1-9]')"
        1

If you want to make sure that $(( ... )) would not choke with given "$1",
you can check by attempting to do a simple $(( ... )) to see if it errors
out, which would be simpler.

	if test -z "$1"
        then
        	...
	elif ! echo $(( "$1" + 0 )) >/dev/null
        then
        	die "$1 is not an integer"
	...
