From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] Fix buffer overflow in prepare_attr_stack
Date: Wed, 16 Jul 2008 18:54:03 +0400
Message-ID: <1216220043-27678-2-git-send-email-dpotapov@gmail.com>
References: <37fcd2780807160733o156e49c6m51314ff18764ccd5@mail.gmail.com>
 <1216220043-27678-1-git-send-email-dpotapov@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 16:55:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ8PR-00010g-LY
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 16:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756844AbYGPOyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 10:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756843AbYGPOyO
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 10:54:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:3274 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756122AbYGPOyL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 10:54:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2454971fgg.17
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UWFDNZANzjE9sZVDFIcGi53DU3PxnmtUVgkAY85W50Q=;
        b=f7AtXZTYeUl9F8YzYUYSyL5fOwy2qyysrDm4Dq6h+yX6fPNoM0PJnK5LNTMx/V05HJ
         UT2brCHGXEs4K7UGxDXBBxaZJ6Gd6jBBYrd7227OWvgX8tEthoDUkhfyiClj50tcPH1J
         INIi/SXCYROsNVxZtgN/yJ1k9CrYEmU6gO1Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=v2f23vfqO/zfExWhTWJ8D6jsMNNShDIDixLyVGolFRNA1+sOknViNyqlc1gB7bv5lE
         BMawcfnXV+MHt+RUrzRN9IvCcxelA48Y9rBhccBXN4euNH8n0IFLezyWT+b44KKKHJB5
         /dBVT4bs83tnTr+sMpSrTRh0Htv8vxs2c5beU=
Received: by 10.86.65.11 with SMTP id n11mr2165405fga.64.1216220050945;
        Wed, 16 Jul 2008 07:54:10 -0700 (PDT)
Received: from localhost ( [85.141.237.219])
        by mx.google.com with ESMTPS id e11sm1335577fga.4.2008.07.16.07.54.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 07:54:10 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3.3.gfcafb
In-Reply-To: <1216220043-27678-1-git-send-email-dpotapov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88686>

If PATH_MAX on your system is smaller than a path stored in the git repo,
it may cause the buffer overflow in prepare_attr_stack.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 attr.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/attr.c b/attr.c
index 0fb47d3..73b6d6d 100644
--- a/attr.c
+++ b/attr.c
@@ -459,7 +459,9 @@ static void prepare_attr_stack(const char *path, int dirlen)
 {
 	struct attr_stack *elem, *info;
 	int len;
-	char pathbuf[PATH_MAX];
+	struct strbuf pathbuf;
+
+	strbuf_init(&pathbuf, dirlen+2+strlen(GITATTRIBUTES_FILE));
 
 	/*
 	 * At the bottom of the attribute stack is the built-in
@@ -510,13 +512,14 @@ static void prepare_attr_stack(const char *path, int dirlen)
 			len = strlen(attr_stack->origin);
 			if (dirlen <= len)
 				break;
-			memcpy(pathbuf, path, dirlen);
-			memcpy(pathbuf + dirlen, "/", 2);
-			cp = strchr(pathbuf + len + 1, '/');
+			pathbuf.len = 0;
+			strbuf_add(&pathbuf, path, dirlen);
+			strbuf_addch(&pathbuf, '/');
+			cp = strchr(pathbuf.buf + len + 1, '/');
 			strcpy(cp + 1, GITATTRIBUTES_FILE);
-			elem = read_attr(pathbuf, 0);
+			elem = read_attr(pathbuf.buf, 0);
 			*cp = '\0';
-			elem->origin = strdup(pathbuf);
+			elem->origin = strdup(pathbuf.buf);
 			elem->prev = attr_stack;
 			attr_stack = elem;
 			debug_push(elem);
-- 
1.5.6.3.3.gfcafb
