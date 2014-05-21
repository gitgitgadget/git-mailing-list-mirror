From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v7 1/2] format-patch: make newline after signature conditional
Date: Wed, 21 May 2014 14:07:51 -0700
Message-ID: <1400706472-13471-2-git-send-email-jmmahler@gmail.com>
References: <1400706472-13471-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 21 23:08:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnDkG-0002hq-9Z
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 23:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbaEUVIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 17:08:11 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:41469 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbaEUVIK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 17:08:10 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so1769151pab.38
        for <git@vger.kernel.org>; Wed, 21 May 2014 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3lOJg/FWjkgsJuMAPNxlGzUHglZcKqw3IhBbVQYSmow=;
        b=NL+Sorifb+6fwiBLs9vqPEXeXmiGlCYDUAsX5GqsSAAeGSlNuaDZUB2ZM2uO9YvJQP
         bjB0cuetbeCScm63k5cORAKfRrBSomRqEgT7KAT1v9c0m+MeQiWfByuyn7uS//X4YDuZ
         PJXczs0NJvValwZxk8PHxb7jR93uIl1h1MQw8PyI1z43fV8uDZdiurBUTYWMNwKaVAEZ
         RMckpgb2e7pgGUs4iLKnSD6oCbLbv/wfydGZcvF7dKDyiEhkDbcLD2psRwYjxG1DZb/r
         8JdrGQP7Rzu4rkJ6/9wTXPbKjbQ2DKaHv67PtOHeVr79vtjP8mKzDhHFy0jjx9fWhfF/
         uwVw==
X-Received: by 10.68.201.226 with SMTP id kd2mr61528626pbc.157.1400706489296;
        Wed, 21 May 2014 14:08:09 -0700 (PDT)
Received: from hudson (o247-linksys-rtr.CSUChico.EDU. [132.241.18.53])
        by mx.google.com with ESMTPSA id gg3sm9594910pbc.34.2014.05.21.14.08.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 14:08:08 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 21 May 2014 14:08:05 -0700
X-Mailer: git-send-email 2.0.0.rc3.19.gd74db96.dirty
In-Reply-To: <1400706472-13471-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249830>

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
