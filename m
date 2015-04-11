From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] t4059: test 'diff --cc' with a change from only few parents
Date: Sat, 11 Apr 2015 14:07:25 -0700
Message-ID: <xmqqa8ye5q7m.fsf@gitster.dls.corp.google.com>
References: <1428006853-21212-1-git-send-email-max@max630.net>
	<1428076716-4449-1-git-send-email-max@max630.net>
	<1428076716-4449-2-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sat Apr 11 23:07:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yh2cq-0005mJ-70
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 23:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbbDKVH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2015 17:07:28 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753347AbbDKVH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2015 17:07:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C96804623A;
	Sat, 11 Apr 2015 17:07:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y3Iv+KdXDOUI3u6HUWV2kYg2wbo=; b=Qv4/4Q
	GVgycUSdaLY1sTPIGGKWIN7AqMaYOPsackqvAxxWfw8EiK3FaUPE2E4P+vmUSGtu
	qAmAuK1SuSDoj98oAOJG0UnDrwZRF7cHEDOTJpFZbJt0nXc1nXBA3xJ4vGwScaN9
	6D1yOGZLStRbuoJcZIt/sZaPowGDkhCz3AUPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D5Wp+HUbRwjbSnJXIDUIngJqt8zMXESn
	qj9c2hTm8afPnObuVopq1a8lTZeJEZhSyI9qIABmWD2UM57Vwz7RWt7crUS04NOe
	v/O2LSGeny9kbLMynWSxjZwqwrzHA9skMQN4Hkf8MMpSxKsfkP7naustLt/WSMcs
	QPAgsnohC7w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C2D7746239;
	Sat, 11 Apr 2015 17:07:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C73A46238;
	Sat, 11 Apr 2015 17:07:26 -0400 (EDT)
In-Reply-To: <1428076716-4449-2-git-send-email-max@max630.net> (Max Kirillov's
	message of "Fri, 3 Apr 2015 18:58:33 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C1706112-E08E-11E4-B40F-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267033>

Max Kirillov <max@max630.net> writes:

> If `git diff --cc` is used with 2 or more parents, then it shows
> all hunks which have changed compared to at least 2 parents.
> Which is reasonable, because those places are likely places for
> conflicts, and it should be displayed how they were resolved.

OK.

> But, preliminary path filtering passes a path only it was changed
> compared to each parent.

That is true, but I am a bit confused by the above, especially the
word "But" that begins the sentence.  Are you talking about this
comment that describes what the caller wants to do?

    /* find set of paths that every parent touches */
    static struct combine_diff_path *find_paths_generic(const unsigned char *sha1,
            const struct sha1_array *parents, struct diff_options *opt)

When the result of a merge exactly matches one (or more) of the
parent of the merge, we do not want to show it in the combined
format, so intersect_paths() does want to find paths that are
different from all parents.  Isn't that a good thing?

> So, if a hunk which has not changed compared to some of parents is
> shown if there are more changed hunks in the file, but not shown
> if it is the only change.
>
> This looks inconsistent and for some scenarios it is desirable to show
> such changes.

Hmm, that may be true.  So help me see if I understand your goal by
checking if I rephrased you correctly below:

 - We want to show a combined hunk when the number of parent
   variants for the hunk is more than 2 (i.e. interesting octopus)
   or the result does not match any of the parents (i.e. conflict
   resolution of a pairwise merge).  We want to drop a hunk whose
   result came from only one set of parent and the other parents had
   the same original that is different from the result.

 - The current code filters out a path that matches one of the
   parents very early.  This is OK for a two-way merge.  If the
   result matches one of the parent's, then any hunk we might
   produce by not pre-filtering would have the result that came from
   one parent (i.e. the one identical to the result) and there is
   only one other parent, which cannot make it an interesting
   octopus by definition.

   But an octopus may merge three variants and pick the result from
   one of the parents as a whole.  With the pre-filtering, no hunk
   from such a path is shown, even when the other two variants in
   "discarded" parents are not identical.

The original to refer to are two commits bf1c32bd (combine-diff:
update --cc "uninteresting hunks" logic., 2006-02-02) and fd4b1d21
(combine-diff: add safety check to --cc., 2006-02-02).

Especially, we need to pay close attention to the discussion that
germinated the current behaviour:

  http://thread.gmane.org/gmane.comp.version-control.git/15486/focus=15519

I recall that the "diff --cc" before that change was not discarding
uninteresting merges sufficiently and the two commits were a
deliberate attempt to reject what your series wants to show as
uninteresting hunks.  

Two suggestions.

 - This is primarily for 2/4, but can we make it more clear in the
   code that we do this "include more" change only on Octopus
   merges?  This change should not make any difference for two-way
   merges and I'd prefer to avoid extra processing of finding
   matching hunks and combining, only to discard the result.

 - Can you run "diff --cc" with and without your patches to the
   "merge from hell" commit mentioned in the original thread and see
   if we show more hunks with your patches, and make sure what are
   shown additionally looked really "interesting"?

Thanks.
