From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 14/15] daemon: make --inetd and --detcach incompatible
Date: Fri, 22 Oct 2010 02:05:43 +0200
Message-ID: <1287705944-5668-14-git-send-email-kusmabite@gmail.com>
References: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com, jrnieder@gmail.com, schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 02:07:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P95AL-0004aC-KJ
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 02:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935Ab0JVAHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 20:07:08 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34643 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759302Ab0JVAHB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 20:07:01 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so248736eye.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 17:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=O1jdLuMZpSYRnjP1ogbFtNrUHrzSomzDoWSeXPUSaoE=;
        b=DNfyuD7x9w5YDV0X99z34DpiG9UxtES1X7eYYAVH2WI1/iUtZz8q8L2WuMmEBhdCP4
         jP6HO6+l1Seu7Fz2v4FtLkCK/rzxXpDLJOAllX6tlzC9Rmh65SVHyN2S63Uy5zz2JSP9
         9QZKGQadKQqW6Uvfirr/eYMqa8DIoQiefV4Oo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HR3YmmjiZLlwy2ep8HyRJDjvBtFIVezRRs5iAXJvmdALSj/zttEFNhzIdPazsXdE82
         RcKaDSErQved4vGZqd+kf3wXORFQ8U4oY10o9U1/K4mv0rVO0AWGhbW2qtNktvol19Oj
         SS3IVZjnE7FgkvnlvubaB6OET91VF4xJTCjKA=
Received: by 10.14.47.78 with SMTP id s54mr1478247eeb.21.1287706017788;
        Thu, 21 Oct 2010 17:06:57 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q58sm2456823eeh.9.2010.10.21.17.06.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:06:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159605>

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
index af13f4a..fc55367 100644
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
