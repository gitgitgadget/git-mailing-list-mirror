From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 11:05:05 -0800
Message-ID: <7v39n27llq.fsf@alter.siamese.dyndns.org>
References: <4D70EBC3.3010400@colin.guthr.ie>
 <7vr5am7p30.fsf@alter.siamese.dyndns.org>
 <7vei6m7muw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Colin Guthrie <gmane@colin.guthr.ie>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 20:05:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvaJY-0006bW-Mk
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 20:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760049Ab1CDTFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 14:05:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759999Ab1CDTFS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 14:05:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 944614F2A;
	Fri,  4 Mar 2011 14:06:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VLZHNf6CPj9QWy7D3WYHnCIw/vc=; b=Mfbdzb
	HDshb0rOZi0zGaPTbIgMyCm4DIzdpY6orn6AhbyC1Wgacv+Be9D+yXAvOgX8Cnz0
	blQOBP8PSWR1IaXluJOJ5CA9q/SNcgKWmsXCYYq0M9g9yz60T9+e0v0rtsHRU8Yi
	cecBS4JsFjFtbgt3mnc2em7dw46UYxKsZMzRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o2/Lv1sZqZPu3zIOahVHnKl37O4UKJ/P
	+eHU+IhKCGX2kFP0V8beo//ylSbi8yVSrgiw1/jRvrxeiLdU5dn9+hRjtP5dQ7Ze
	E0GNmiLk2Jfubp348bFIze7cijTnukMFzh9AZB45ceQxv0UBT4JCxkceTyF851sE
	+fLSMqxYBhQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 62D834F29;
	Fri,  4 Mar 2011 14:06:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0F7084F28; Fri,  4 Mar 2011
 14:06:29 -0500 (EST)
In-Reply-To: <7vei6m7muw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 04 Mar 2011 10\:37\:59 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85B732DA-4692-11E0-8284-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168460>

Junio C Hamano <gitster@pobox.com> writes:

> Looking at it closer, however, I noticed that the false hit (i.e. "two
> blocks closed, a blank line, return 0 and the end of function") in this
> particular case only appears because we applied the previous hunk.  In the
> version of the file in 0ce3017b, there is only one such place and there
> should be no ambiguity in the patch application.
>
> The problem we are seeing is caused only because we look at the result of
> application of the previous hunks in the patch and incrementally try to
> apply the remaining hunks.  So clearly "git apply" can and should be fixed
> for this case by teaching find_pos() not to report a match on a line that
> was touched by application of the previous hunk.

And here is a quick and dirty fix to do something like that.  It assumes
that the hunks for a single file being patched are already sorted in the
ascending order (which should be the case), and may regress cases where we
used to find a match even when the version you are patching has moved
functions around in the file by failing to notice a match.  And it does
get the same result as your GNU patch test.

-- >8 --
Subject: [PATCH] apply: do not look behind beyond what we already patched

When looking for a place to apply a hunk, we used to check lines that
match the preimage of it, starting from the line that the patch wants to
apply the hunk at, with increasing offsets in both ways until we find a
match.

Colin Guthrie found an interesting case where this misapplied a patch that
wanted to touch a preimage that consists of "two block closed '<indent>}<LF>',
a blank line, '<indent>return 0;<LF>', the function closed '}<LF>'".  The
target version of the file originally had only one such location, but the hunk
immediately before that created another such preimage, and find_pos() happily
reported that the preimage matched what the hunk wanted to modify.  Oops.

By recording where the last hunk is applied, and limiting the search done
by find_pos() to the rest of the file, we can reduce such an accident.
Ideally, we should not simply limit the upward search like this patch
does, but skip the regions that were touched by previous hunks, but this
approach was much simpler ;-)

I also considered to teach apply_one_fragment() to take the offset we have
found while applying the previous hunk into account when looking for a
match with find_pos(), but dismissed that approach, because it would
sometimes work better but sometimes worse, depending on the difference
between the version the patch was created against and the version the
patch is being applied.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 14951da..30857c6 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -211,6 +211,7 @@ struct line {
  */
 struct image {
 	char *buf;
+	size_t last_match;
 	size_t len;
 	size_t nr;
 	size_t alloc;
@@ -2323,11 +2324,11 @@ static int find_pos(struct image *img,
 			return try_lno;
 
 	again:
-		if (backwards_lno == 0 && forwards_lno == img->nr)
+		if (backwards_lno <= img->last_match && forwards_lno == img->nr)
 			break;
 
 		if (i & 1) {
-			if (backwards_lno == 0) {
+			if (backwards_lno <= img->last_match) {
 				i++;
 				goto again;
 			}
@@ -2648,6 +2649,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 				" to apply fragment at %d\n",
 				leading, trailing, applied_pos+1);
 		update_image(img, applied_pos, &preimage, &postimage);
+		img->last_match = applied_pos;
 	} else {
 		if (apply_verbosely)
 			error("while searching for:\n%.*s",
