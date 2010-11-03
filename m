From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v6 09/16] daemon: use full buffered mode for stderr
Date: Wed,  3 Nov 2010 17:31:27 +0100
Message-ID: <1288801894-1168-10-git-send-email-kusmabite@gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 17:33:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgGT-0002aC-Ta
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab0KCQcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:32:08 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55502 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab0KCQcH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:32:07 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so386169eye.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=F/EYjQZJeMaa3Xwp1trEoXTjN2eEbi/uO9HZi5g9Ig4=;
        b=ChfqCp2fQMc+yLa6Y85yqDKbRbxs7DmDFJDQ8acJmBT1bge+XVkEHYOLmuCoFw4sPM
         lpUYsNhCYi8R5c4uqI9j+pjc3zWttz2+TSSEwK+Ts8aXWip92RO5/1OhYp7bZys4TDkx
         nyaxmZJn0KgfLeswHbJbZQzASoroAptRA9r2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MN7HllIeQq6cATBI2bjYxZwEB7v1CVvjIOGH/2WN+zs0BhuPlSVJx/sgQ2aqbZUPoL
         YIhYjVBuH/3w8ZFm4Y8jzilhQ2HQNuaAk//XLFKFhIPGROKfX24p2s+6KP4ZECKUrAHd
         GPATlTuF9i7l+eTGfKHaRDFOVC4JE3yeSXUkY=
Received: by 10.213.17.145 with SMTP id s17mr717243eba.8.1288801925859;
        Wed, 03 Nov 2010 09:32:05 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id w20sm6706938eeh.18.2010.11.03.09.32.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:32:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.2.g22c0a
In-Reply-To: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160622>

Windows doesn't support line buffered mode for file
streams, so let's just use full buffered mode with
a big buffer ("4096 should be enough for everyone")
and add explicit flushing.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 6eee570..9a4884a 100644
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
1.7.3.2.161.gd6e00
