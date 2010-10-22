From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v5 14/16] daemon: use socklen_t
Date: Fri, 22 Oct 2010 02:35:25 +0200
Message-ID: <1287707727-5780-15-git-send-email-kusmabite@gmail.com>
References: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com, jrnieder@gmail.com, schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 02:37:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P95d8-0002bm-En
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 02:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab0JVAgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 20:36:52 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59343 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756566Ab0JVAgu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 20:36:50 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so377562ewy.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 17:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4XocFaG79R5VeyPZYhuraiU7zmg3ir6kL5c4+m662DE=;
        b=QIwfD3so2nZi26ZwyjpDFZ+pHofrurB+aQDmkN7fVDJC56REtmJizmfplU+uC15IWW
         mHnnUn6uN+knOzCgSGD9IeKBkHEaf05k7Ox7E9GjieLi6UYNbGV0NVq0PjqwN0Mu4y+e
         kzpCypdc588HIztukqMiBxO2WFIIFNxC/60GI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vp0NoU7NnIbcXo74059HMlMRmCpHc+B9wpw78nZYPp32s4XQX2CZdb1sw3zVc2GdW8
         uWihZV8HlmJlX07EBj1zTw0KJOTcj8XVm4jEAKY9t0neCN5IV55JBHdnBdzvkT7ZP7Wc
         qqaWYnK3IEELwusPneSJwpD5/Un8/dPfz55bw=
Received: by 10.213.19.19 with SMTP id y19mr2545296eba.33.1287707810041;
        Thu, 21 Oct 2010 17:36:50 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id w20sm2489583eeh.0.2010.10.21.17.36.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:36:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159624>

Windows's accept()-function takes the last argument as an int, but glibc
takes an unsigned int. Use socklen_t to get rid of a warning. This is
basically a revert of 7fa0908, but we have already been depending on
socklen_t existing since June 2006 (commit 5b276ee4). I guess this means
that socklen_t IS defined on OSX after all - at least in recent headers.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/daemon.c b/daemon.c
index b3aae8a..272514b 100644
--- a/daemon.c
+++ b/daemon.c
@@ -597,7 +597,7 @@ static struct child {
 	struct sockaddr_storage address;
 } *firstborn;
 
-static void add_child(struct child_process *cld, struct sockaddr *addr, int addrlen)
+static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child *newborn, **cradle;
 
@@ -654,7 +654,7 @@ static void check_dead_children(void)
 }
 
 static char **cld_argv;
-static void handle(int incoming, struct sockaddr *addr, int addrlen)
+static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child_process cld = { 0 };
 	char addrbuf[300] = "REMOTE_ADDR=", portbuf[300];
@@ -904,7 +904,7 @@ static int service_loop(struct socketlist *socklist)
 		for (i = 0; i < socklist->nr; i++) {
 			if (pfd[i].revents & POLLIN) {
 				struct sockaddr_storage ss;
-				unsigned int sslen = sizeof(ss);
+				socklen_t sslen = sizeof(ss);
 				int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
-- 
1.7.3.1.199.g72340
