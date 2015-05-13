From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 2/2] git-p4: fix handling of multi-word P4EDITOR
Date: Wed, 13 May 2015 08:36:15 +0100
Message-ID: <1431502575-2176-3-git-send-email-luke@diamand.org>
References: <1431502575-2176-1-git-send-email-luke@diamand.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>,
	Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 09:37:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsRE5-0001sF-8Z
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 09:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933065AbbEMHhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 03:37:06 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33534 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933059AbbEMHg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 03:36:59 -0400
Received: by wgin8 with SMTP id n8so34238383wgi.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 00:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=elrQ67vWilrADV+BQ8wgYRAxqINAOz12MP/rQG8S91s=;
        b=DEr3on3v5POArdmu9TsnHexfypxURYZdQzoRs59F6J9jcyl4bM6os8bCNR2QDmeZWh
         pnkLb+jXHS4So9dkB+4+CJjCpigZKHFDKvjcmI+k2goM656uDdmeBq9+PkKICIQ0J5PD
         iPns5ZZ6/9SOwADLwrPTD3eKpMSGYjKqaohDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=elrQ67vWilrADV+BQ8wgYRAxqINAOz12MP/rQG8S91s=;
        b=YzHGti/bAgAppq8lCt9mwGVB1cpXx33ktji0RrdM1OJc06z7DBP6PmqZapYhNo80Ju
         h33UMsVMF49uNB5xvx/7NO9jAOyAiaUY2uHZAQh52SzTNHIkxPak+QzjKQXzAg4ql7ir
         4rG+PXmarPtHlbfMWs1BmS7lJHK1I8nyuX4P3OF34mJQkmwaGNdOiSPmfVcLAmUTVz95
         Wc91nL3FFlVestELuU6l9pAMRJyh3S3LVl2t4kEnQB/7vmlo4kOmaOo34EkC/dUob51X
         SdeHgxRp3Q1yccDPpyKl2sQQDRqAumZmh93Na0dRFHoIaxlcSEo322stsU+Uz0N1sRnd
         J17A==
X-Gm-Message-State: ALoCoQki76s+ZW5FXhIEaAnyY7XhG477yffMCmVJgd+zddVGVG+PYtkKkj0XcBbzqlyub1yYYicP
X-Received: by 10.180.105.233 with SMTP id gp9mr37028700wib.83.1431502618394;
        Wed, 13 May 2015 00:36:58 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id nb9sm6579871wic.10.2015.05.13.00.36.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 00:36:57 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.380.g8e2ddc7
In-Reply-To: <1431502575-2176-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268943>

This teaches git-p4 to pass the P4EDITOR variable to the
shell for expansion, so that any command-line arguments are
correctly handled. Without this, git-p4 can only launch the
editor if P4EDITOR is solely the path to the binary, without
any arguments.

This also fixes t9805, which relied on the previous
behaviour.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-p4.py                          | 2 +-
 t/t9805-git-p4-skip-submit-edit.sh | 2 +-
 t/t9820-git-p4-editor-handling.sh  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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
