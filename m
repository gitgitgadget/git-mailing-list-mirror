From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 07/11] run-command: support input-fd
Date: Thu, 26 Nov 2009 00:39:14 +0000
Message-ID: <1259195958-2372-8-git-send-email-kusmabite@gmail.com>
References: <1259195958-2372-1-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-2-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-3-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-4-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-5-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-6-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-7-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlecode.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:40:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSOw-0007ui-Qn
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbZKZAjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbZKZAjs
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:39:48 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:25856 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964979AbZKZAjr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:39:47 -0500
Received: by ey-out-2122.google.com with SMTP id 4so87639eyf.19
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wp7L9DCsMAhcvvFwRMWfj60ApFDzG2jbYAMmtdkC+xk=;
        b=KvKrJvSpgkGhmMDOk9vTaAM7jscYgEQqMkVNzG4PfBx5ojwGfQD6e/l9TXLoL52q3t
         qinPKCnm8DPcfAJ8OOSPxMrttjUXYqf3YpzVPR1obx5jSPAs48F4h9fmKpvucRtZ+W9H
         DlSynqOWMM1QIxycqwXb7Y9HJvkHBM5+5xLKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pmjcYGfrNPdfzQ3n3QgVFSciPMGDV+Xn9CQ3oyD48p4nWDOV4HfezoJOQghu0+NNNx
         spupXE4oBQ29aQIHb6t1agk9w9Y7RHR6uCcZDhRL29b1hJEMDX0r9kZ0tBmW8sAz1syr
         UMHn/zZc0XLbfxkq4pO9lSjL6HpKbfxxZ58HU=
Received: by 10.216.87.66 with SMTP id x44mr2749759wee.96.1259195993210;
        Wed, 25 Nov 2009 16:39:53 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 5sm3847590eyf.4.2009.11.25.16.39.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:39:52 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259195958-2372-7-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133726>

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
