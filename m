From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/9] revert: tolerate extra spaces, tabs in insn sheet
Date: Fri,  9 Dec 2011 21:12:00 +0530
Message-ID: <1323445326-24637-4-git-send-email-artagnon@gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 16:43:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ2bb-00010h-BB
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 16:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239Ab1LIPnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 10:43:20 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41561 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab1LIPnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 10:43:19 -0500
Received: by mail-qy0-f174.google.com with SMTP id z2so2223292qcq.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 07:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qe/Vrt62mKZpSUOiy9xKzI20zh9uHtmF7eXdagvLtZU=;
        b=tTPTIWP74dArdH9HbdMQkLU6XA9qcXKQzak50JdmhGhDVjyUvYjeyLVRXDCVFDVy7w
         5oeYc+rghWMDqqhVuo1Yaflk3u5fZrMcxM5JoPvCSr3vZLPvCAUnoot7BRQgkoKRGRkM
         dIHtTltA3PmHMhbSrh7ezwVDjobf944qnFZx4=
Received: by 10.50.208.72 with SMTP id mc8mr3824488igc.19.1323445398642;
        Fri, 09 Dec 2011 07:43:18 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id a2sm18298821igj.7.2011.12.09.07.43.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 07:43:17 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186641>

Tolerate extra spaces and tabs as part of the the field separator in
'.git/sequencer/todo', for people with fat fingers.

Requested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |    6 +++++-
 t/t3510-cherry-pick-sequence.sh |   11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 70055e5..b976562 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -727,7 +727,11 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	} else
 		return NULL;
 
-	end_of_object_name = bol + strcspn(bol, " \n");
+	/* Eat up extra spaces/ tabs before object name */
+	while (*bol == ' ' || *bol == '\t')
+		bol += 1;
+
+	end_of_object_name = bol + strcspn(bol, " \t\n");
 	saved = *end_of_object_name;
 	*end_of_object_name = '\0';
 	status = get_sha1(bol, commit_sha1);
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 6390f2a..781c5ac 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -342,6 +342,17 @@ test_expect_success 'malformed instruction sheet 3' '
 	test_must_fail git cherry-pick --continue
 '
 
+test_expect_success 'instruction sheet, fat-fingers version' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick \([0-9a-f]*\)/pick 	 \1 	/" .git/sequencer/todo >new_sheet &&
+	cp new_sheet .git/sequencer/todo &&
+	git cherry-pick --continue
+'
+
 test_expect_success 'commit descriptions in insn sheet are optional' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..anotherpick &&
-- 
1.7.7.3
