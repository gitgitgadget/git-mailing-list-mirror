From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/4] revert: use getn_sha1() to simplify insn parsing
Date: Thu, 29 Mar 2012 19:28:13 +0530
Message-ID: <1333029495-10034-3-git-send-email-artagnon@gmail.com>
References: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 29 15:59:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDFsS-0007Q4-1B
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 15:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759381Ab2C2N6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 09:58:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55347 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932807Ab2C2N6a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 09:58:30 -0400
Received: by yhmm54 with SMTP id m54so1454802yhm.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NBFeDZ3ll5Brh9ZoSPwgWFnTmhikI3DFiDMsUWndNnI=;
        b=DV2YPapfObCIWSg2z7FBqUWsFMLOhJEKDBRQj8mVoLetEmHsJPsKcM/QkBhHhjXssn
         ad/QmZCW8DcwcQf9EEO90zTctDn7Ct4/QsU3wD7/biCekGsIJQA/fhDrfhsyayH61H0P
         ES9erP+jv2c4yJLzPhAGtvg4yhsGy9x5RfiXQOKJR4YL7WJdqZifogeicpwrO6Rf6mVC
         TVqw7ry27NUZjMSQIUDit8CjaepMUusIjRvn5BytTmFsL3Epuxk23orMFzoK0ydLfCgj
         JVOzG4WiNnGbMPm/kKFs9bfUwxuPYoAS9SWkLSz3AzfeFiyaUz8Xbe9oJT6lwqC+iQvG
         Zk/Q==
Received: by 10.68.136.65 with SMTP id py1mr367477pbb.64.1333029509492;
        Thu, 29 Mar 2012 06:58:29 -0700 (PDT)
Received: from localhost.localdomain ([122.174.77.58])
        by mx.google.com with ESMTPS id j3sm5090947pbb.29.2012.03.29.06.58.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 06:58:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194256>

To read the object name in the instruction sheet, we currently
manipulate the buffer to artificially introduce a NUL after the
supposed object name, and then use get_sha1() to read the object name
before restoring the buffer.  Get rid of this ugliness by using
getn_sha1(), a function introduced in the previous patch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a37846a..458cffb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -517,8 +517,7 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 {
 	unsigned char commit_sha1[20];
 	enum replay_action action;
-	char *end_of_object_name;
-	int saved, status, padding;
+	int namelen, padding;
 
 	if (!prefixcmp(bol, "pick")) {
 		action = REPLAY_PICK;
@@ -535,12 +534,6 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 		return NULL;
 	bol += padding;
 
-	end_of_object_name = bol + strcspn(bol, " \t\n");
-	saved = *end_of_object_name;
-	*end_of_object_name = '\0';
-	status = get_sha1(bol, commit_sha1);
-	*end_of_object_name = saved;
-
 	/*
 	 * Verify that the action matches up with the one in
 	 * opts; we don't support arbitrary instructions
@@ -552,8 +545,8 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 		return NULL;
 	}
 
-	if (status < 0)
+	namelen = strcspn(bol, " \t\n");
+	if (getn_sha1(bol, namelen, commit_sha1))
 		return NULL;
 
 	return lookup_commit_reference(commit_sha1);
-- 
1.7.8.1.362.g5d6df.dirty
