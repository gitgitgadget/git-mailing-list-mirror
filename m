From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/48] Handling more corner cases in merge-recursive.c
Date: Sat, 11 Jun 2011 11:12:03 -0700
Message-ID: <7vipsctez0.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 20:12:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVSfT-0004Qg-Kg
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 20:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598Ab1FKSMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2011 14:12:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab1FKSMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2011 14:12:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 169E251E4;
	Sat, 11 Jun 2011 14:14:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dSx4JIOq/wKomj4HLU5Y7h7XNWM=; b=h5N4ul
	RUczw5UX6/GsSGu7mjhAeCO0U4K3QagtzVZ2d2eh/JHHKIeerq0LPfL7TxBomRAY
	j6/LajHeD8w8LedOAgUfZpmgc2QU5GOF7pb7p7PawCw5INWVu/gqZxtLtK0WOZhc
	qHRzeRkbBmDM8XhtCg/lPJLOa1VfFKnUCLtHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v9N/Zhc88HSCXk8NUvv3M1Bmk/48MFVS
	PxDNI0M5ym/tcVqkbcQq4hzlnqhf6+KCa95w7zW51iomFF5iQ9D+jVsv21wjn6yb
	hHzLpl+3cWnR5mVaOIjoz34F5WVOtNx+CRLgyrea7i/rBTriwJ/yuvEKsvPKTKYK
	RDYLzBNS3hw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D8DC251E3;
	Sat, 11 Jun 2011 14:14:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8AECE51E2; Sat, 11 Jun 2011
 14:14:13 -0400 (EDT)
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Wed, 8 Jun 2011 01:30:30 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F130BFC-9456-11E0-A1AD-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175642>

Elijah Newren <newren@gmail.com> writes:

> You can note that I did not fix all the testcases I added.  I consider
> some cases either unfixable or not worth fixing.

Thanks for working on these.  A quick comment (after reading a handful of
tests in the early part of the series) I have on rename cases is that the
test might be aiming too high to be too strict in "undetected rename"
cases. Consider:

 - We start from commit A that has path file1 where commit B and C fork
   from;
 - One side, commit B, renames file1 to file2 and edits file2;
 - The other side, commit C, modifies file1.

When merging B and C, we will ideally want to see file1 removed and
content level merge done between C's edit to file1 and B's edit to file2
left in file2. The content level merge may or may not conflict, and if
it cleanly merges, then that is Ok.

But if B's edit is too extensive, we may see what B did as "delete file1,
add file2", and we may report conflict at file1 (delete/modify) while
resolving file2 cleanly (one side added). When notifying the user with
delete/modify conflict at file1, we should make him aware that among the
paths added by the merge (i.e. file2) there might be a corresponding
rewrite of it on the other side, so that such a case can be manually
merged. As long as that is done, a test of such a case should consider
both clean merge (rename noticed) and a conflict at the tree structure
level (delete/modify with new) valid expected result, I think.

To put it another way, merge-recursive should expect that one side of
history may rewrite a path it renames beyond recognition, and when
punting, loudly ask the user for help, with enough information to help the
user to help it (e.g. perhaps say "file1 has delete/modify conflict; the
deleted side has added file2---you the user might want to inspect it and
see if it is a rename with extensive rewrite and resolve it accordingly if
that is the case").  We might want to dig deeper at that point by checking
the similarity again between the two blobs ourselves at that stage before
punting.

If we change what C did to "removes file1", instead of "modifies file1",
the story changes.

When merging B and C, that would be rename/delete conflict (B renamed, C
deleted). However, if we see that B's history as "delete file1 and add
file2", it would merge cleanly with C that deletes file1. The end result
would be an addition of file2. This tastes bad, as it will end up with a
clean merge that the user may not even notice.

Ideally we would want the merge to somehow warn the user to see if the
added "file2" still is wanted, and the worst part of this problem is that
this cannot be mechanically inferred. We could warn against every merge
that has a history that adds new paths and removes some other paths, but
then the warning becomes meaningless.

The changes done by B to the other parts of the tree (that wasn't involved
in the conflict) still want the updated content in file2 to work
correctly, and the changes done by C will not want the original content in
file1 (now in file2). The latter may or may not care about the presense of
what was added to "file2" by B. If C's work was to remove file1 that was
nothing but dead code (and other parts of C's work removed all the
callsite of code in original "file1" to make them dead), while B's work
was to add a code with purpose similar to the original code "file1" had
(and other parts of B's work calls that new code), then the right merge
result of "file2" might be to keep the line removal of dead code made by C
while keeping the code added by B there. So (I am thinking aloud here
without thinking things through) a possible approach to this issue might
involve considering a removal of a path and modifying the contents of a
path to make it empty similarly.

> However, there is one large class of problems that I think is fixable,
> I'm just not sure whether it is worth fixing.  git's rename detection
> optimization of only considering files that exist on one side of the
> diff but not the other causes issues with merges (undetected conflicts,
> spurious conflicts, or merged cleanly but wrongly due to deleting files
> that should be present).  To fix these cases, we would need some way of
> including rewritten files as potential rename candidates,...

This may be part of the larger "when punting, loudly ask the user for
help, or we may want to go deeper". If we can come up with a way to avoid
"undetected conflicts" ("merged cleanly but wrongly" is saying the same
thing as "undetected conflicts"), maybe we can attempt a cheap way first,
and then only when we know there is something complicated going on, we can
redo the diff with -B/-M options on. Spurious conflicts can be handled the
same way, as we should be able to come up with a clean merge once we dig
deeper (that's the definition of "spurious", right?).
