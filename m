From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not ignore merge options in interactive rebase
Date: Tue, 25 Jun 2013 10:04:58 -0700
Message-ID: <7v61x23yv9.fsf@alter.siamese.dyndns.org>
References: <87bo70dokb.fsf@duckcorp.org>
	<7vr4fvkxew.fsf@alter.siamese.dyndns.org>
	<87bo6wyn0z.fsf@duckcorp.org> <87ppvcx84r.fsf@duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Arnaud Fontaine <arnau@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 19:05:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrWg2-0002ID-BU
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 19:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208Ab3FYRFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 13:05:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65019 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab3FYRFB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 13:05:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEFCE2876B;
	Tue, 25 Jun 2013 17:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=24Pv2m9ZnSnoY+Roft/rgJTw4/A=; b=PmXYxe
	buQxAOqEfcuLkmCcRpY0jwtZxpDVTXGHcrQ75uMYrN4BOxDv98hyNjJAYkkCJYbF
	corNd7FaQaCnWrDv4Ge/HHjfF8etkl+8AoeA+dZxDlP+VEWy0oX7cshJ/PiLfaow
	8V4V1YOfgCcb5KiiwlmcEIiHZJbm7HIObGO0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OyEQzAGsH6VTt8NWT3CpxSkV24hcg5Oa
	2fik151UCfhvTlhJAzMndxxrx0w0I4roickNXmDAN5YKLaVq54Ep0pIBHC61F3bR
	rIUmAc8Z0WA5dG3YfEVdws3wMn+OdnU1ZNugg/Zj6nmOurAlh+Dqs+I3oJgEcXoO
	ZaYwTU8DpXI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1E532876A;
	Tue, 25 Jun 2013 17:05:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1A7E28765;
	Tue, 25 Jun 2013 17:04:59 +0000 (UTC)
In-Reply-To: <87ppvcx84r.fsf@duckcorp.org> (Arnaud Fontaine's message of "Mon,
	24 Jun 2013 16:47:32 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E802404-DDB9-11E2-A065-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228981>

Arnaud Fontaine <arnau@debian.org> writes:

> Fix inconsistency where `--strategy` and/or `--strategy-option` can be
> specified in git rebase, but with `--interactive` argument only there
> were completely ignored.
>
> Signed-off-by: Arnaud Fontaine <arnau@debian.org>
> ---
>  git-rebase--interactive.sh    | 13 ++++++++++---
>  t/t3404-rebase-interactive.sh | 11 +++++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index f953d8d..e558397 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -80,6 +80,13 @@ amend="$state_dir"/amend
>  rewritten_list="$state_dir"/rewritten-list
>  rewritten_pending="$state_dir"/rewritten-pending
>  
> +strategy_args=
> +if test -n "$do_merge"
> +then
> +	strategy_args="${strategy+--strategy=$strategy}
> + $(echo $strategy_opts | sed "s/'--\([^']*\)'/-X\1/g")"
> +fi

The "${var+if_set_use_this}" interpolates if $var is set (as opposed to
"unset"); this will cause it to have "--strategy= " in strategy_args
when $do_merge is set.  If you ran t3421, you would have noticed
breakage.

You should use ${var:+if_set_to_nonempty_use_this} here.

stragety_opts is designed to be a valid shell scriptlet that can be
inserted as a part of eval'ed string.  git-rebase.sh does this:

	-X)
		shift
		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--$1")"
		do_merge=t

so that git-rebase--merge.sh can use it like so:

	eval 'git-merge-$strategy' $strategy_opts '"$cmt^" -- "$hd" "$cmt"'

without having to worry about quoting issues when future strategy
options have letters that need quoting, e.g.

	$ git rebase -X foo="bar ' baz"

git rev-parse --sq-quote turns it into '--foo=bar '\'' baz' and then
in the eval'ed string, it becomes a single argument given to the
git-merge-$strategy command, even though it may have spaces and
single quotes and other characters that may be tricky to quote
manually without mistakes.

So munging it manually with sloppy "sed" script is simply wrong.

>  GIT_CHERRY_PICK_HELP="$resolvemsg"
>  export GIT_CHERRY_PICK_HELP
>  
> @@ -239,7 +246,7 @@ pick_one () {
>  
>  	test -d "$rewritten" &&
>  		pick_one_preserving_merges "$@" && return
> -	output git cherry-pick $empty_args $ff "$@"
> +	output git cherry-pick $strategy_args $empty_args $ff "$@"
>  }
>  
>  pick_one_preserving_merges () {
> @@ -341,7 +348,7 @@ pick_one_preserving_merges () {
>  			# No point in merging the first parent, that's HEAD
>  			new_parents=${new_parents# $first_parent}
>  			if ! do_with_author output \
> -				git merge --no-ff ${strategy:+-s $strategy} -m \
> +				git merge --no-ff $strategy_args -m \
>  					"$msg_content" $new_parents
>  			then
>  				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
> @@ -350,7 +357,7 @@ pick_one_preserving_merges () {
>  			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
>  			;;
>  		*)
> -			output git cherry-pick "$@" ||
> +			output git cherry-pick $strategy_args "$@" ||
>  				die_with_patch $sha1 "Could not pick $sha1"
>  			;;
>  		esac
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 79e8d3c..8b6a36f 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -947,4 +947,15 @@ test_expect_success 'rebase -i respects core.commentchar' '
>  	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>  '
>  
> +test_expect_success 'rebase -i with --strategy and -X' '
> +	git checkout -b conflict-merge-use-theirs conflict-branch &&
> +	git reset --hard HEAD^ &&
> +	echo five >conflict &&
> +	echo Z >file1 &&
> +	git commit -a -m "one file conflict" &&
> +	EDITOR=true git rebase -i --strategy=recursive -Xours conflict-branch &&
> +	test $(git show conflict-branch:conflict) = $(cat conflict) &&
> +	test $(cat file1) = Z
> +'
> +
>  test_done
