From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v4 06/15] mingw: support waitpid with pid > 0 and WNOHANG
Date: Mon, 11 Oct 2010 23:50:20 +0200
Message-ID: <1286833829-5116-7-git-send-email-kusmabite@gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 23:52:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5QHr-0006IO-5t
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 23:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576Ab0JKVv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 17:51:57 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36668 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756491Ab0JKVv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 17:51:56 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so833577ewy.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=n0F5yY7ZOa+qSo1LHUc7Vx5fMxO1s8ZkewTiA3Dx2rg=;
        b=miAm75j6qI4AW4l/f3PL9OiWiMhK2JQT/YPUUntqP0UP2ruCpe+JK6WDvSIw0nuWjd
         5aoqn3nJNXRjC4wZxUL+ALLtYnYSOK4HmbXghLkAEfA3PVpie1FhV8j1bRUNxdEvs4LL
         mKKMDRjyXPGgMLLLtfDi5/NyNLnkZPe+OxPXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ozjjUtUg2EvP0xG6hRr6OZXktGtnDvptO8KrK+xwhifPennKPROkflhLoX+lDFdorc
         HOhCiicjyhjziE5m3C3Rmomk8TInfMX1EmT2ufqoxZNEcBr8lJNPnLpD9cAG4y69jl0H
         bzKL+SYjCt1TwlCBGXyITvIlthykiViKZD9WQ=
Received: by 10.213.114.19 with SMTP id c19mr3527170ebq.97.1286833915923;
        Mon, 11 Oct 2010 14:51:55 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q54sm7812113eeh.12.2010.10.11.14.51.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 14:51:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158798>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |    6 ++++++
 compat/mingw.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index e2e3c54..2e7c644 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1550,6 +1550,12 @@ pid_t waitpid(pid_t pid, int *status, unsigned options)
 		return -1;
 	}
 
+	if (pid > 0 && options & WNOHANG) {
+		if (WAIT_OBJECT_0 != WaitForSingleObject((HANDLE)pid, 0))
+			return 0;
+		options &= ~WNOHANG;
+	}
+
 	if (options == 0) {
 		int i;
 		if (WaitForSingleObject(h, INFINITE) != WAIT_OBJECT_0) {
diff --git a/compat/mingw.h b/compat/mingw.h
index 7c4eeea..379d7bf 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -140,6 +140,7 @@ static inline int mingw_unlink(const char *pathname)
 }
 #define unlink mingw_unlink
 
+#define WNOHANG 1
 pid_t waitpid(pid_t pid, int *status, unsigned options);
 
 #ifndef NO_OPENSSL
-- 
1.7.3.1.199.g72340
