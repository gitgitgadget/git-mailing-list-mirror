From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/8] revert: separate out parse errors logically
Date: Tue, 10 Jan 2012 21:43:55 +0530
Message-ID: <1326212039-13806-5-git-send-email-artagnon@gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 17:16:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkeN7-0005XL-1b
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 17:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226Ab2AJQP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 11:15:56 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51935 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143Ab2AJQPz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 11:15:55 -0500
Received: by ghbg21 with SMTP id g21so2204286ghb.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 08:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2YN5oPOjIitNJT1r5r7nn585DlmX06JytksYgrrJQ6k=;
        b=Gls0q2n6OutAJtPPugLayaVHt4Rx2jHX9v90i9Vbpb7mm0IByI9P0uNXoOTnDbj+6E
         MerpwIEHD++XJeLyy908fsW/Uti/D8TDeiY3UhvVcdD+QPHVbIsxJOKOA6RnSWOPU745
         bh/R8CEuLyauSdaiPdy6mg2SWo2DEo/swa8Jk=
Received: by 10.50.155.195 with SMTP id vy3mr2878966igb.12.1326212154754;
        Tue, 10 Jan 2012 08:15:54 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id lu10sm129662851igc.0.2012.01.10.08.15.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 08:15:52 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1326212039-13806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188262>

Three kinds of errors can arise from parsing the instruction sheet:
1. Unrecognized action
2. Malformed object name
3. Object name does not refer to a valid commit

The next patch makes an attempt to make the parser report meaningful
errors by replacing the "return -1" with "return error(...)"
appropriately.  For the first kind of error, it is insufficient to
check if the buffer beings with a "pick" or "revert", otherwise the
following insn sheet would be interpreted as having a malformed object
name:

pickle a1fe57~2

In reality, the issue is that "pickle" is an unrecognized instruction.
So, check that the buffer starts with ("pick " or "pick\t") and
("revert " or "revert\t").

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1841ffa..9a09471 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -736,22 +736,19 @@ static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
 {
 	unsigned char commit_sha1[20];
 	char *end_of_object_name;
-	int saved, status, padding;
+	int saved, status;
 
-	if (!prefixcmp(bol, "pick")) {
+	if (!prefixcmp(bol, "pick ") || !prefixcmp(bol, "pick\t")) {
 		item->action = REPLAY_PICK;
-		bol += strlen("pick");
-	} else if (!prefixcmp(bol, "revert")) {
+		bol += strlen("pick ");
+	} else if (!prefixcmp(bol, "revert ") || !prefixcmp(bol, "revert\t")) {
 		item->action = REPLAY_REVERT;
-		bol += strlen("revert");
+		bol += strlen("revert ");
 	} else
 		return -1;
 
 	/* Eat up extra spaces/ tabs before object name */
-	padding = strspn(bol, " \t");
-	if (!padding)
-		return -1;
-	bol += padding;
+	bol += strspn(bol, " \t");
 
 	end_of_object_name = bol + strcspn(bol, " \t\n");
 	saved = *end_of_object_name;
-- 
1.7.8.2
