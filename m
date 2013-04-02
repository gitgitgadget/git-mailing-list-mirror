From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diffcore-break: don't divide by zero
Date: Tue, 02 Apr 2013 14:15:17 -0700
Message-ID: <7vvc84ab2y.fsf@alter.siamese.dyndns.org>
References: <cover.1364931627.git.john@keeping.me.uk>
 <a2b6c61371ac6ff1e180c6600e57499ff94b2fd2.1364931627.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Apr 02 23:15:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN8YY-0002yZ-GO
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 23:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761197Ab3DBVPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 17:15:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56818 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238Ab3DBVPV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 17:15:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DED7A12AD9;
	Tue,  2 Apr 2013 21:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TuCpMvqJMZosoNq3MgZ/JU6hb7E=; b=tZyT0N
	nlRL9MFmhW7a2571lerDrA3qBMe3RDyBuYa0TW2VkUgZBcLJDmPlERHTmpaBrqSw
	VKyeGENTagLg//cJUlvOhLNoUU7Bey/c4dDdNQxTnHjWL9WoEHPQRICAPjL+pBAA
	6I1dgSSeJHECiDhY18SFc4OFhv30bkFcURH2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J+Px58agQH+KeT96gQNWbQVJt1y0X7wg
	boVb1u9Kk3zKz3LKkvS7mnGYwUFUmucIhz/zkQyukI3XA7J8LVE7aA8xOyHLy00Q
	pZizXiUPyG7HgDguKNnvXqU8DjVCAB+Vk9gvLr3j//wS2hmN+Qk6UTfHBBuA7JCJ
	aNKeseKDa6s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3D8B12AD8;
	Tue,  2 Apr 2013 21:15:20 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD62112AD6; Tue,  2 Apr
 2013 21:15:19 +0000 (UTC)
In-Reply-To: <a2b6c61371ac6ff1e180c6600e57499ff94b2fd2.1364931627.git.john@keeping.me.uk>
 (John Keeping's message of "Tue, 2 Apr 2013 20:50:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C54987E-9BDA-11E2-8C8A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219887>

John Keeping <john@keeping.me.uk> writes:

> When the source file is empty, the calculation of the merge score
> results in a division by zero.  Since the merge score is initialized to
> zero, it makes sense to just leave it as it is if the source size is
> zero.  This means that we still use the extent of damage metric to
> decide whether to break the filepair.

Well spotted.  An empty blob to another blob that is larger than 400
bytes will trigger div0, and it makes sense to leave merge-score to
0 (i.e. do not show as whole-delete-then-whole-add after rename
detection is done and the broken filepair is merged back).

Actually, if src->size is 0, we probably shouldn't break the filepair
in the first place.  That is, if your preimage and postimage looked
like these:


     == preimage ==		== postimage ==

     F (empty file)		F (a large file)
			        E (a new empty file)

do we want to see F renamed to E and then a new file created as F
while running "git diff -B -M"?  I doubt it.

So in that sense, this might be a better solution.  I dunno.

 diffcore-break.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/diffcore-break.c b/diffcore-break.c
index 44f8678..eabafd5 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -67,6 +67,8 @@ static int should_break(struct diff_filespec *src,
 	max_size = ((src->size > dst->size) ? src->size : dst->size);
 	if (max_size < MINIMUM_BREAK_SIZE)
 		return 0; /* we do not break too small filepair */
+	if (src->size == 0)
+		return 0; /* we do not let empty files get renamed */
 
 	if (diffcore_count_changes(src, dst,
 				   &src->cnt_data, &dst->cnt_data,
