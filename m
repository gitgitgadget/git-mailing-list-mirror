From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v3 2/4] format-patch: add '--base' option to record base
 tree info
Date: Fri, 1 Apr 2016 21:38:01 +0800
Message-ID: <20160401133801.GA2915@yexl-desktop>
References: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
 <1459388776-18066-3-git-send-email-xiaolong.ye@intel.com>
 <xmqqy48yo8eb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 15:39:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alzIE-0007R5-6q
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 15:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbcDANjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 09:39:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:62034 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565AbcDANjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 09:39:12 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 01 Apr 2016 06:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,427,1455004800"; 
   d="scan'208";a="936262271"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.26])
  by fmsmga001.fm.intel.com with ESMTP; 01 Apr 2016 06:38:43 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com
Content-Disposition: inline
In-Reply-To: <xmqqy48yo8eb.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290535>

On Thu, Mar 31, 2016 at 10:38:04AM -0700, Junio C Hamano wrote:
>Xiaolong Ye <xiaolong.ye@intel.com> writes:
>
>> Maintainers or third party testers may want to know the exact base tree
>> the patch series applies to. Teach git format-patch a '--base' option to
>> record the base tree info and append this information at the end of the
>> _first_ message (either the cover letter or the first patch in the series).
>
>You'd need a description of what "base tree info" consists of as a
>separate paragraph after the above paragraph.  I'd also suggest to
>
>	s/and append this information/and append it/;
>
>Based on my understanding of what you consider "base tree info", it
>may look like this, but you know your design better, so I'd expect
>you to rewrite it to be more useful, or at least to fill in the
>blanks.
>
>	The base tree info consists of the "base commit", which is a
>	well-known commit that is part of the stable part of the
>	project history everybody else works off of, and zero or
>	more "prerequisite patches", which are well-known patches in
>	flight that is not yet part of the "base commit" that need
>	to be applied on top of "base commit" ???IN WHAT ORDER???
>	before the patches can be applied.
>
>	"base commit" is shown as "base-commit: " followed by the
>	40-hex of the commit object name.  A "prerequisite patch" is
>	shown as "prerequisite-patch-id: " followed by the 40-hex
>	"patch id", which can be obtained by ???DOING WHAT???
>
Thanks for the review.

Ok, I'll polish up the description of base tree info and add it to commit log
as you suggested.

>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by: Wu Fengguang <fengguang.wu@intel.com>
>> Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
>> ---
>>  Documentation/git-format-patch.txt | 25 +++++++++++
>>  builtin/log.c                      | 89 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 114 insertions(+)
>>
>> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
>> index 6821441..067d562 100644
>> --- a/Documentation/git-format-patch.txt
>> +++ b/Documentation/git-format-patch.txt
>> @@ -265,6 +265,31 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>>    Output an all-zero hash in each patch's From header instead
>>    of the hash of the commit.
>>  
>> +--base=<commit>::
>> +	Record the base tree information to identify the whole tree
>> +	the patch series applies to. For example, the patch submitter
>> +	has a commit history of this shape:
>> +
>> +	---P---X---Y---Z---A---B---C
>> +
>> +	where "P" is the well-known public commit (e.g. one in Linus's tree),
>> +	"X", "Y", "Z" are prerequisite patches in flight, and "A", "B", "C"
>> +	are the work being sent out, the submitter could say "git format-patch
>> +	--base=P -3 C" (or variants thereof, e.g. with "--cover" or using
>> +	"Z..C" instead of "-3 C" to specify the range), and the identifiers
>> +	for P, X, Y, Z are appended at the end of the _first_ message (either
>> +	the cover letter or the first patch in the series).
>> +
>> +	For non-linear topology, such as
>> +
>> +	    ---P---X---A---M---C
>> +		\         /
>> +		 Y---Z---B
>> +
>> +	the submitter could also use "git format-patch --base=P -3 C" to generate
>> +	patches for A, B and C, and the identifiers for P, X, Y, Z are appended
>> +	at the end of the _first_ message.
>
>The contents of this look OK, but does it format correctly via
>AsciiDoc?  I suspect that only the first paragraph up to "of this
>shape:" would appear correctly and all the rest would become funny.

Sorry, just heard of AsciiDoc, I will try to use it to do the right format work.

>
>Also the definition of "base tree information" you need to have in
>the log message should be given somewhere in this documentation, not
>necessarily in the documentation of --base=<commit> option.
>
>Because the use of this new option is not an essential part of
>workflow of all users of format-patch, it may be a good idea to have
>its own separate section, perhaps between the "DISCUSSION" and
>"EXAMPLES" sections, titled "BASE TREE IDENTIFICATION", move the
>bulk of text above there with the specification of what "base tree
>info" consists of there.
>
>And shorten the description of the option to something like:
>
>--base=<commit>::
>	Record the base tree information to identify the state the
>	patch series applies to.  See the BASE TREE IDENTIFICATION
>        section below for details.
>
>or something.

