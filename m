From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v2 2/4] format-patch: add '--base' option to record base
 tree info
Date: Thu, 24 Mar 2016 11:08:11 +0800
Message-ID: <20160324030811.GA26582@yexl-desktop>
References: <1458723147-7335-1-git-send-email-xiaolong.ye@intel.com>
 <1458723147-7335-3-git-send-email-xiaolong.ye@intel.com>
 <xmqqfuvhcbjf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 04:08:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aivdk-0008I4-Ur
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 04:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbcCXDIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 23:08:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:61404 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295AbcCXDIr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 23:08:47 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP; 23 Mar 2016 20:08:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,383,1455004800"; 
   d="scan'208";a="930612798"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.26])
  by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2016 20:08:46 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com
Content-Disposition: inline
In-Reply-To: <xmqqfuvhcbjf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289707>

On Wed, Mar 23, 2016 at 11:08:20AM -0700, Junio C Hamano wrote:
>Xiaolong Ye <xiaolong.ye@intel.com> writes:
>
>Reviewing the patch out of order, caller first and then callee.
>
>> +static void print_bases(struct base_tree_info *bases)
>> +{
>> +	int i;
>> +
>> +	/* Only do this once, either for the cover or for the first one */
>> +	if (is_null_oid(&bases->base_commit))
>> +		return;
>> +
>> +	printf("** base-commit-info **\n");
>
>I am not sure if you want to have this line (an empty line might not
>hurt), as the "base-commit: ..." that comes next is a clear enough
>indication of what these lines are.

Ok, I will remove this extra line.
>
>> +	if (base_commit) {
>> +		struct commit *prerequisite_head = NULL;
>> +		if (list[nr - 1]->parents)
>> +			prerequisite_head = list[nr - 1]->parents->item;
>> +		memset(&bases, 0, sizeof(bases));
>> +		reset_revision_walk();
>> +		prepare_bases(&bases, base_commit, prerequisite_head);
>> +	}
>> +
>
>list[] holds the commits in reverse topological order, so the first
>parent of the last element in the list[] would hopefully give you
>the latest change your series depends on, and that is why you are
>working on list[nr - 1] here.

Yes, I just considered linear topology before.
>
>I however think that is flawed.
>
>What if your series A, B and C are on this topology?
>
>    ---P---X---A---M---C
>        \         /
>         Y---Z---B
>
>"git format-patch --base=P -3 C" would show A, B and C.  It may show
>B, A and C, as A and B are independent (you would be flattening the
>history into the shape you have in your documentation part of the
>patch in order to adjust for their interactions before running
>format-patch if that were not the case).  Depending on which one
>happens to be chosen as prerequisite_head, you would miss either X
>or Y & Z, wouldn't you?
>
>A simpler and safer (but arguably less useful) approach may be to
>use the logic and limitation of your patch as-is but add code to
>check that the history is linear and refuse to do the "base" thing.
>But just in case you want to handle a more general case like the
>above, read on.
>
>> +static void prepare_bases(struct base_tree_info *bases,
>> +			  const char *base_commit,
>> +			  struct commit *prerequisite_head)
>> +{
>> +	struct commit *base = NULL, *commit;
>> +	struct rev_info revs;
>> +	struct diff_options diffopt;
>> +	struct object_id *patch_id;
>> +	unsigned char sha1[20];
>> +	int pos = 0;
>> +
>> +	if (!prerequisite_head)
>> +		return;
>> +	base = lookup_commit_reference_by_name(base_commit);
>> +	if (!base)
>> +		die(_("Unknown commit %s"), base_commit);
>> +	oidcpy(&bases->base_commit, &base->object.oid);
>> +
>> +	if (base == prerequisite_head)
>> +		return;
>> +
>> +	if (!in_merge_bases(base, prerequisite_head))
>> +		die(_("base commit should be the ancestor of revs you specified"));
>> +
>> +	init_revisions(&revs, NULL);
>> +	revs.max_parents = 1;
>> +
>> +	base->object.flags |= UNINTERESTING;
>> +	add_pending_object(&revs, &base->object, "base");
>> +	prerequisite_head->object.flags |= 0;
>> +	add_pending_object(&revs, &prerequisite_head->object, "prerequisite-head");
>> +
>> +	diff_setup(&diffopt);
>> +	DIFF_OPT_SET(&diffopt, RECURSIVE);
>> +	diff_setup_done(&diffopt);
>> +
>> +	if (prepare_revision_walk(&revs))
>> +		die(_("revision walk setup failed"));
>> +	/*
>> +	 * Traverse the commits list between base and prerequisite head,
>> +	 * get the patch ids and stuff them in bases structure.
>> +	 */
>> +	while ((commit = get_revision(&revs)) != NULL) {
>> +		if (commit_patch_id(commit, &diffopt, sha1))
>> +			return;
>> +		ALLOC_GROW(bases->patch_id, bases->nr_patch_id + 1, bases->alloc_patch_id);
>> +		patch_id = bases->patch_id + pos;
>> +		hashcpy(patch_id->hash, sha1);
>> +		pos++;
>> +		bases->nr_patch_id++;
>
>Micronit.  Aren't pos and nr_patch_id always the same?
Sorry, will only use nr_patch_id.
>
>> +	}
>> +}
>
>I think the right thing to do is probably to start another revision
>walk (which you do) but setting the starting points of the traversal
>to all elements in the list[] (which you don't--you use either A^ or
>B^).  And skip the ones in the list[] before grabbing its patch-id
>in the loop.  That way, you do not have to worry about the topology
>of the history tripping you up at all.
>
>So I'd suggest to redo this function perhaps like so, if you do want
>to handle the more general case:

Thanks for the elaborated suggestions. I will redo the prepare_bases
function accordingly to handle more general case.
>
>static void prepare_bases(struct base_tree_info *bases,
>			  const char *base_commit,
>			  struct commit **list,
>                          int total)
>{
>	... boilerplate ...
>
>	base = lookup_commit_reference_by_name(base_commit);
>	if (!base)
>		die(_("Unknown commit %s"), base_commit);
>	oidcpy(&bases->base_commit, &base->object.oid);
>
>	init_revisions(&revs, NULL);
>	revs.max_parents = 1;
>	add_pending_commit(&revs, base, UNINTERESTING);
>	for (i = 0; i < total; i++)
>        	add_pending_commit(&revs, list[i], 0);
>
>	if (prepare_revision_walk(&revs))
>		die(_("revision walk setup failed"));
>
>	while ((commit = get_revision(&revs)) != NULL) {
>        	if (COMMIT_IS_IN_LIST(commit))
>                	continue;
>		if (commit_patch_id(commit, &diffopt, sha1))
>                	die("cannot get patch id");
>		... do your ptach_id thing ...
>	}
>}
>
>And COMMIT_IS_IN_LIST() can probably be implemented by using commit->util
>field, e.g. change the part that sets up the traversal
>
>	for (i = 0; i < total; i++) {
>        	add_pending_commit(&revs, list[i], 0);
>		list[i]->util = (void *)1;
>	}
>
>to mark those in list[] as such, and the test would be
>
>		if (commit->util)
>                	continue; /* on list[] */
>
>or something like that.
