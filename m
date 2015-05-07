From: Luke Diamand <luke@diamand.org>
Subject: [PATCH 2/2] git-p4: fix handling of multi-word P4EDITOR
Date: Thu,  7 May 2015 18:25:01 +0100
Message-ID: <1431019501-30807-3-git-send-email-luke@diamand.org>
References: <1431019501-30807-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 19:25:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqPYX-0007mf-5f
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 19:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbbEGRZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 13:25:46 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36031 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbEGRZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 13:25:43 -0400
Received: by wizk4 with SMTP id k4so251545266wiz.1
        for <git@vger.kernel.org>; Thu, 07 May 2015 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fyeZqUMn35L4qkmUrxhVwcnlQb1QCdLHSZ8PhuJB5PQ=;
        b=MeX3FP747hTSbmhesl8DSBEFJyQv/OPql86Jvlj3w7zF5GJrUCO1xBHEboqtK4+4SU
         V6oByKiiVjhSodjc2FRfr8hhqXd4UJRFSscDDYpk6I90sOKIFVzPniOg54Hyyn8/ypS/
         sJz9zrXOGfjPfuBShMd+Ilm067EQ4UBf85bDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fyeZqUMn35L4qkmUrxhVwcnlQb1QCdLHSZ8PhuJB5PQ=;
        b=ZYjBL15Sue5EtTi5GBxdzbyaMGup9XzgQsKaX8GfwGy+EODIfVBGTwar+2cR66nY3B
         87yRAjFdrMbmbgLYu9+cUyf5z8viJnCjtpU//9CtmNhDeiPmWC8HgfqK1DsZwPCL2ggS
         zLG2XXwvppFiXW1gq1rq5rkoKy8gR/XnIeIA6lxvsyaUgREC5c8tD2Y1zOpdDjaaPTeY
         a6yutRRhZQcnCJdXuOOu+vkEsejrigl2tuTZryY7iSCtPhWZ9g8Dot4bxsCZWyzXwGcA
         qbJjKVSW/lpm5yNhLzMJZToYmocIDHkZJ+v9nyD5AgV68LegNZ0SQylaVrMKWx3OSdJG
         GrSA==
X-Gm-Message-State: ALoCoQkSBuK9IjQG8vyaC04ux2QsAD2uKQ83CLei5+LaDVBQiobzz+mBG1uTq3KTbGHw0h7fZXLy
X-Received: by 10.180.208.7 with SMTP id ma7mr8931608wic.0.1431019542381;
        Thu, 07 May 2015 10:25:42 -0700 (PDT)
Received: from ethel.cable.virginmedia.net (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id b5sm8416807wiw.8.2015.05.07.10.25.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 10:25:41 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.380.g8e2ddc7
In-Reply-To: <1431019501-30807-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268559>

This teaches git-p4 to pass the P4EDITOR variable to the
shell for expansion, so that any command-line arguments are
correctly handled. Without this, git-p4 can only launch the
editor if P4EDITOR is solely the path to the binary, without
any arguments.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py                         | 2 +-
 t/t9820-git-p4-editor-handling.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 41a77e6..ca6bb95 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1248,7 +1248,7 @@ class P4Submit(Command, P4UserMap):
             editor = os.environ.get("P4EDITOR")
         else:
             editor = read_pipe("git var GIT_EDITOR").strip()
-        system([editor, template_file])
+        system(["sh", "-c", ('%s "$@"' % editor), editor, template_file])
 
         # If the file was not saved, prompt to see if this patch should
         # be skipped.  But skip this verification step if configured so.
diff --git a/t/t9820-git-p4-editor-handling.sh b/t/t9820-git-p4-editor-handling.sh
index e0a3c52..c178bd7 100755
--- a/t/t9820-git-p4-editor-handling.sh
+++ b/t/t9820-git-p4-editor-handling.sh
@@ -17,9 +17,9 @@ test_expect_success 'init depot' '
 	)
 '
 
-test_expect_failure 'EDITOR has options' '
 # Check that the P4EDITOR argument can be given command-line
 # options, which git-p4 will then pass through to the shell.
+test_expect_success 'EDITOR has options' '
 	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
-- 
2.4.0.rc3.380.g8e2ddc7
