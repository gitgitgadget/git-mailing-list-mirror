From: Michael Wookey <michaelwookey@gmail.com>
Subject: [PATCH] run-command.c: fix build warnings on Ubuntu
Date: Sat, 30 Jan 2010 09:38:19 +1100
Message-ID: <d2e97e801001291438k21a652cakb05ec34fc8bee227@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 23:38:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NazUE-0000zX-8d
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808Ab0A2Wil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 17:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754534Ab0A2Wil
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:38:41 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:46756 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881Ab0A2Wik (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 17:38:40 -0500
Received: by pzk28 with SMTP id 28so1942225pzk.4
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 14:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=XI5Uo5HEL54WNuxJuY3wovtB1ril74g2UNBFPFbJllQ=;
        b=SgbV+8OSlKt/VnABbnjreluclP9SAFQ1XLyemefna5sRDn1ZqFGq2fyLvkBlNFxdWp
         uFVHCptsNSjRqf3HuOnO+/Y19zfeQLZxLV/3Zq9lRVrqINuPOhISgiDmexN8U54Bym6m
         UZLhP5ea/REefK+QrR3guOM7Q7NRbWclRD770=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=K37OY1WSp7usdumPwLQEGwfrYHGAkPOyyjN9AGfRasrzvHTy0zzA7+9PnHv7w7yFIh
         +yzSFz3B8JfMJs9bvlKIMDEA8cmp+lNCxLtNVw8VUiwikPfs1ojxANVxQVnER3OmwvCN
         BVTWytcu3a4ymp1uGduF8BjP9Rs45Di9ff8jk=
Received: by 10.115.85.14 with SMTP id n14mr892411wal.127.1264804719338; Fri, 
	29 Jan 2010 14:38:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138392>

Building git on Ubuntu 9.10 warns that the return value of write(2)
isn't checked. These warnings were introduced in commits:

  2b541bf8 ("start_command: detect execvp failures early")
  a5487ddf ("start_command: report child process setup errors to the
parent's stderr")

GCC details:

  $ gcc --version
  gcc (Ubuntu 4.4.1-4ubuntu9) 4.4.1

Silence the warnings by reading (but not making use of) the return value
of write(2).

Signed-off-by: Michael Wookey <michaelwookey@gmail.com>
---
Although this will fix the build warnings, I am unsure if there is a
better way to achieve the same result. Using "(void)write(...)" still
gives warnings and I am unaware of any annotations that will silence
gcc.

 run-command.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 2feb493..3206d61 100644
--- a/run-command.c
+++ b/run-command.c
@@ -67,19 +67,21 @@ static int child_notifier = -1;

 static void notify_parent(void)
 {
-	write(child_notifier, "", 1);
+	ssize_t unused;
+	unused = write(child_notifier, "", 1);
 }

 static NORETURN void die_child(const char *err, va_list params)
 {
 	char msg[4096];
+	ssize_t unused;
 	int len = vsnprintf(msg, sizeof(msg), err, params);
 	if (len > sizeof(msg))
 		len = sizeof(msg);

-	write(child_err, "fatal: ", 7);
-	write(child_err, msg, len);
-	write(child_err, "\n", 1);
+	unused = write(child_err, "fatal: ", 7);
+	unused = write(child_err, msg, len);
+	unused = write(child_err, "\n", 1);
 	exit(128);
 }

-- 
1.7.0.rc0.48.gdace5
