From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 2/3] git-p4: fix handling of multi-word P4EDITOR
Date: Tue, 19 May 2015 23:23:17 +0100
Message-ID: <1432074198-13806-3-git-send-email-luke@diamand.org>
References: <xmqqa8x0a7wq.fsf@gitster.dls.corp.google.com>
 <1432074198-13806-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 00:24:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yupvl-0005aF-Lr
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbbESWYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:24:06 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34982 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbESWYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:24:04 -0400
Received: by wicmx19 with SMTP id mx19so134317986wic.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 15:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6pQ/NnEGyRw88dx5JTDbz0OQ2eN3l0J09+B0ACi9/SI=;
        b=JJd59WbdzVG8RcVcwW8iUO3fc25mKLjGCqtbL/zNINr39eSOmolNkurr6Kn8L/J3BY
         jo/wNFdeUYN05e/VqceHldrij7XC+oYD2I1MJUAQbKCO9LY8WG7QTpDXHvuBATUJ0/gy
         xrrfb7UtXU20mO2OMFKhIOFnet8B2XbdQY+rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6pQ/NnEGyRw88dx5JTDbz0OQ2eN3l0J09+B0ACi9/SI=;
        b=luqcgx4/Q2KWjDO0kMFI4Nu+YE98s7CONwy+4NwEUjZOtnda9VB/PoQS3ZqmqwwOKg
         lB2wFNcd8iMhttQBW2g4Hy3lUzkof1fIiuttEnQmpazSuHoMKX29PJe2BNy6OWQm/6B4
         xs8Zm+F4RryHg6tkddvetjjOEn7tq25uT6ywvMz1jvOXfm7sV78rnfX8rUJUKlN1jgaR
         t9YdBml6eikGHRfONXgWJCCyUTtVjw/31v2oOVP8db4L09ZLlmXymcP+d3C3L8Jf32hL
         V79MsCldfrn1dL0+RB2gVcn+wB0Eoz6tcjxHr6bazHTvnl0MPSW3iOkhwk7dTbHMD4J4
         QU2A==
X-Gm-Message-State: ALoCoQmF9oyRjBbZgUgmetMR7ITmsRr7joToht0Y1mUS4FQcfUerv/jNwaP1j2LY0LSUFhbvX4+D
X-Received: by 10.180.97.164 with SMTP id eb4mr36318450wib.3.1432074242925;
        Tue, 19 May 2015 15:24:02 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id x10sm23711568wjf.45.2015.05.19.15.24.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 May 2015 15:24:02 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.502.gb11c5ab
In-Reply-To: <1432074198-13806-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269423>

This teaches git-p4 to pass the P4EDITOR variable to the
shell for expansion, so that any command-line arguments are
correctly handled. Without this, git-p4 can only launch the
editor if P4EDITOR is solely the path to the binary, without
any arguments.

This also adjusts t9805, which relied on the previous behaviour.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-p4.py                          | 2 +-
 t/t9805-git-p4-skip-submit-edit.sh | 2 +-
 t/t9820-git-p4-editor-handling.sh  | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index ff132b2..de06046 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1220,7 +1220,7 @@ class P4Submit(Command, P4UserMap):
             editor = os.environ.get("P4EDITOR")
         else:
             editor = read_pipe("git var GIT_EDITOR").strip()
-        system([editor, template_file])
+        system(["sh", "-c", ('%s "$@"' % editor), editor, template_file])
 
         # If the file was not saved, prompt to see if this patch should
         # be skipped.  But skip this verification step if configured so.
diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
index 8931188..5fbf904 100755
--- a/t/t9805-git-p4-skip-submit-edit.sh
+++ b/t/t9805-git-p4-skip-submit-edit.sh
@@ -90,7 +90,7 @@ test_expect_success 'no config, edited' '
 		cd "$git" &&
 		echo line >>file1 &&
 		git commit -a -m "change 5" &&
-		P4EDITOR="$TRASH_DIRECTORY/ed.sh" &&
+		P4EDITOR="\"$TRASH_DIRECTORY/ed.sh\"" &&
 		export P4EDITOR &&
 		git p4 submit &&
 		p4 changes //depot/... >wc &&
diff --git a/t/t9820-git-p4-editor-handling.sh b/t/t9820-git-p4-editor-handling.sh
index af924bb..7026ef9 100755
--- a/t/t9820-git-p4-editor-handling.sh
+++ b/t/t9820-git-p4-editor-handling.sh
@@ -17,7 +17,6 @@ test_expect_success 'init depot' '
 	)
 '
 
-test_expect_failure 'EDITOR has options' '
 # Check that the P4EDITOR argument can be given command-line
 # options, which git-p4 will then pass through to the shell.
 test_expect_success 'EDITOR has options' '
-- 
2.4.1.502.gb11c5ab
