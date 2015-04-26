From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/14] merge: small leakfix and code simplification
Date: Sat, 25 Apr 2015 22:25:59 -0700
Message-ID: <1430025967-24479-7-git-send-email-gitster@pobox.com>
References: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
 <1430025967-24479-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 07:26:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmF5S-0002kU-VG
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 07:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbbDZF01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 01:26:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751159AbbDZF0R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 01:26:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 488D9466F2;
	Sun, 26 Apr 2015 01:26:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=YMqF
	g5bgI/Unft2m/16MvoEo08Y=; b=c1WCuKQ80oUcEthJqYRDSTfz1ertSAKjBOPm
	NpehJjNUkzZ5JQKepTAmXGErhN2lkT6vrEQIQtxlO9nYNN5CXikJUWmwS5KJONHV
	J8KV0JEc1NfiD6z4PsUgmktoXod+LvDQqSxoQCa02RsoP5slbapaf2yufPUSdWSa
	hxEvgfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BwyycW
	jamaMeG7fqUjqYu8nhffaIHR8WWIKCeDZNm1pLlDxBXb1IkHtwUUzoLpbuNwYitN
	koVMRUtEC1XNyXNVKKBh3GVBIOOMkyN939jVHfjrZ/IkIj7tDLAqU7k+kx1qunIf
	fvtr3E0gWJFu4orNavnx2s2Y1L4hZuzonl8jg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FDA7466F1;
	Sun, 26 Apr 2015 01:26:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8101466EF;
	Sun, 26 Apr 2015 01:26:16 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-238-g36f5934
In-Reply-To: <1430025967-24479-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C31CC13A-EBD4-11E4-8564-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267815>

When parsing a merged object name like "foo~20" to formulate a merge
summary "Merge branch foo (early part)", a temporary strbuf is used,
but we forgot to deallocate it when we failed to find the named
branch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 1d4fbd3..b2d0332 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -491,8 +491,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	}
 	if (len) {
 		struct strbuf truname = STRBUF_INIT;
-		strbuf_addstr(&truname, "refs/heads/");
-		strbuf_addstr(&truname, remote);
+		strbuf_addf(&truname, "refs/heads/%s", remote);
 		strbuf_setlen(&truname, truname.len - len);
 		if (ref_exists(truname.buf)) {
 			strbuf_addf(msg,
@@ -503,6 +502,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 			strbuf_release(&truname);
 			goto cleanup;
 		}
+		strbuf_release(&truname);
 	}
 
 	if (!strcmp(remote, "FETCH_HEAD") &&
-- 
2.4.0-rc3-238-g36f5934
