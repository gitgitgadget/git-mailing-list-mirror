From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix revision walk for commits with the same dates
Date: Fri, 22 Mar 2013 13:45:47 -0700
Message-ID: <7va9pv6u4k.fsf@alter.siamese.dyndns.org>
References: <20130307180321.GA26756@camk.edu.pl>
 <20130322183819.GA18210@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 21:46:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ8qx-0005DS-RA
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 21:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422959Ab3CVUpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 16:45:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422946Ab3CVUpu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 16:45:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D88FDB229;
	Fri, 22 Mar 2013 16:45:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FspDBDyeMtVuGD25qA43ffhi47c=; b=uqNFIz
	TL7b/BQf4wAH63hZeMKxXyK5YNV/D24wMeBEh7oi4Cl7fSWJxXweID2CjoIncB6n
	r0IYSFN5/YpvDbHaYf2P+hJHhTMMQVjDU22HEn2hR0N1BJf5FiP2ZZF5a0bKJtYp
	DXsFfSw+pta1mi+5kgKBFa1YWEArFjv1qbnns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nbulW9a/xrF44kpJbx+6zJXvZ24SsoOx
	FyEK69ZH6kh3n6kgFlYLXHDC8c+uJcEVr4LDcMzMWUjDVKh65kO+R8kbcqvFOGoQ
	mO4BDdbSZrAA5AvAL2pQoaadImtGvwkYYizwNIyWE5S/YiLVv50Px9TM9uewNvpE
	EpIooi/uE/k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD866B228;
	Fri, 22 Mar 2013 16:45:49 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19E1AB226; Fri, 22 Mar 2013
 16:45:49 -0400 (EDT)
In-Reply-To: <20130322183819.GA18210@camk.edu.pl> (Kacper Kornet's message of
 "Fri, 22 Mar 2013 19:38:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A6C5138-9331-11E2-B7E6-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218843>

Kacper Kornet <draenog@pld-linux.org> writes:

> Logic in still_interesting function allows to stop the commits
> traversing if the oldest processed commit is not older then the
> youngest commit on the list to process and the list contains only
> commits marked as not interesting ones. It can be premature when dealing
> with a set of coequal commits. For example git rev-list A^! --not B
> provides wrong answer if all commits in the range A..B had the same
> commit time and there are more then 7 of them.
>
> To fix this problem the relevant part of the logic in still_interesting
> is changed to: the walk can be stopped if the oldest processed commit is
> younger then the youngest commit on the list to processed.

Is the made-up test case to freeze the clock even interesting?  The
slop logic is merely a heuristic to compensate for effects caused by
skewed or non-monototic clocks, so in a different repository you may
even need to fuzz the timestamp comparison further

	if (date - 10 < src->item->date)

or something silly like that.



> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
> ---
>
> I don't know whether the first version was overlooked or deemed as not
> worthy. So just in case I resend it. Changes since the first version:
>
> 1. The test has been added
> 2. The commit log has been rewritten
>
>
>  revision.c                 |  2 +-
>  t/t6009-rev-list-parent.sh | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index ef60205..cf620c6 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -709,7 +709,7 @@ static int still_interesting(struct commit_list *src, unsigned long date, int sl
>  	 * Does the destination list contain entries with a date
>  	 * before the source list? Definitely _not_ done.
>  	 */
> -	if (date < src->item->date)
> +	if (date <= src->item->date)
>  		return SLOP;
>  
>  	/*
> diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
> index 3050740..66cda17 100755
> --- a/t/t6009-rev-list-parent.sh
> +++ b/t/t6009-rev-list-parent.sh
> @@ -133,4 +133,17 @@ test_expect_success 'dodecapus' '
>  	check_revlist "--min-parents=13" &&
>  	check_revlist "--min-parents=4 --max-parents=11" tetrapus
>  '
> +
> +test_expect_success 'ancestors with the same commit time' '
> +
> +	test_tick_keep=$test_tick &&
> +	for i in 1 2 3 4 5 6 7 8; do
> +		test_tick=$test_tick_keep
> +		test_commit t$i
> +	done &&
> +	git rev-list t1^! --not t$i >result &&
> +	>expect &&
> +	test_cmp expect result
> +'
> +
>  test_done
> -- 
> 1.8.2
