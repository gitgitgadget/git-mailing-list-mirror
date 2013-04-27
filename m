From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/3] simplify-merges: never remove all TREESAME parents
Date: Sat, 27 Apr 2013 16:02:55 -0700
Message-ID: <7vli83shk0.fsf@alter.siamese.dyndns.org>
References: <517AD304.6020807@bracey.fi>
	<1367004718-30048-1-git-send-email-kevin@bracey.fi>
	<1367004718-30048-2-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sun Apr 28 01:03:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWE9C-0008Dv-T3
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 01:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704Ab3D0XC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 19:02:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985Ab3D0XC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 19:02:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCBE11A6D8;
	Sat, 27 Apr 2013 23:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tMcAuS/PU1DrlqrGNQk3KaH9ShQ=; b=xARg2n
	91ChL/vvX2DrchBqfK9ZZHjc7xyvTAprchac8iiRdONITd6F5HaJsikuCYTY3rfv
	4G7WJJrqWVvyvhRi8O5c/qQINUJpOmidzDXnUNk+CsdygpynbPt8lFOyIfzu6mWk
	NgfniARuIyYFLA4JJujzp/m5hvRuI0LYCXZS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rvAq1EtDcLoFy1X88f2+qslB0smNOaRx
	ByVQ5tpZZmhuZS7L7lHQwGUmgq18DhPPiYSa3yFMGU8BUatXYFjtKNTmUaJfDOo5
	0PZFn7PXLFA/qjSDGPo3Lb/qzG8FvPsQMnNQKQCmPbblDM01hmYolE0EMH3+DoEb
	fzawaVBkGjA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3A471A6D6;
	Sat, 27 Apr 2013 23:02:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 137D71A6D5;
	Sat, 27 Apr 2013 23:02:56 +0000 (UTC)
In-Reply-To: <1367004718-30048-2-git-send-email-kevin@bracey.fi> (Kevin
	Bracey's message of "Fri, 26 Apr 2013 22:31:57 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 998CC682-AF8E-11E2-BD3E-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222713>

Kevin Bracey <kevin@bracey.fi> writes:

> In the event of an odd merge, we may find ourselves TREESAME to
> apparently redundant parents. Prevent simplify_merges() from removing
> every TREESAME parent - in the event of such a merge it's useful to see
> where we came actually from came.
>
> Signed-off-by: Kevin Bracey <kevin@bracey.fi>
> ---
>  Documentation/rev-list-options.txt |  3 ++-
>  revision.c                         | 24 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 380db48..0832004 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -472,7 +472,8 @@ history according to the following rules:
>  +
>  * Replace each parent `P` of `C'` with its simplification `P'`.  In
>    the process, drop parents that are ancestors of other parents, and
> -  remove duplicates.
> +  remove duplicates, but take care to never drop all parents that
> +  we are TREESAME to.
>  +
>  * If after this parent rewriting, `C'` is a root or merge commit (has
>    zero or >1 parents), a boundary commit, or !TREESAME, it remains.
> diff --git a/revision.c b/revision.c
> index 176eb7b..4e27c9a 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2106,8 +2106,32 @@ static int remove_marked_parents(struct rev_info *revs, struct commit *commit)
>  {
>  	struct treesame_state *ts = lookup_decoration(&revs->treesame, &commit->object);
>  	struct commit_list **pp, *p;
> +	struct commit *su = NULL, *sm = NULL;

What do "su" and "sm" stand for?

>  	int n, removed = 0;
>  
> +	/* Prescan - look for both marked and unmarked TREESAME parents */
> +	for (p = commit->parents, n = 0; p; p = p->next, n++) {
> +		if (ts->treesame[n]) {
> +			if (p->item->object.flags & TMP_MARK) {
> +				if (!sm) sm = p->item;
> +			}
> +			else {
> +				if (!su) {
> +					su = p->item;
> +					break;
> +				}
> +			}
> +		}
> +	}
> +
> +	/* If we are TREESAME to a marked-for-deletion parent, but not to any
> +	 * unmarked parents, unmark the first TREESAME parent. We don't want
> +	 * to remove our "real" parent in the event of an "-s ours" type
> +	 * merge.

Could you explain here a bit more the reason why we do not want to
remove them and why "-s ours" is so significant that it deserves to
be singled out?  And why randomly picking one that is redundant
(because it is an ancestor of some other parent) is an improvement?

The "remove-redundant" logic first marks commits that are ancestors
of other commits in the original set, without taking treesame[] into
account at all.  If the final objective of the code is to keep paths
that consists of non-treesame[] commits, perhaps the logic needs to
be changed to reject non-treesame[] commits that are ancestors of
other non-treesame[] commits, or something?

> +	 */
> +	if (!su && sm)
> +		sm->object.flags &= ~TMP_MARK;
> +
>  	pp = &commit->parents;
>  	n = 0;
>  	while ((p = *pp) != NULL) {
