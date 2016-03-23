From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] format-patch: introduce --base=auto option
Date: Wed, 23 Mar 2016 11:25:41 -0700
Message-ID: <xmqqbn65caqi.fsf@gitster.mtv.corp.google.com>
References: <1458723147-7335-1-git-send-email-xiaolong.ye@intel.com>
	<1458723147-7335-4-git-send-email-xiaolong.ye@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Xiaolong Ye <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 19:25:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ainTZ-0004f9-Cj
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 19:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbcCWSZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 14:25:45 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755945AbcCWSZo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 14:25:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 627244E112;
	Wed, 23 Mar 2016 14:25:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g2VIR0+GyWlT17oM1wHB0V0FyvI=; b=EXnYr3
	Z/LXSuxGSfgzrUHJobxhZ4Eh/ydWBXwSmeH2y+RshiTYMCFEA6mtkS50g9lLYzYJ
	KyE6v9Bl09hOC/PGeCm7jkqXn834mzMrWrs4+P9ghT6ft5MuwfoHh89dLrsahkxQ
	nA+psGLMLkOPCex/DAz30WjmDgbY0CFUyxn4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZB2+qJiduyvXqwu0CE8xtgAfvwv3zFMq
	dethjOwlKl+AOX4iZG8K/T6ZTzO1j2GTUVTtJ9279Z+eSyOH18vqaIscHzu2fQwT
	O8idrdLPJGIoABke6+Zdcd9/yVQ58ZRy1Kt1JL1682Te7nVWYGHMp5HepuLmhSta
	Oj5LDeupnYs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 59D574E111;
	Wed, 23 Mar 2016 14:25:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D03554E110;
	Wed, 23 Mar 2016 14:25:42 -0400 (EDT)
In-Reply-To: <1458723147-7335-4-git-send-email-xiaolong.ye@intel.com>
	(Xiaolong Ye's message of "Wed, 23 Mar 2016 16:52:26 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A7108804-F124-11E5-B32C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289673>

Xiaolong Ye <xiaolong.ye@intel.com> writes:

> +
> +	diff_setup(&diffopt);
> +	DIFF_OPT_SET(&diffopt, RECURSIVE);
> +	diff_setup_done(&diffopt);

It is annoying that you moved "diff" stuff here (if it can be
initialized once at the beginning and then reused over and over,
it should have been done here from the beginning at PATCH 2/4).

> +	if (!strcmp(base_commit, "auto")) {
> +		curr_branch = branch_get(NULL);
> +		upstream = branch_get_upstream(curr_branch, NULL);
> +		if (upstream) {
> +			if (get_sha1(upstream, sha1))
> +				die(_("Failed to resolve '%s' as a valid ref."), upstream);
> +			base = lookup_commit_or_die(sha1, "upstream base");
> +			oidcpy(&bases->base_commit, &base->object.oid);
> +		} else {
> +			commit_patch_id(prerequisite_head, &diffopt, sha1);
> +			oidcpy(&bases->parent_commit, &prerequisite_head->object.oid);
> +			hashcpy(bases->parent_patch_id.hash, sha1);
> +			return;

What happens if you did this sequence?

	$ git fetch origin
        $ git checkout -b fork origin/master
        $ git fetch origin
        $ git format-patch --base=auto origin..

You grab the updated origin/master as base and use it here, no?
At that point the topology would look like:

          1---2---3 updated upstream
         /
	0---X---Y---Z---A---B---C
        ^
        old upstream

so you are basing your worn on "0" (old upstream) but setting base
to "3"

Wouldn't that trigger "base must be an ancestor of Z" check you had
in [PATCH 2/4]?

I also do not see the point of showing "parent id" which as far as I
can see is just a random commit object name and show different
output that is not even described what it is.  It would be better to

 * find the upstream (i.e. 3 in the picture) and then with our range
   (i.e. A B and C) compute the merge base (i.e. you would find 0)
   and use it as base;

 * if there is no upstream, error out and tell the user that there
   is no upstream.  The user is intelligent enough and knows what
   commit the base should be.

I suspect, but I didn't think things through.
