From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] toposort: rename "lifo" field
Date: Thu, 06 Jun 2013 18:25:30 -0700
Message-ID: <7vfvwuww39.fsf@alter.siamese.dyndns.org>
References: <1370369299-20744-1-git-send-email-me@ell.io>
	<1370369299-20744-2-git-send-email-me@ell.io>
	<7vip1t7koi.fsf@alter.siamese.dyndns.org>
	<7vobbl60aj.fsf@alter.siamese.dyndns.org>
	<CAPZ477OFM6D4n_Wz-OozN=aYn5-LmNA2ggL+9GNrbGrRQh9pRQ@mail.gmail.com>
	<7vobbjxc21.fsf@alter.siamese.dyndns.org>
	<7vvc5qx3cm.fsf@alter.siamese.dyndns.org>
	<7vppvyx1mv.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 03:26:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UklRA-0002Q7-6x
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 03:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678Ab3FGBZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 21:25:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51258 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755650Ab3FGBZm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 21:25:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2376D18D08;
	Fri,  7 Jun 2013 01:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JeRpmyqIcV75W0mvnE5icd3NXpU=; b=L/HHxI
	tvlOU0qlFNxuNoYlQxfMj0+N90bilcm6WTqY03rp57sLRTrcoIg+JhJgIa6UyRmg
	NXlce7KR2o2s2Skd+cSTp1GgTgDmWu765jC1nd+CI+X48pHsbTr/BDtwTWXFGsyn
	swTOZ5y23cL5kql96hpy0xQIQpVvWMdBphG7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bXjuxyjTnURMb1qqVh3onP+5lQ7B/CMw
	g7aMKmd+SyFByUyNSOfkfyZ69jwUrCMV36VkKrIEqbc7ixFcUA7Yh8f7VPsoIj+G
	zWjFm1/XWW1ropx/eSoZIvUL/4rjWRB+DrKyb3JRVWeqbzOr5oc2dgXZZxd/RWkv
	0WeC+Wsef8M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0221E18D03;
	Fri,  7 Jun 2013 01:25:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3856E18CF9;
	Fri,  7 Jun 2013 01:25:41 +0000 (UTC)
In-Reply-To: <7vppvyx1mv.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 06 Jun 2013 16:25:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2AB4C87A-CF11-11E2-83B0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226576>

Junio C Hamano <gitster@pobox.com> writes:

> When sorting commits topologically, the primary invariant is to emit
> all children before its parent is emitted.  When traversing a forked

s/its/their/;

>> As I needed to have an excuse to push jk/commit-info-slab topic
>> further (I have an unpublished show-branch rewrite on top of it),
>> I may take a look at doing this myself if/when I find some time.
>
>   So this is the first step, applies on top of jk/commit-info-slab.

The next step will be to replace the use of commit_list in this
function with a priority queue, whose API may look like what is at
the end of this message.

Then write a compare function that looks at commit->date field to
compare committer timestamp, and set it to commit_queue->compare
when REV_SORT_BY_COMMIT_DATE is asked for.  When doing the graph
traversal order, set compare function to NULL when initializing the
commit_queue and use it as a LIFO stack.

And the step after that will be to add an author-date field to the
commit-info-slab we currently use to keep track of indegree, grab
author timestamp from commits as we encounter them, and write
another comparison function to use that information (using the
cb_data field of commit_queue to point at the info slab) to
implement REV_SORT_BY_AUTHOR_DATE.  That step can also implement the
command line option parsing for the new --author-date-order option
(or alternatively, --date-order={author,committer}).


#ifndef COMMIT_QUEUE_H
#define COMMIT_QUEUE_H

/*
 * Compare two commits; the third parameter is cb_data in the
 * commit_queue structure.
 */
typedef int (*commit_compare_fn)(struct commit *, struct commit *, void *);

struct commit_queue {
	commit_compare_fn compare;
	void *cb_data;
	int alloc, nr;
	struct commit **array;
};

/*
 * Add the commit to the queue
 */
struct commit *commit_queue_put(struct commit_queue *, struct commit *);

/*
 * Extract the commit that compares the smallest out of the queue,
 * or NULL.  If compare function is NULL, the queue acts as a LIFO
 * stack.
 */
struct commit *commit_queue_get(struct commit_queue *);

#endif /* COMMIT_QUEUE_H */
