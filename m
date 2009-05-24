From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/2] mailinfo: handle StGit patches
Date: Sun, 24 May 2009 09:19:17 +0200
Message-ID: <1243149558-17160-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 24 09:19:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M87zj-0005bT-9g
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 09:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbZEXHTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 03:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbZEXHTc
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 03:19:32 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:64843 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbZEXHTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 03:19:30 -0400
Received: by bwz22 with SMTP id 22so2436821bwz.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 00:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=W2zq3B7DA9QTiksuEFzv8YYIRlQnjBXhCrqzpVPHwbI=;
        b=gKe3iXynBxwymBw1+OrHQNuYWrg5mnl24dxkz5L+Bu+L0Nt+8No32R9VHMSOfeSAgw
         +cqBKYcA/3lydMhqEA8SHmNxlidkk0xCSnCm/OGnSITpy+YnvG3ybCS0HKbfGqcZ9721
         XMp4FuobSYc09srHeUwVov5uu3qIi6RSMOP+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iskwLXyehJcz0bbjXAcDYqZW2AeDkroj7BTiurDf538jihGf8AF/Ub8wXkpaXGk4gg
         9Lat7AGF7BUkOd7x+589MK+Q0dnRv6lVqTx9PmVUMWCIAFI2agmhNEyDwcSog80xJq0X
         7V0lb+LCiQtfCsrTms0s97CfAZnz2Ixg9wit0=
Received: by 10.103.240.15 with SMTP id s15mr2906734mur.93.1243149571162;
        Sun, 24 May 2009 00:19:31 -0700 (PDT)
Received: from localhost (host-78-15-2-20.cust-adsl.tiscali.it [78.15.2.20])
        by mx.google.com with ESMTPS id i7sm2047574mue.18.2009.05.24.00.19.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 00:19:30 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.212.g6c0d3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119812>

The default StGit export template puts author information in a From:
line located between the subject and the body of the commit message.
We can handle these files by prepending 'Subject: ' to the first
line of the file and skipping the whitespace following it.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 builtin-mailinfo.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 92637ac..67317e2 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -920,6 +920,24 @@ static int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
 	} while (isspace(peek));
 	ungetc(peek, in);
 
+	/* The default StGit export template has the subject as first line
+	   (without 'Subject:') followed by an empty line, followed by
+	   the author info (with 'From:'), followed by an empty line,
+	   followed by the body. If the first line is not a mail header
+	   and we add 'Subject:' in front of it, skipping the subsequent
+	   empty line(s), we can thus parse StGit patches.
+	   */
+	if (read_one_header_line(&line, fin))
+		check_header(&line, p_hdr_data, 1);
+	else {
+		strbuf_insert(&line, 0, "Subject: ", 9);
+		check_header(&line, p_hdr_data, 1);
+		do {
+			peek = fgetc(in);
+		} while (isspace(peek));
+		ungetc(peek, in);
+	}
+
 	/* process the email header */
 	while (read_one_header_line(&line, fin))
 		check_header(&line, p_hdr_data, 1);
-- 
1.6.3.1.212.g6c0d3.dirty
