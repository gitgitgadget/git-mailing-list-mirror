From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 01/23] receive-pack: do not overallocate command structure
Date: Wed, 17 Sep 2014 15:45:36 -0700
Message-ID: <1410993958-32394-2-git-send-email-gitster@pobox.com>
References: <1410993958-32394-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 00:46:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUNzI-000208-C4
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 00:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882AbaIQWqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 18:46:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54264 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756521AbaIQWqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 18:46:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB01939DCD;
	Wed, 17 Sep 2014 18:46:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=W/qB
	gtwxZgq4t8yj1eHHjfiKKhE=; b=lH3Fr52L12y1tSlwp4iaYvBhyqN8OzPDHUce
	jzFf/diW7JJ84cg3cmQ8wcu/MvwaktZybipXXG2XgJKa5/4iIu5xSIx6Oh3bSqv/
	BBNst/h54w9GsZS8aGAhJpqQmyQqHAjZcMsnfx3BQeDqRbnbis82JgD/krn/0UJm
	pT+L5XA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ijbsyv
	ORuB6lLteyAFPT2psUr8ekuaQ+uRYkAUJjbm0yibT2W/xe9gCoLBty05WjY2f4zo
	FTD0cJzPrOpuqszJ7CqhWwigeBUAw0V+3K/qADZKUyfPPgsrc2I9uEPfSRUjlnAO
	XVsdMvJsOgND40WFvDCt0AgxVtOiQEY6GL3QM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C273739DCB;
	Wed, 17 Sep 2014 18:46:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4D97E39DC8;
	Wed, 17 Sep 2014 18:46:03 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-403-g099cf47
In-Reply-To: <1410993958-32394-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 67258DD2-3EBC-11E4-8139-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257228>

An "update" command in the protocol exchange consists of 40-hex old
object name, SP, 40-hex new object name, SP, and a refname, but the
first instance is further followed by a NUL with feature requests.

The command structure, which has a flex-array member that stores the
refname at the end, was allocated based on the whole length of the
update command, without excluding the trailing feature requests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Unchanged since v5.

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
2.1.0-403-g099cf47
