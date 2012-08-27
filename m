From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] http-push: use in_merge_bases() for fast-forward check
Date: Mon, 27 Aug 2012 16:12:01 -0700
Message-ID: <1346109123-12357-4-git-send-email-gitster@pobox.com>
References: <1346109123-12357-1-git-send-email-gitster@pobox.com>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 01:12:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68Ts-0007Qr-2P
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 01:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979Ab2H0XMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 19:12:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48237 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754927Ab2H0XMM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 19:12:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B45D9168;
	Mon, 27 Aug 2012 19:12:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=yX/G
	awqIWL9unZNUB22i++ee5Tk=; b=a9AJ9socDAXrCTBdRXbldzZ7y0xTPWdNsIos
	ByyJp6zGp66MU8EbcUc8jicvnTgX3Kh2y108CjAHe0F5NBxkSUVUaWc9+zm5SU9O
	zV3m9BW3DsXcHGJ+0Vs+i/CSkPFBsbdlxCIeLpmEgziWqU33/vT8/hw9Febiu0J2
	XnspYHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	nlCQ08hHMvvUYyI4dChAmOa3OC2aMaEq35usnQ6tagv7IzH1piGS1Lz6QNeqqmOs
	qtiuCnS5mfSU3CfloLq4whc6wC6hdubUsfbktZm8ZgdGSy6BkSA4APOMcW/DiEGr
	+NbiWFTKmlfgeKGWerSCAu9mHNNtrRMzMc/leKx4aUI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 092959167;
	Mon, 27 Aug 2012 19:12:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A56F9165; Mon, 27 Aug 2012
 19:12:11 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.270.g724661d
In-Reply-To: <1346109123-12357-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A1A12374-F09C-11E1-9D36-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204390>

The original computed merge-base between HEAD and the remote ref and
checked if the remote ref is a merge base between them, in order to
make sure that we are fast-forwarding.

Instead, call in_merge_bases(remote, HEAD) which does the same.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http-push.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index a832ca7..8701c12 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1610,9 +1610,8 @@ static int verify_merge_base(unsigned char *head_sha1, struct ref *remote)
 {
 	struct commit *head = lookup_commit_or_die(head_sha1, "HEAD");
 	struct commit *branch = lookup_commit_or_die(remote->old_sha1, remote->name);
-	struct commit_list *merge_bases = get_merge_bases(head, branch, 1);
 
-	return (merge_bases && !merge_bases->next && merge_bases->item == branch);
+	return in_merge_bases(branch, head);
 }
 
 static int delete_remote_branch(const char *pattern, int force)
-- 
1.7.12.116.g31e0100
