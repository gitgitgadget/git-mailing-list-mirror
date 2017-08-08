Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BDA920899
	for <e@80x24.org>; Tue,  8 Aug 2017 20:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752347AbdHHU4P (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 16:56:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52692 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752205AbdHHU4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 16:56:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38C3C963CE;
        Tue,  8 Aug 2017 16:56:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jhbea4Cvqw+azuiExWdErtZx5h0=; b=T1PjZK
        +BqjcdzIUe4cihMONYKaDOdlbf9BWasQI53C/Wf7o7xx5CWsZjBkb69wF0uOpmRQ
        0a8hXw12s+qkvtwBfsnRjj2qVQ4MkgETfpO5KF1qtU713wmk4M/WVZsuhBjk8dKK
        us3Tc4gTUh7ae9JfY7YZKc5lOX00zM2+w5VN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HXJPoiFE+RgPboeC9V71VBJ0GyZONs31
        svPfUGzNBg+d6Jxhsl5N67R9r6jDTj0xO/BerJQv0V0Zw+NBNoPtb5TImoI9GfU5
        C6pFyPIKauePLwYFHPQOUIItRmXOlhhewf8CIY0gE5mXmK1TtRo3wgPnmLz7ScOM
        nfo6w4knbe8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31044963CD;
        Tue,  8 Aug 2017 16:56:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85DF8963CA;
        Tue,  8 Aug 2017 16:56:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ian Campbell <ijc@hellion.org.uk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] filter-branch: Add --state-branch to hold pickled copy of ref map
References: <1502179560.2735.22.camel@hellion.org.uk>
        <20170808080620.9536-1-ijc@hellion.org.uk>
Date:   Tue, 08 Aug 2017 13:56:05 -0700
In-Reply-To: <20170808080620.9536-1-ijc@hellion.org.uk> (Ian Campbell's
        message of "Tue, 8 Aug 2017 09:06:19 +0100")
Message-ID: <xmqq4lthbwyi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF637636-7C7B-11E7-9F72-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Campbell <ijc@hellion.org.uk> writes:

> Allowing for incremental updates of large trees.

"by doing what" is missing.  And ...

>
> I have been using this as part of the device tree extraction from the Linux
> kernel source since 2013, about time I sent the patch upstream!

... this does not help understanding what is going on.  It belongs
to the space after three dashes.

Perhaps

	Subject: filter-branch: stash away ref map in a branch

	With "--state-branch=<branchname>" option, the mapping from
	old object names and filtered ones in ./map/ directory is
	stashed away in the object database, and the one from the
	previous run is read to populate the ./map/ directory,
	allowing for incremental updates of large trees.

or something?

>
> Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
> ---
>  git-filter-branch.sh | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 3a74602ef..d07db3fee 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -86,7 +86,7 @@ USAGE="[--setup <command>] [--env-filter <command>]
>  	[--parent-filter <command>] [--msg-filter <command>]
>  	[--commit-filter <command>] [--tag-name-filter <command>]
>  	[--subdirectory-filter <directory>] [--original <namespace>]
> -	[-d <directory>] [-f | --force]
> +	[-d <directory>] [-f | --force] [--state-branch <branch>]
>  	[--] [<rev-list options>...]"
>  
>  OPTIONS_SPEC=
> @@ -106,6 +106,7 @@ filter_msg=cat
>  filter_commit=
>  filter_tag_name=
>  filter_subdir=
> +state_branch=
>  orig_namespace=refs/original/
>  force=
>  prune_empty=
> @@ -181,6 +182,9 @@ do
>  	--original)
>  		orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/
>  		;;
> +	--state-branch)
> +		state_branch="$OPTARG"
> +		;;
>  	*)
>  		usage
>  		;;
> @@ -252,6 +256,20 @@ export GIT_INDEX_FILE
>  # map old->new commit ids for rewriting parents
>  mkdir ../map || die "Could not create map/ directory"
>  
> +if [ -n "$state_branch" ] ; then
> +	state_commit=`git show-ref -s "$state_branch"`

I hate to nitpick styles, especially on this script that already has
existing violations, but for completeness:

Style: we prefer to write $(command substitution) instead.
Style: we prefer to write "if test", not "if [".
Style: we prefer to avoid ';' and write "if test condtion" and
       "then" on different lines.

It is a bit curious use of "show-ref".  It is not wrong per-se, but
"git rev-parse" may be more common.  I do not care too deeply either
way, though.

Don't we want to make sure the value given to --state-branch is a
full refname, not just a branch name?  What happens when you say 

	filter-branch --state-branch master

by mistake?  "show-ref -s" is likely to show your refs/heads/master,
and other master branches that appear as remote-tracking branches for
the remotes you interact with.

> +	if [ -n "$state_commit" ] ; then
> +		echo "Populating map from $state_branch ($state_commit)" 1>&2
> +		git show "$state_commit":filter.map |
> +		    perl -n -e 'm/(.*):(.*)/ or die;
> +				open F, ">../map/$1" or die;
> +				print F "$2" or die;
> +				close(F) or die'

The process calling this perl script, which carefully diagnoses
malformed input and dies, does not seem to do anything when it sees
errors.  Intended?

> +	else
> +		echo "Branch $state_branch does not exist. Will create" 1>&2
> +	fi
> +fi
> +
>  # we need "--" only if there are no path arguments in $@
>  nonrevs=$(git rev-parse --no-revs "$@") || exit
>  if test -z "$nonrevs"
> @@ -544,6 +562,25 @@ if [ "$filter_tag_name" ]; then
>  	done
>  fi
>  
> +if [ -n "$state_branch" ] ; then
> +	echo "Saving rewrite state to $state_branch" 1>&2
> +	STATE_BLOB=$(ls ../map |
> +	    perl -n -e 'chomp();
> +			open F, "<../map/$_" or die;
> +			chomp($f = <F>); print "$_:$f\n";' |

I see it somewhat gross to pipe the output of "/bin/ls" to a Perl
script, instead of iterating over "while (<../map/*>)" inside the
script itself.

> +	    git hash-object -w --stdin )
> +	STATE_TREE=$(/bin/echo -e "100644 blob $STATE_BLOB\tfilter.map" | git mktree)
> +	STATE_PARENT=$(git show-ref -s "$state_branch")

Don't you already have this in $state_commit?

One advantage of reading $state_branch again at this point is to
detect mistakes of running more than one filter-branch (which may
cause you to read $STATE_PARENT that is different from $state_commit
you read earlier), but I do not think that is being done here, so...

> +	unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
> +	unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL GIT_COMMITTER_DATE

Hmph.  I can see that you are trying not to be affected by the
committers and authors of the commits on the branch being filtered
(which are set by finish_ident shell function), but I wonder if we
could (and more importantly "want to") do better to preserve the
real committer the user who runs the script may have in the
environment before running it.  I guess it does not matter that
much, as long as the user has properly user.{name,email} configured
elsewhere without relying on the environment variable.

> +	if [ -n "$STATE_PARENT" ] ; then
> +	    STATE_COMMIT=$(/bin/echo "Sync" | git commit-tree "$STATE_TREE" -p "$STATE_PARENT")
> +	else
> +	    STATE_COMMIT=$(/bin/echo "Sync" | git commit-tree "$STATE_TREE" )
> +	fi
> +	git update-ref "$state_branch" "$STATE_COMMIT"
> +fi
> +
>  cd "$orig_dir"
>  rm -rf "$tempdir"

Despite all the above comments, I like what you are trying to
achieve here.  Thanks for sharing.
