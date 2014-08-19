From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/18] receive-pack: do not overallocate command structure
Date: Tue, 19 Aug 2014 15:06:10 -0700
Message-ID: <1408485987-3590-2-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:06:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrYL-0005RA-7U
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbaHSWGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:06:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62891 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbaHSWGr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:06:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D6E33306E;
	Tue, 19 Aug 2014 18:06:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=JUnF
	NDE1Ad5EtQ1k3EqsHr89EZo=; b=OCRVc4nFv65m0orPN3tRJRadc9kbDMqdHidU
	RGoXIOgP6MrPS8z2MpMacWS3VFEBpvg7MhYa+BbG3mYt52GsY5dNkImsI+lB8Dsf
	PUxvGRXOucKlnbAxKrY5RPQX7HPvUtYpl/W1qEqndibBJbrV8VWo2n01AR5+yrSP
	W8F/CUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=j+KaVi
	qDDWFWANhSISIbfbzt/CUISo2Yh1pZ8P5jHpm5ZAcsIIXFHRAyLApOiEeD3R60Y3
	0qh6IRAikXwZg/YKVj8BZPxH6S47WFNLnRD5wgRFbqpDxyL7RrqhLozskZGDN/3F
	Kxfxo/XYrb2Wuy6MKDj2aEw4pYIpa4PwjFnZ4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13B533306D;
	Tue, 19 Aug 2014 18:06:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5710E33064;
	Tue, 19 Aug 2014 18:06:39 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 18236F3C-27ED-11E4-8E18-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255521>

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
2.1.0-301-g54593e2
