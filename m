From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] rebase: learn to rebase root commit
Date: Thu, 01 Jan 2009 13:00:46 -0800
Message-ID: <7v4p0iivwh.fsf@gitster.siamese.dyndns.org>
References: <200812301323.30550.trast@student.ethz.ch>
 <7b2902d36a4790670f20f786d4ea2e26052a6e71.1230639970.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 01 22:02:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIUgM-0005jH-Da
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 22:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbZAAVAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 16:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbZAAVAx
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 16:00:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbZAAVAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 16:00:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BEDA48C14E;
	Thu,  1 Jan 2009 16:00:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BA71A8C14C; Thu,
  1 Jan 2009 16:00:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4548FDA2-D847-11DD-8A94-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104323>

Thomas Rast <trast@student.ethz.ch> writes:

> Teach git-rebase a new option --root, which instructs it to rebase the
> entire history leading up to <branch>.
>
> The main use-case is with git-svn: suppose you start hacking (perhaps
> offline) on a new project, but later notice you want to commit this
> work to SVN.  You will have to rebase the entire history, including
> the root commit, on a (possibly empty) commit coming from git-svn, to
> establish a history connection.  This previously had to be done by
> cherry-picking the root commit manually.

I like what this series tries to do.  Using the --root option is probably
a more natural way to do what people often do with the "add graft and
filter-branch the whole history once" procedure.

But it somewhat feels sad if the "main" use-case for this is to start your
project in git and then migrate away by feeding your history to subversion
;-).

> @@ -344,17 +348,23 @@ case "$diff" in
>  	;;
>  esac
>  
> +if test -z "$rebase_root"; then
>  # The upstream head must be given.  Make sure it is valid.
> -upstream_name="$1"
> -upstream=`git rev-parse --verify "${upstream_name}^0"` ||
> -    die "invalid upstream $upstream_name"
> +	upstream_name="$1"
> +	shift
> +	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
> +	die "invalid upstream $upstream_name"
> +fi
> +
> +test ! -z "$rebase_root" -a -z "$newbase" &&
> +	die "--root must be used with --onto"

This is much easier to read if it were:

	if test -z "$rebase_root"
        then
        	... do the upstream_name/upstream thing, such as
                upstream_name="$1"
                ...
	else
        	... do the rebase_root thing, including
                unset upstream
                unset upstream_name
                test -z "$newbase" && die "--root without --onto"
                ...
	fi

(Mental note.  You shifted positional parameters and the remainders need
to be adjusted, which you seem to have done).

>  # Make sure the branch to rebase onto is valid.
>  onto_name=${newbase-"$upstream_name"}
>  onto=$(git rev-parse --verify "${onto_name}^0") || exit
>  
>  # If a hook exists, give it a chance to interrupt
> -run_pre_rebase_hook ${1+"$@"}
> +run_pre_rebase_hook ${upstream_name+"$upstream_name"} "$@"

I do not think ${upstream_name+"$upstream_name"} is a good check to begin
with, because presense of it does not necessarily mean the command was
invoked without --root; it could have come from the environment of the
invoker (hence the suggestion to unset the variable explicitly).

And I do not think this is a good way to extend the calling convention of
the hook, either.  pre-rebase-hook used to always take upstream and
optionally the explicit branch name.  When --root is given, your code will
give the hook a single parameter which is the explicit branch name
(i.e. "we will switch to this branch and rebase it, are you Ok with it?"),
but the hook will mistakenly think you are feeding the fork-point commit.

Because an old pre-rebase-hook cannot verify --root case correctly anyway
and needs to be updated, how about doing 'run_pre_rebase_hook --root "$@"'
when --root was given?

> @@ -393,7 +403,8 @@ case "$#" in
>  esac
>  orig_head=$branch
>  
> -# Now we are rebasing commits $upstream..$branch on top of $onto
> +# Now we are rebasing commits $upstream..$branch (or simply $branch
> +# with --root) on top of $onto

"or simply everything leading to $branch if --root is given"?

>  # Check if we are already based on $onto with linear history,
>  # but this should be done only when upstream and onto are the same.
> @@ -429,10 +440,18 @@ then
>  	exit 0
>  fi
>  
> +if test ! -z "$rebase_root"; then
> +	revisions="$orig_head"
> +	fp_flag="--root"
> +else
> +	revisions="$upstream..$orig_head"
> +	fp_flag="--ignore-if-in-upstream"
> +fi

Hmph, the reason why --ignore-if-in-upstream is irrelevant when --root is
given is because...?

> diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
> new file mode 100755
> index 0000000..63ec5e6
> --- /dev/null
> +++ b/t/t3412-rebase-root.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +
> +test_description='git rebase --root
> ...
> +test_done

Including tests for the pre-rebase-hook would be nice.
