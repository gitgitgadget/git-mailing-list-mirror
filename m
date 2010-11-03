From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v6 14/16] daemon: use socklen_t
Date: Wed,  3 Nov 2010 17:31:32 +0100
Message-ID: <1288801894-1168-15-git-send-email-kusmabite@gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 17:32:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgGX-0002aC-6d
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930Ab0KCQcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:32:25 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54289 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab0KCQcU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:32:20 -0400
Received: by vws13 with SMTP id 13so1199821vws.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YOiM8IjjDtZ2ppIQJo9OPCNkruaNU0P2F7cv7DpK6qg=;
        b=pCaCfrr83AYDEmFxnVuGwnRgTg0izib8bmYgTsZJdtC2YFyr1pwDazuFQ5y41ph7Md
         yomE9NHy+TAzZa1N4B4dnaYzxQTEDg8ExAPEOFhAkbNSdjxlRMlodIESGqrhcYBv8I+W
         t27J1ILWD6Rbfb29AjRIBLw0ZNpQA98rH1+2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NoAdYMu/F+CW10AXuh0ulQEb98HiK03e0N1+l5b7h+MewKT/deNGBh9EaJ68aw09EN
         oA/t9ebvn8CzhTcl6KwkpC6jUZOyJupLruQ2qTwijiZgMVsH7GBof0F/iJDdRY8s6pL/
         lXn1DWzs1SQ9rkhfo7szZFxJ74Sve5V5FK3FE=
Received: by 10.14.11.147 with SMTP id 19mr863606eex.14.1288801938891;
        Wed, 03 Nov 2010 09:32:18 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id x54sm6708728eeh.5.2010.11.03.09.32.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:32:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.2.g22c0a
In-Reply-To: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160616>

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
index 3d8f6e6..5b30a2e 100644
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
1.7.3.2.161.gd6e00
