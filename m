From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 02/19] sha1_name: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:21 -0700
Message-ID: <724e8529e76a5868787311c10ed025a4e80e25cc.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:20:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7vc-0000S8-RP
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbaFIWU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:20:29 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:37990 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:20:28 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so5358265pde.4
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Je09I5fu77RSZdAEsOYVYMAeLbqEgv/sh3ZhCp/3CA4=;
        b=SZh4+FXu6wGfjb7TPD7a48mr32G5Rv+pztkD9fEVYjGxedFjeyLJORx6sXWawXXW06
         xllDRaIcFrdVSCE3fsDvd7iq6y5lihYB7TXo/yVAdYvhCdLCZwejsxzY6hbnmNivNoK8
         sbH8jkXtQ5jpHDO+UoOQwYmFysE091eI4DOaI2AUa6zvOsI7oy1EoKQSMMAITYh+huZe
         gqxBRB9Kd+ciOY5xPd+vsgOYfJ9PCBs+ksTnMeJWAQySfTjf0CtTxUS+YPdBL4Nk7BR0
         W10agRwYmTPtCbHQD2v68e3c5XKF0GcHqwilENe6Eu7dndNVpybgb5VOPIc+dYzH/ahs
         1LDw==
X-Received: by 10.68.162.34 with SMTP id xx2mr7339769pbb.120.1402352427935;
        Mon, 09 Jun 2014 15:20:27 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id bv4sm2702444pad.25.2014.06.09.15.20.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:20:26 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:20:24 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251110>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

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
2.0.0.592.gf55b190
