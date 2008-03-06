From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] - Added pre command and custom argument support to git
 submodule recurse command
Date: Thu, 06 Mar 2008 02:42:25 -0800
Message-ID: <7vlk4w9lri.fsf@gitster.siamese.dyndns.org>
References: <1204788817-22720-1-git-send-email-imyousuf@gmail.com>
 <1204788817-22720-2-git-send-email-imyousuf@gmail.com>
 <1204788817-22720-3-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 06 11:43:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXDZU-0007fc-Ga
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 11:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757452AbYCFKmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 05:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757448AbYCFKmi
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 05:42:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757266AbYCFKmh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 05:42:37 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 47B04181B;
	Thu,  6 Mar 2008 05:42:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 47949181A; Thu,  6 Mar 2008 05:42:32 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76368>

imyousuf@gmail.com writes:

> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>
> There is one scenario that has been put forward several times in
> discussion over the recurse command - it is that commands can have
> different arguments for different modules. For example for the same example
> mentioned above, one wants to check a_1 for submdoule a, while it wants to
> checkout d_2 for d. It can be achieved by using [-ca|--customized-argument].

Read this again, notice "for the same example mentioned above", and go
"Huh?"

> This results the script to prompt for user input, which will be passed as
> argument to the command for that module.
> 	git submodule recurse -ca checkout
> 	Working in mod a .......
> 	Please provide arguments for this module: a_1
> 	Working in mod d .......
> 	Please provide arguments for this module: a_1

Again, a blank line before the displayed script like this would make it
easier to read.

A single dash with two letters for an option name is somewhat
unconventional.  Shouldn't this be called interactive arguments, by the
way?

> It is usually helpful that when typing a command, being able to see some options
> come in handy. For example if I can see the available branches before checking
> out a branch that would be useful, IOW, if one could git branch before git
> checkout; it is now possible using the [-p|--pre-command] option. Using this
> command you can actually execute other git commands before specifying the
> arguments to the original command. E.g. if the above command is changed to,
> 	git submodule recurse -ca -p checkout
> it will prompt the user for the pre command until one is satisfied and later
> the user can actually use them in the argument.

Btw, can we please try to keep commit log messages readable?

The above "blob of text" could/should have more structure than being just 
one big block, and could have been structured as a few shorter paragraphs 
to make it easier to read.

I don't know about you guys, but I read a *lot* of emails (and commit
messages), and I hate seeing big blobs of text without structure. Give it
a few breaks to make it easier to read, like just making new paragraphs,
i.e. something like:

> When typing a command, being able to see some options come in handy.
> For example, if a command asks for an option to "git checkout", being
> able to run "git branch" to see what branches exist before answering
> might help the user.
>
> "git submodule recurse" allows this with the [-p|--pre-command]
> option. With this option, you can actually execute other git commands
> before specifying the arguments to the original command. E.g. if the
> above command is changed to:
>
>     git submodule recurse -ca -p checkout
>
> it will prompt the user for the pre command until one is satisfied and
> later the user can actually use them in the argument.

and now you have a bit of a breather space and some visual cues for where
you are in the text.

Yeah, maybe it's just me, but I like my whitespace. Ihaveareallyhardtime
readingtextthatdoesn'thavethepropermarkersforwhereconceptsstartandbegin, 
andthatreallydoesincludetheverticalwhitespacetoo.

By the way, I do not find your example particularly convincing.

> +do_pre_command()
> +{
> +	say "Starting pre-comamnd execution!"
> +	while :
> +	do
> +		(
> +			read -p "Please provide a git command: " pre_command

"read -p"?  That's not even in POSIX.  Please don't.

> +			test -z "$pre_command" || git "$pre_command"

I am not convinced.  Why do you limit it only to a git command?  Why do
you limit it only to a git command that does not take any parameters?  How
is this more useful over \C-z and returning to a shell, or examining the
situation in a different window/screen?

> +}
> +
> +# Take arguments from user to pass as custom arguments
> +get_custom_args()
> +{
> +	read -p "Please provide arguments for this module: " custom_args
> +}

Contrary to its name, it reads a _single_ argument,...

>  # Initializes the submodule if already not initialized
>  # and auto initialize is enabled
>  initialize_sub_module()
> @@ -460,8 +484,10 @@ traverse_module()
>  		# pwd is mentioned in order to enable the ser to distinguish
>  		# between same name modules, e.g. a/lib and b/lib.
>  		say "Working in mod $submod_path" @ `pwd` "with $@ ($#)"
> +		test -n "$pre_cmd" && do_pre_command
> +		test -n "$use_custom_args" && get_custom_args
>  		cmd_status=
> -		git "$@" || cmd_status=1
> +		git "$@" "$custom_args" || cmd_status=1

... and passes it as a single argument.

The overall structure of recursing into and running arbitrary commands
inside each submodule might be useful, but the implementation feels rather
too limiting.

Come to think of it, does it really matter that the command you run by
recursing into them is limited to "git-foo" command?  I do not see you are
taking advantage of it being a git command, so it feels like an arbitrary
restriction to me, too.

