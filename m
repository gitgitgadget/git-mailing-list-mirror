From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] format-patch: add '--base' option to record base tree info
Date: Wed, 23 Mar 2016 11:08:20 -0700
Message-ID: <xmqqfuvhcbjf.fsf@gitster.mtv.corp.google.com>
References: <1458723147-7335-1-git-send-email-xiaolong.ye@intel.com>
	<1458723147-7335-3-git-send-email-xiaolong.ye@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Xiaolong Ye <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 19:08:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ainCy-0001qo-Rz
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 19:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbcCWSIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 14:08:25 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751488AbcCWSIY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 14:08:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 96E254FC87;
	Wed, 23 Mar 2016 14:08:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pBKcbqKJL3TvguRbq1J8zkmzmUo=; b=uCgWhO
	Gf3ZOuqANMttEnxoT5J3dmHBWPogycaJ7U7WCfUDZCAR1M84s5cS/3kfV7RBZpBD
	w/5Em2CmQXwyLWOP5TYkChUBeGn/s2nJm1UDp4q8cfLzJ94XGEORPXnT2v3wsWk4
	OOaiTJoo3weor74j1DvEB9exr88sbMifpYmbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uL3F2Ef0uHz/RjdlFtnIheoJd93JQcBf
	T80/HvvPfeAbEMslNa1Giuf4M4HdsbsXdOW5x9z9v23ZH28NR1xjznQLJJJ8HqxN
	pO9OnACegN6xcHpW6P3Xus4DfsceIwPOuYNiaxbt0SWcUchjWqRFMR4Nb8FzoRYD
	eVpPrthsE8A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8CA794FC86;
	Wed, 23 Mar 2016 14:08:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E2E744FC82;
	Wed, 23 Mar 2016 14:08:21 -0400 (EDT)
In-Reply-To: <1458723147-7335-3-git-send-email-xiaolong.ye@intel.com>
	(Xiaolong Ye's message of "Wed, 23 Mar 2016 16:52:25 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3AAAAF16-F122-11E5-98A5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289672>

Xiaolong Ye <xiaolong.ye@intel.com> writes:

Reviewing the patch out of order, caller first and then callee.

> +static void print_bases(struct base_tree_info *bases)
> +{
> +	int i;
> +
> +	/* Only do this once, either for the cover or for the first one */
> +	if (is_null_oid(&bases->base_commit))
> +		return;
> +
> +	printf("** base-commit-info **\n");

I am not sure if you want to have this line (an empty line might not
hurt), as the "base-commit: ..." that comes next is a clear enough
indication of what these lines are.

> +	if (base_commit) {
> +		struct commit *prerequisite_head = NULL;
> +		if (list[nr - 1]->parents)
> +			prerequisite_head = list[nr - 1]->parents->item;
> +		memset(&bases, 0, sizeof(bases));
> +		reset_revision_walk();
> +		prepare_bases(&bases, base_commit, prerequisite_head);
> +	}
> +

list[] holds the commits in reverse topological order, so the first
parent of the last element in the list[] would hopefully give you
the latest change your series depends on, and that is why you are
working on list[nr - 1] here.

I however think that is flawed.

What if your series A, B and C are on this topology?

    ---P---X---A---M---C
        \         /
         Y---Z---B

"git format-patch --base=P -3 C" would show A, B and C.  It may show
B, A and C, as A and B are independent (you would be flattening the
history into the shape you have in your documentation part of the
patch in order to adjust for their interactions before running
format-patch if that were not the case).  Depending on which one
happens to be chosen as prerequisite_head, you would miss either X
or Y & Z, wouldn't you?

A simpler and safer (but arguably less useful) approach may be to
use the logic and limitation of your patch as-is but add code to
check that the history is linear and refuse to do the "base" thing.
But just in case you want to handle a more general case like the
above, read on.

> +static void prepare_bases(struct base_tree_info *bases,
> +			  const char *base_commit,
> +			  struct commit *prerequisite_head)
> +{
> +	struct commit *base = NULL, *commit;
> +	struct rev_info revs;
> +	struct diff_options diffopt;
> +	struct object_id *patch_id;
> +	unsigned char sha1[20];
> +	int pos = 0;
> +
> +	if (!prerequisite_head)
> +		return;
> +	base = lookup_commit_reference_by_name(base_commit);
> +	if (!base)
> +		die(_("Unknown commit %s"), base_commit);
> +	oidcpy(&bases->base_commit, &base->object.oid);
> +
> +	if (base == prerequisite_head)
> +		return;
> +
> +	if (!in_merge_bases(base, prerequisite_head))
> +		die(_("base commit should be the ancestor of revs you specified"));
> +
> +	init_revisions(&revs, NULL);
> +	revs.max_parents = 1;
> +
> +	base->object.flags |= UNINTERESTING;
> +	add_pending_object(&revs, &base->object, "base");
> +	prerequisite_head->object.flags |= 0;
> +	add_pending_object(&revs, &prerequisite_head->object, "prerequisite-head");
> +
> +	diff_setup(&diffopt);
> +	DIFF_OPT_SET(&diffopt, RECURSIVE);
> +	diff_setup_done(&diffopt);
> +
> +	if (prepare_revision_walk(&revs))
> +		die(_("revision walk setup failed"));
> +	/*
> +	 * Traverse the commits list between base and prerequisite head,
> +	 * get the patch ids and stuff them in bases structure.
> +	 */
> +	while ((commit = get_revision(&revs)) != NULL) {
> +		if (commit_patch_id(commit, &diffopt, sha1))
> +			return;
> +		ALLOC_GROW(bases->patch_id, bases->nr_patch_id + 1, bases->alloc_patch_id);
> +		patch_id = bases->patch_id + pos;
> +		hashcpy(patch_id->hash, sha1);
> +		pos++;
> +		bases->nr_patch_id++;

Micronit.  Aren't pos and nr_patch_id always the same?

> +	}
> +}

I think the right thing to do is probably to start another revision
walk (which you do) but setting the starting points of the traversal
to all elements in the list[] (which you don't--you use either A^ or
B^).  And skip the ones in the list[] before grabbing its patch-id
in the loop.  That way, you do not have to worry about the topology
of the history tripping you up at all.

So I'd suggest to redo this function perhaps like so, if you do want
to handle the more general case:

static void prepare_bases(struct base_tree_info *bases,
			  const char *base_commit,
			  struct commit **list,
                          int total)
{
	... boilerplate ...

	base = lookup_commit_reference_by_name(base_commit);
	if (!base)
		die(_("Unknown commit %s"), base_commit);
	oidcpy(&bases->base_commit, &base->object.oid);

	init_revisions(&revs, NULL);
	revs.max_parents = 1;
	add_pending_commit(&revs, base, UNINTERESTING);
	for (i = 0; i < total; i++)
        	add_pending_commit(&revs, list[i], 0);

	if (prepare_revision_walk(&revs))
		die(_("revision walk setup failed"));

	while ((commit = get_revision(&revs)) != NULL) {
        	if (COMMIT_IS_IN_LIST(commit))
                	continue;
		if (commit_patch_id(commit, &diffopt, sha1))
                	die("cannot get patch id");
		... do your ptach_id thing ...
	}
}

And COMMIT_IS_IN_LIST() can probably be implemented by using commit->util
field, e.g. change the part that sets up the traversal

	for (i = 0; i < total; i++) {
        	add_pending_commit(&revs, list[i], 0);
		list[i]->util = (void *)1;
	}

to mark those in list[] as such, and the test would be

		if (commit->util)
                	continue; /* on list[] */

or something like that.
