From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] revert: Parse instruction sheet more cautiously
Date: Fri, 12 Aug 2011 00:21:42 +0530
Message-ID: <1313088705-32222-4-git-send-email-artagnon@gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 11 20:55:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QraPG-00035c-Kc
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 20:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab1HKSy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 14:54:56 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63951 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab1HKSyz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 14:54:55 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so4115440pzk.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JhXzs4SLys1tuIFjsUupWvV7ekV1beZu4wzHIqK/ffM=;
        b=nA3hCbj/NBPkDnTYrS0Yh/ONfTHI03WxJRSmWh41yybtp5gOK/++qdNbi06OXETjVS
         smv1ReZ9OCHJSRPLOv2X7dNaQZJcOg9GUNWZL+r+6PHUA6KfO6OacOICeIyHSnjpfCZY
         sd/+YLU7T9Fno/fkjx66SlBkjG5rpIDOFX9zY=
Received: by 10.142.216.20 with SMTP id o20mr288wfg.5.1313088895298;
        Thu, 11 Aug 2011 11:54:55 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id t7sm1117355wfl.2.2011.08.11.11.54.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 11:54:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179131>

Fix a buffer overflow bug by checking that parsed SHA-1 hex will fit
in the buffer we've created for it.  Also change the instruction sheet
format subtly so that a description of the commit after the object
name is optional.  So now, an instruction sheet like this is perfectly
valid:

  pick 35b0426
  pick fbd5bbcbc2e
  pick 7362160f

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |   20 +++++++++-----------
 t/t3510-cherry-pick-sequence.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1a4187a..f44f749 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -697,26 +697,24 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
 	unsigned char commit_sha1[20];
 	char sha1_abbrev[40];
 	enum replay_action action;
-	int insn_len = 0;
-	char *p, *q;
+	char *p = start, *q, *end = strchrnul(start, '\n');
 
 	if (!prefixcmp(start, "pick ")) {
 		action = CHERRY_PICK;
-		insn_len = strlen("pick");
-		p = start + insn_len + 1;
+		p += strlen("pick ");
 	} else if (!prefixcmp(start, "revert ")) {
 		action = REVERT;
-		insn_len = strlen("revert");
-		p = start + insn_len + 1;
+		p += strlen("revert ");
 	} else
 		return NULL;
 
-	q = strchr(p, ' ');
-	if (!q)
+	q = strchrnul(p, ' ');
+	if (q > end)
+		q = end;
+	if (q - p + 1 > sizeof(sha1_abbrev))
 		return NULL;
-	q++;
-
-	strlcpy(sha1_abbrev, p, q - p);
+	memcpy(sha1_abbrev, p, q - p);
+	sha1_abbrev[q - p] = '\0';
 
 	/*
 	 * Verify that the action matches up with the one in
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 3bca2b3..bc5f0b8 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -211,4 +211,33 @@ test_expect_success 'malformed instruction sheet 2' '
 	test_must_fail git cherry-pick --continue
 '
 
+test_expect_success 'missing commit descriptions in instruction sheet' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git commit &&
+	cut -d" " -f1,2 .git/sequencer/todo >new_sheet &&
+	cp new_sheet .git/sequencer/todo &&
+	git cherry-pick --continue &&
+	test_path_is_missing .git/sequencer &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	unrelated
+	OBJID
+	:000000 100644 OBJID OBJID A	foo
+	:000000 100644 OBJID OBJID A	unrelated
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.6.351.gb35ac.dirty
