From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull takes ~8 seconds on up-to-date Linux git tree
Date: Fri, 05 Oct 2012 13:34:02 -0700
Message-ID: <7vehlcu091.fsf@alter.siamese.dyndns.org>
References: <20121004141454.GA246@x4>
 <20121004184314.GA15389@sigill.intra.peff.net>
 <7v391ux7im.fsf@alter.siamese.dyndns.org>
 <7vvceqvses.fsf@alter.siamese.dyndns.org>
 <7vmx01x3s4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 22:34:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKEbD-0005j6-6Q
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 22:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757278Ab2JEUeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 16:34:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50238 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757189Ab2JEUeF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 16:34:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF2FC868F;
	Fri,  5 Oct 2012 16:34:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OvbZiMd3IT6jO7yVOueyQadCRu4=; b=lDumxW
	SU3mWxtadrI5kSrFtwnQ5qPHZSGHKHX68KOVixTFAITnZHvWCP1+GvQ/aBl5DwXW
	o6OjbVy9T16liK81r4N//Nd15xFpp/+Z147z/5eWOMuCu+ZVWgjMpDwr7Fchb7lD
	5zbGENd/YoBOxbugAdCTAMI+0qt3KdnJskg1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B6INP3T6t9znQWo5+AKg8xWwnJUL6kPW
	IYkNJJuDXCcR2l1NI4BeWzThjJL28nESjZ2brCpCBlM3wdO8HRTnZ+0Je6SUAfFc
	fpaJvOw5ANGS4RrGjf3lKxs4RCM8TFWb0jzyvCLQBemUZegeoL/8+DqgmJcrbkDB
	gGT1f86hEpQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EE19868E;
	Fri,  5 Oct 2012 16:34:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AAB1868D; Fri,  5 Oct 2012
 16:34:03 -0400 (EDT)
In-Reply-To: <7vmx01x3s4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 04 Oct 2012 15:37:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0073CAA2-0F2C-11E2-AE2B-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207119>

Junio C Hamano <gitster@pobox.com> writes:

> Here is a tested (in the sense that it passes the test suite, and
> also in the sense that an empty pull in the kernel history gives
> quick turnaround) patch.  As I do not think we would want to revert
> 5802f81 (fmt-merge-msg: discard needless merge parents, 2012-04-18)
> which was a correctness fix, I think we would rather want to do
> something like this.

OK, I think I am convinced myself that this patch is the right fix.

The performance regression Markus saw is in fmt-merge-message, and
it is caused by the updated remove_redundant() that is used by
get_merge_bases_many() and reduce_heads().  On the topic branch, all
callers of reduce_heads() were passing commits that are already
parsed, but before the topic was merged to 'master', we added one
more caller to reduce_heads() on the 'master' front that passed an
unparsed commit, which is why the problem surfaced at that merge.

It might make sense to assert or die in commit_list_insert_by_date()
when a caller mistakenly pass an unparsed commit object to prevent
this kind of breakages in the future.

> -- >8 --
> Subject: paint_down_to_common(): parse commit before relying on its timestamp
>
> When refactoring the merge-base computation to reduce the pairwise
> O(n*(n-1)) traversals to parallel O(n) traversals, the code forgot
> that timestamp based heuristics needs each commit to have been
> parsed.  This caused an empty "git pull" to spend cycles, traversing
> the history all the way down to 0 (because an unparsed commit object
> has 0 timestamp, and any other commit object with positive timestamp
> will be processed for its parents, all getting parsed), only to come
> up with a merge message to be used.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  commit.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git i/commit.c w/commit.c
> index 0246767..213bc98 100644
> --- i/commit.c
> +++ w/commit.c
> @@ -609,6 +609,7 @@ static struct commit *interesting(struct commit_list *list)
>  	return NULL;
>  }
>  
> +/* all input commits in one and twos[] must have been parsed! */
>  static struct commit_list *paint_down_to_common(struct commit *one, int n, struct commit **twos)
>  {
>  	struct commit_list *list = NULL;
> @@ -617,6 +618,8 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
>  
>  	one->object.flags |= PARENT1;
>  	commit_list_insert_by_date(one, &list);
> +	if (!n)
> +		return list;
>  	for (i = 0; i < n; i++) {
>  		twos[i]->object.flags |= PARENT2;
>  		commit_list_insert_by_date(twos[i], &list);
> @@ -737,6 +740,8 @@ static int remove_redundant(struct commit **array, int cnt)
>  	redundant = xcalloc(cnt, 1);
>  	filled_index = xmalloc(sizeof(*filled_index) * (cnt - 1));
>  
> +	for (i = 0; i < cnt; i++)
> +		parse_commit(array[i]);
>  	for (i = 0; i < cnt; i++) {
>  		struct commit_list *common;
>  
