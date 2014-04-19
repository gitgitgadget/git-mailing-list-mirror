From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] transport-helper: trivial cleanup
Date: Sat, 19 Apr 2014 00:00:42 -0700
Message-ID: <1397890843-27035-5-git-send-email-gitster@pobox.com>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
 <1397890843-27035-1-git-send-email-gitster@pobox.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 08:59:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbPFK-0007Hx-Vk
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 08:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbaDSG7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 02:59:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbaDSG7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 02:59:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D93A6E614;
	Sat, 19 Apr 2014 02:59:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=t0Zc
	a/ILPwdJdogAAXLa2vxhPRg=; b=vxlgGIG1MdpCSQOGzk+j/1LDK9NcdII6BV24
	QEDxcIqxOS4zs7QTt8GQLye6qLu7NW982/6hilmUzhazXhglU5BHXK/3XKSX9RVt
	UyomC5MYbK9ZKFQXLnm5pkDkR3f/nioMw9r9FN501vhHGh3Qu0z/wmGGXU0u7Xtq
	g+qI+ps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	OVc2kTV+dCypugYwL70MFL6n81wlkZsaG2+wftTX2kosctDN15bXZHqX9OCSGkZx
	1HfYpzSl40e3UrrtjWxXd4aeyftBFufYmKjBV0906CNTNaJ8ULlE0wxbb71fzOfP
	SaJWseKSHMbQFiH6x5AeORXMphDQO9jJdUnqNcNb0Zg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 197CF6E613;
	Sat, 19 Apr 2014 02:59:20 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E2C16E611;
	Sat, 19 Apr 2014 02:59:18 -0400 (EDT)
X-Mailer: git-send-email 1.9.2-459-g68773ac
In-Reply-To: <1397890843-27035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2051CA86-C790-11E3-98F8-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246505>

From: Felipe Contreras <felipe.contreras@gmail.com>

It's simpler to store the file names directly, and form the fast-export
arguments only when needed, and re-use the same strbuf with a format.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index e91bc9a..c890db6 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -195,15 +195,9 @@ static struct child_process *get_helper(struct transport *transport)
 		} else if (!strcmp(capname, "signed-tags")) {
 			data->signed_tags = 1;
 		} else if (starts_with(capname, "export-marks ")) {
-			struct strbuf arg = STRBUF_INIT;
-			strbuf_addstr(&arg, "--export-marks=");
-			strbuf_addstr(&arg, capname + strlen("export-marks "));
-			data->export_marks = strbuf_detach(&arg, NULL);
+			data->export_marks = xstrdup(capname + strlen("export-marks "));
 		} else if (starts_with(capname, "import-marks")) {
-			struct strbuf arg = STRBUF_INIT;
-			strbuf_addstr(&arg, "--import-marks=");
-			strbuf_addstr(&arg, capname + strlen("import-marks "));
-			data->import_marks = strbuf_detach(&arg, NULL);
+			data->import_marks = xstrdup(capname + strlen("import-marks "));
 		} else if (starts_with(capname, "no-private-update")) {
 			data->no_private_update = 1;
 		} else if (mandatory) {
@@ -428,6 +422,8 @@ static int get_exporter(struct transport *transport,
 	struct helper_data *data = transport->data;
 	struct child_process *helper = get_helper(transport);
 	int argc = 0, i;
+	struct strbuf tmp = STRBUF_INIT;
+
 	memset(fastexport, 0, sizeof(*fastexport));
 
 	/* we need to duplicate helper->in because we want to use it after
@@ -438,10 +434,14 @@ static int get_exporter(struct transport *transport,
 	fastexport->argv[argc++] = "--use-done-feature";
 	fastexport->argv[argc++] = data->signed_tags ?
 		"--signed-tags=verbatim" : "--signed-tags=warn-strip";
-	if (data->export_marks)
-		fastexport->argv[argc++] = data->export_marks;
-	if (data->import_marks)
-		fastexport->argv[argc++] = data->import_marks;
+	if (data->export_marks) {
+		strbuf_addf(&tmp, "--export-marks=%s", data->export_marks);
+		fastexport->argv[argc++] = strbuf_detach(&tmp, NULL);
+	}
+	if (data->import_marks) {
+		strbuf_addf(&tmp, "--import-marks=%s", data->import_marks);
+		fastexport->argv[argc++] = strbuf_detach(&tmp, NULL);
+	}
 
 	for (i = 0; i < revlist_args->nr; i++)
 		fastexport->argv[argc++] = revlist_args->items[i].string;
-- 
1.9.2-459-g68773ac
