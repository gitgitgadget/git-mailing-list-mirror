From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 08/19] builtin/mailinfo: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:27 -0700
Message-ID: <ec9b2997b3a74581ec59af6354d276181b5481f5.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:20:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7w2-0000lF-Aa
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbaFIWUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:20:54 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:47475 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWUx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:20:53 -0400
Received: by mail-pb0-f45.google.com with SMTP id um1so5531320pbc.32
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WrUPu5PLpsoYbDVSLDuDww640wKM8qGDALRBUY22pjg=;
        b=ra4walvFIk7po/1fGodilLuNHrh/QZkxyobYlvm+YDlThG4r6cG4TDAeDhsnYHQBsB
         4RXH4Qb2BonROlGmxzQfIaI25QVJajrFkUEInYgassvbJC/5620AlesgVVPH12FDMKpK
         uvnVBPWqJAOHm146P5VIp7T6wTIopuFpSCZUn2TKd0Q9WaXhb3X4ogkicWigD3DagznN
         V7SwlbU8uFKinaisHDYp+xvKDfGltc7otxWCaKzhRw6DFEre/hQ8t0zlRYRmGKGLe6NY
         q0KydFVFn8FTyD7XrEfAEp1ZPrIUB+uYaPMDatpoqh0XLWnNA4M2bBB70WEQol9Xse8r
         yxlg==
X-Received: by 10.68.224.198 with SMTP id re6mr36395909pbc.8.1402352452551;
        Mon, 09 Jun 2014 15:20:52 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id cz3sm65861240pbc.9.2014.06.09.15.20.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:20:51 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:20:48 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251116>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 builtin/mailinfo.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index cf11c8d..596071e 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -40,8 +40,7 @@ static void get_sane_name(struct strbuf *out, struct strbuf *name, struct strbuf
 		src = email;
 	else if (name == out)
 		return;
-	strbuf_reset(out);
-	strbuf_addbuf(out, src);
+	strbuf_setbuf(out, src);
 }
 
 static void parse_bogus_from(const struct strbuf *line)
@@ -62,11 +61,9 @@ static void parse_bogus_from(const struct strbuf *line)
 	if (!ket)
 		return;
 
-	strbuf_reset(&email);
-	strbuf_add(&email, bra + 1, ket - bra - 1);
+	strbuf_set(&email, bra + 1, ket - bra - 1);
 
-	strbuf_reset(&name);
-	strbuf_add(&name, line->buf, bra - line->buf);
+	strbuf_set(&name, line->buf, bra - line->buf);
 	strbuf_trim(&name);
 	get_sane_name(&name, &name, &email);
 }
@@ -108,8 +105,7 @@ static void handle_from(const struct strbuf *from)
 		at--;
 	}
 	el = strcspn(at, " \n\t\r\v\f>");
-	strbuf_reset(&email);
-	strbuf_add(&email, at, el);
+	strbuf_set(&email, at, el);
 	strbuf_remove(&f, at - f.buf, el + (at[el] ? 1 : 0));
 
 	/* The remainder is name.  It could be
@@ -567,8 +563,7 @@ static int decode_header_bq(struct strbuf *it)
 		in = ep + 2;
 	}
 	strbuf_addstr(&outbuf, in);
-	strbuf_reset(it);
-	strbuf_addbuf(it, &outbuf);
+	strbuf_setbuf(it, &outbuf);
 decode_header_bq_out:
 	strbuf_release(&outbuf);
 	strbuf_release(&charset_q);
@@ -602,8 +597,7 @@ static void decode_transfer_encoding(struct strbuf *line)
 	default:
 		return;
 	}
-	strbuf_reset(line);
-	strbuf_addbuf(line, ret);
+	strbuf_setbuf(line, ret);
 	strbuf_release(ret);
 	free(ret);
 }
-- 
2.0.0.592.gf55b190
