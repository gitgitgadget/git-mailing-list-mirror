From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/18] receive-pack: do not reuse old_sha1[] to other things
Date: Tue, 19 Aug 2014 15:06:12 -0700
Message-ID: <1408485987-3590-4-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:07:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrYh-0005d6-8o
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbaHSWHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:07:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52435 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbaHSWHG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:07:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 743C1330A3;
	Tue, 19 Aug 2014 18:07:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=q3Xm
	PknUG1HIK+9mRa1Og2w90Fo=; b=cDe6FoT1QsQqodTPucTVmuPw0R/Ws7G2qiiU
	tkZGpNnM1p5/W6SuP2OesfoyPvcyogVxezs/9iSPKNLXOQgJaHyDDjjgKLy9VyGO
	SfM9uMPjqeMV7rU7Xjm2l3U3KwBwcThKl+iAPw4l2JNLQT9URTI5nLxNGquYYnhT
	sFeU+CA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=MFeyN1
	oinu8VbC4uHLrkLMf45vl/N0AidoA3AxgH6JMv3ZLB6xRbxlFMNbiIvMagn8u9g/
	0vvB1LQZAHX2EfSPibfwap22gX+NvCNrbctrRZamH1Zqv2shMI7BCVKyZ+KfeLOV
	f4E3R4TbSMSJ/+nimxhdLIxx+VxzqoqkP588c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6846D330A2;
	Tue, 19 Aug 2014 18:07:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EABDF3308C;
	Tue, 19 Aug 2014 18:06:57 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 233A4094-27ED-11E4-BF3C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255523>

This piece of code reads object names of shallow boundaries,
not old_sha1[].

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 43f35c4..ee855b4 100644
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
2.1.0-301-g54593e2
