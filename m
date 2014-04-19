From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] transport-helper: propagate recvline() error pushing
Date: Sat, 19 Apr 2014 00:00:41 -0700
Message-ID: <1397890843-27035-4-git-send-email-gitster@pobox.com>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
 <1397890843-27035-1-git-send-email-gitster@pobox.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 08:59:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbPFH-0007Ey-B9
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 08:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbaDSG7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 02:59:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264AbaDSG7R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 02:59:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 306B66E60E;
	Sat, 19 Apr 2014 02:59:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=j9XH
	8ZONesNpMpnjedh8+KB2Fnw=; b=RQZT+b195WK3odU1ENA0ZQwaCK/AobjsS6MH
	wNGCtejfw8CT182IhsVKjsafQcUi/i4WPFkyiJY6xWEpmOkANXdrpCLckOZkm3mj
	T7C+fchyZ7PKvf1wlIRZPg5i9Zyb8H5o3HmnZOgiRlEl/1HMLD6Kgs4mKGxNAKL/
	dGmqJyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	G0Szz/jTKb/Kr0zm0HtEZ4uKLd0TaBlGsLHjNCwqjoKcBkFf37Q0SLL0yC2hsCK0
	FCzbGboTgod3cz0E7JNoNI4W759mchGbK8t31wQakTotlfiHJpm8i1sjj7Yc2sI8
	0Q747KncdGx4pZ1HPcfvqgDaZo9WTNEynn9Sa0vg70o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 207BF6E60D;
	Sat, 19 Apr 2014 02:59:17 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EC946E609;
	Sat, 19 Apr 2014 02:59:15 -0400 (EDT)
X-Mailer: git-send-email 1.9.2-459-g68773ac
In-Reply-To: <1397890843-27035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1EB10A5C-C790-11E3-AF96-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246504>

From: Felipe Contreras <felipe.contreras@gmail.com>

It's cleaner, and will allow us to do something sensible on errors
later.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index f0d7fc7..e91bc9a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -739,17 +739,22 @@ static int push_update_ref_status(struct strbuf *buf,
 	return !(status == REF_STATUS_OK);
 }
 
-static void push_update_refs_status(struct helper_data *data,
+static int push_update_refs_status(struct helper_data *data,
 				    struct ref *remote_refs,
 				    int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref = remote_refs;
+	int ret = 0;
+
 	for (;;) {
 		char *private;
 
-		if (recvline(data, &buf))
-			exit(128);
+		if (recvline(data, &buf)) {
+			ret = 1;
+			break;
+		}
+
 		if (!buf.len)
 			break;
 
@@ -767,6 +772,7 @@ static void push_update_refs_status(struct helper_data *data,
 		free(private);
 	}
 	strbuf_release(&buf);
+	return ret;
 }
 
 static int push_refs_with_push(struct transport *transport,
@@ -847,8 +853,7 @@ static int push_refs_with_push(struct transport *transport,
 	sendline(data, &buf);
 	strbuf_release(&buf);
 
-	push_update_refs_status(data, remote_refs, flags);
-	return 0;
+	return push_update_refs_status(data, remote_refs, flags);
 }
 
 static int push_refs_with_export(struct transport *transport,
@@ -906,8 +911,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
-	push_update_refs_status(data, remote_refs, flags);
-	return 0;
+	return push_update_refs_status(data, remote_refs, flags);
 }
 
 static int push_refs(struct transport *transport,
-- 
1.9.2-459-g68773ac
