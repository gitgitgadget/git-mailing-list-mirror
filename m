From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-v3 4/4] git-commit: add a prepare-commit-msg hook
Date: Tue, 05 Feb 2008 23:22:45 -0800
Message-ID: <7v1w7q4khm.fsf@gitster.siamese.dyndns.org>
References: <E1JMe6e-0004HH-Uq@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 08:23:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMed8-0000zQ-Qv
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 08:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758205AbYBFHW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 02:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758152AbYBFHW5
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 02:22:57 -0500
Received: from rune.pobox.com ([208.210.124.79]:56276 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758128AbYBFHW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 02:22:56 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 1A294192157;
	Wed,  6 Feb 2008 02:23:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8DB9719217C;
	Wed,  6 Feb 2008 02:23:09 -0500 (EST)
In-Reply-To: <E1JMe6e-0004HH-Uq@fencepost.gnu.org> (Paolo Bonzini's message of
	"Wed, 06 Feb 2008 01:50:04 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72763>

Paolo Bonzini <bonzini@gnu.org> writes:

> The prepare-commit-msg hook is run whenever a "fresh" commit message
> is prepared, just before it is shown in the editor (if it is).
> It can modify the commit message in-place and/or abort the commit.
>
> It takes two parameters.  The first is the source of the commit
> message, and can be: `message' (if a -m or -F option was
> given); `template' (if a -t option was given or the
> configuration option commit.template is set); `merge' (if the
> commit is a merge or a .git/MERGE_MSG file exists); `squash'
> (if a .git/SQUASH_MSG file exists); or a commit SHA1 (if a
> -c, -C or --amend option was given).  The second
> parameter if the name of the file that the commit log message.
>
> If the exit status is non-zero, `git-commit` will abort.
> The hook is not suppressed by the --no-verify option, and
> this is the only hook that can abort a commit if --no-verify is
> given.

I doubt the last two lines should be said.  What it says is
correct, but that is because we happen to have only two hooks
that are not at all about validation (after this patch is
applied), and the other one is post-commit that is _defined_ to
ignore the error.  It should be the norm for hook failure to
abort the execution of the main command.

> Signed-off-by: Paolo Bonzini <bonzini@gnu.org>

Good.  The earlier three patches lacked S-o-b.

> diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
> index e8d80cf..6df5c42 100644
> --- a/Documentation/hooks.txt
> +++ b/Documentation/hooks.txt
> @@ -55,7 +55,8 @@ This hook is invoked by `git-commit`, and can be bypassed
>  with `\--no-verify` option.  It takes no parameter, and is
>  invoked before obtaining the proposed commit log message and
>  making a commit.  Exiting with non-zero status from this script
> -causes the `git-commit` to abort.
> +causes the `git-commit` to abort.  This hook can also modify
> +the index.
>  
>  The default 'pre-commit' hook, when enabled, catches introduction
>  of lines with trailing whitespaces and aborts the commit when

This hunk is a good documentation fix but does not belong to the
series.

> @@ -65,6 +66,37 @@ All the `git-commit` hooks are invoked with the environment
>  variable `GIT_EDITOR=:` if the command will not bring up an editor
>  to modify the commit message.
>  
> +prepare-commit-msg
> +------------------
> +
> +This hook is invoked by `git-commit` right after preparing the
> +default log message, and before the editor is started.
> +
> +It takes two parameters.  The first is the source of the commit
> +message, and can be: `message` (if a `\-m` or `\-F` option was
> +given); `template` (if a `\-t` option was given or the
> +configuration option `commit.template` is set); `merge` (if the
> +commit is a merge or a `.git/MERGE_MSG` file exists); `squash`
> +(if a `.git/SQUASH_MSG` file exists); or a commit SHA1 (if a
> +`\-c`, `\-C` or `\--amend` option was given).  The second
> +parameter if the name of the file that the commit log message.

The second parameter "is"???

I suspect "or a commit SHA1" is a wrong interface.  Wouldn't it
be much easier for the hook to parse its arguments if you give a
token "commit" and the commit object name as separate arguments?

> +If the exit status is non-zero, `git-commit` will abort.
> +The hook is not suppressed by the `\--no-verify` option, and
> +this is the only hook that can abort a commit if `\--no-verify`
> +is given.

I'd suggest removing ", and this is.....given".

> +The hook is allowed to edit the message file in place, and
> +can be used to augment the default commit message with some
> +project standard information.

"with some project standard information."  Is that something you
need to say here?  It is allowed to augment the default commit
message in _any way_, isn't it?

> +It can also be used for the same
> +purpose as the pre-commit message, if the verification has
> +to be skipped for automatic commits (e.g. during rebasing).

As we seem to have agreed to make its exit status matter, it
cannot be used for that.  A non-zero exit from the script is an
error and not verification failure.

> +The default 'prepare-commit-msg' hook adds a Signed-off-by line
> +(doing it with a hook is not necessarily a good idea, but doing
> +it in 'commit-msg' is worse because you are not reminded in
> +the editor).

I am moderately opposed to call something that blindly adds
S-o-b "the default".  S-o-b should be a conscious choice.  I am
Ok with an "example" for people whose work contract says "what I
write is always Open Source", but that is far from the norm, so
it can hardly be the default nor necessarily is a good example.

Perhaps we can add diffstat with '#' prefix as an example, like
this, instead?

	#!/bin/sh
	# Note that this needs to be tightened to deal with the root
	# commit sensibly.
	git diff --name-status HEAD -- >>"$1"

> diff --git a/templates/hooks--commit-msg b/templates/hooks--commit-msg
> index c5cdb9d..4ef86eb 100644
> --- a/templates/hooks--commit-msg
> +++ b/templates/hooks--commit-msg
> @@ -9,6 +9,9 @@
>  # To enable this hook, make this file executable.
>  
>  # Uncomment the below to add a Signed-off-by line to the message.
> +# Doing this in a hook is a bad idea in general, but the prepare-commit-msg
> +# hook is more suited to it.
> +#
>  # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
>  # grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"

And this is a good change.
