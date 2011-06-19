From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] branch: add optional parameter to -r to specify
 remote
Date: Sun, 19 Jun 2011 15:32:55 -0700
Message-ID: <7vtyble9k8.fsf@alter.siamese.dyndns.org>
References: <1308511149-10933-1-git-send-email-billiob@gmail.com>
 <1308511149-10933-2-git-send-email-billiob@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Boris Faure <billiob@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 00:33:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYQYF-0000KW-Ge
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 00:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab1FSWc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 18:32:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55448 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729Ab1FSWc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 18:32:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE26D6740;
	Sun, 19 Jun 2011 18:35:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rx9FMLb2jTthtuXBebamN91p8VA=; b=RmANxN
	QMmkTb6oMVUIjK1QpHmaqOKbKKjEKOqrqNnLQkw1jYW/+SeMlpsXhPlXEchuJeJN
	dN3Zo06Hm3GwuO0rO9E012cYbVXR/jJp2Qn0+i5gWXSdC9lBi43GYjTqJ4oQ3pRs
	wHTKJ8mKAv+jHpd6UuqxNfV3vOSSmmugJuezM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w1JKD5xSvukRGjx9CviSY5XNQyVXb2uH
	z8jUytPy33pFcv1bIAccKXuVgYqWyGotKM7zDp66YnGNuBIPh0CWI2Eu2kuKZq+8
	RxxBpDcFZSarmJ5cvIxcPXDDTPm5mgoNkNSyZohI5/SQNrR3iTnpzAyoRomZWeGX
	iyMy1ZbftmE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D746E673F;
	Sun, 19 Jun 2011 18:35:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D5B6A673D; Sun, 19 Jun 2011
 18:35:07 -0400 (EDT)
In-Reply-To: <1308511149-10933-2-git-send-email-billiob@gmail.com> (Boris
 Faure's message of "Sun, 19 Jun 2011 21:19:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 628DD760-9AC4-11E0-AF9A-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176035>

Boris Faure <billiob@gmail.com> writes:

> add '--remote' as long version for '-r'
> update documentation
> add tests

(style) Sentences begin with a capital letter and ends with a period.

This commit does a lot more than the above, no? It adds an optional remote
name parameter to the existing "-r" option and limits the output to the
remote tracking branches of the remote when it is specified.

> ---

Sign-off?

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index c50f189..242da9c 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> ...
> @@ -99,8 +99,10 @@ OPTIONS
>  	default to color output.
>  	Same as `--color=never`.
>  
> --r::
> -	List or delete (if used with -d) the remote-tracking branches.
> +-r[=<remote>]::
> +--remote[=<remote>]::
> +	List or delete (if used with -d) the remote-tracking branches from
> +	<remote> if specified.

It is now unspecified what the command would do when the optional <remote>
is left unspecified.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index d6ab93b..52dff04 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -17,15 +17,18 @@
>  #include "revision.h"
>  
>  static const char * const builtin_branch_usage[] = {
> -	"git branch [options] [-r | -a] [--merged | --no-merged]",
> +	"git branch [options] [-r[=<remote>] | -a] [--merged | --no-merged]",
>  	"git branch [options] [-l] [-f] <branchname> [<start-point>]",
> -	"git branch [options] [-r] (-d | -D) <branchname>",
> +	"git branch [options] [-r[=<remote>]] (-d | -D) <branchname>",
>  	"git branch [options] (-m | -M) [<oldbranch>] <newbranch>",
>  	NULL
>  };
>  
>  #define REF_LOCAL_BRANCH    0x01
>  #define REF_REMOTE_BRANCH   0x02
> +static int kinds = REF_LOCAL_BRANCH;

This used to be nicely scoped out of global space and got passed around as
parameter, but now it has become a global? I do not see a good reason for
this change.

> +static const char *remote = NULL;

Two issues.

 1. Presumably you wanted to have this change because you have too many
    remotes, way more than two, and wanted to filter the output from
    remotes that you are not interested in. Is it entirely implausible
    that you might be interested in not just one, but two remotes out of
    many remotes you have? A single string variable would not suffice for
    that but you should be able to make this an array of strings.

 2. The name suck for a global variable (same for the "kinds" that is now
    global), and caused the patch to become unnecessarily big by renaming
    concisely named "remote" to ugly "remote_trans" in delete_branches()
    function. In general, local variables are scoped narrower and readers
    can rely on the context to tell what the variable is _for_, so it is
    easy for them to see a variable called "remote" and understand what
    aspects of "remote" the variable is trying to express. On the other
    hand, global variables are used in wider context and has to have more
    descriptive names.  This is about "filtering" set of remote tracking
    branches we deal with to the subset specified by this variable, so it
    at least has to have "filter" or "limit" or something to that effect
    in its name.

> @@ -144,12 +147,12 @@ static int branch_merged(int kind, const char *name,
>  	return merged;
>  }
>  
> -static int delete_branches(int argc, const char **argv, int force, int kinds)
> +static int delete_branches(int argc, const char **argv, int force)
>  {
>  	struct commit *rev, *head_rev = NULL;
>  	unsigned char sha1[20];
>  	char *name = NULL;
> -	const char *fmt, *remote;
> +	const char *fmt, *remote_trans;

Unwarranted change caused by a poor choice of the new global variable
above.

> @@ -610,13 +631,28 @@ static int opt_parse_merge_filter(const struct option *opt, const char *arg, int
>  	return 0;
>  }
>  
> +static int parse_opt_remote_cb(const struct option *opt, const char *arg,
> +			       int unset)
> +{
> +	kinds = REF_REMOTE_BRANCH;
> +	if (unset)
> +		kinds = REF_LOCAL_BRANCH;

What is this "unset" check about? Wouldn't that be an error if the command
line said "--no-remote"?

And you do not return but proceed to look at "arg", presumably to handle a
case where the command line said "--no-remote=foobar"?

> +	if (arg) {
> +		if ( *arg == '=')

(style) Unwanted SP after an open parenthesis.

> +			remote = arg + 1; /* skip '=' */

(style) It is clear enough what this does without the extra comment.

Does this forbid remote names that begin with a "="?  I.e.

	$ git branch -r =temporary

As to the design of the new feature, I see you tried to make it possible
to perform what

	$ git branch -d -r origin/master

does with

	$ git branch -d --remote=origin master

I do not think it is particularly a good idea. Adding yet another way to
do the same thing, unless that new way is vastly superiour (e.g. easier to
use, easier to explain, more efficient to perform, etc.), does not add
much value to the system.

It would make much more sense to restrict this feature to the "listing"
side of the branches.  It would be nice if you can do:

	$ git branch -r --match alice --match bob

to show only remote tracking branches under refs/remotes/{alice,bob}
and also

	$ git branch --match "jk/*"

to show only local topic branches whose names match the given blob.
