From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] - Added 'recurse' subcommand to git submodule
Date: Thu, 06 Mar 2008 02:42:14 -0800
Message-ID: <7vr6eo9lrt.fsf@gitster.siamese.dyndns.org>
References: <1204788817-22720-1-git-send-email-imyousuf@gmail.com>
 <1204788817-22720-2-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 06 11:43:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXDZ7-0007VO-Oa
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 11:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757395AbYCFKm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 05:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757266AbYCFKm3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 05:42:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43967 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757264AbYCFKm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 05:42:28 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1BC1B1819;
	Thu,  6 Mar 2008 05:42:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E8B381818; Thu,  6 Mar 2008 05:42:20 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76365>

imyousuf@gmail.com writes:

> The purpose of the recurse command in the git submodule is to recurse

s/command/sub&/;

> a command in its submodule. For example if one wants to do a diff on its
> project with submodules at once, one can simply do
> 	git-submodule recurse diff HEAD
> and would see the diff for all the modules it contains.

Can we please have a blank line around the example command line to make it
visually stand out more?

> The recurse commands behavior can be customized with several arguments
> that it accepts. The synopsis for the recurse command is:
>
> 	git-submodule [-q|--quiet] recurse [-i|--initialize]
> 	[-e|--exit-after-error] [-d|--depth <recursion depth>]
> 	[-df|--depth-first] [-ca|--customized-argument] [-p|--pre-command]
> 	<command> [<arguments> ...]
>
> When traversing modules, a module could be uninitialized that is git
> submodule init and update has not been called for it; if [-i|--initialize]
> option is specified, it will initialize any module that is not initialized;
> else if the module is not initialized it will simply skip it.

I really do not think the -i option should exist.  "init" is a conscious
action and should not be a side effect of something else.  (Why doesn't
"git submodule status -i" exist? ;-)

I do not mind "git submodule recurse init", though.  "git submodule
recurse update" might also be a natural thing to do.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 257be4c..ee3c928 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -8,7 +8,8 @@
>  # git-submodule [-q|--quiet] add [-b|--branch branch] <repository> [<path>]
>  # git-submodule [-q|--quiet] [status] [-c|--cached] [--] [<path>...]
>  # git-submodule [-q|--quiet] init|update [--] [<path>...]
> -USAGE='[-q|--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
> +# git-submodule [-q|--quiet] recurse [-i|--initialize] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-df|--depth-first] <command> [<arguments> ...]
> +USAGE='[-q|--quiet] [[[add [-b|--branch branch] <repo>]|[[[status [-c|--cached]]|init|update] [--]]]  [<path>...]]|[recurse [-i|--initialize] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-df|--depth-first] <command> [<arguments> ...]]'

I commented on the overlong USAGE and also not-so-useful comments that
would only hurt maintainability in the previous message.  The comment you
have above would look reasonably good in LONG_USAGE without leading "#",
don't you think?

> +# This module simply checks whether the depth is traverseable

s/module/function/; I wouldn't nitpick like this, but in the context of
"git-submodule", saying "module" when you do not mean the _module_ you are
working on is misleading.

> +# This actually traverses a module; checks
> +# whether the module is initialized or not.
> +# if not initialized, then tries to do so 
> +# based on the user preference and then the
> +# intended command is evaluated in the 
> +# traversal manner requested - breadth first 
> +# or depth first. Then it# recursively goes 
> +# into it modules.

Overnarrow lines are harder to read as well as overlong ones...

> +traverse_module()
> +{
> +	# Will work in the module if and only if the module is initialized
> +	initialize_sub_module "$1" &&
> +	(
> +		submod_path="$1"
> +		shift
> +		cd "$submod_path"
> +		# If depth-first is specified in that case submodules are
> +		# are traversed before executing the command on this module
> +		test -n "$depth_first" && traverse_submodules "$@"
> +		# pwd is mentioned in order to enable the ser to distinguish
> +		# between same name modules, e.g. a/lib and b/lib.
> +		say "Working in mod $submod_path" @ `pwd` "with $@ ($#)"

This feels more like a debug message than progress report useful for the
end users.  Perhaps:

	say "git submodule recurse $submod_path $*"

(which is modeled after how "diff -r" repeats itself) would be enough.

By the way, please make it the habit of using $@ only when you are asking
for the magic field splitting with "$@"; interpolating all params inside a
single string should be done with "$*".  say() happens to take multiple
parameters, so your code happens to work Ok, but it is error prone; I do
not think you deliberately tried to send multiple parameters to the above
"say" by using "$@", knowing what this piece of code would do:

	frotz () {
        	echo $#; for i; do echo $i; done
	}
	set b c d
        frotz "a $@ e"

> +		cmd_status=
> +		git "$@" || cmd_status=1
> +		# if exit on error is specifed than script will exit if any
> +		# command fails. As there is no transaction there will be
> +		# no rollback either
> +		# TODO - If possible facilitate transaction

You can test $? here without $cmd_status.

> +		if  test -n "$cmd_status" && test -n "$on_error"

Excess SP between "if test".

> +		then
> +			die "git $@ failed in module $submod_path @ $(pwd)"

Same issue with $@ vs $*, and excess $submod_path vs the remainder cruft.

If the issue you wanted to solve with $(pwd) was that $submod_path is a
local path within the current submodule, a better way to solve it would be
to pass another "full path from the top" around when recursing into a new
sublevel.

> +# Propagates or recurses over all the submodules at any
> +# depth with any git command, e.g. git-clone, git-status,
> +# git-commit etc., with the arguments supplied exactly as
> +# it would have been supplied to the command otherwise.
> +# This actually starts the recursive propagation
> +cmd_recurse() {
> +	while :
> +	do
> ...
> +			elif test "$(expr $1 : '[1-9][0-9]*')" -eq "$(expr $1 : '.*')"

What is this doing?  $1 is underquoted here, by the way.

> +		-df|--depth-first)
> +			depth_first=1
> +			;;

Single dash followed by two letters is a somewhat unconventional option
flag.

> +		-ca|--customized-argument)
> +			use_custom_args=1
> +			;;

Who uses this and other options?  The series seems to be split
incorrectly.

> +	project_home="$(pwd)"
> +	if test "$depth" -gt 0
> +	then
> +		say Command will recurse upto "$depth" depth
> +	fi
> +	if test -d "$project_home"/.git/
> +	then
> +		say "Command to recurse: git $@"
> +		traverse_module . "$@"

These "say" are too noisy, compared to other existing uses.  It feels as
if the command is being run with --debug option.

> @@ -441,3 +598,4 @@ then
>  fi
>  
>  "cmd_$command" "$@"
> +

Adds trailing blank line.
