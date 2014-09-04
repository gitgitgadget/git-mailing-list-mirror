From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/21] receive-pack: do not overallocate command structure
Date: Thu,  4 Sep 2014 13:04:37 -0700
Message-ID: <1409861097-19151-2-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:05:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdHP-0000W3-IH
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342AbaIDUFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:05:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50611 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304AbaIDUFH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:05:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CBA6138143;
	Thu,  4 Sep 2014 16:05:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=b970
	NwMDjaO9NCaJ+RqS7zqfV2w=; b=NVKBUjc4hjLOO6ECOzqjr12a6CdmPMKFarS4
	Svg152YiCsiKcThigflz50F8CUrldy8C945+ePXIf5KVOaeaWsglz7ji23JA1pFh
	MxJ3e18rHS6VpT4Hd87mVDv/syFOCTRENmQ/tUjQWlbiWwICOIAYtGx9PoeAc1fy
	5K44O5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xj8h9+
	xAKGzNHDuO89JQ4q9uGNiBzuUAIW1+1YLWFsf+t/JoesMGRiwBgq1++ys3SnvcWL
	OU39HevFbThKxeMAXtKQkJjhuUAmqR+YYL/rEISMEKYR/j+aEqepcrggVPrM+gHC
	t7k5cQJz9NzIjv9y+uNvFaNOgfQ4YwUFAHcpk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B977238142;
	Thu,  4 Sep 2014 16:05:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 23C363812D;
	Thu,  4 Sep 2014 16:05:04 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C285D78E-346E-11E4-9110-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256459>

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
2.1.0-399-g1364b4d
