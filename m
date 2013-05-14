From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 46/47] remote-hg: improve lightweight tag author
Date: Mon, 13 May 2013 23:37:09 -0500
Message-ID: <1368506230-19614-47-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:41:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc73G-0005A8-Vj
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082Ab3ENElQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:41:16 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:52238 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab3ENElL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:41:11 -0400
Received: by mail-ob0-f178.google.com with SMTP id v19so99937obq.9
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=3LBXot6gD13ynpoKBeWLuz0UKETTDIWQWgZFh5G7UK8=;
        b=QDGO3ATQBYMWLNea2cK+lTdhquB7A+FkjFnLq9oXaFt1P+IRcu8+jB2zFaJkmFM5VI
         UCqqkEvV93KxHDknthl9rqmXccMtTKxIgNVZ9CRu505I4050hmbQZTbOePPwCxlyTuD9
         CQDDheqq3BccGiBDSTvXqjhaudDecYPturI0oMQAYPeoSuViOVcrIj9/JX8WOg60Q2wh
         A8HAUD2DSZIslBsX8YDQS6KLh8IMX+srmpUys3zUYILhm/evDUc/EXllSMMjLbS4Tdjf
         JU8Ek0aw2zfVthKuDiaOgStoLrFIy7hxp/GuafwnJvFEBTPEIOiX1xhIUlZSDoARfxTm
         JXLA==
X-Received: by 10.60.59.198 with SMTP id b6mr15408184oer.84.1368506470939;
        Mon, 13 May 2013 21:41:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n6sm20474959oel.8.2013.05.13.21.41.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:41:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224278>

Use git's committer.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index ff38fac..24100df 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -820,13 +820,23 @@ def write_tag(repo, tag, node, msg, author):
 
     p1 = tip.hex()
     p2 = '0' * 40
-    if not author:
-        author = (None, 0, 0)
-    user, date, tz = author
+    if author:
+        user, date, tz = author
+        date_tz = (date, tz)
+    else:
+        cmd = ['git', 'var', 'GIT_COMMITTER_IDENT']
+        process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
+        output, _ = process.communicate()
+        m = re.match('^.* <.*>', output)
+        if m:
+            user = m.group(0)
+        else:
+            user = repo.ui.username()
+        date_tz = None
 
     ctx = context.memctx(repo, (p1, p2), msg,
             ['.hgtags'], getfilectx,
-            user, (date, tz), {'branch' : branch})
+            user, date_tz, {'branch' : branch})
 
     tmp = encoding.encoding
     encoding.encoding = 'utf-8'
-- 
1.8.3.rc1.579.g184e698
