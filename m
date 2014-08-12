From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] mailsplit.c: remove dead code
Date: Tue, 12 Aug 2014 23:21:27 +0200
Message-ID: <1407878487-23530-1-git-send-email-stefanbeller@gmail.com>
References: <53EA430E.8050905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@gmail.com>
To: l.s.r@web.de, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 23:21:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHJVe-0003bq-Op
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 23:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbaHLVVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Aug 2014 17:21:31 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:37414 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbaHLVVa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 17:21:30 -0400
Received: by mail-we0-f172.google.com with SMTP id x48so10489751wes.17
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mtFDMhJdY8qUWrW5lrySLJMqebDV4ay8tT6ng5VVVp0=;
        b=VgZ3PWvkEeTbmOJPUeeET7J2Od6wo+cLDNpb6PnvZLVsSkyHsCN7Q2TSXXAXm6uLHG
         mbhOy+n6TRfBxny3UT6gtkcuJBBerLn8/ONNR5pz2J0I+F0ezUNlbZ5y3K9pHxtYihOo
         /8MqZuWFqXbrB5rq47mDsNguaPRvgEho2z2uAOXIs1VJttLaAAe/umQ5DhRQNbDHlY4B
         JPMmp0PmH/V7WPpG/5ykka9h8uuxj6Rt499Mp5L7+tdAjNAxgZvfpzFQ+axcxs4kho5u
         YCc+WL4jgn0QWpeYmlpms/nExSpu0pxANHbhUcZJFkVBmMpfn+D8GYNcg81joTWQt16D
         Zfyw==
X-Received: by 10.194.84.69 with SMTP id w5mr403666wjy.0.1407878489545;
        Tue, 12 Aug 2014 14:21:29 -0700 (PDT)
Received: from localhost (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id j5sm11815282wjf.35.2014.08.12.14.21.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Aug 2014 14:21:28 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.rc2
In-Reply-To: <53EA430E.8050905@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255166>

This was found by coverity. (Id: 290001)

The variable 'output' is assigned to a value
after all gotos to the corrupt label.

Remove the goto by moving the errorhandling code to the
condition, which detects the error.

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
---
 builtin/mailsplit.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

If I understood correctly, this is what you had in mind?

Thanks,
Stefan

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 06296d4..763cda0 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -53,14 +53,16 @@ static int keep_cr;
  */
 static int split_one(FILE *mbox, const char *name, int allow_bare)
 {
-	FILE *output =3D NULL;
+	FILE *output;
 	int fd;
 	int status =3D 0;
 	int is_bare =3D !is_from_line(buf.buf, buf.len);
=20
-	if (is_bare && !allow_bare)
-		goto corrupt;
-
+	if (is_bare && !allow_bare) {
+		unlink(name);
+		fprintf(stderr, "corrupt mailbox\n");
+		exit(1);
+	}
 	fd =3D open(name, O_WRONLY | O_CREAT | O_EXCL, 0666);
 	if (fd < 0)
 		die_errno("cannot open output file '%s'", name);
@@ -91,13 +93,6 @@ static int split_one(FILE *mbox, const char *name, i=
nt allow_bare)
 	}
 	fclose(output);
 	return status;
-
- corrupt:
-	if (output)
-		fclose(output);
-	unlink(name);
-	fprintf(stderr, "corrupt mailbox\n");
-	exit(1);
 }
=20
 static int populate_maildir_list(struct string_list *list, const char =
*path)
--=20
2.1.0.rc2
