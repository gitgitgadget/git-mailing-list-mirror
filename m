From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 7/8] revert: use getn_sha1() to simplify insn parsing
Date: Tue, 10 Jan 2012 21:43:58 +0530
Message-ID: <1326212039-13806-8-git-send-email-artagnon@gmail.com>
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
	id 1RkeN9-0005XL-5p
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 17:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259Ab2AJQQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 11:16:11 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47391 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143Ab2AJQQK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 11:16:10 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so1076194iab.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 08:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=C9JcVsDYgKZAwyy5hSecdeF/v0cOjdJsqYOLbEEqnEc=;
        b=SsXdQLu8YC5jIijzZU71LQ4pz9AGvMmaOUjd6W7AHcHF0N11UErmBy3uvUMNgbrOEV
         Qh5n/qmZfGVfrB5TbmSg7BYc98WbaWMGNqxY8tHKeLPy9VTr5bsCQowrJQZ0PWr2Hhzk
         74Ev+URlE/GRDH4yhsTYQ4IJ3mWpnDoN4tXoE=
Received: by 10.43.45.137 with SMTP id uk9mr22202140icb.52.1326212169598;
        Tue, 10 Jan 2012 08:16:09 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id lu10sm129662851igc.0.2012.01.10.08.16.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 08:16:08 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1326212039-13806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188260>

To read the object name in the instruction sheet, we currently
manipulate the buffer to artificially introduce a NUL after the
supposed object name, and then use get_sha1() to read the object name
before restoring the buffer.  Get rid of this ugliness by using
getn_sha1(), a function introduced in the previous patch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0954d22..187c317 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -750,8 +750,7 @@ static int parse_insn_line(char *bol, char *eol,
 			struct replay_insn_list *item, int lineno)
 {
 	unsigned char commit_sha1[20];
-	char *end_of_object_name;
-	int saved, status;
+	int namelen;
 
 	if (!prefixcmp(bol, "pick ") || !prefixcmp(bol, "pick\t")) {
 		item->action = REPLAY_PICK;
@@ -766,13 +765,8 @@ static int parse_insn_line(char *bol, char *eol,
 	/* Eat up extra spaces/ tabs before object name */
 	bol += strspn(bol, " \t");
 
-	end_of_object_name = bol + strcspn(bol, " \t\n");
-	saved = *end_of_object_name;
-	*end_of_object_name = '\0';
-	status = get_sha1(bol, commit_sha1);
-	*end_of_object_name = saved;
-
-	if (status < 0)
+	namelen = strcspn(bol, " \t\n");
+	if (getn_sha1(bol, namelen, commit_sha1))
 		return parse_error(_("malformed object name"),
 				git_path(SEQ_TODO_FILE), lineno, bol);
 
-- 
1.7.8.2
