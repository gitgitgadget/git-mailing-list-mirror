From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH/RFC v1 3/5] sha1_name.c: cleanup using strbuf_set operations
Date: Mon,  9 Jun 2014 01:36:27 -0700
Message-ID: <d98e710757df0ad7465e074f283f3bf3781f7652.1402301816.git.jmmahler@gmail.com>
References: <cover.1402301815.git.jmmahler@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 10:37:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wtv5L-0007GJ-2N
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 10:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbaFIIhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 04:37:37 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34946 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150AbaFIIhf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 04:37:35 -0400
Received: by mail-pd0-f172.google.com with SMTP id fp1so4574539pdb.31
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rIM158JL0pOPgjwCsj3CQgf3DcQzr+p9UsSqVOyb+nc=;
        b=jSVBIl6Y+k3VhpUFEwHMd6astbFA2AhN8E5ZLOTx+TWzqCdWAtuLDScZPoHaSNqPUS
         z/bMOBChPUK0xWUz9rlG5j6db81dFEPs2msI/0+5lAoSToPh4lk0tUz4r4R8d9mDQREe
         TN1olmDrnYznJ/oEq/wxR91nLnEnQuIjd+6K0llfhefRtSR0DQIogl4uBPfIr7gXXTeO
         7qQxsbTMx376MsncYAqqcxui0axYU9qQxaoSt4mMnU+SbZnDEVTINJ6UaXBhCLJYLXDp
         J+qWaR6kPZi1v7dTLmcukgjCN53+fkgjSsNi8ex88I9FrdBfI17Ao0yu1GvfFJHHeehj
         CLdQ==
X-Received: by 10.68.213.97 with SMTP id nr1mr2982280pbc.52.1402303055113;
        Mon, 09 Jun 2014 01:37:35 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id wl5sm62742757pbc.13.2014.06.09.01.37.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 01:37:33 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 01:37:31 -0700
X-Mailer: git-send-email 2.0.0.573.ged771ce.dirty
In-Reply-To: <cover.1402301815.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402301815.git.jmmahler@gmail.com>
References: <cover.1402301815.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251063>

Simplified cases where a strbuf_reset was immediately followed by a
strbuf_add using the new strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 sha1_name.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 2b6322f..f88b66c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -920,8 +920,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 		return 0;
 	if (--(cb->remaining) == 0) {
 		len = target - match;
-		strbuf_reset(&cb->buf);
-		strbuf_add(&cb->buf, match, len);
+		strbuf_set(&cb->buf, match, len);
 		return 1; /* we are done */
 	}
 	return 0;
@@ -957,8 +956,7 @@ static int interpret_nth_prior_checkout(const char *name, int namelen,
 
 	retval = 0;
 	if (0 < for_each_reflog_ent_reverse("HEAD", grab_nth_branch_switch, &cb)) {
-		strbuf_reset(buf);
-		strbuf_add(buf, cb.buf.buf, cb.buf.len);
+		strbuf_set(buf, cb.buf.buf, cb.buf.len);
 		retval = brace - name + 1;
 	}
 
@@ -1025,8 +1023,7 @@ static int interpret_empty_at(const char *name, int namelen, int len, struct str
 	if (next != name + 1)
 		return -1;
 
-	strbuf_reset(buf);
-	strbuf_add(buf, "HEAD", 4);
+	strbuf_set(buf, "HEAD", 4);
 	return 1;
 }
 
@@ -1044,8 +1041,7 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
 		strbuf_setlen(buf, used);
 		return len;
 	}
-	strbuf_reset(buf);
-	strbuf_addbuf(buf, &tmp);
+	strbuf_setbuf(buf, &tmp);
 	strbuf_release(&tmp);
 	/* tweak for size of {-N} versus expanded ref name */
 	return ret - used + len;
@@ -1054,8 +1050,7 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
 static void set_shortened_ref(struct strbuf *buf, const char *ref)
 {
 	char *s = shorten_unambiguous_ref(ref, 0);
-	strbuf_reset(buf);
-	strbuf_addstr(buf, s);
+	strbuf_setstr(buf, s);
 	free(s);
 }
 
-- 
2.0.0.573.ged771ce.dirty
