From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] fast-import: Create import-marks file when necessary
Date: Mon, 10 Jan 2011 01:03:57 +0530
Message-ID: <1294601637-18416-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 09 20:33:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pc11P-0007Tt-MM
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 20:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab1AITdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jan 2011 14:33:42 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40862 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab1AITdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 14:33:41 -0500
Received: by iyj18 with SMTP id 18so314927iyj.19
        for <git@vger.kernel.org>; Sun, 09 Jan 2011 11:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=gS8DSsW9MX58deq1hIdPyHoM/ckd+ARF6nWpiaQ9Uyo=;
        b=t39wQUpRoH/3oyf8CREAZLG/zOQ3ca+XsflQTnqAaE4IZy0vrpkhQMTzCfVOmD+pfJ
         qo/6X0Klt7GTA+l6C6xWZsHuYbqrZrFKmJXS1PVCdejAvZwjt60yO5BHGjGavFUuBTSy
         sn1Dug0VCknkS/8hlQD3jsnJ1DhT6ww+9Zclg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=VyTSo8t9Ub4nHfhDhmP/X0uwibQft6M5auuouVRTWAIbxtOBr/h0H1cGj46xnvUCuY
         rzrIV/Ii0CcJoR9+w2YFufBYrbxrd8XfHDyFqOh6SxixR2r5pwnmC4JVpjun1QAruelh
         g+O8USbQdT8QhbYDyIkQ9xyId6w24Xv/JvHew=
Received: by 10.42.230.1 with SMTP id jk1mr3422205icb.67.1294601620949;
        Sun, 09 Jan 2011 11:33:40 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id gy41sm25461143ibb.5.2011.01.09.11.33.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Jan 2011 11:33:39 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.8.g98938a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164859>

When both --import-marks and --export-marks are given, and specify the
same file, that file should be created if it doesn't exist. Without
this patch, the caller would have to check for the existence of a
marks file and vary its fast-import invocation accordingly.

Requested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 fast-import.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 5055504..cb7a9c9 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3247,8 +3247,23 @@ static void parse_argv(void)
 		usage(fast_import_usage);
 
 	seen_data_command = 1;
-	if (import_marks_file)
+	if (import_marks_file) {
+		FILE *f = fopen(import_marks_file, "r");
+		if (!f) {
+			if (errno == ENOENT &&
+				!strcmp(import_marks_file, export_marks_file)) {
+				FILE *d = fopen(import_marks_file, "w");
+				if (!d)
+					die_errno("cannot create '%s'", import_marks_file);
+				fclose(d);
+			}
+			else
+				die_errno("cannot read '%s'", import_marks_file);
+		}
+		else
+			fclose(f);
 		read_marks();
+	}
 }
 
 int main(int argc, const char **argv)
-- 
1.7.4.rc1.8.g98938a.dirty
