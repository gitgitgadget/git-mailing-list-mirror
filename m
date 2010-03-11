From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git status: Fix false positive "new commits" output for
 dirty submodules
Date: Thu, 11 Mar 2010 12:04:13 -0800
Message-ID: <7v3a061v7m.fsf@alter.siamese.dyndns.org>
References: <4B9909F6.5090104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 11 21:04:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpocQ-0002XB-U4
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 21:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337Ab0CKUEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 15:04:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab0CKUEX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 15:04:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7835BA1E34;
	Thu, 11 Mar 2010 15:04:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wAA2hRiQxDLCrUkWYjPmIeyh9zM=; b=qFLOEt
	jZBi3iPmV+04xwn4i/tuWju5JsUA1uK1PELT2SoxEbsOP8+rhS3JMSlERAz8JxZx
	y6ZpNhUVonhWA22lEIXz5M6QZy23Nw8qOTQ8LpH2mUu9rkVhWgFSx1uKvIqThBDM
	nk5Qv9qzSv62CcQyKfG9bdokMEOt95oSAkYBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NKz+5wbmufuSizsfJ9Y63a+T5alcAh40
	WhWCAxoYRI36dB8OH5kPykP6W8LEM0rzH5kPCRydKGzmP2HiCXE7zPiKTJAQ96/+
	vcAp/Svq1hKoAn4Cj4h/tKh6dhwL9Xzd4qp+ZCI9qGCR/jv3ikkytYJX01mLAC6n
	nd+JBY5qRhA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B326A1E31;
	Thu, 11 Mar 2010 15:04:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2E03A1E2F; Thu, 11 Mar
 2010 15:04:15 -0500 (EST)
In-Reply-To: <4B9909F6.5090104@web.de> (Jens Lehmann's message of "Thu\, 11
 Mar 2010 16\:19\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 467B1C34-2D49-11DF-BE5A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141994>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Another way to fix this bug would have been to enter the correct sha1
> into two->sha1 for submodules with new commits.

I didn't follow all the codepaths involved, but it might be worth a try.
The beginning of the patch may look something like this, and then you
would probably have to fix potential fallouts in diff.c from this change.

 diff-lib.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index d7e13cb..a147d9c 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -182,10 +182,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		    && !DIFF_OPT_TST(&revs->diffopt, IGNORE_SUBMODULES)
 		    && (!changed || (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
 		    && is_submodule_modified(ce->name)) {
-			changed = 1;
 			dirty_submodule = 1;
 		}
-		if (!changed) {
+		if (!changed && !dirty_submodule) {
 			ce_mark_uptodate(ce);
 			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
 				continue;
