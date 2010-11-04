From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v7 14/16] daemon: use socklen_t
Date: Thu,  4 Nov 2010 02:35:22 +0100
Message-ID: <1288834524-2400-15-git-send-email-kusmabite@gmail.com>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 02:36:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDokv-0001ds-DH
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab0KDBf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 21:35:59 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40076 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455Ab0KDBf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 21:35:57 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so722320eye.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 18:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AuYjBbZHsGF975LfIt9KekSdDFWSzhmqBxkU/KQpp9M=;
        b=YlHHOM0tJvg9MRQKpyv4G1QbpiNP2j33ToxLbNKN49yBf88uWWNwDuiJQTEZeiWDfu
         47sH749/MO0X8FgRd2ZKAF33oJHayLm0kKt4fwKrcaUGIUj/SA7VBmV1gIeu2942AOVm
         DmPF8Lohev2n47GKEnXkxpoZZecdhEMR+wciM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MsvIR3bP1cr7q8WkhTYtfPAWB70G5pU1zBr/vxdPRbRyZfb3XwJ3k6+8yb2Wm5nLpG
         3TuzI1fVHeyg8Lc1sfRhQxwbMv2MvcS5aDXJeZHE/klhaPq5WOrSKbm3iUPrGj+IV0Es
         PtpAtGfzHsbEXiVeHnPPhVpwvN8zsXMi3QFNk=
Received: by 10.213.27.197 with SMTP id j5mr147804ebc.47.1288834556269;
        Wed, 03 Nov 2010 18:35:56 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id w20sm7191453eeh.18.2010.11.03.18.35.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 18:35:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160675>

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
index 8162f10..a4d3e91 100644
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
@@ -910,7 +910,7 @@ static int service_loop(struct socketlist *socklist)
 					struct sockaddr_in6 sai6;
 #endif
 				} ss;
-				unsigned int sslen = sizeof(ss);
+				socklen_t sslen = sizeof(ss);
 				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
-- 
1.7.3.2.162.g09d37
