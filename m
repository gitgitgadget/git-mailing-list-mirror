From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diffcore-break: save cnt_data for other phases
Date: Mon, 16 Nov 2009 13:20:00 -0800
Message-ID: <7vvdhanp4v.fsf@alter.siamese.dyndns.org>
References: <20091116155331.GA30719@coredump.intra.peff.net>
 <20091116160202.GB30777@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 22:20:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA8zm-0006fH-BC
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 22:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbZKPVUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 16:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbZKPVUD
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 16:20:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbZKPVUC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 16:20:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 596BA9E825;
	Mon, 16 Nov 2009 16:20:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=dDkGV/wpBgIly752MDba0uQrqmI=; b=VqjL01RpsLwUACMvWJjaAaC
	4KXWYzmtH41SJuNcyBtZlv1paZZWx87z77g5M70S6m4XR9deU5oLd/hK29DYCwD6
	sVAwY7gg1+MpUks8ZtEZgmqNrNq09AVj2shjFzFJvKmMvIX6q+britAZyXKZ730P
	S0NC8S+MphpCYQUvSp70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=h4Heru6kGlkZqMtk+soT/3Q6JNt6ztrdPDMETy0EzPMVgkcpG
	bcT7rTaZo+pLV4l10NfUvVbWP59zy/pq3W+blfOF1DoWHP235Dwvk6JNhSyaJo3i
	32NerRIezt1vbtCYGPGmvu/pczt1JCvjjIyIbKkU0tsvmnN/RPyBItW1ZA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 387AF9E824;
	Mon, 16 Nov 2009 16:20:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 16A6A9E821; Mon, 16 Nov 2009
 16:20:01 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF23109A-D2F5-11DE-BD2C-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133024>

Jeff King <peff@peff.net> writes:

> The "break" phase works by counting changes between two
> blobs with the same path. We do this by splitting the file
> into chunks (or lines for text oriented files) and then
> keeping a count of chunk hashes.
>
> The "rename" phase counts changes between blobs at two
> different paths. However, it uses the exact same set of
> chunk hashes (which are immutable for a given sha1).
>
> The rename phase can therefore use the same hash data as
> break. Unfortunately, we were throwing this data away after
> computing it in the break phase. This patch instead attaches
> it to the filespec and lets it live through the rename
> phase, working under the assumption that most of the time
> that breaks are being computed, renames will be too.

The change looks correct, but I initially got worried about your change
interacts badly with this part in estimate_similarity() around line 176:

	if (!src->cnt_data && diff_populate_filespec(src, 0))
		return 0;
	if (!dst->cnt_data && diff_populate_filespec(dst, 0))
		return 0;

I think the reason why it (not your patch but the original code) felt a
bit brittle is because the above if() statements know too much about the
internal of d-c-c (namely, it never looks at src->data when src->cnt_data
is already available, so it is safe to leave src->data NULL).

The same logic suggests that the loop to build the matrix in
diffcore_rename() could free two->data at the end of the innermost loop.

We currently loop this way (around ll. 505-530):

	for each two (i.e. rename destination candidate):
        	for each one (i.e. rename source candidate):
                	compute and record how similar one and two are
			free one->data
		free two->data

After computing how similar "one" and something else is only once, we have
one->cnt_data so we won't need one->data (the same fact is exploited by
your patch for optimization), and that is why freeing one->data in the
innermost loop does not result in constant re-reading of the same blob
data when we iterate more than one rename destination.  But the same logic
applies to "two" and we should be able to free the blob data early to
reduce the memory pressure.

I dunno if it would give us measurable performance benefit, though.

Here is the idea on top of your patch, but I think it can be applied
independently.

 diffcore-rename.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 63ac998..875ca81 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -523,10 +523,13 @@ void diffcore_rename(struct diff_options *options)
 			this_src.dst = i;
 			this_src.src = j;
 			record_if_better(m, &this_src);
+			/*
+			 * Once we run estimate_similarity, 
+			 * We do not need the text anymore.
+			 */
 			diff_free_filespec_blob(one);
+			diff_free_filespec_blob(two);
 		}
-		/* We do not need the text anymore */
-		diff_free_filespec_blob(two);
 		dst_cnt++;
 	}
 
