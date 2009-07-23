From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 23:04:59 -0700
Message-ID: <7vy6qg2aus.fsf@alter.siamese.dyndns.org>
References: <20090722235914.GA13150@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain>
 <20090723012207.GA9368@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <7vtz146mgr.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907222204310.21520@localhost.localdomain>
 <7veis83q0e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 08:05:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTrQb-0001xa-4d
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 08:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbZGWGFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 02:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbZGWGFH
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 02:05:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58150 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbZGWGFG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 02:05:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B6AB10AFA;
	Thu, 23 Jul 2009 02:05:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 91ACA10AF8; Thu,
 23 Jul 2009 02:05:00 -0400 (EDT)
In-Reply-To: <7veis83q0e.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 22 Jul 2009 22\:52\:17 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C48A6550-774E-11DE-8E9A-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123846>

Junio C Hamano <gitster@pobox.com> writes:

> Exactly.
>
> That is_null_sha1() thing was a remnant of your idea to represent deleted
> ref that has a packed counterpart by storing 0{40} in a loose ref, so that
> we can implement deletion efficiently.
>
> Since we currently implement deletion by repacking packed refs if the ref
> has a packed (possibly stale) one, we do not use such a "negative ref",
> and skipping 0{40} done by the normal (i.e. non-raw) for_each_ref() family
> is not necessary.
>
> I was inclined to say that, because I never saw anybody complained that
> deleting refs was too slow, we declare that we would forever stick to the
> current implementation of ref deletion, and remove the is_null_sha1()
> check from the do_one_ref() function, even for include-broken case.
>
> But after thinking about it again, I'd say "if null, then skip" should be
> outside the DO_FOR_EACH_INCLUDE_BROKEN anyway, because the null check is
> not about brokenness of the ref, but is about a possible future expansion
> to represent deleted ref with such a "negative ref" entry.
>
> If we remove is_null_sha1() from do_one_ref(), or if we move it out of the
> "include broken" thing, my "Not exactly nice" comment can be rescinded, as
> doing the former (i.e. removal of is_null_sha1() check) is a promise that
> we will never have to worry about negative refs, and doing the latter will
> still protect callers of do_for_each_rawref() from negative refs if we
> ever introduce them in some future.

That is, a patch like this (this should go to 'maint'), and my worries
will go away.

-- >8 --
Subject: do_one_ref(): null_sha1 check is not about broken ref

f8948e2 (remote prune: warn dangling symrefs, 2009-02-08) introduced a
more dangerous variant of for_each_ref() family that skips the check for
dangling refs, but it also made another unrelated check optional by
mistake.

The check to see if a ref points at 0{40} is not about brokenness, but is
about a possible future plan to represent a deleted ref by writing 40 "0"
in a loose ref when there is a stale version of the same ref already in
.git/packed-refs, so that we can implement deletion of a ref without
having to rewrite the packed refs file excluding the ref being deleted.
This check has to be outside of the conditional.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index bb0762e..3da3c8c 100644
--- a/refs.c
+++ b/refs.c
@@ -531,9 +531,10 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 {
 	if (strncmp(base, entry->name, trim))
 		return 0;
+	/* Is this a "negative ref" that represents a deleted ref? */
+	if (is_null_sha1(entry->sha1))
+		return 0;
 	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
-		if (is_null_sha1(entry->sha1))
-			return 0;
 		if (!has_sha1_file(entry->sha1)) {
 			error("%s does not point to a valid object!", entry->name);
 			return 0;
