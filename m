From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] interpret_branch_name(): unconfuse @{-1}@{u} when @{-1} is detached
Date: Wed, 08 May 2013 14:18:29 -0700
Message-ID: <7vd2t1dvbu.fsf@alter.siamese.dyndns.org>
References: <7vk3n9dvlu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 23:18:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaBl0-0002om-3G
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 23:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab3EHVSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 17:18:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031Ab3EHVSb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 17:18:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AABC1C419;
	Wed,  8 May 2013 21:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iH3fz8EQa2/OGv6zDyNpbTo7Sao=; b=ZSqJgE
	nN9ZMwY79LJKqliBNIioIWi5NYCR6UskWbawNhQJj98q70VHzG+2Fd6c+AZs5vgS
	WACBcilLrJuxFZmab+oG8xQ09xdReiTxCHDueNhO5047Y0DMZ1l/JNsa3eW60JIZ
	IpFcFK6qmO9WyabDd6BIvvC2qPWFC0IJfiTnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gYU8xlt+Q25sTIGRCDnVNEpO3RPOXeFe
	kpSZjEcrSl6KiFemNkoveuf4I6Guns+JqCRoxlM32m1smYPsiPl8n/sRXe7ElXOh
	3UoA1C8pSCmiI/ruww/hCklV4OjtldWDbeqtnIfChJZ1lABr8Wn0ddByTryEN1PO
	GF2pPiGWVic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DE661C418;
	Wed,  8 May 2013 21:18:31 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D3E71C416;
	Wed,  8 May 2013 21:18:30 +0000 (UTC)
In-Reply-To: <7vk3n9dvlu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 08 May 2013 14:12:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4EDDD3A-B824-11E2-B930-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223687>

Now interpret_nth_prior_checkout() can tell the caller if the result
of expansion of @{-1} is a real branch name or the commit object
name for a detached HEAD state, let's avoid re-interpreting $HEX@{u}
in the latter case.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This prevents us from mistakenly refering to the upstream of an
   unrelated branch in this sequence:

     HEX=$(git rev-parse --verify HEAD)
     git branch $HEX     
     git checkout HEAD^0
     git checkout -
     git log @{-1}@{u}

   The branch created in the first step has never been checked out,
   and @{-1} does not refer to it.  @{-1}@{u} would first turn into 
   $HEX@{u} but we should not look for upstream of refs/heads/$HEX.

 sha1_name.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 1473bb6..d3b6897 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1004,15 +1004,21 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 	char *cp;
 	struct branch *upstream;
 	int namelen = strlen(name);
-	int len = interpret_nth_prior_checkout(name, buf, NULL);
+	int detached;
+	int len = interpret_nth_prior_checkout(name, buf, &detached);
 	int tmp_len;
 
 	if (!len)
 		return len; /* syntax Ok, not enough switches */
 	if (0 < len && len == namelen)
 		return len; /* consumed all */
-	else if (0 < len) {
-		/* we have extra data, which might need further processing */
+	else if (0 < len && !detached) {
+		/*
+		 * We have extra data, which might need further
+		 * processing.  E.g. for the original "@{-1}@{u}" we
+		 * have converted @{-1} into buf and yet to process
+		 * the remaining @{u} part.
+		 */
 		struct strbuf tmp = STRBUF_INIT;
 		int used = buf->len;
 		int ret;
-- 
1.8.3-rc1-182-gc61d106
