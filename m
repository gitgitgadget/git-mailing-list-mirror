From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Lines missing from git diff-tree -p -c output?
Date: Wed, 15 May 2013 10:17:43 -0700
Message-ID: <7vhai4cgco.fsf@alter.siamese.dyndns.org>
References: <20130515143508.GO25742@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Wed May 15 19:17:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcfKq-00076c-0L
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 19:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759720Ab3EORRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 13:17:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759615Ab3EORRq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 13:17:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02EB21E824;
	Wed, 15 May 2013 17:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=eJ0RxPh6/tfBIua1yxMpT19X/S8=; b=szOnaiErsAMt/EabBknB
	0A3/mlZxdhkxbiSHKbBgkFbRDXNX95qFr3C5bu9LbhrQLpngYPGi6h4NepmoBp6l
	gC3MCXdqptVGn/RMbb+n3RrGhnDBlrAPmWtyx3MC4FHXiqNrwaRSIsJU9Zm9+E6Q
	ABf7CTtKXoFVjNuON3ebusk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=fK0YFARaB4v9JRPnJPid6dCqUm9ExF81m7Dquk1BObbec7
	WV9xBKSLIraQHMunZwT9rVuaduHTJMwAjUsrFHP8o5nkkkkZS4Al5T55tzF5RcR7
	m9+z9GwXS7cWdRhjZZHfslzzuFff4wpB8+FEXPsVppQgD9zddgWjZgB2xsJ4c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE1A11E823;
	Wed, 15 May 2013 17:17:45 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5694A1E816;
	Wed, 15 May 2013 17:17:45 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5BD5CA0C-BD83-11E2-B081-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224426>

Matthijs Kooijman <matthijs@stdin.nl> writes:

> $ git diff-tree -p -c HEAD
> d945a51b6ca22e6e8e550c53980d026f11b05158
> diff --combined file
> index 3404f54,0eab113..e8c8c18
> --- a/file
> +++ b/file
> @@@ -1,7 -1,5 +1,6 @@@
>  +LEFT
>   BASE2
>   BASE3
>   BASE4
> - BASE5
> + BASE5MODIFIED
>   BASE6
>
> Here, the header claims that the first head has 7 lines, but there really are
> only 6 (5 lines of context and one delete line). The numbers for the others
> heads are incorrect. In the original diff, the difference was bigger
> (first head was stated to have 28 lines, while the output was similar to
> the above).

The count and the output does look inconsistent.  The hunk header
claims that it is showing:

 - range 1,7 for the first parent but it should be 1,5 (2, 3, 4, 5 and 6) 
   to match the output.
 - range 1,5 for the second parent (left, 2, 3, 4, 5mod, and 6 -- correct)
 - range 1,6 for the result (left, 2, 3, 4, 5mod and 6 -- correct)

If we resurrect the loss of "BASE1" from the output, then the
output should have shown:

  +LEFT
 - BASE1
   BASE2
   BASE3
   BASE4
 - BASE5
 + BASE5MODIFIED
   BASE6

which means the numbers shown for the first parent (1, 2, 3, 4, 5
and 6) should be 1,6.

> Note that to trigger this behaviour, the number of context lines between the
> BASE1 and BASE5 must be _exactly_ 3, more or less prevents this bug from
> occuring.

I think the coalescing of two adjacent hunks into one is painting
leading lines "interesting to show context but not worth showing
deletion before it" incorrectly.

Does this patch fix the issue?

 combine-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index 77d7872..7359b84 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -533,7 +533,7 @@ static int give_context(struct sline *sline, unsigned long cnt, int num_parent)
 		k = find_next(sline, mark, j, cnt, 0);
 		j = adjust_hunk_tail(sline, all_mask, i, j);
 
-		if (k < j + context) {
+		if (k <= j + context) {
 			/* k is interesting and [j,k) are not, but
 			 * paint them interesting because the gap is small.
 			 */
