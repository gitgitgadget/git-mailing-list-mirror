From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] for-each-ref: introduce %(upstream:track[short])
Date: Fri, 01 Nov 2013 10:17:15 -0700
Message-ID: <xmqq61sc2g9w.fsf@gitster.dls.corp.google.com>
References: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
	<1383212774-5232-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 18:17:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcILm-0000bI-1M
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 18:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab3KARRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 13:17:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754691Ab3KARRV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 13:17:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AB3B4E663;
	Fri,  1 Nov 2013 13:17:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IjLo6KSThFWFntG6dU3xA/dM3Ig=; b=JdejgV
	SJHLEnlOqYkjqzrfQOyy6YowKBB8CFy7WfwuuCgfznKLk7gnjANtWs1OoBIU5M29
	JcvACTNAmxOiKvDenrNpHJ66NUw0DHiZKhQRYPVJmLP2tXLcAROB52Ats6uR4tgM
	i1okNm6EJxnXCYLrs+bGyWxgwaiSxc52qUfpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wNKK+P6zrzTD+UIPPUgSgbYMBR1FJ9rn
	YDu+zMGoeDsAx6tsAGIR7nOq5NAJ8hiQUyTJgvHkyLhs5soBxpWIvc6fZ0WyhfNO
	woiakQSkHcerCIqIcqO7wRlOh6IBqevKaTszCEYYcXJtTf3MwMVGON4P9ZNIvpKI
	gn09CByS7mQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59CFB4E662;
	Fri,  1 Nov 2013 13:17:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99B844E660;
	Fri,  1 Nov 2013 13:17:17 -0400 (EDT)
In-Reply-To: <1383212774-5232-4-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 31 Oct 2013 15:16:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7588C0E6-4319-11E3-BD14-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237216>

This patch needed on top of 3/3 for me to pass gcc cleanly.

-- >8 --
Subject: [PATCH] fixup! for-each-ref: introduce %(upstream:track[short])

The condition !prefixcmp(name, "upstream") must be true for the
variable "branch" to be reused, so the variable should be always set
when it gets used, but GCC does not seem to realize this fact.
---
 builtin/for-each-ref.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 7d5c174..871d86c 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -648,7 +648,7 @@ static void populate_value(struct refinfo *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
-		struct branch *branch;
+		struct branch *branch = NULL;
 
 		if (*name == '*') {
 			deref = 1;
@@ -727,6 +727,7 @@ static void populate_value(struct refinfo *ref)
 			} else if (!strcmp(formatp, "trackshort") &&
 				!prefixcmp(name, "upstream")) {
 
+				assert(branch != NULL);
 				stat_tracking_info(branch, &num_ours, &num_theirs);
 				if (!num_ours && !num_theirs)
 					v->s = "=";
-- 
1.8.5-rc0-205-g5b7460b
