From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/19] reset $sha1 $pathspec: require $sha1 only to be
 treeish
Date: Wed, 09 Jan 2013 12:23:55 -0800
Message-ID: <7vzk0i3y1w.fsf@alter.siamese.dyndns.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-18-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:24:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt2CD-0003Y6-8C
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 21:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395Ab3AIUYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 15:24:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53497 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106Ab3AIUX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 15:23:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CC30B746;
	Wed,  9 Jan 2013 15:23:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LXT0X/vhT8rI2lxJB+RR5XCKK9A=; b=Yi8Mlj
	5CNJxjXlMxjYMftx8kyu6cqpJ/8Pi8Ssxw2wA6QS+5sSB3Tr+lDRxwzTW96rWW3q
	YhXfhJUgwSe09A+0QZmIoSzAKL931hQrFuv2D/egSboPtzJHKKYNjjxnHX9zO/qU
	UL4kveLbCxXZezv7gIKrZi30XxEn9BC2HHans=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x3KQojS/Vg9MrE6IC4LEn+sLjVORoCgZ
	jp56fEoMD38UaSENAQTEeE/ju1aQbDXBxl949Y/fTPc9Gjb2bdIdL0LTR4LCtiY8
	a/TpnBaiB5RwLCW15BMsL810YBkXs/IanLc1UCqQcakIHp84NJpxgva+2qQOOES6
	ClvPwywrjhI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A07FB745;
	Wed,  9 Jan 2013 15:23:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4427AB73C; Wed,  9 Jan 2013
 15:23:57 -0500 (EST)
In-Reply-To: <1357719376-16406-18-git-send-email-martinvonz@gmail.com>
 (Martin von Zweigbergk's message of "Wed, 9 Jan 2013 00:16:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EC58AEE-5A9A-11E2-8849-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213099>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> Resetting with paths does not update HEAD and there is nothing else
> that a commit should be needed for. Relax the argument parsing so only
> a tree is required.
>
> The sha1 is only passed to read_from_tree(), which already only
> requires a tree.
>
> The "rev" variable we pass to run_add_interactive() will resolve to a
> tree. This is fine since interactive_reset only needs the parameter to
> be a treeish and doesn't use it for display purposes.
> ---
> Is it correct that interactive_reset does not use the revision
> specifier for display purposes? Or, worse, that it requires it to be a
> commit in some cases? I tried it and didn't see any problem.

As far as I know, it is only given to git-diff-index as the tree-ish,
and resulting patch text is used for application via git-apply just
like any patch coming from any origin, so I think it should be fine.

> Can the two blocks of code that look up commit or tree be made to
> share more? I'm not very familiar with what functions are available. I
> think I tried keeping a separate "struct object *object" to be able to
> put the last three lines outside the blocks, but didn't like the
> result.

I think the patch looks fine from the sharing perspective, but it
may be even nicer to have a separate variable to hold a commit
object limited to the scope of if (!pathspec) block to make them
more symmetric.  The commit is only needed later to show "we are now
at this commit", but that code can find the commit itself given the
object name in sha1[].

>  builtin/reset.c  | 46 ++++++++++++++++++++++++++--------------------
>  t/t7102-reset.sh |  8 ++++++++
>  2 files changed, 34 insertions(+), 20 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index a2e69eb..4c223bd 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -177,9 +177,10 @@ const char **parse_args(int argc, const char **argv, const char *prefix, const c
>  	/*
>  	 * Possible arguments are:
>  	 *
> -	 * git reset [-opts] <rev> <paths>...
> -	 * git reset [-opts] <rev> -- <paths>...
> -	 * git reset [-opts] -- <paths>...
> +	 * git reset [-opts] [<rev>]
> +	 * git reset [-opts] <tree> [<paths>...]
> +	 * git reset [-opts] <tree> -- [<paths>...]
> +	 * git reset [-opts] -- [<paths>...]
>  	 * git reset [-opts] <paths>...
>  	 *
>  	 * At this point, argv points immediately after [-opts].
> @@ -194,11 +195,13 @@ const char **parse_args(int argc, const char **argv, const char *prefix, const c
>  		}
>  		/*
>  		 * Otherwise, argv[0] could be either <rev> or <paths> and
> -		 * has to be unambiguous.
> +		 * has to be unambiguous. If there is a single argument, it
> +		 * can not be a tree
>  		 */
> -		else if (!get_sha1_committish(argv[0], unused)) {
> +		else if ((argc == 1 && !get_sha1_committish(argv[0], unused)) ||
> +			 (argc > 1 && !get_sha1_treeish(argv[0], unused))) {
>  			/*
> -			 * Ok, argv[0] looks like a rev; it should not
> +			 * Ok, argv[0] looks like a commit/tree; it should not
>  			 * be a filename.
>  			 */
>  			verify_non_filename(prefix, argv[0]);
> @@ -240,7 +243,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  	const char *rev;
>  	unsigned char sha1[20];
>  	const char **pathspec = NULL;
> -	struct commit *commit;
> +	struct commit *commit = NULL;
>  	const struct option options[] = {
>  		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
>  		OPT_SET_INT(0, "mixed", &reset_type,
> @@ -262,19 +265,22 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  						PARSE_OPT_KEEP_DASHDASH);
>  	pathspec = parse_args(argc, argv, prefix, &rev);
>  
> -	if (get_sha1_committish(rev, sha1))
> -		die(_("Failed to resolve '%s' as a valid ref."), rev);
> -
> -	/*
> -	 * NOTE: As "git reset $treeish -- $path" should be usable on
> -	 * any tree-ish, this is not strictly correct. We are not
> -	 * moving the HEAD to any commit; we are merely resetting the
> -	 * entries in the index to that of a treeish.
> -	 */
> -	commit = lookup_commit_reference(sha1);
> -	if (!commit)
> -		die(_("Could not parse object '%s'."), rev);
> -	hashcpy(sha1, commit->object.sha1);
> +	if (!pathspec) {
> +		if (get_sha1_committish(rev, sha1))
> +			die(_("Failed to resolve '%s' as a valid revision."), rev);
> +		commit = lookup_commit_reference(sha1);
> +		if (!commit)
> +			die(_("Could not parse object '%s'."), rev);
> +		hashcpy(sha1, commit->object.sha1);
> +	} else {
> +		struct tree *tree;
> +		if (get_sha1_treeish(rev, sha1))
> +			die(_("Failed to resolve '%s' as a valid tree."), rev);
> +		tree = parse_tree_indirect(sha1);
> +		if (!tree)
> +			die(_("Could not parse object '%s'."), rev);
> +		hashcpy(sha1, tree->object.sha1);
> +	}
>  
>  	if (patch_mode) {
>  		if (reset_type != NONE)
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 81b2570..1fa2a5f 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -497,4 +497,12 @@ test_expect_success 'disambiguation (4)' '
>  	test ! -f secondfile
>  '
>  
> +test_expect_success 'reset with paths accepts tree' '
> +	# for simpler tests, drop last commit containing added files
> +	git reset --hard HEAD^ &&
> +	git reset HEAD^^{tree} -- . &&
> +	git diff --cached HEAD^ --exit-code &&
> +	git diff HEAD --exit-code
> +'
> +
>  test_done
