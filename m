From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH] connect.c: finish_connect(): allow null pid parameter
Date: Tue, 12 Sep 2006 11:00:13 +0200
Message-ID: <4506771D.9040605@innova-card.com>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>	<7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>	<45053BA2.6050502@innova-card.com> <7vzmd5eedk.fsf@assigned-by-dhcp.cox.net> <45066CFD.5040202@innova-card.com> <450673B7.8050704@innova-card.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 12 11:00:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GN47b-0008CF-Tm
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 11:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWILI7z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 04:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWILI7z
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 04:59:55 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:12930 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965151AbWILI7y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Sep 2006 04:59:54 -0400
Received: by nz-out-0102.google.com with SMTP id n1so687161nzf
        for <git@vger.kernel.org>; Tue, 12 Sep 2006 01:59:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=rS7KsKRkJh8pEFG2xH1IaO44MIOgROQlsIZ7/bKlRN/TDTS92XcmPdcfVp5/MaUNIIKIZLF/E2vjw9/CVVACAXsIQmQE7HqxSKbzI5RNJUL+5NQ3h8nHc1+4XYFNIFoUALtcRwMUG4NVHqXNZREGRZTHS5FbYNhNWonMmNqbYzs=
Received: by 10.65.219.14 with SMTP id w14mr3065288qbq;
        Tue, 12 Sep 2006 01:59:53 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id e14sm5076162qbe.2006.09.12.01.59.52;
        Tue, 12 Sep 2006 01:59:52 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <450673B7.8050704@innova-card.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26885>

git_connect() can return 0 if we use git protocol for example.
Users of this function don't know and don't care if a process
had been created or not, and to avoid them to check it before
calling finish_connect() this patch allows finish_connect() to
take a null pid. And in that case return 0.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---

 Found it when debugging 'git archive --remote=git://...'
 command. I noticed that this command always exited with 1 as
 status.

 connect.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/connect.c b/connect.c
index 1c6429b..e6efff9 100644
--- a/connect.c
+++ b/connect.c
@@ -737,6 +737,9 @@ int git_connect(int fd[2], char *url, co
 
 int finish_connect(pid_t pid)
 {
+	if (pid == 0)
+		return 0;
+
 	while (waitpid(pid, NULL, 0) < 0) {
 		if (errno != EINTR)
 			return -1;
-- 
1.4.2
