From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v7 09/16] daemon: use full buffered mode for stderr
Date: Thu,  4 Nov 2010 02:35:17 +0100
Message-ID: <1288834524-2400-10-git-send-email-kusmabite@gmail.com>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 02:36:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDoks-0001ds-GG
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499Ab0KDBfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 21:35:50 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57379 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab0KDBfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 21:35:46 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so738633ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 18:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=k1TnAPF20rfUeq5f6r74SmOFOzfd3cVnXNwNUZGcg9A=;
        b=Y5U5hHVQC3CplU238kiJcVsp/0G539A41+h6qOeCuDNtXeNk33NfjS1cVxnh9LmYR9
         SmAZ5nKHY+ql1YNjmYd/t2Ja6cdUl6xZLCSb2EIA5u/hlGcX/SirkSUnWSuDAakujY2I
         NdwXTrRkfrm+PlQxM7D2KqiUSrGLJZ5GnHIWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fThassAyyhEAHwSZEzs09kFgzO5N4npNjSfNlaFe1kNaUGWCrAAzyOEGTR8nG0hsKm
         tX98MIw7JvmQHVeVNrxt9W8D5c+MKjWxhVpU/IiB3QtoLsfJSA/K+7tWtYYh5hFpr5Kt
         4GE9PldrzEghm/GVt2xxFME7WA985gKtOI7l0=
Received: by 10.213.22.142 with SMTP id n14mr74010ebb.78.1288834545906;
        Wed, 03 Nov 2010 18:35:45 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id b52sm7189591eei.19.2010.11.03.18.35.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 18:35:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160670>

Windows doesn't support line buffered mode for file
streams, so let's just use full buffered mode with
a big buffer ("4096 should be enough for everyone")
and add explicit flushing.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 4059593..941c095 100644
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
 
@@ -1117,7 +1119,7 @@ int main(int argc, char **argv)
 		set_die_routine(daemon_die);
 	} else
 		/* avoid splitting a message in the middle */
-		setvbuf(stderr, NULL, _IOLBF, 0);
+		setvbuf(stderr, NULL, _IOFBF, 4096);
 
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
-- 
1.7.3.2.162.g09d37
