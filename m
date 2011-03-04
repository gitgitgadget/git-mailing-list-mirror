From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 14:58:32 -0800
Message-ID: <7vhbbi5w87.fsf@alter.siamese.dyndns.org>
References: <4D70EBC3.3010400@colin.guthr.ie>
 <7vr5am7p30.fsf@alter.siamese.dyndns.org>
 <7vei6m7muw.fsf@alter.siamese.dyndns.org>
 <7v39n27llq.fsf@alter.siamese.dyndns.org>
 <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Colin Guthrie <gmane@colin.guthr.ie>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 04 23:58:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvdxS-0007We-FL
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 23:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711Ab1CDW6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 17:58:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932520Ab1CDW6o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 17:58:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 54D5B4B2F;
	Fri,  4 Mar 2011 18:00:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FjxkOJ/L1CTanK3CC0E8S1Ynwgk=; b=pnYh35
	+Mfk6N5w29KKfJcDoigetVDGc9eS4DETn1Wm+7zn3BYYDO+Uoq+2iKVep7QbaigK
	a1m/JpBRFky0XrH27RrdCFVELzyLtQmGWs34gP8i7mU0Kw07KDSKbofWAaXWNgcg
	7a4wKnJZb/rk9WbuXKv4WZlFa1hdCHr1lZfLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xCBweb2cd8fllVbkJ2k1SQGqoNrtz0VO
	hm9ITTTXmj0r5FFJu3jjoGz+Bbob9720Eh1o/NB/Zo5hysGMi03OLCjCJOG0Vbn7
	npZhH+renrUBLefsUpDw4VQuJFtPCDs928mQ3DJ2y/ic1zQIMNFopcJEurMXmoIq
	5Qp1l11eI0o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0DD914B2E;
	Fri,  4 Mar 2011 18:00:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 94A5B4B29; Fri,  4 Mar 2011
 17:59:57 -0500 (EST)
In-Reply-To: <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com>
 (Linus Torvalds's message of "Fri\, 4 Mar 2011 11\:18\:01 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 22EB81DA-46B3-11E0-89CC-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168473>

Sorry to bother you with another review request; I slightly prefer this
one better.  The exact same issue, different approach.

-- >8 --
Subject: [PATCH] apply: do not patch lines that were already patched

When looking for a place to apply a hunk, we used to check lines that
match the preimage of it, starting from the line that the patch wants to
apply the hunk at, looking forward and backward with increasing offsets
until we find a match.

Colin Guthrie found an interesting case where this misapplied a patch that
wanted to touch a preimage that consists of

                        }
                }

                return 0;
        }

which is a rather unfortunately common pattern.

The target version of the file originally had only one such location, but
the hunk immediately before that created another instance of such block of
lines, and find_pos() happily reported that the preimage of the hunk
matched what it wanted to modify.

Oops.

By marking the lines application of earlier hunks touched and preventing
match_fragment() from considering them as a match with preimage of other
hunks, we can reduce such an accident.

I also considered to teach apply_one_fragment() to take the offset we have
found while applying the previous hunk into account when looking for a
match with find_pos(), but dismissed that approach, because it would
sometimes work better but sometimes worse, depending on the difference
between the version the patch was created against and the version the
patch is being applied.

This does _not_ prevent misapplication of patches to a file that has many
similar looking blocks of lines and a preimage cannot identify which one
of them should be applied.  For that, we would need to scan beyond the
first match in find_pos(), and issue a warning (or error out).  That will
be a separate topic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 14951da..04f56f8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -204,6 +204,7 @@ struct line {
 	unsigned hash : 24;
 	unsigned flag : 8;
 #define LINE_COMMON     1
+#define LINE_PATCHED	2
 };
 
 /*
@@ -2085,7 +2086,8 @@ static int match_fragment(struct image *img,
 
 	/* Quick hash check */
 	for (i = 0; i < preimage_limit; i++)
-		if (preimage->line[i].hash != img->line[try_lno + i].hash)
+		if ((img->line[try_lno + i].flag & LINE_PATCHED) ||
+		    (preimage->line[i].hash != img->line[try_lno + i].hash))
 			return 0;
 
 	if (preimage_limit == preimage->nr) {
@@ -2428,6 +2430,9 @@ static void update_image(struct image *img,
 	memcpy(img->line + applied_pos,
 	       postimage->line,
 	       postimage->nr * sizeof(*img->line));
+	for (i = 0; i < postimage->nr; i++)
+		img->line[applied_pos + i].flag |= LINE_PATCHED;
+
 	img->nr = nr;
 }
 
-- 
1.7.4.1.287.g1ecf2
