From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] git-cherry-pick: Add keep-redundant-commits
 option
Date: Tue, 10 Apr 2012 10:04:32 -0700
Message-ID: <7vy5q3pl9i.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-3-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 19:08:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHeYh-0008Dp-2P
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 19:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922Ab2DJRIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 13:08:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42595 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374Ab2DJRIn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 13:08:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CD127034;
	Tue, 10 Apr 2012 13:08:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=GRxM16Gia11ToKPro0AABZJu5z0=; b=l180gliEnh3C2Go1BM+7
	FeJAQK1nXNaeyvMQsCKF8seY2PvZQa1cXgNrhA5TZ9r+P+G7w3ggzLqXqspOyh6G
	NMGEj3d78fTm6Ha4JCFEAV4DrlN1m0fUlnj53LlB+TmnuXpIAf2xfqz6mVMNe3en
	VXmHHwCUpyQxpbt9VmAMUAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=qyvIqygNfb13jQ9/24dL9+wiKYEvvc1n7Jbbz4YqdsGuKd
	gQ7OyopgwK+sq57xdLilhBQT0f8D8dFKfzlGgx9jVpQ/lC43NaLD1YEH5SvNIclj
	qulPk7C96dOnftoKJKtYBnvlgagIbTLXW8JrNQgz2H51zfRSo9GSJZ/fEURlA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03B0F7033;
	Tue, 10 Apr 2012 13:08:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D2C07031; Tue, 10 Apr 2012
 13:08:42 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2F6D0D4-832F-11E1-8177-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195104>

Neil Horman <nhorman@tuxdriver.com> writes:

> +	/* keep_if_made_empty implies allow_empty */
> +	if (opts->keep_if_made_empty)
> +		opts->allow_empty = 1;
> +
 
OK.

> diff --git a/sequencer.c b/sequencer.c
> index 71929ba..5d033db 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -13,6 +13,7 @@
>  #include "rerere.h"
>  #include "merge-recursive.h"
>  #include "refs.h"
> +#include "argv-array.h"
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> @@ -258,26 +259,102 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>   * If we are revert, or if our cherry-pick results in a hand merge,
>   * we had better say that the current user is responsible for that.
>   */
> -static int run_git_commit(const char *defmsg, struct replay_opts *opts)
> +static int run_git_commit(const char *defmsg, struct replay_opts *opts, int empty)
>  {
> -	/* 7 is max possible length of our args array including NULL */
> -	const char *args[7];
> -	int i = 0;
> +	struct argv_array array;
> +	int rc;
> +
> +	if (!empty && !opts->keep_if_made_empty) {
> +		const char *argv[] = { "diff-index", "--quiet", "--exit-code",
> +					"--cached", "HEAD", NULL };
> +
> +		/*
> + 		 * If we run git diff-index with the above option and it returns
> + 		 * zero, then there have been no changes made to the index by
> + 		 * this patch, i.e. its empty.  Since our previous empty test
> + 		 * indicated that this patch was not created empty, its been made
> + 		 * redundant.  Since keep_if_made_empty is not set, we just skip
> + 		 * it
> + 		 */
> +		if (run_command_v_opt(argv, RUN_GIT_CMD) == 0)
> +			return 0;

Wouldn't it be far simpler to do this without forking diff-index?  I
haven't followed the codepath leading to this, but it should be very easy
to find a commit object that corresponds to the current HEAD and peek the
tree object in it to find out the current tree, and because the original
function is going to run an as-is "git commit", the tree you are going to
commit should be available by calling cache_tree_update() like write-tree
does.  If they match, you are trying to create an empty commit.  E.g. (error
checking elided):

	unsigned char head_sha1[20];
	struct commit *head_commit;

	resolve_ref_unsafe("HEAD", head_sha1, 1, NULL);
        head_commit = lookup_commit(head_sha1);
        parse_commit(head_commit);

        if (!cache_tree_fully_valid(active_cache_tree))
		cache_tree_update(active_cache_tree, active_cache,
				active_nr, 0);
	return hashcmp(active_cache_tree->sha1, head_commit->tree->object.sha1);

> +static int is_original_commit_empty(struct commit *commit)
> +{
> +	struct argv_array argv_array;
> +	struct child_process cp;
> +	char ptree[40], pptree[40];
> +	int ret = 0;
> +
> +	argv_array_init(&argv_array);
> +	memset(&cp, 0, sizeof(struct child_process));
> +
> +	argv_array_push(&argv_array, "rev-parse");
> +	argv_array_pushf(&argv_array, "%s^{tree}", sha1_to_hex(commit->object.sha1));

Likewise.  You have the commit object, so just make sure it was parsed,
and peek its tree object.  Also do the same for its parent commit.  Now
you have two trees, so you can compare their object names.  E.g. (error
checking elided):

	const unsigned char *ptree_sha1;

	parse_commit(commit);
        if (commit->parents) {
		struct commit *parent = commit->parents->item;
                parse_commit(parent);
                ptree_sha1 = parent->tree->object.sha1;
	} else {
        	ptree_sha1 = EMPTY_TREE_SHA1_BIN; /* commit is root */
        }
	return hashcmp(ptree_sha1, commit->tree->object.sha1);

The higher code structure of this patch looks good, but the lower level
implementation details are done way too inefficiently.
