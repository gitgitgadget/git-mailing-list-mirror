From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 09/14] daemon: use full buffered mode for stderr
Date: Sun, 10 Oct 2010 15:20:49 +0200
Message-ID: <1286716854-5744-10-git-send-email-kusmabite@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 15:22:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4vrZ-00057R-FO
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 15:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757722Ab0JJNWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 09:22:43 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54307 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757715Ab0JJNWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 09:22:42 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so255794ewy.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 06:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PYcPIKdjCYpJKXTNrjZwL9+dCA4bGG3PPF/7E2seRB0=;
        b=DgVmXtbkJ9ruMqEeh44rD7vQ9lSix4yNQjZtglU46TaKejM3iumV723zBL2WBlP5Hp
         J3AK2D+hj8dSFI9ELWD+7XkqDipm4nb+PEo7B1uAPjhHonaSVJn37ew8SxTeu792RZaB
         spQMYvZA85RjxX/c1dsphZf8qi1NNXByBrj/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ACA4IGQF+n6pqcSEOWJPJcV52TB8iqDDKcgSdQN1M/s9xunutK9H8apLjvWVO+7ltm
         nYV7CXniqgRQWgvtuFos2GKj9UWpSeXJ7MwiSrT84Gni/xYZtZh9/rS0QXHdz67Wq0tP
         kkgUBKb04a+He2z8805vpqjYLppymAivUpHXs=
Received: by 10.14.37.139 with SMTP id y11mr1828757eea.14.1286716961684;
        Sun, 10 Oct 2010 06:22:41 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id z55sm9037410eeh.21.2010.10.10.06.22.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 06:22:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158668>

Windows doesn't support line buffered mode for file
streams, so let's just use full buffered mode with
a big buffer ("4096 should be enough for everyone")
and add explicit flushing.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index ee29c9f..82ba5c7 100644
--- a/daemon.c
+++ b/daemon.c
@@ -67,12 +67,14 @@ static void logreport(int priority, const char *err, va_list params)
 		syslog(priority, "%s", buf);
 	} else {
 		/*
-		 * Since stderr is set to linebuffered mode, the
+		 * Since stderr is set to buffered mode, the
 		 * logging of different processes will not overlap
+		 * unless they overflow the (rather big) buffers.
 		 */
 		fprintf(stderr, "[%"PRIuMAX"] ", (uintmax_t)getpid());
 		vfprintf(stderr, err, params);
 		fputc('\n', stderr);
+		fflush(stderr);
 	}
 }
 
@@ -1118,7 +1120,7 @@ int main(int argc, char **argv)
 		set_die_routine(daemon_die);
 	} else
 		/* avoid splitting a message in the middle */
-		setvbuf(stderr, NULL, _IOLBF, 0);
+		setvbuf(stderr, NULL, _IOFBF, 4096);
 
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
-- 
1.7.3.1.51.ge462f.dirty
