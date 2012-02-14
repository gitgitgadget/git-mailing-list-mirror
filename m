From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diff --stat
Date: Tue, 14 Feb 2012 13:49:11 -0800
Message-ID: <7vty2t5bmw.fsf@alter.siamese.dyndns.org>
References: <7v4nuub7el.fsf@alter.siamese.dyndns.org>
 <20120214195036.GD12072@sigill.intra.peff.net>
 <7vfwed6uws.fsf@alter.siamese.dyndns.org>
 <20120214202934.GA23291@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:49:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQFV-0004gy-UB
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 22:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593Ab2BNVtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 16:49:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932557Ab2BNVtP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 16:49:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D421667E;
	Tue, 14 Feb 2012 16:49:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nO7N2c18yTNBIK51BcJGlIMv9ZE=; b=Ee5yVX
	BIg5U8xZ6+6Rbd3M55CJyVA1Lp1RDDJBmr1/iNkXlS3L7WykY0FUeHMGRVpD2RU8
	sbMhd151Cxvb4L4n1OjGl95IP+w4rtJCqEauJ8hmjPlaZHZKGiJXT4Wv6SVUR09m
	phvcRf2C1rPTzxyNcTdSGryC5+e+K3cBB33G0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s60Khl81SPfnyQgNFrrodxnrnjPkuU/M
	P0RTzcBhfmglrd1Ke9FvzOXdbfWQck1PWoTZBkYIzfLiMJDxxi4BTy4DAA45Ziji
	0gh0S0vhL6rkrTjaIjsclIB2/KM13xd4vwxDxcL/7uicisRwNJ6ptrEmZ5DXu70w
	lVlvvwMmR4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13D89667D;
	Tue, 14 Feb 2012 16:49:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6710F6679; Tue, 14 Feb 2012
 16:49:13 -0500 (EST)
In-Reply-To: <20120214202934.GA23291@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 14 Feb 2012 15:29:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBE9CF78-5755-11E1-9B19-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190766>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 14, 2012 at 12:07:31PM -0800, Junio C Hamano wrote:
>
>> Of course, an easy way out without worrying about the correct math is to
>> scale the total and the smaller one and then declare that the scaled
>> larger one is the difference between the two. That way, both of these two
>> files have 109 in total so the length of the entire graph would be the
>> same ;-).
>
> It looks like we actually did that, pre-3ed74e6. I think it's a valid
> strategy. It is just pushing the error around,...

Yes, that is exactly why I suggested that approach. We have to deal with
rounding error somewhere no matter what we do, and the balance between
add/del is much less noticeable than the change with the same total not
lining up.

Anyway, here is an obvious patch to fix this.  We did not have any test
that failed with this change, as all our test vectors fit comfortably on
the default 80-column output.

-- >8 --
Subject: diff --stat: resurrect "same for same" heuristic

When commit 3ed74e6 (diff --stat: ensure at least one '-' for deletions,
and one '+' for additions, 2006-09-28) improved the output for files with
tiny modifications, we accidentally broke rounding logic to ensure that
two equal sized changes are shown with the bars of the same length.

This updates the logic to compute the length of the graph bars, using the
same "non-zero changes is shown with at least one column" scaling logic,
but by scaling the sum of additions and deletions to come up with the
total length of the bar (this ensures that two equal sized changes result
in bars of the same length), and then scaling the smaller of the additions
or deletions. The other side is computed as the difference between the
two. This makes the apportioning between additions and deletions less
accurate due to rounding errors, but it is much less noticeable than two
files with the same amount of change showing bars of different length.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 3550c18..76d4724 100644
--- a/diff.c
+++ b/diff.c
@@ -1273,13 +1273,17 @@ const char mime_boundary_leader[] = "------------";
 
 static int scale_linear(int it, int width, int max_change)
 {
+	if (!it)
+		return 0;
 	/*
-	 * make sure that at least one '-' is printed if there were deletions,
-	 * and likewise for '+'.
+	 * make sure that at least one '-' or '+' is printed if
+	 * there is any change to this path. The easiest way is to
+	 * scale linearly as if all the quantities were one smaller
+	 * than they actually are, and then add one to the result.
 	 */
 	if (max_change < 2)
-		return it;
-	return ((it - 1) * (width - 1) + max_change - 1) / (max_change - 1);
+		return 1;
+	return 1 + ((it - 1) * (width - 1) / (max_change - 1));
 }
 
 static void show_name(FILE *file,
@@ -1495,8 +1499,19 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		dels += del;
 
 		if (width <= max_change) {
-			add = scale_linear(add, width, max_change);
-			del = scale_linear(del, width, max_change);
+			int total = add + del;
+
+			total = scale_linear(add + del, width, max_change);
+			if (total < 2 && add && del)
+				/* width >= 2 due to the sanity check */
+				total = 2;
+			if (add < del) {
+				add = scale_linear(add, width, max_change);
+				del = total - add;
+			} else {
+				del = scale_linear(del, width, max_change);
+				add = total - del;
+			}
 		}
 		fprintf(options->file, "%s", line_prefix);
 		show_name(options->file, prefix, name, len);
