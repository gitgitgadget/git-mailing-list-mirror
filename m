From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] merge: a random object may not necssarily be a commit
Date: Mon,  1 Apr 2013 12:57:17 -0700
Message-ID: <1364846239-8802-2-git-send-email-gitster@pobox.com>
References: <7v7gl3jmx0.fsf_-_@alter.siamese.dyndns.org>
 <1364846239-8802-1-git-send-email-gitster@pobox.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 21:57:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMkra-0000PA-QG
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 21:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759586Ab3DAT50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 15:57:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37736 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759465Ab3DAT5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 15:57:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B13B1105E;
	Mon,  1 Apr 2013 19:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=x6rb
	9jlEoN+5R3LBlEE2QPuFIeY=; b=bfpwdmYZdqfI5bzIMvukoqX/p7ip0foX5gzm
	uLReul0h59SrIP5XHoTJHd6qYFH6/VxMYYJCtilV13uGLQLUEILRQ7lTRGRoYJre
	TSnNlUs6nqxER44Gb2j2iPqnLc1WqBkl/KKylbmJjd62p/HQW7nK2HdQSlnk5rR7
	skWmTPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	OOWA0cVmLCTOTgt7nhcmXaqUqX7MUdZw1+v0IFl84ALuR3+cHsGBM9BnnbtJKFSn
	U0WyA3eGlzQTtLRrHDn/p0wneFkmADfhRHF3/GFJaQTfKiy+NjMfwv+lEZsqxx6C
	SibqSZ8lp+7xhbE0ztbkGyLALs0ykY5EAnHhPTIQCzI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F57D1105D;
	Mon,  1 Apr 2013 19:57:23 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B916A1105C; Mon,  1 Apr
 2013 19:57:22 +0000 (UTC)
X-Mailer: git-send-email 1.8.2-480-g064f421
In-Reply-To: <1364846239-8802-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5E3C3258-9B06-11E2-B2A6-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219702>

The user could have said "git merge $(git rev-parse v1.0.0)"; we
shouldn't mark it as "Merge commit '15999998fb...'" as the merge
name, even though such an invocation might be crazy.

We could even read the "tag " header from the tag object and replace
the object name the user gave us, but let's not lose the information
by doing so, at least not yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 0ec8f0d..990e90c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -516,6 +516,19 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		strbuf_release(&line);
 		goto cleanup;
 	}
+
+	if (remote_head->util) {
+		struct merge_remote_desc *desc;
+		desc = merge_remote_util(remote_head);
+		if (desc && desc->obj && desc->obj->type == OBJ_TAG) {
+			strbuf_addf(msg, "%s\t\t%s '%s'\n",
+				    sha1_to_hex(desc->obj->sha1),
+				    typename(desc->obj->type),
+				    remote);
+			goto cleanup;
+		}
+	}
+
 	strbuf_addf(msg, "%s\t\tcommit '%s'\n",
 		sha1_to_hex(remote_head->object.sha1), remote);
 cleanup:
-- 
1.8.2-480-g064f421
