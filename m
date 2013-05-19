From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote-hg: set stdout to binary mode on win32
Date: Sun, 19 May 2013 06:53:48 -0500
Message-ID: <1368964428-1059-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Amit Bakshi <ambakshi@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 19 13:55:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2D0-00081D-8N
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491Ab3ESLzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:55:21 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:50581 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab3ESLzU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 07:55:20 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so6570409oag.25
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=BI6ACt+ydc0HO4M6inkcZbA7nSgofGz/ie2djSIII2E=;
        b=lJT/BszQgjBG0Jp8paS/HJ/7yArAXn5HAl0VMdyXq+e9NhXbjpYc+cDbk3t1aULBap
         b0Rsi7DRbUYgcwm9dWkwqDETfkTMfofqPg7nx+j8XOJk6jO08Ec0vXclEspUBEM60vHF
         kZrwdhHnLBgKXU9HpAWeXUSis5VH/xtdOS2vZSF/QFqDYhKXURtTf4GU5Ol+hAlcQvnA
         Wsrzr7oIu+wMZkwyFWOO2pyN2gYjuDQR268by/+UnRwHLLRpKShE3KgpMkL3FVXBBLnM
         Lvg7TZUdXTuCt1Cps6fHUy6NphVmcJbK/tBw/cjSFLrir6lZLdJhdgywFqm/Wmt+avLj
         R9nA==
X-Received: by 10.182.153.5 with SMTP id vc5mr24911987obb.32.1368964519963;
        Sun, 19 May 2013 04:55:19 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id na9sm8306819obb.10.2013.05.19.04.55.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 19 May 2013 04:55:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.286.g3d43083
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224873>

From: Amit Bakshi <ambakshi@gmail.com>

git clone hangs on windows, and file.write would return errno 22 inside
of mercurial's windows.winstdout wrapper class. This patch sets stdout's
mode to binary, fixing both issues.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index beb864b..01555dc 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -954,6 +954,10 @@ def main(args):
     marks_path = os.path.join(dirname, 'marks-hg')
     marks = Marks(marks_path)
 
+    if sys.platform == 'win32':
+        import msvcrt
+        msvcrt.setmode(sys.stdout.fileno(), os.O_BINARY)
+
     parser = Parser(repo)
     for line in parser:
         if parser.check('capabilities'):
-- 
1.8.3.rc3.286.g3d43083
