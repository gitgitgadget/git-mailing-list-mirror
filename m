From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 03/23] receive-pack: do not reuse old_sha1[] for other things
Date: Mon, 15 Sep 2014 15:24:04 -0700
Message-ID: <1410819864-22967-4-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:24:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTehR-0006GD-OC
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758703AbaIOWYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:24:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57208 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755603AbaIOWYe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:24:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 687673B17E;
	Mon, 15 Sep 2014 18:24:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=x8wk
	cFZLyCa+JoEWF9o+Tdq+pFw=; b=RZmVHji+IS2cMIP+OTfwyAXRhnPw5NjxNcSq
	/Xl4yCcovi8Q+gVzc6j9td2oDi8oRMrdgBtiSFQFBulAZrwsFqUVBN5D76IIRgR2
	fgFaIXLvfblkK1CyqTpPq7Ag8/yNNYhg+Vr+YPrke3BXshgkQ0S/VhpPBhtn0Z0J
	/SpwB+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=olD49z
	T3KxHJ278/OmminsX3AUDMlr9VQ0xXwlOmbRPrWjbSQfN/qjUH7omEYzrtND6lgw
	qMkKWZhFN89eErnla1kt6tfCViKRgBcjS56x+g4r1vlxHnwI5tjnvqTD/PwPzM3p
	TnTX8Tj21pwh+XJjPnfGTxinboKPHiospBRi0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F6FB3B17D;
	Mon, 15 Sep 2014 18:24:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 019993B178;
	Mon, 15 Sep 2014 18:24:31 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 10A3D676-3D27-11E4-9AED-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257092>

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
2.1.0-410-gd72dacd
