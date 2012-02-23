From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] mingw: work around stat-limitation
Date: Thu, 23 Feb 2012 21:25:44 +0100
Message-ID: <1330028744-5280-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org, msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 21:26:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0fEv-0001uB-QE
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 21:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174Ab2BWUZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 15:25:59 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39338 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932170Ab2BWUZ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 15:25:58 -0500
Received: by lagu2 with SMTP id u2so1927117lag.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 12:25:56 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 10.112.27.165 as permitted sender) client-ip=10.112.27.165;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of kusmabite@gmail.com designates 10.112.27.165 as permitted sender) smtp.mail=kusmabite@gmail.com; dkim=pass header.i=kusmabite@gmail.com
Received: from mr.google.com ([10.112.27.165])
        by 10.112.27.165 with SMTP id u5mr1251451lbg.48.1330028756853 (num_hops = 1);
        Thu, 23 Feb 2012 12:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=GVp/wB0YKa/8Sai7Na0JFnfbYMxbzOva9RFd7AX6D/Y=;
        b=EKh8VQIT0vHuIeOxtQT1e9513e69TqYH08w6pP+S5F4/Z8A53jUCBRrfnJr2c4Bh9n
         zmaXyAuLk1/7pc7bTc5YyYTmqxSh03Y6kSTO3FTU7Tf1CGAYzkWHTFDqZZxbT0t3pl/Y
         hrU6x0tq8RWEee8D4kdFia+5vEWBLXLmN1jxc=
Received: by 10.112.27.165 with SMTP id u5mr1058469lbg.48.1330028756735;
        Thu, 23 Feb 2012 12:25:56 -0800 (PST)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id fl2sm2900414lbb.4.2012.02.23.12.25.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 12:25:55 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191394>

Our stat implementation for Windows always sets st_ino to 0. This
means that checking if isatty(0) and comparing the reported inodes
of stdout and stdin is not sufficient to detect that both are
pointing to the same TTY.

Luckily, there's only one console on Windows, so adding a check for
isatty(1) should do the trick. For platforms where inodes are
reported correctly, this should still be correct.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Here's a proper patch for this glitch.

 builtin/merge.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index ed0f959..bef01e3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1130,6 +1130,7 @@ static int default_edit_option(void)
 	return (!fstat(0, &st_stdin) &&
 		!fstat(1, &st_stdout) &&
 		isatty(0) &&
+		isatty(1) &&
 		st_stdin.st_dev == st_stdout.st_dev &&
 		st_stdin.st_ino == st_stdout.st_ino &&
 		st_stdin.st_mode == st_stdout.st_mode);
-- 
1.7.9
