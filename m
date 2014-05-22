From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v8 1/2] format-patch: make newline after signature conditional
Date: Wed, 21 May 2014 18:53:08 -0700
Message-ID: <1400723589-8975-2-git-send-email-jmmahler@gmail.com>
References: <1400723589-8975-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 03:54:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnICz-0008W2-Hd
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 03:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbaEVByI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 21:54:08 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:36012 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbaEVByI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 21:54:08 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so1992016pbb.11
        for <git@vger.kernel.org>; Wed, 21 May 2014 18:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3lOJg/FWjkgsJuMAPNxlGzUHglZcKqw3IhBbVQYSmow=;
        b=njfhB4dpJP8hspn2e7So6Eil3OTft9B9oIxG9Uv7DybmE5vCEENDug+iyXVMp8hB3z
         C0OoE+FjlGczmPDkAOLD5EUgy4LdU0wmNO9vvidwGeEj4OWZr/aVhPIyey7bqme29+IE
         MbONv0C7tYs5lpyjNGRO5xXchDIuqTBAV0rnwWW2VgCuPifKprp/lAyjneK68F1MPM95
         hO19ueFE5cW+HvqRRVC3lzIxrbt8j6aHufiBYJI0JB3RseLgeAkFnpS7Tcbvd1o97Gxv
         xVMF+TWPw5Iya+n4Lke2c4hE3z7GyPVfSk2BA4lJ0u/1HVPZkx4uiLQEjPyn3y+Rinvm
         Ae3A==
X-Received: by 10.68.105.4 with SMTP id gi4mr63734410pbb.73.1400723647497;
        Wed, 21 May 2014 18:54:07 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id gu11sm10201009pbd.38.2014.05.21.18.54.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 18:54:06 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 21 May 2014 18:54:03 -0700
X-Mailer: git-send-email 2.0.0.rc3.19.gd74db96.dirty
In-Reply-To: <1400723589-8975-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249870>

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
