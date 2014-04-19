From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] remote-helpers: make recvline return an error
Date: Sat, 19 Apr 2014 00:00:40 -0700
Message-ID: <1397890843-27035-3-git-send-email-gitster@pobox.com>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
 <1397890843-27035-1-git-send-email-gitster@pobox.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 08:59:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbPFB-0006zt-15
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 08:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbaDSG7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 02:59:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbaDSG7P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 02:59:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CA8E6E607;
	Sat, 19 Apr 2014 02:59:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=s5LJ
	8oFc0s0Ot+39g9anbRdFtCg=; b=WKGEdnULUd5bi76w/ogYOoSfBztCwuh98rvN
	wYTxX1oIKoc2oLsQQJgZvFGA3jYbcpPAKaJaqRRaLgYGkg/b4eLo+ZuPcwI4tv5V
	DzK758vsqC1ot46XgQujgcFk61dS4D9mmzr2N2yOk/j0fiqnthLMtSMkN7q3zt8L
	df8/3iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	kNFcc6X//KeOXRFe17WQhoIQoVtkCOR018mKc3kSayRcHBWwhNeA5FnVaJT34ohk
	TEay7NhuGGPbRHNRzbVc1rZahVgdjgpDjLYLn+tY0b68sMTKNUgZTeF40aGwiPFj
	I8wxI+3mwbahEtRKfXtgRViy2T6ACAAWMH+Jsk8f9yA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 856036E606;
	Sat, 19 Apr 2014 02:59:14 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C1BD6E603;
	Sat, 19 Apr 2014 02:59:12 -0400 (EDT)
X-Mailer: git-send-email 1.9.2-459-g68773ac
In-Reply-To: <1397890843-27035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1CBCDB36-C790-11E3-BEC9-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246502>

From: Felipe Contreras <felipe.contreras@gmail.com>

Instead of exiting directly, make it the duty of the caller to do so.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 892107c..f0d7fc7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -58,7 +58,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 	if (strbuf_getline(buffer, helper, '\n') == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
-		exit(128);
+		return 1;
 	}
 
 	if (debug)
@@ -157,7 +157,8 @@ static struct child_process *get_helper(struct transport *transport)
 	while (1) {
 		const char *capname;
 		int mandatory = 0;
-		recvline(data, &buf);
+		if (recvline(data, &buf))
+			exit(128);
 
 		if (!*buf.buf)
 			break;
@@ -302,7 +303,8 @@ static int set_helper_option(struct transport *transport,
 	strbuf_addch(&buf, '\n');
 
 	sendline(data, &buf);
-	recvline(data, &buf);
+	if (recvline(data, &buf))
+		exit(128);
 
 	if (!strcmp(buf.buf, "ok"))
 		ret = 0;
@@ -374,7 +376,8 @@ static int fetch_with_fetch(struct transport *transport,
 	sendline(data, &buf);
 
 	while (1) {
-		recvline(data, &buf);
+		if (recvline(data, &buf))
+			exit(128);
 
 		if (starts_with(buf.buf, "lock ")) {
 			const char *name = buf.buf + 5;
@@ -558,7 +561,9 @@ static int process_connect_service(struct transport *transport,
 		goto exit;
 
 	sendline(data, &cmdbuf);
-	recvline_fh(input, &cmdbuf, name);
+	if (recvline_fh(input, &cmdbuf, name))
+		exit(128);
+
 	if (!strcmp(cmdbuf.buf, "")) {
 		data->no_disconnect_req = 1;
 		if (debug)
@@ -743,7 +748,8 @@ static void push_update_refs_status(struct helper_data *data,
 	for (;;) {
 		char *private;
 
-		recvline(data, &buf);
+		if (recvline(data, &buf))
+			exit(128);
 		if (!buf.len)
 			break;
 
@@ -969,7 +975,8 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	while (1) {
 		char *eov, *eon;
-		recvline(data, &buf);
+		if (recvline(data, &buf))
+			exit(128);
 
 		if (!*buf.buf)
 			break;
-- 
1.9.2-459-g68773ac
