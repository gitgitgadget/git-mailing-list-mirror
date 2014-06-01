From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 6/9] builtin/log.c: replace signal() with sigaction()
Date: Sun,  1 Jun 2014 11:10:15 -0700
Message-ID: <089731f7d0287838646c52e14a8c4a8bc41dea7d.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 20:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrADz-0007WE-6i
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 20:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbaFASLK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jun 2014 14:11:10 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:46803 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbaFASLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 14:11:06 -0400
Received: by mail-pd0-f172.google.com with SMTP id fp1so2655129pdb.17
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=zPdhFKPfAOocIISDOZ1nKiS43ZZ+txwn+9cugTAZa5w=;
        b=FirxBxMBfR8aAk0NSksWit2UlxOWCSRkG8FC3HoXhqeLjHnkKyER6nfufeuBKb+yny
         +pbUsRvMwIWIRudCFTkLbIoVCvXGFKRGvmiVNc4fG1q7AdRBTwQetPo2Wz3bX8d5YYSP
         bdUgX67Y45uiYuNYq77raDxFjfxhpkHtQntR9ec8E7Sj9MYRzKQbzrFSyAxi+3t/bYuK
         lTNjvF8/AtJhv9M48yhJSYWtSWC3ek76kms7YBqVPe1C4jh4OOkhnT1uNBAYJikyVvsv
         D7SChQ+pli8oYbLuy22eVw9BbG6qgOQeab3toBL80W9IXwyyHu0fL4Gtn8JeESKOxJzt
         zzKQ==
X-Received: by 10.69.15.2 with SMTP id fk2mr34607311pbd.123.1401646265930;
        Sun, 01 Jun 2014 11:11:05 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id sh5sm16514920pbc.21.2014.06.01.11.11.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 01 Jun 2014 11:11:04 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 01 Jun 2014 11:11:01 -0700
X-Mailer: git-send-email 2.0.0.8.g7bf6e1f.dirty
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250539>

=46rom the signal(2) man page:

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.

Replaced signal() with sigaction() in builtin/log.c

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 builtin/log.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 39e8836..f1deea1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -315,7 +315,11 @@ static void setup_early_output(struct rev_info *re=
v)
 static void finish_early_output(struct rev_info *rev)
 {
 	int n =3D estimate_commit_count(rev, rev->commits);
-	signal(SIGALRM, SIG_IGN);
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D SIG_IGN;
+	sigaction(SIGALRM, &sa, NULL);
 	show_early_header(rev, "done", n);
 }
=20
--=20
2.0.0.8.g7bf6e1f.dirty
