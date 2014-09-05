From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 01/22] receive-pack: do not overallocate command structure
Date: Fri,  5 Sep 2014 13:54:49 -0700
Message-ID: <1409950510-10209-2-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:55:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0XU-0005R5-D7
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbaIEUzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57780 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbaIEUzR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A30436626;
	Fri,  5 Sep 2014 16:55:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=39mk
	kiTJxwPRdIyKw6/1BzoomzI=; b=PAcS7V+yjdOivzpSWHVhkWAkZb390O2tjmon
	9+K9+NWI54Y9kllWVTc0EL1lGy2Ae59c/yuBr3mzWQSN0Bwarh1vudQ99kXMBze9
	rtq7gotc+3wgEGJLrnPM8FiFN9Rp8HzzjCjMFBfcf6HJ9CfC9rUNDVRm+my0hX75
	3INcHLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=fp/0p1
	syde/sN9Q2D94hUf0KRN1aQJKOnE6ZtpY4bf7ihi+vC8PIqTqL7o9DEZ0fHT9qFw
	fvUc3S+pOk52rvPbDSpXoWwOJMmJPWQkPKDG2oH3A/3qzKvPgK2fDnq0aaTLbZHn
	4NHHOcq8QLhW9UxXpDI4zjet3GFT/LBpeyp9g=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 03C2436625;
	Fri,  5 Sep 2014 16:55:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6D8C13661D;
	Fri,  5 Sep 2014 16:55:14 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EF280C64-353E-11E4-AE4D-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256519>

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
2.1.0-399-g2df620b
