From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/6] fetch-pack: fix deepen shallow over smart http with no-done cap
Date: Thu,  6 Feb 2014 22:10:39 +0700
Message-ID: <1391699439-22781-7-git-send-email-pclouds@gmail.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 16:12:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBQcg-0005w3-Dq
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 16:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbaBFPMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 10:12:09 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:51770 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbaBFPMI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 10:12:08 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so1866178pbc.38
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 07:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GctyJEfMt/94IbPmHSg0rND82o5SvKO8zQaaMEbQbj4=;
        b=tr+h9doqfxIrhVKAtBoaO7VAINQtPS7GmnwgP8NOlAGHpsNnFB72trC5FPt0U+wTV4
         V/9wxTIBhChpOkwiEGRv/9fdc5IPFtq6a/IkSxIYDHJ6b1kgmt9heSzkgJv72Pnnb89l
         peFoBqLf4SqmSEavhfgBflw9R5g3E1L9nMcwxY/X0zGNROiX2c2bHHr48h5bBmUYT8Q8
         kgaP7rfaQUxG83vVRUhNhIZFDwW9z73okqNMI6nqArCtMqSd8W9U3WzwsjC1jginlq7q
         qgn3UHF48EBtmvA8IFNnwDXKkP4Ty4qtv6BIyS7zVmCVii2owTo5CEe7L3HijviOcWxS
         u1mQ==
X-Received: by 10.66.242.17 with SMTP id wm17mr1210589pac.102.1391699527637;
        Thu, 06 Feb 2014 07:12:07 -0800 (PST)
Received: from lanh ([115.73.207.183])
        by mx.google.com with ESMTPSA id mo2sm4415282pbc.6.2014.02.06.07.12.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Feb 2014 07:12:06 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 06 Feb 2014 22:12:07 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241700>

In smart http, upload-pack adds new shallow lines at the beginning of
each rpc response. Only shallow lines from the first rpc call are
useful. After that they are thrown away. It's designed this way
because upload-pack is stateless and has no idea when its shallow
lines are helpful or not.

So after refs are negotiated with multi_ack_detailed and both sides
happy. The server sends "ACK obj-id ready", terminates the rpc call
and waits for the final rpc round. The client sends "done". The server
sends another response, which also has shallow lines at the beginning,
and the last "ACK obj-id" line.

When no-done is active, the last round is cut out, the server sends
"ACK obj-id ready" and "ACK obj-id" in the same rpc
response. fetch-pack is updated to recognize this and not send
"done". However it still tries to consume shallow lines, which are
never sent.

Update the code, make sure to skip consuming shallow lines when
no-done is enabled.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fetch-pack.c             |  3 ++-
 t/t5537-fetch-shallow.sh | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 90fdd49..f061f1f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -439,7 +439,8 @@ done:
 	}
 	strbuf_release(&req_buf);
=20
-	consume_shallow_list(args, fd[0]);
+	if (!got_ready || !no_done)
+		consume_shallow_list(args, fd[0]);
 	while (flushes || multi_ack) {
 		int ack =3D get_ack(fd[0], result_sha1);
 		if (ack) {
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index b0fa738..fb11073 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -200,5 +200,29 @@ EOF
 	)
 '
=20
+# This test is tricky. We need large enough "have"s that fetch-pack
+# will put pkt-flush in between. Then we need a "have" the the server
+# does not have, it'll send "ACK %s ready"
+test_expect_success 'add more commits' '
+	(
+	cd shallow &&
+	for i in $(seq 10); do
+	git checkout --orphan unrelated$i &&
+	test_commit unrelated$i >/dev/null &&
+	git push -q "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" refs/heads/unrelated=
$i:refs/heads/unrelated$i
+	git push -q ../clone/.git refs/heads/unrelated$i:refs/heads/unrelated=
$i
+	done &&
+	git checkout master &&
+	test_commit new &&
+	git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" master
+	) &&
+	(
+	cd clone &&
+	git checkout --orphan newnew &&
+	test_commit new-too &&
+	git fetch --depth=3D2
+	)
+'
+
 stop_httpd
 test_done
--=20
1.8.5.2.240.g8478abd
