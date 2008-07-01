From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/14] Build in merge
Date: Mon, 30 Jun 2008 23:23:17 -0700
Message-ID: <7vtzfaqg16.fsf@gitster.siamese.dyndns.org>
References: <cover.1214879690.git.vmiklos@frugalware.org>
 <9201d4e13e574c10b1674cf1f6da23a44a73f8b2.1214879690.git.vmiklos@frugalware.org> <1b74bb93e518a906b0067d182fb29279baff3b25.1214879690.git.vmiklos@frugalware.org> <5e65b37998d1fdd9d314e48cea2cf67fd73ba8cd.1214879690.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 08:24:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDZI0-00006U-62
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 08:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbYGAGXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 02:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbYGAGXf
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 02:23:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbYGAGXe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 02:23:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 206B01B4C6;
	Tue,  1 Jul 2008 02:23:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0B2B91B4C5; Tue,  1 Jul 2008 02:23:25 -0400 (EDT)
In-Reply-To: <5e65b37998d1fdd9d314e48cea2cf67fd73ba8cd.1214879690.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Tue, 1 Jul 2008 04:37:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3ACB57D2-4736-11DD-BC02-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87004>

Miklos Vajna <vmiklos@frugalware.org> writes:

> +static int read_tree_trivial(unsigned char *common, unsigned char *head,
> +	unsigned char *one)
> +{
> +	int i, nr_trees = 0;
> +	struct tree *trees[MAX_UNPACK_TREES];
> +	struct tree_desc t[MAX_UNPACK_TREES];
> +	struct unpack_trees_options opts;
> +
> +	memset(&opts, 0, sizeof(opts));
> +	opts.head_idx = 2;

Do you still need this assignment here?

> +int cmd_merge(int argc, const char **argv, const char *prefix)
> +{
> +	unsigned char result_tree[20];
> +	struct strbuf buf;
> +	const char *head_arg;
> +	int flag, head_invalid = 0, i;
> +	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
> +	struct commit_list *common = NULL;
> +	struct path_list_item *best_strategy = NULL, *wt_strategy = NULL;
> +	struct commit_list **remotes = &remoteheads;
> +
> +	setup_work_tree();
> +	if (unmerged_cache())
> +		die("You are in the middle of a conflicted merge.");
> +
> +	/*
> +	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
> +	 * current branch.
> +	 */
> +	branch = resolve_ref("HEAD", head, 0, &flag);
> +	if (branch && flag & REF_ISSYMREF) {
> +		const char *ptr = skip_prefix(branch, "refs/heads/");
> +		if (ptr)
> +			branch = ptr;
> +	} else
> +		head_invalid = 1;

Wait a minute...  Are you calling a detached HEAD as head_invalid here?  I
am not too much worried about variable naming, but you later do ...

> +	if (!have_message && is_old_style_invocation(argc, argv)) {
> ...
> +	} else if (head_invalid) {
> +		struct object *remote_head;
> +		/*
> +		 * If the merged head is a valid one there is no reason
> +		 * to forbid "git merge" into a branch yet to be born.
> +		 * We do the same for "git pull".
> +		 */
> +		if (argc != 1)
> +			die("Can merge only exactly one commit into "
> +				"empty head");

Which is about HEAD pointing at a branch that isn't born yet.  They are
two very different concepts.

Either the above "else if (head_invalid)" is wrong, or more likely the
setting of head_invalid we saw earlier is wrong.

Probably what you meant was:

	- "char *branch" points at either "HEAD" (when detached) or
          the name of the branch (e.g. "master" when "refs/heads/master");

	- "unsigned char head[]" stores the commit object name of the
          current HEAD (or 0{40} if the current branch is unborn);

        - set head_invalid to true only when the current branch is unborn.

So perhaps...

	branch = resolve_ref("HEAD", head, 0, &flag);
        if (branch && (flag & REF_ISSYMREF) && !prefixcmp(branch, "refs/heads/"))
		branch += 11;
        head_invalid = is_null_sha1(head);

And probably we can even drop (flag & REF_ISSYMREF) from the above safely.
Do we even care if the head is detached in this program?  I doubt it.

> ...
> +		strbuf_init(&msg, 0);
> +		strbuf_addstr(&msg, "Fast forward");
> +		if (have_message)
> +			strbuf_addstr(&msg,
> +				" (no commit created; -m option ignored)");
> +		o = peel_to_type(sha1_to_hex(remoteheads->item->object.sha1),
> +			0, NULL, OBJ_COMMIT);
> +		if (!o)
> +			return 1;
> +
> +		if (checkout_fast_forward(head, remoteheads->item->object.sha1))
> +			return 1;

Not exiting with 0 status from around here upon error is an improvement,
but does the user see sensible error messages in addition to the exit
status?

Getting warmer ;-)
