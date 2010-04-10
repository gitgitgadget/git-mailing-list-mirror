From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] wt-status: plug memory leak while collecting untracked
 files
Date: Sat, 10 Apr 2010 00:40:53 -0700
Message-ID: <1270885256-31589-3-git-send-email-gitster@pobox.com>
References: <1270885256-31589-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 09:41:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0VJi-0000KR-4X
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 09:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452Ab0DJHlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 03:41:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab0DJHlG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 03:41:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 816A7A954F
	for <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qXRV
	Vbl3EEesmkjMcuybt03DmNY=; b=aeWt+WSgvlrtKT7XY6DzfTlN8bQJwJFTcl6Q
	zvxWof9tX8MXPzVeRMrSv9qfWBoR67iZWa8VgTEwXBzmv3i+qXS9STfpMa7CRDs4
	kqOVpw52rHyNPc65HmWKkJ+N5UBg0BTSaqQE7gjLFWCkPut6kyC2sxhNctChGBIQ
	+POsgtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=eFfUDY
	gfwhg4FXgiO3Na6lhwL7KCbpjdli20c6zdC6HaQur871E0aFS6KTciX1zT3EekyG
	NuyHmBYl1WhZqwr21phCsmCXtVAofS5Sggpsh+yZYsINSErb3G0XU4p7aCLLU2sB
	i23EJ8ShaKdDGlZlyTsbbVt6u41BTFkcf84rM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7988CA954E
	for <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A71BA954D for
 <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc0.264.g94f6e
In-Reply-To: <1270885256-31589-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6AE217DE-4474-11DF-B165-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144524>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index db20b86..c88159a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -379,7 +379,10 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		if (!match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
 			continue;
 		string_list_insert(ent->name, &s->untracked);
+		free(ent);
 	}
+
+	free(dir.entries);
 }
 
 void wt_status_collect(struct wt_status *s)
-- 
1.7.1.rc0.264.g94f6e
