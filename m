From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] push: give early feedback
Date: Mon, 24 Jun 2013 23:11:02 +0530
Message-ID: <1372095662-24527-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 24 19:44:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrAob-0000bk-Mh
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 19:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab3FXRoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 13:44:30 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:51770 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab3FXRo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 13:44:26 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so11419848pbc.16
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=aljIbiiwWB1gFpQf9m341j33ne7rjhJZnKy6xpitS08=;
        b=N3Ei9otfkehTfAyibkxBubGyTwdnaTxyyYEEzwxnQp6PWE2CapzZ324aMrPtQWT4BS
         RbSLBX84bnBbIMZN8VQQ+TN+CqdvTlQfoudGN5pPU07LOG/q88ro/oFweKnx88IZtRhE
         yTNc1ddzKXTQlg5KV1NzwzgeceH3ek7FjtmN9vJL9bZ75CB+NffXht1RHLyzrRmUjF4K
         QIz1iQqzpnW5xD2NU718eDlLNfTxv/lH5QNZHOHkcl1adYB/xJek9GS1TBLiObkVPi6O
         ZCm1Ut8hUfx7NzFgBv+/NeNPgCZmKhv9gNyleleiKxGq59Qj/3k+xs3ahIXyG4JQRldl
         7Anw==
X-Received: by 10.68.252.162 with SMTP id zt2mr24398463pbc.103.1372095865725;
        Mon, 24 Jun 2013 10:44:25 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id qp4sm19065841pbc.41.2013.06.24.10.44.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 10:44:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.549.g1f3a412.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228884>

There are many configuration variables that determine exactly what a
push does.  Give the user early feedback so that she has a chance to
abort if she doesn't mean to push those refspecs to that destination
like:

  $ git push
  # pushing refspecs 'master next' to ram (^C to abort)

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Goes without saying: this is an early preview.

 builtin/push.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/push.c b/builtin/push.c
index 2d84d10..085d5ab 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -330,6 +330,7 @@ static int do_push(const char *repo, int flags)
 {
 	int i, errs;
 	struct remote *remote = pushremote_get(repo);
+	struct strbuf sb = STRBUF_INIT;
 	const char **url;
 	int url_nr;
 
@@ -375,6 +376,11 @@ static int do_push(const char *repo, int flags)
 	}
 	errs = 0;
 	url_nr = push_url_of_remote(remote, &url);
+
+	for (i = 0; i < refspec_nr; i++)
+		strbuf_addf(&sb, "%s%s", refspec[i], i == refspec_nr - 1 ? "": " ");
+	printf("# pushing refspecs '%s' to %s (^C to abort)\n", sb.buf, remote->name);
+
 	if (url_nr) {
 		for (i = 0; i < url_nr; i++) {
 			struct transport *transport =
-- 
1.8.3.1.549.g1f3a412.dirty
