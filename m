From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/4] revert: simplify insn parsing logic
Date: Thu, 29 Mar 2012 19:28:14 +0530
Message-ID: <1333029495-10034-4-git-send-email-artagnon@gmail.com>
References: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 29 15:59:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDFsS-0007Q4-J5
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 15:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807Ab2C2N6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 09:58:40 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57959 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759354Ab2C2N6c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 09:58:32 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so162702pbc.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fAfHmyIYmmbOu7ID7cpWPpCNr8R5VLQqx5YEp98tmcA=;
        b=Gd7J0RBYne7mzjt0/x839N86mEX2EFKOrUJEk+ncA9cFG8eT13vw6xu124q2vPhTnq
         8zFCROh2Jjm3s0a5r41+cUU01Lff2bAUDRvWrXBz/RQr+qroOz/03x7mSAMC0UmuXbyj
         B27UWFl/AzsBzY9O5tt5zVZWzmIt57gdWN5zHrGwhIOJBY5TMFLBtF6uBdhfm3XqUYaM
         HXcPxi9Od/5Cb9VpXGGAJ2m2NRdyCxMzJG3BzjhoK3aGR1t9aw76Pcl/IkIyk4t3ZNFV
         ZAcq16hmVTeelhnFq130aOB1KFa5S7KBd1Nv6kcNe8Pkg9nbKpaM8x1zMQozWdNkAxIR
         zTsA==
Received: by 10.68.218.72 with SMTP id pe8mr259123pbc.45.1333029512422;
        Thu, 29 Mar 2012 06:58:32 -0700 (PDT)
Received: from localhost.localdomain ([122.174.77.58])
        by mx.google.com with ESMTPS id j3sm5090947pbb.29.2012.03.29.06.58.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 06:58:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194258>

Our instruction sheet parser first looks for a valid action by
checking that the buffer starts with either "pick" or "revert".  Then,
it looks for either spaces or tabs before looking for the object name,
erroring out if it doesn't find any.  Simplify this logic without
making any functional changes by looking for ("pick " or "pick\t") or
("revert " or "revert\t") in the first place.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 458cffb..02e58ad 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -517,22 +517,19 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 {
 	unsigned char commit_sha1[20];
 	enum replay_action action;
-	int namelen, padding;
+	int namelen;
 
-	if (!prefixcmp(bol, "pick")) {
+	if (!prefixcmp(bol, "pick ") || !prefixcmp(bol, "pick\t")) {
 		action = REPLAY_PICK;
 		bol += strlen("pick");
-	} else if (!prefixcmp(bol, "revert")) {
+	} else if (!prefixcmp(bol, "revert ") || !prefixcmp(bol, "revert\t")) {
 		action = REPLAY_REVERT;
 		bol += strlen("revert");
 	} else
 		return NULL;
 
 	/* Eat up extra spaces/ tabs before object name */
-	padding = strspn(bol, " \t");
-	if (!padding)
-		return NULL;
-	bol += padding;
+	bol += strspn(bol, " \t");
 
 	/*
 	 * Verify that the action matches up with the one in
-- 
1.7.8.1.362.g5d6df.dirty
