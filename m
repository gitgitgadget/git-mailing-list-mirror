From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Teach git to change to a given directory using -C option
Date: Tue, 03 Sep 2013 15:46:00 -0700
Message-ID: <xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
References: <20130903115944.GA29542@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 00:46:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGzMX-0004QY-GB
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 00:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760732Ab3ICWqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 18:46:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53152 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754287Ab3ICWqM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 18:46:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CBF53E2AA;
	Tue,  3 Sep 2013 22:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=dE6OutcgPgIWgJjpqXIfURATNEA=; b=LfLAIttklHZhQgfqcJW2
	gk2IWF0njkv+zHmLQOOMiJaGemoihaUIjESmkxqoKHvc3iKkmAx9KIz1zqcaeO4i
	J63EJKciRaEy0CrHInMMmL+DxH0zChtA+SRKF+QhrY4nr9eOAXtrcv5+1E0gzJFO
	PAWuac5tJ1Tzu7JZaykJ0yE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Jl+HoeiF5vI/u2YwUYCYiox97GLs37D/A93YCroKwZlb1w
	BPymR81fF8yHjkAx9uhsuE3XcFsuSZonqoyBPhMO/ZeS3gM2+ANCHUKGenlp6agx
	csYBzw5obBqxZBzaW+DtcL7BJHPoM60KXlmtAA0XC7QNRAWcqiViRor8ROoe0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD8D43E29A;
	Tue,  3 Sep 2013 22:46:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D7C73E27D;
	Tue,  3 Sep 2013 22:46:06 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9F5C44C2-14EA-11E3-A2F0-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233792>

Nazri Ramliy <ayiehere@gmail.com> writes:

> -- >8 --
> Subject: [PATCH] Teach git to change to a given directory using -C option
>
> This is similar in spirit to to "make -C dir ..." and "tar -C dir ...".
>
> Currently it takes more effort (keypresses) to invoke git command in a
> different directory than the current one without leaving the current
> directory:
>
>     1. (cd ~/foo && git status)
>        git --git-dir=~/foo/.git --work-dir=~/foo status
>        GIT_DIR=~/foo/.git GIT_WORK_TREE=~/foo git status
>     2. (cd ../..; git grep foo)
>     3. for d in d1 d2 d3; do (cd $d && git svn rebase); done
>
> While doable the methods shown above are arguably more suitable for
> scripting than quick command line invocations.
>
> With this new option, the above can be done with fewer keystrokes:
>
>     1. git -C ~/foo status
>     2. git -C ../.. grep foo
>     3. for d in d1 d2 d3; do git -C $d svn rebase; done
>
> A new test script is added to verify the behavior of this option with
> other path-related options like --git-dir and --work-tree.
>
> Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
> ---

Thanks; will tentatively queue on 'pu' with some rephrasing of the
log message, but I have a few comments.

>  Documentation/git.txt | 16 +++++++++-
>  git.c                 | 15 ++++++++--
>  t/t0056-git-C.sh      | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 110 insertions(+), 3 deletions(-)
>  create mode 100755 t/t0056-git-C.sh
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 83edf30..6105cb0 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -9,7 +9,7 @@ git - the stupid content tracker
>  SYNOPSIS
>  --------
>  [verse]
> -'git' [--version] [--help] [-c <name>=<value>]
> +'git' [--version] [--help] [-C <path>] [-c <name>=<value>]

I do not care too deeply either way, but I am curious if there was a
reason why you changed the earlier <directory> to <path>?  Somehow,
when we _know_ a path has to be a directory, I find it easier on the
readers to spell that out, instead of saying "this is a path",
implying that it could be a directory, a regular file, or even
non-existent.

>      [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
>      [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
>      [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
> @@ -395,6 +395,20 @@ displayed. See linkgit:git-help[1] for more information,
>  because `git --help ...` is converted internally into `git
>  help ...`.
>  
> +-C <path>::
> +	Run as if git was started in <path> instead of the current working
> +	directory.  When multiple -C options are given, each subsequent
> +	non-absolute "-C <path>" is interpreted relative to the preceding "-C
> +	<path>".
> +
> +	This option affects options that expect path name like --git-dir and
> +	--work-tree in that their interpretations of the path names would be
> +	made relative to the working directory caused by the -C option. For
> +	example the following invocations are equivalent:
> +
> +	    git --git-dir=a.git --work-tree=b -C c status
> +	    git --git-dir=c/a.git --work-tree=c/b status
> +

Does the above format correctly without the usual "second and
subsequent paragraphs are not indented, but has '+' in place of
a blank line"?

> diff --git a/git.c b/git.c
> index 2025f77..52bce74 100644
> --- a/git.c
> +++ b/git.c
> @@ -7,7 +7,7 @@
>  #include "commit.h"
>  
>  const char git_usage_string[] =
> -	"git [--version] [--help] [-c name=value]\n"
> +	"git [--version] [--help] [-C <path>] [-c name=value]\n"
>  	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
>  	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
>  	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
> @@ -54,7 +54,18 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  		/*
>  		 * Check remaining flags.
>  		 */
> -		if (!prefixcmp(cmd, "--exec-path")) {
> +		if (!strcmp(cmd, "-C")) {
> +			if (*argc < 2) {
> +				fprintf(stderr, "No directory given for -C.\n" );
> +				usage(git_usage_string);
> +			}
> +			if (chdir((*argv)[1]))
> +				die_errno("Cannot change to '%s'", (*argv)[1]);
> +			if (envchanged)
> +				*envchanged = 1;
> +			(*argv)++;
> +			(*argc)--;
> +		} else if (!prefixcmp(cmd, "--exec-path")) {

We usually do not prepend to an existing if/else if/ chain unless
there is a very good reason (e.g. the new "if" condition is very
often triggered and we are better off checking it early) exactly
because doing so would make a patch that is ugly like the above.
You are not touching the codepath that deal with --exec-path, but
the resulting patch makes it appear as if you are doing something to
it.
