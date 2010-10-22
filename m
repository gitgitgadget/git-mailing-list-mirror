From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v5 15/16] daemon: make --inetd and --detcach incompatible
Date: Fri, 22 Oct 2010 02:35:26 +0200
Message-ID: <1287707727-5780-16-git-send-email-kusmabite@gmail.com>
References: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com, jrnieder@gmail.com, schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 02:37:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P95d8-0002bm-VL
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 02:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228Ab0JVAgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 20:36:55 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36588 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757196Ab0JVAgy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 20:36:54 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so270970eye.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 17:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vI1oD3XbE6UPoKQEdG5EiZBA34UlDljdgifngWEOV0Y=;
        b=C2WzE2T82Em7DpXAZX+bvbJY8fryR4kM8X2BFeUmWw78G9yK9/FLPlf16opHjlLFjB
         OIskIQKNxQ4B6BDNsUnZRNQB8Z6xV4KTeUQ40r83tAK0YqOYaA179oTgU4xX2ejfM0GK
         p5F8FuDSBK9/20HSMVai4D+0I5SohHm9U8c/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OobWWfNk8nRSDqMTJZ1Cj7taBd2FIiSPKD9XyhTKlveND4ULAMQnmJVaJOgE6VNiXP
         qc7NxdLJE8CpM+EeRTG+S/vumNHz5UY1QWP/YP+gFt5nWdMhvWlF6vw7MFpot2zrTjCv
         9kKXMhawB8qUcxRYwbwiUzLrYr/dtFKxHSROU=
Received: by 10.213.31.145 with SMTP id y17mr1093732ebc.1.1287707812599;
        Thu, 21 Oct 2010 17:36:52 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q58sm2479748eeh.9.2010.10.21.17.36.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:36:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159625>

Since --inetd makes main return with the result of execute() before
daemonize is gets called, these two options are already incompatible.

Document it, and add an error if attempted.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Documentation/git-daemon.txt |    3 ++-
 daemon.c                     |    8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 685aa58..053ded5 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -78,7 +78,8 @@ OPTIONS
 
 --inetd::
 	Have the server run as an inetd service. Implies --syslog.
-	Incompatible with --port, --listen, --user and --group options.
+	Incompatible with --detach, --port, --listen, --user and --group
+	options.
 
 --listen=host_or_ipaddr::
 	Listen on a specific IP address or hostname.  IP addresses can
diff --git a/daemon.c b/daemon.c
index 272514b..8886455 100644
--- a/daemon.c
+++ b/daemon.c
@@ -23,10 +23,10 @@ static const char daemon_usage[] =
 "           [--strict-paths] [--base-path=path] [--base-path-relaxed]\n"
 "           [--user-path | --user-path=path]\n"
 "           [--interpolated-path=path]\n"
-"           [--reuseaddr] [--detach] [--pid-file=file]\n"
+"           [--reuseaddr] [--pid-file=file]\n"
 "           [--[enable|disable|allow-override|forbid-override]=service]\n"
 "           [--inetd | [--listen=host_or_ipaddr] [--port=n]\n"
-"                      [--user=user [--group=group]]\n"
+"                      [--detach] [--user=user [--group=group]]\n"
 "           [directory...]";
 
 /* List of acceptable pathname prefixes */
@@ -1122,8 +1122,8 @@ int main(int argc, char **argv)
 		/* avoid splitting a message in the middle */
 		setvbuf(stderr, NULL, _IOFBF, 4096);
 
-	if (inetd_mode && (group_name || user_name))
-		die("--user and --group are incompatible with --inetd");
+	if (inetd_mode && (detach || group_name || user_name))
+		die("--detach, --user and --group are incompatible with --inetd");
 
 	if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
 		die("--listen= and --port= are incompatible with --inetd");
-- 
1.7.3.1.199.g72340
