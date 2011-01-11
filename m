From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] fast-import: Don't barf if import-marks file is missing
Date: Tue, 11 Jan 2011 22:44:18 +0530
Message-ID: <1294766058-29739-1-git-send-email-artagnon@gmail.com>
References: <7vwrmd7kxe.fsf@alter.siamese.dyndns.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 18:14:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PchnM-0000V9-Vr
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 18:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451Ab1AKROA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 12:14:00 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:34174 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932422Ab1AKRN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 12:13:59 -0500
Received: by yib18 with SMTP id 18so5778768yib.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 09:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=h6hHlYXZ6Y7FRNCLpGsAtNkYYizsY2Nj7+FYozNvK8U=;
        b=LolRZhb3DwcpbIspkJaICdVzHKWa2zAfj18q5+wjzRMuX4pV1azRuyk21I2v4hmfQE
         bhz3Ei7MX1wvdnd+mMI6RwRBNvf9c6+18tVHVySdAlYqqknfQ/tSw/tVwn08E55sZeL0
         6L525v7EwFKjJrRHWnKagGnH//mlbVpi2cjQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=P55ap3f/cXqLdDsgD3a7Zfl/zIqd7rTAI5BPklB1IYyC7EN84BoYvWrR74AEC9PfAd
         9X17JLPzvTk6drLtnn5LkUQFbjMcz+iW/gY1tj1c9BWBeGR9CTDhIOk2UtslPHqNqjkg
         44ErOQqC21isHj8vNeOYxCokPMAfb2ygRc3Sc=
Received: by 10.90.25.13 with SMTP id 13mr395440agy.33.1294766038284;
        Tue, 11 Jan 2011 09:13:58 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id e24sm39110504ana.22.2011.01.11.09.13.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 09:13:57 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.529.gc7bce.dirty
In-Reply-To: <7vwrmd7kxe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164957>

The --import-marks option used to barf when the specified marks file
doesn't exist. Change its meaning to "read marks file if it exists" so
that callers don't have to handle bootstraping as a special case.

Requested-by: Jonathan Nieder <jrnieder@gmail.com>
Thanks-to: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-fast-import.txt |    2 +-
 fast-import.c                     |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index f56dfca..94fbe54 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -72,7 +72,7 @@ OPTIONS
 
 --import-marks=<file>::
 	Before processing any input, load the marks specified in
-	<file>.  The input file must exist, must be readable, and
+	<file>, if it exists.  The input file must be readable, and
 	must use the same format as produced by \--export-marks.
 	Multiple options may be supplied to import more than one
 	set of marks.  If a mark is defined to different values,
diff --git a/fast-import.c b/fast-import.c
index 7857760..cbd5124 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1795,7 +1795,11 @@ static void read_marks(void)
 {
 	char line[512];
 	FILE *f = fopen(import_marks_file, "r");
-	if (!f)
+	if (f)
+		;
+	else if (errno == ENOENT)
+		return; /* Marks file does not exist */
+	else
 		die_errno("cannot read '%s'", import_marks_file);
 	while (fgets(line, sizeof(line), f)) {
 		uintmax_t mark;
-- 
1.7.2.2.409.gdbb11.dirty
