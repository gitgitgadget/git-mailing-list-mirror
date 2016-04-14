From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v4 2/4] format-patch: add '--base' option to record base
 tree info
Date: Thu, 14 Apr 2016 22:23:33 +0800
Message-ID: <20160414142333.GA31621@yexl-desktop>
References: <1460342873-28900-1-git-send-email-xiaolong.ye@intel.com>
 <1460342873-28900-3-git-send-email-xiaolong.ye@intel.com>
 <xmqq7fg2r6fi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 16:24:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqiCV-0008Px-K9
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 16:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020AbcDNOYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 10:24:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:43879 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756628AbcDNOYo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 10:24:44 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP; 14 Apr 2016 07:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,485,1455004800"; 
   d="scan'208";a="686245205"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.139])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Apr 2016 07:24:27 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com
Content-Disposition: inline
In-Reply-To: <xmqq7fg2r6fi.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291524>

On Tue, Apr 12, 2016 at 12:08:33PM -0700, Junio C Hamano wrote:
>> +static void prepare_bases(struct base_tree_info *bases,
>> +			  const char *base_commit,
>> +			  struct commit **list,
>> +			  int total)
>> +{
>> +	struct commit *base = NULL, *commit;
>> +	struct rev_info revs;
>> +	struct diff_options diffopt;
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
>> +	revs.topo_order = 1;
>> +	for (i = 0; i < total; i++) {
>> +		if (!in_merge_bases(base, list[i]) || base == list[i])
>> +			die(_("base commit should be the ancestor of revision list"));
>
>This check looks overly expensive, but I do not think of a more
>efficient way to do this, given that "All the commits from our
>series must reach the specified base" is what you seem to want.
>
>My understanding is that if base=P is given and you are doing
>"format-patch Z..C" in this picture:
>
>    Q---P---Z---B---*---C
>     \             /
>      .-----------A
>

How about we compute the merge base of the specified rev list in
cmdline (it should be Q in above case), then check whether specified
base (P in this case) could be reachable from it, if it couldn't, we
just error out.

>your list would become A, B and C, and you want to detect that P is
>not an ancestor of A.  merge_bases_many() computes a wrong thing for
>this use case, and you'd need to go one-by-one.
>
>Unless there is some clever trick to take advantage of the previous
>traversal you made in order to find out A, B and C are the commits
>that are part of your series somehow.
>
>Anybody with clever ideas?
>
