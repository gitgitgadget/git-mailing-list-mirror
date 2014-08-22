From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/19] receive-pack: do not overallocate command structure
Date: Fri, 22 Aug 2014 13:30:06 -0700
Message-ID: <1408739424-31429-2-git-send-email-gitster@pobox.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:30:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvU5-00077S-Q4
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbaHVUaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:30:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65080 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbaHVUap (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:30:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B94533120;
	Fri, 22 Aug 2014 16:30:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=VN/v
	gDLFAw5WTrPSi2cd1Wu20+I=; b=IEQrYDA7ZgBu8FHOufxLjGN2vV9/omCI8mkW
	OmzWXnrwPQUY0eM4rVfuMJNyRfvr9Nb1F5qzx0HMwYXnRS42U6igvddmTGMSzR3S
	AdOFQF/z1kW+lkHMIgCB3uQnt4oQrKooXoBjb94BwTHpuB6jxKzmU9DzSsQsBL+x
	7dbaoQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=mRv9N3
	1Pfz7F4l7Yk4CpGHJKcvUuD5y9Dah8KQQNb9Ati/sd6Bac/pI4YIeeuZgz7dBmYZ
	kFN1on+BL5xapHk/ZgmjXJ9CkHj+toV+eT1XF0wPJjzkjK1I+xRdTsNBvtYSLTX2
	w4QFaokT3ZoGJ8pFLmtp7XxmcVv4WIgALS5bs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 72E5F3311F;
	Fri, 22 Aug 2014 16:30:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A59323311A;
	Fri, 22 Aug 2014 16:30:37 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-304-g950f846
In-Reply-To: <1408739424-31429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2D2665B0-2A3B-11E4-9A02-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255702>

An "update" command in the protocol exchange consists of 40-hex old
object name, SP, 40-hex new object name, SP, and a refname, but the
first instance is further followed by a NUL with feature requests.

The command structure, which has a flex-array member that stores the
refname at the end, was allocated based on the whole length of the
update command, without excluding the trailing feature requests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f93ac45..1663beb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -872,10 +872,11 @@ static struct command *read_head_info(struct sha1_array *shallow)
 			if (parse_feature_request(feature_list, "quiet"))
 				quiet = 1;
 		}
-		cmd = xcalloc(1, sizeof(struct command) + len - 80);
+		cmd = xcalloc(1, sizeof(struct command) + reflen + 1);
 		hashcpy(cmd->old_sha1, old_sha1);
 		hashcpy(cmd->new_sha1, new_sha1);
-		memcpy(cmd->ref_name, line + 82, len - 81);
+		memcpy(cmd->ref_name, refname, reflen);
+		cmd->ref_name[reflen] = '\0';
 		*p = cmd;
 		p = &cmd->next;
 	}
-- 
2.1.0-304-g950f846
