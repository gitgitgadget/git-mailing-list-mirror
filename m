From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/8] combine-diff: do not pass revs->dense_combined_merges redundantly
Date: Mon, 08 Sep 2014 10:29:41 -0700
Message-ID: <xmqqvboynhq2.fsf@gitster.dls.corp.google.com>
References: <cover.1409860234.git.tr@thomasrast.ch>
	<33951a1d4be8ec15eec569e1a36c0a620b9edaa6.1409860234.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Sep 08 19:29:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR2lG-0007gw-Qv
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 19:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbaIHR3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 13:29:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61974 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071AbaIHR3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 13:29:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B30B36C56;
	Mon,  8 Sep 2014 13:29:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=07Nhd11Va6kkEu2HtdNjZ3+fZwQ=; b=kiF/Q4
	ckePF3MNbYJINfk//2qQKSXQhyef9CDLB1C5g/empLBl1oc3iumFh7wpC10pn48G
	/9wqXeKy7USQaaU1I53Bi9Dz2lu+LaQetR6i8uUgPsluZ10tUFsNROqqReivg0Wi
	CbXqPzEEZ12mrDFf+TCCIOkJAaXbSfMJ41wts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QNorYeUasP/z8ZNI7/t7ArZenC1H6lDI
	LeM1x41w4NlKKBLhsVohu162vuPuK4D0ufjRae0ZlKAnU0tRM2CfneZZPRe2uozD
	XI9jgkjgCd7R6+s6s+MLJG8r+gVqKRRK8FqhEIEFnZepAi2+NDCOVHYXq5VvvCXV
	Ut9IK0n+/uE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F7BC36C54;
	Mon,  8 Sep 2014 13:29:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A319036C53;
	Mon,  8 Sep 2014 13:29:43 -0400 (EDT)
In-Reply-To: <33951a1d4be8ec15eec569e1a36c0a620b9edaa6.1409860234.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Sat, 6 Sep 2014 19:57:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B8AE2312-377D-11E4-96FB-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256658>

Thomas Rast <tr@thomasrast.ch> writes:

> The existing code passed revs->dense_combined_merges along revs itself
> into the combine-diff functions, which is rather redundant.  Remove
> the 'dense' argument until much further down the callchain to simplify
> callers.

It was not apparent that the changes to diff_tree_combined_merge()
was correct without looking at both of its callsites, but one passes
the .dense_combined_merges member, and the other in submodules
always gives true, which you covered here:

> Note that while the caller in submodule.c needs to do extra work now,
> the next commit will simplify this to a single setting again.

> diff --git a/submodule.c b/submodule.c
> index c3a61e7..0499de6 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -482,10 +482,13 @@ static void find_unpushed_submodule_commits(struct commit *commit,
>  	struct rev_info rev;
>  
>  	init_revisions(&rev, NULL);
> +	rev.ignore_merges = 0;
> +	rev.combined_merges = 1;
> +	rev.dense_combined_merges = 1;
>  	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
>  	rev.diffopt.format_callback = collect_submodules_from_diff;
>  	rev.diffopt.format_callback_data = needs_pushing;
> -	diff_tree_combined_merge(commit, 1, &rev);
> +	diff_tree_combined_merge(commit, &rev);
>  }

I briefly wondered if there can be any unwanted side effects in this
particular codepath that is caused by setting rev.combined_merges
which was not set in the original code, but seeing that this &rev is
not used for anything other than diff_tree_combined_merge(), it
should be OK.

Also I wondered if this is leaking whatever in the &rev structure,
but in this call I think rev is used only for its embedded diffopt
in a way that does not leak anything, so it seems to be OK, but I'd
appreciate if submodule folks can double check.

Thanks.
