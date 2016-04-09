From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v3 2/4] format-patch: add '--base' option to record base
 tree info
Date: Sat, 9 Apr 2016 23:56:30 +0800
Message-ID: <20160409155630.GA2046@yexl-desktop>
References: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
 <1459388776-18066-3-git-send-email-xiaolong.ye@intel.com>
 <xmqqy48yo8eb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 17:57:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aovGK-0000tT-Uk
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 17:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbcDIP5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 11:57:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:35225 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137AbcDIP5X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 11:57:23 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 09 Apr 2016 08:57:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,454,1455004800"; 
   d="scan'208";a="941750497"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.26])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2016 08:57:21 -0700
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291099>

On Thu, Mar 31, 2016 at 10:38:04AM -0700, Junio C Hamano wrote:
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
>
>> +		add_pending_object(&revs, &list[i]->object, "rev_list");
>> +		list[i]->util = (void *)1;
>
>Are we sure commit objects not on the list have their ->util cleared?
>The while() loop below seems to rely on that to correctly filter out
>the ones that are on the list.
>
After some investigation and according to my understanding, the commit
object is allocated through alloc_commit_node->alloc_node, 

void *alloc_commit_node(void)
{
	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
	c->object.type = OBJ_COMMIT;
	c->index = alloc_commit_index();
	return c;
}

static inline void *alloc_node(struct alloc_state *s, size_t node_size)
{
	void *ret;

	if (!s->nr) {
		s->nr = BLOCKING;
		s->p = xmalloc(BLOCKING * node_size);
	}
	s->nr--;
	s->count++;
	ret = s->p;
	s->p = (char *)s->p + node_size;
	memset(ret, 0, node_size);
	return ret;
}

So the commit->util should be cleared after initialization, and it has
not been touched except above "for" loop in our code execution path, I think
it is safe to rely on it to filter out commits that are on the rev list.

Thanks,
Xiaolong.
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
