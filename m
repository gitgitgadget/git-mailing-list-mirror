From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git status: Fix false positive "new commits" output for
 dirty submodules
Date: Thu, 11 Mar 2010 12:16:42 -0800
Message-ID: <7vpr3azk9h.fsf@alter.siamese.dyndns.org>
References: <4B9909F6.5090104@web.de>
 <7v3a061v7m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 11 21:16:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpooU-0000eG-Nk
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 21:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758129Ab0CKUQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 15:16:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab0CKUQv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 15:16:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A7AABA100A;
	Thu, 11 Mar 2010 15:16:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lE8/4R4NYl2p+J+EEAlBu3eyoOM=; b=LbHFmq
	61V+erf1eE9EVwV88EdNBYyxe2x4smlzhjPJYSRU1rjB8/rvPGl6LmRvfBttxQaK
	quoVFKED6bwr4iDfjIJYsluM0Rnu5CZVGs8dKhPca1AA6ufGxHE6d2GFGd04x6T/
	qckMpMiqMB87aj3QZqBrNaARrGzea8lZZH+v0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CTStdpEnr0xtS8kpgRHAMTgJAvVEcpOl
	+RqSJiXJMlWFSFCUwHYVG8rpQWzCqM4YbxxcuSOrOBKD/lmir6+ZqeGJq3u4jm24
	NppQnl0KCc0Y5Jmo9hTQwCNLGVhCK3Qu3z3TY6ZdXd80iiI7OT/vloDPPnXi9Kze
	/+TvBl3QBlk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8445AA1007;
	Thu, 11 Mar 2010 15:16:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D69DEA1FFF; Thu, 11 Mar
 2010 15:16:43 -0500 (EST)
In-Reply-To: <7v3a061v7m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 11 Mar 2010 12\:04\:13 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 047750F8-2D4B-11DF-9CE0-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141995>

Junio C Hamano <gitster@pobox.com> writes:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> Another way to fix this bug would have been to enter the correct sha1
>> into two->sha1 for submodules with new commits.
>
> I didn't follow all the codepaths involved, but it might be worth a try.
> The beginning of the patch may look something like this, and then you
> would probably have to fix potential fallouts in diff.c from this change.

Here is a fix of one of the fallouts.

 diff.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index dfdfa1a..eefe836 100644
--- a/diff.c
+++ b/diff.c
@@ -3221,6 +3221,8 @@ static void diff_resolve_rename_copy(void)
 		}
 		else if (hashcmp(p->one->sha1, p->two->sha1) ||
 			 p->one->mode != p->two->mode ||
+			 p->one->dirty_submodule ||
+			 p->two->dirty_submodule ||
 			 is_null_sha1(p->one->sha1))
 			p->status = DIFF_STATUS_MODIFIED;
 		else {
