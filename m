From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 07/11] run-command: support input-fd
Date: Thu, 26 Nov 2009 00:44:16 +0000
Message-ID: <1259196260-3064-8-git-send-email-kusmabite@gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-4-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-5-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-6-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-7-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSTk-0001E4-Sc
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbZKZAoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbZKZAoo
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:44:44 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:46652 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965073AbZKZAon (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:44:43 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so298499ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wp7L9DCsMAhcvvFwRMWfj60ApFDzG2jbYAMmtdkC+xk=;
        b=WBE3UWe9z81FP0BqONMB8x4l7G+dO950cNi2vpGcB/RyrFSMGGvggOLnopU/P3+A3p
         wu/kvNFuIGK0eMFtGg+jgKf8VELlYulOKJek5WPoMCWZewuWAoeAZ/dTssJqYKBOoJ/W
         9+Z6gHoezlPMq6AbGrPGLW/vTlGNk1iepD26U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BRlbBMHFartumcV4kpRyAw6tKDDDjpb4vDqxx+7YgHkn3IPQbK6b4xTn+l0nAxj3LY
         pZhjWNVNc4wG8aiC4yVT1zuUNYce79LrLVsFdINWNfSm5YUJIWyftTYrkXJX/asSvnAX
         0M+mUZ/acs21QH8a8rmu6wAB9EAJ7E7cDB2GQ=
Received: by 10.213.23.201 with SMTP id s9mr2118501ebb.15.1259196289674;
        Wed, 25 Nov 2009 16:44:49 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 28sm383632eyg.44.2009.11.25.16.44.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:44:48 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259196260-3064-7-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133738>

This patch adds the possibility to supply a non-0
file descriptor for communucation, instead of the
default-created pipe. The pipe gets duplicated, so
the caller can free it's handles.

This is usefull for async communication over sockets.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 run-command.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index e5a0e06..98771ef 100644
--- a/run-command.c
+++ b/run-command.c
@@ -327,7 +327,10 @@ int start_async(struct async *async)
 {
 	int pipe_out[2];
 
-	if (pipe(pipe_out) < 0)
+	if (async->out) {
+		pipe_out[0] = dup(async->out);
+		pipe_out[1] = dup(async->out);
+	} else if (pipe(pipe_out) < 0)
 		return error("cannot create pipe: %s", strerror(errno));
 	async->out = pipe_out[0];
 
-- 
1.6.5.rc2.7.g4f8d3
