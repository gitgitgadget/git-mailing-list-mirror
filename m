From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v9 1/2] format-patch: make newline after signature conditional
Date: Fri, 23 May 2014 21:08:13 -0700
Message-ID: <d74db966b42529b7d222745b2950e97ba5f46822.1400904004.git.jmmahler@gmail.com>
References: <cover.1400904004.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 06:08:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wo3GD-0002l9-ST
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 06:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbaEXEIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2014 00:08:38 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:59415 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaEXEIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2014 00:08:37 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so4950953pab.15
        for <git@vger.kernel.org>; Fri, 23 May 2014 21:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3lOJg/FWjkgsJuMAPNxlGzUHglZcKqw3IhBbVQYSmow=;
        b=Ph/q+Vpvtd0UlfZDMOwGf06JlXbNrWoNQOTnLH8jAwTG8y/VrY0Ixa4oIj3kkW/vGo
         CQ7BAj6Cel1NdeF6qJGHMnKroAjIYvIOS/5a0hoyj8OdcKBJ3/pOJfOlvcES0+/p4htA
         ugm+MwD1vx7rxsWol3p1u8nMqXMHINnVCADm6SPAFsJXtRfE40wTL1C+/7RUHSF76fBW
         rAEBR/9hqzIGRqdDdyIU+BHymNoLja518EAVLyRPEvpTiOlVAg+GfYJ3KnaYqZ4gFvNS
         +2nlKauYuThdrw1cmLtJbPEetLF2G7NIJdOud9tukEsjPWc00fvxOGEH6sQ4+xKCm5k2
         70aw==
X-Received: by 10.68.139.137 with SMTP id qy9mr11125026pbb.11.1400904516883;
        Fri, 23 May 2014 21:08:36 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id g6sm22946724pat.2.2014.05.23.21.08.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 23 May 2014 21:08:35 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Fri, 23 May 2014 21:08:32 -0700
X-Mailer: git-send-email 2.0.0.rc2
In-Reply-To: <cover.1400904004.git.jmmahler@gmail.com>
In-Reply-To: <cover.1400904004.git.jmmahler@gmail.com>
References: <cover.1400904004.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250053>

From: Jeff King <peff@peff.net>

When we print an email signature, we print the divider "--
\n", then the signature string, then two newlines.
Traditionally the signature is a one-liner (and the default
is just the git version), so the extra newline makes sense.

But one could easily specify a longer, multi-line signature,
like:

  git format-patch --signature='
  this is my long signature

  it has multiple lines
  ' ...

We should notice that it already has its own trailing
newline, and suppress one of ours.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 builtin/log.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 39e8836..5acc048 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -844,8 +844,13 @@ static void gen_message_id(struct rev_info *info, char *base)
 
 static void print_signature(void)
 {
-	if (signature && *signature)
-		printf("-- \n%s\n\n", signature);
+	if (!signature || !*signature)
+		return;
+
+	printf("-- \n%s", signature);
+	if (signature[strlen(signature)-1] != '\n')
+		putchar('\n');
+	putchar('\n');
 }
 
 static void add_branch_description(struct strbuf *buf, const char *branch_name)
-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
