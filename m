From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce filter_independent() in commit.c
Date: Sat, 21 Jun 2008 02:45:38 -0700
Message-ID: <7vr6arazp9.fsf@gitster.siamese.dyndns.org>
References: <7vabhgq02p.fsf@gitster.siamese.dyndns.org>
 <1214007784-4801-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jun 21 11:46:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9zgE-0006Ai-SY
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 11:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbYFUJpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 05:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbYFUJpx
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 05:45:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbYFUJpw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 05:45:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 48E8BA705;
	Sat, 21 Jun 2008 05:45:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6A094A703; Sat, 21 Jun 2008 05:45:45 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D4FA925E-3F76-11DD-89CF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85696>

Miklos Vajna <vmiklos@frugalware.org> writes:

> +struct commit_list *filter_independent(unsigned char *head,
> +	struct commit_list *heads)
> +{
> +	struct commit_list *b, *i, *j, *k, *bases = NULL, *ret = NULL;
> +	struct commit_list **pptr = &ret;
> +
> +	commit_list_insert(lookup_commit(head), &heads);

Isn't the special casing of head making this function less easier to reuse
in other contexts?  "show-branch --independent" is about getting N commits
and removing commits from that set that can be reachable from another
commit, so there is no need nor reason to treat one "head" in any special
way.

> +	for (i = heads; i; i = i->next) {
> +		for (j = heads; j; j = j->next) {
> +			if (i == j)
> +				continue;
> +			b = get_merge_bases(i->item, j->item, 1);
> +			for (k = b; k; k = k->next)
> +				commit_list_insert(k->item, &bases);
> +		}
> +	}

You run (N-1)*N merge-base computation to get all pairwise merge-bases
here.  As merge-base(A,B) == merge-base(B,A), this is computing the same
thing twice.

Isn't your "b" leaking?

> +	for (i = heads; i; i = i->next) {
> +		int found = 0;
> +		for (b = bases; b; b = b->next) {
> +			if (!hashcmp(i->item->object.sha1, b->item->object.sha1)) {
> +				found = 1;

Then you see if the given heads exactly match one of the merge bases you
found earlier.  But does this have to be in a separate pass?

Isn't your "bases" list leaking?

Even though you may be able to reduce more than 25 heads, you run N^2
merge base traversals, which means 625 merge base traversals for 25 heads;
show-branch engine can do the same thing with a single traversal.

Can't we do better than O(N^2)?

Let's step back a bit and think.  You have N commits (stop thinking about
"my head and N other heads" like your function signature suggests).  For
each one, you would want to see if it is reachable from any of the other
(N-1) commits, and if so, you would exclude it from the resulting set.
And you do that for all N commits and you are done.  You can relatively
easily do this with an O(N) traversals.

Now, if you have one commit and other (N-1) commits, is there a way to
efficiently figure out if that one commit is reachable from any of the
other (N-1) commits?

If there were a merge of these other (N-1) commits, and if you compute a
merge base between that merge commit and the one commit you are looking
at, what would you get?  Yes, you will get your commit back if and only if
it is reachable from some of these (N-1) commits.

If you recall the merge-base-many patch we discussed earlier, that is
exactly what it computes, isn't it?