I'll restructure the descriptions in a resend.

>
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 0d738d6..03cbab0 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -1185,6 +1185,82 @@ static int from_callback(const struct option *opt, const char *arg, int unset)
>>  	return 0;
>>  }
>>  
>> +struct base_tree_info {
>> +	struct object_id base_commit;
>> +	int nr_patch_id, alloc_patch_id;
>> +	struct object_id *patch_id;
>> +};
>> +
>> +static void prepare_bases(struct base_tree_info *bases,
>> +			  const char *base_commit,
>> +			  struct commit **list,
>> +			  int total)
>> +{
>> +	struct commit *base = NULL, *commit;
>> +	struct rev_info revs;
>> +	struct diff_options diffopt;
>> +	struct object_id *patch_id;
>> +	unsigned char sha1[20];
>> +	int i;
>> +
>> +	diff_setup(&diffopt);
>> +	DIFF_OPT_SET(&diffopt, RECURSIVE);
>> +	diff_setup_done(&diffopt);
>> +
>> +	base = lookup_commit_reference_by_name(base_commit);
>> +	if (!base)
>> +		die(_("Unknown commit %s"), base_commit);
>> +	oidcpy(&bases->base_commit, &base->object.oid);
>> +
>> +	init_revisions(&revs, NULL);
>> +	revs.max_parents = 1;
>> +	base->object.flags |= UNINTERESTING;
>> +	add_pending_object(&revs, &base->object, "base");
>> +	for (i = 0; i < total; i++) {
>> +		list[i]->object.flags |= 0;
>
>What does this statement do, exactly?  Are you clearing some bits
>but not others, and if so which ones?

My mistake, it's useless and should be removed.

>
>> +		add_pending_object(&revs, &list[i]->object, "rev_list");
>> +		list[i]->util = (void *)1;
>
>Are we sure commit objects not on the list have their ->util cleared?
>The while() loop below seems to rely on that to correctly filter out
>the ones that are on the list.
>

I'll need to check it.

>> +	}
>> +
>> +	if (prepare_revision_walk(&revs))
>> +		die(_("revision walk setup failed"));
>> +	/*
>> +	 * Traverse the prerequisite commits list,
>> +	 * get the patch ids and stuff them in bases structure.
>> +	 */
>> +	while ((commit = get_revision(&revs)) != NULL) {
>> +		if (commit->util)
>> +			continue;
>> +		if (commit_patch_id(commit, &diffopt, sha1))
>> +			die(_("cannot get patch id"));
>> +		ALLOC_GROW(bases->patch_id, bases->nr_patch_id + 1, bases->alloc_patch_id);
>> +		patch_id = bases->patch_id + bases->nr_patch_id;
>> +		hashcpy(patch_id->hash, sha1);
>
>The variable patch_id is used only once here.  Perhaps either write
>
>	hashcpy(bases->patch_id[bases->nr_patch_id]->hash, sha1);
>
>to get rid of the variable, or move its declaration inside the
>while() loop to limit its scope?
>

Sure, I'll move the patch_id declaration inside the loop.

>Has this traversal been told, when setting up the &revs structure,
>to show commits in specific order (like "topo order")?  Should it
>be?

Thanks for the reminder, this traversal need to be in topo order,
I'll set revs.topo_order to 1 explicitly.

>
>> +		bases->nr_patch_id++;
>> +	}
>> +}
>> +
>> +static void print_bases(struct base_tree_info *bases)
>> +{
>> +	int i;
>> +
>> +	/* Only do this once, either for the cover or for the first one */
>> +	if (is_null_oid(&bases->base_commit))
>> +		return;
>> +
>> +	/* Show the base commit */
>> +	printf("base-commit: %s\n", oid_to_hex(&bases->base_commit));
>> +
>> +	/* Show the prerequisite patches */
>> +	for (i = 0; i < bases->nr_patch_id; i++)
>> +		printf("prerequisite-patch-id: %s\n", oid_to_hex(&bases->patch_id[i]));
>
>This shows the patches in the order discovered by the revision
>traversal, which typically is newer to older.  Is that intended?
>Is it assumed that the order of the patches does not matter?

The prerequisite patches should show in topological order, thus robot
could parse them one by one and apply the patches in reverse order.

Thanks,
Xiaolong.
>
>> @@ -1209,6 +1285,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>
>The remainder of the patch looks very sensible, including the call
>to reset_revision_walk().
>
>Thanks.
