From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 01/23] receive-pack: do not overallocate command structure
Date: Mon, 15 Sep 2014 15:24:02 -0700
Message-ID: <1410819864-22967-2-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:24:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTehQ-0006GD-6c
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583AbaIOWYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:24:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50093 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755016AbaIOWY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:24:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A42083B16F;
	Mon, 15 Sep 2014 18:24:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ONSe
	C2OupnKZYASK1KCxD+DhzhE=; b=SXdE4gArcQy0lIpj/JWU2j5hiw3bV8lwz1Tl
	1UTRxYZ298mXJTPjMokgD2iDfoYfQhb4R1cWIfI+PGVYHSQaig+DZM/T5gql/DAu
	Nh9rxa5xNhFrNzatqKWMctQkWhIpTW9gFXAb366xvaAXz61KR3ZBj1rBJWfWTcns
	26Tf1sA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=G0Qfyr
	tenaxG3d0BCp/Q4/A4qI7WokwkCRcN9j8N8XjabJMHTVLEul2qEsyQviywoRaHl8
	U6kdxW/FjEpvZix0i+I7Up7+eveimVd2wXGWpenrdIXv0zXtxQynkI952Yz6FPSe
	m35WhBJCw5YxckCFArDhpvam0DSvc40COfYI4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C1213B16E;
	Mon, 15 Sep 2014 18:24:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 20BAD3B16C;
	Mon, 15 Sep 2014 18:24:28 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0E54CB50-3D27-11E4-8E94-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257088>

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
2.1.0-410-gd72dacd
