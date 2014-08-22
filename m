From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/19] receive-pack: do not reuse old_sha1[] for other things
Date: Fri, 22 Aug 2014 13:30:08 -0700
Message-ID: <1408739424-31429-4-git-send-email-gitster@pobox.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:31:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvUP-0007KO-3D
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbaHVUbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:31:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50913 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbaHVUbG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:31:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0032533136;
	Fri, 22 Aug 2014 16:31:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=9tgY
	Z+WjFEJdU+qkiIdz5NAkVkg=; b=G0DTRyYp2p3ywbClgNiepnT4ok6xC+ZkhsLP
	ILY1Ogt4o2+8UklxJldUxv4yYtsd8E2Na7usiRod9IJGSNNTvVy8emxTnSot+5Yv
	/lXK+GECQfhD9TBNV8/L3Zypcfd6jOzj99cLzCUcl0mlLCo9pL5Wy75agWv6Obu/
	p4t7HRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Ur8OLs
	7rVUm1PuBpkUhSbh6l/1pAilS69Tct/YDeW1Lh+L5354vYkkhNileyjrsWTJdTKv
	rSt2mdEKBMZxZuWnVTNdpomn2x9/O+cO2o5L6CqIVbpGGTQXGqigNOs87QLLnkre
	MOI2KjSVCk8/rUf8c6emD0bbgYtDR5AhKNkqQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC02D33135;
	Fri, 22 Aug 2014 16:31:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 748F73312E;
	Fri, 22 Aug 2014 16:30:56 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-304-g950f846
In-Reply-To: <1408739424-31429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 385B0F94-2A3B-11E4-BB4A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255704>

This piece of code reads object names of shallow boundaries, not
old_sha1[], i.e. the current value the ref points at, which is to be
replaced by what is in new_sha1[].

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a91eec8..c9b92bf 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -847,9 +847,11 @@ static struct command *read_head_info(struct sha1_array *shallow)
 			break;
 
 		if (len == 48 && starts_with(line, "shallow ")) {
-			if (get_sha1_hex(line + 8, old_sha1))
-				die("protocol error: expected shallow sha, got '%s'", line + 8);
-			sha1_array_append(shallow, old_sha1);
+			unsigned char sha1[20];
+			if (get_sha1_hex(line + 8, sha1))
+				die("protocol error: expected shallow sha, got '%s'",
+				    line + 8);
+			sha1_array_append(shallow, sha1);
 			continue;
 		}
 
-- 
2.1.0-304-g950f846
