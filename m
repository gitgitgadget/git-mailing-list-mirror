From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v3 3/4] format-patch: introduce --base=auto option
Date: Fri, 1 Apr 2016 21:52:07 +0800
Message-ID: <20160401135207.GB2915@yexl-desktop>
References: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
 <1459388776-18066-4-git-send-email-xiaolong.ye@intel.com>
 <xmqqtwjmo84r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 15:52:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alzVR-0005JD-2O
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 15:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758732AbcDANww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 09:52:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:46015 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212AbcDANww (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 09:52:52 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP; 01 Apr 2016 06:52:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,427,1455004800"; 
   d="scan'208";a="679189415"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.26])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Apr 2016 06:52:50 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com
Content-Disposition: inline
In-Reply-To: <xmqqtwjmo84r.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290537>

On Thu, Mar 31, 2016 at 10:43:48AM -0700, Junio C Hamano wrote:
>Xiaolong Ye <xiaolong.ye@intel.com> writes:
>
>> Introduce --base=auto to record the base commit info automatically, the base_commit
>> will be the merge base of tip commit of the upstream branch and revision-range
>> specified in cmdline.
>
>This line is probably a bit too long.

How about simplifying it to "the base_commit is the merge base of upstream and
specified revision-range."?

>
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by: Wu Fengguang <fengguang.wu@intel.com>
>> Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
>> ---
>>  Documentation/git-format-patch.txt |  4 ++++
>>  builtin/log.c                      | 31 +++++++++++++++++++++++++++----
>>  2 files changed, 31 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
>> index 067d562..d8fe651 100644
>> --- a/Documentation/git-format-patch.txt
>> +++ b/Documentation/git-format-patch.txt
>> @@ -290,6 +290,10 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>>  	patches for A, B and C, and the identifiers for P, X, Y, Z are appended
>>  	at the end of the _first_ message.
>>  
>> +	If set '--base=auto' in cmdline, it will track base commit automatically,
>> +	the base commit will be the merge base of tip commit of the remote-tracking
>> +	branch and revision-range specified in cmdline.
>> +
>>  --root::
>>  	Treat the revision argument as a <revision range>, even if it
>>  	is just a single commit (that would normally be treated as a
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 03cbab0..c5efe73 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -1200,6 +1200,9 @@ static void prepare_bases(struct base_tree_info *bases,
>>  	struct rev_info revs;
>>  	struct diff_options diffopt;
>>  	struct object_id *patch_id;
>> +	struct branch *curr_branch;
>> +	struct commit_list *base_list;
>> +	const char *upstream;
>>  	unsigned char sha1[20];
>>  	int i;
>>  
>> @@ -1207,10 +1210,30 @@ static void prepare_bases(struct base_tree_info *bases,
>>  	DIFF_OPT_SET(&diffopt, RECURSIVE);
>>  	diff_setup_done(&diffopt);
>>  
>> -	base = lookup_commit_reference_by_name(base_commit);
>> -	if (!base)
>> -		die(_("Unknown commit %s"), base_commit);
>> -	oidcpy(&bases->base_commit, &base->object.oid);
>> +	if (!strcmp(base_commit, "auto")) {
>> +		curr_branch = branch_get(NULL);
>
>Can branch_get() return NULL?  Which ...
>
>> +		upstream = branch_get_upstream(curr_branch, NULL);
>
>... would cause branch_get_upstream() to give you an error (which
>you ignore)?  I guess that is OK because upstream will safely be set
>to NULL in that case.
>
Yes, branch_get_upstream(curr_branch, NULL) will safely return NULL if curr_branch
is NULL, so I think there is no need to add error handling for branch_get().

>> +		if (upstream) {
>> +			if (get_sha1(upstream, sha1))
>> +				die(_("Failed to resolve '%s' as a valid ref."), upstream);
>> +			commit = lookup_commit_or_die(sha1, "upstream base");
>> +			base_list = get_merge_bases_many(commit, total, list);
>> +			if (!bases)
>> +				die(_("Could not find merge base."));
>> +			base = base_list->item;
>> +			free_commit_list(base_list);
>
>What should happen when there are multiple merge bases?  The code
>picks one at random and ignores the remainder, if I am reading this
>correctly.

If there is more than one merge base, commits in base_list should be sorted by date,
if I am understanding it correctly, so base_list->item should be the lastest
merge base commit, it should be enough for us to used as base commit.

Thanks,
Xiaolong.
>
>> +			oidcpy(&bases->base_commit, &base->object.oid);
>> +		} else {
>> +			die(_("Failed to get upstream, if you want to record base commit automatically,\n"
>> +			      "please use git branch --set-upstream-to to track a remote branch.\n"
>> +			      "Or you could specify base commit by --base=<base-commit-id> manually."));
>> +		}
>> +	} else {
>> +		base = lookup_commit_reference_by_name(base_commit);
>> +		if (!base)
>> +			die(_("Unknown commit %s"), base_commit);
>> +		oidcpy(&bases->base_commit, &base->object.oid);
>> +	}
>>  
>>  	init_revisions(&revs, NULL);
>>  	revs.max_parents = 1;
