From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/5] name-rev: strip trailing ^0 in when --name-only
Date: Tue, 18 Jun 2013 22:43:27 +0530
Message-ID: <1371575608-9980-5-git-send-email-artagnon@gmail.com>
References: <1371575608-9980-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 19:16:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UozWa-0003FH-L0
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 19:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952Ab3FRRQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 13:16:48 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:59936 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458Ab3FRRQq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 13:16:46 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so4235954pac.15
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=87b+7nTTpxTThSWExZ6110aMvoxHEQYC0IqzLs3fyho=;
        b=U1oMQVxoRMAe0ePEpAwPS9rAnbFv7/hu9TIwDlLi7DtGaJWzatCI34rv++j88Ep6Xq
         5TtH0GFQosoi6XTTXjXtEDquhBRZMVJ4LY1c0QVCnyDmJBnYWWdBUxQTf13ciznUZGTq
         konfb0ph/cOvDzQW5cD4GvD65XEpHBkzeXwKfJVRKyeLuYgpO8u8dBrtnWzvHaKmWZKR
         vwzgeLXi+no6mWH4m9q/lZUiDEyWG92DwGa80ZhzNGosiywj6X9KUXO63QD131a38WKx
         HzKr+FOaL0PnYoCpA9+y/emLHTh5teDcSTPl3lZtFCI9KyGrhWKdQtLVKQ49JrfgBCkh
         VfxQ==
X-Received: by 10.68.78.37 with SMTP id y5mr17844297pbw.28.1371575806020;
        Tue, 18 Jun 2013 10:16:46 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id vz8sm20498303pac.20.2013.06.18.10.16.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 10:16:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.456.gb7f4cb6.dirty
In-Reply-To: <1371575608-9980-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228280>

236157 (Teach git-describe how to run name-rev, 2007-05-21) introduced
`git name-rev --name-only`, with the intent of using it to implement
`git describe --contains`.  According to the message, one of the primary
objectives of --name-only was to make the output of name-rev match that
of describe.

  $ git describe --contains --all master
  master

  $ git describe --contains --all master~1
  master~1

  $ git describe --contains --all v1.8.3~1
  v1.8.3~1

  $ git describe --contains --all v1.8.3
  v1.8.3^0

The last invocation unnecessarily prints a trailing "^0" (--stdin does
not suffer from this defect).  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/name-rev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 524d790..4b17209 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -160,7 +160,15 @@ static void show_name(const struct object *obj,
 	if (!name_only)
 		printf("%s ", caller_name ? caller_name : sha1_to_hex(sha1));
 	name = get_rev_name(obj);
-	if (name)
+
+	if (name && name_only) {
+		/* strip possible trailing ^0 from name */
+		int len = strlen(name);
+		if (len > 2 && !strcmp(name + len - 2, "^0"))
+			len -= 2;
+		printf("%.*s\n", len, name);
+	}
+	else if (name)
 		printf("%s\n", name);
 	else if (allow_undefined)
 		printf("undefined\n");
-- 
1.8.3.1.456.gb7f4cb6.dirty
