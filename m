From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v7 15/16] daemon: make --inetd and --detach incompatible
Date: Thu,  4 Nov 2010 02:35:23 +0100
Message-ID: <1288834524-2400-16-git-send-email-kusmabite@gmail.com>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 02:36:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDokv-0001ds-Td
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579Ab0KDBgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 21:36:05 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56990 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab0KDBf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 21:35:59 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so722316eye.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 18:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HBC5s8PMBjooJcYUJT22e98d9OmAn41QCqpAC6nJpcU=;
        b=mzxhK7eVkmeK9ne5i94fTjJHHX5enkZ7ct5ZEDx5SB1/ytOknSTWlMQ9FtN7Q/jDNi
         I2eRiOVdQlJezYHG1uvY7Q9DCH1F0UkujPgaXfGRkZEP2ChFldI9H+Q22RLroh3gT2rC
         /lmDqWDePtFecSiaihf4jIRAr5lRFnL4qNVDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hkbq/wgj/W6RZB/vEgUF7EIt9ZYPriNOZis7hFjIi6fMCGFkcIHTsjc4KORW+NS8kI
         vYd+VQhZuD0TXeHijIdU3EfkgWmDo90I4m4XDlajw+YGdUy8buSB1ZNiAVR/86VL9Dh2
         EgLpyFDMPnWeyZpzkTBfV2TJGBQIWEGVuVa5A=
Received: by 10.213.98.78 with SMTP id p14mr145204ebn.54.1288834558349;
        Wed, 03 Nov 2010 18:35:58 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id x54sm7206899eeh.23.2010.11.03.18.35.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 18:35:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160677>

Since --inetd makes main return with the result of execute() before
daemonize is gets called, these two options are already incompatible.

Document it, and add an error if attempted.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Documentation/git-daemon.txt |    3 ++-
 daemon.c                     |    8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 5054f79..d15cb6a 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -78,7 +78,8 @@ OPTIONS
 
 --inetd::
 	Have the server run as an inetd service. Implies --syslog.
-	Incompatible with --port, --listen, --user and --group options.
+	Incompatible with --detach, --port, --listen, --user and --group
+	options.
 
 --listen=<host_or_ipaddr>::
 	Listen on a specific IP address or hostname.  IP addresses can
diff --git a/daemon.c b/daemon.c
index a4d3e91..17028b6 100644
--- a/daemon.c
+++ b/daemon.c
@@ -23,10 +23,10 @@ static const char daemon_usage[] =
 "           [--strict-paths] [--base-path=<path>] [--base-path-relaxed]\n"
 "           [--user-path | --user-path=<path>]\n"
 "           [--interpolated-path=<path>]\n"
-"           [--reuseaddr] [--detach] [--pid-file=<file>]\n"
+"           [--reuseaddr] [--pid-file=<file>]\n"
 "           [--(enable|disable|allow-override|forbid-override)=<service>]\n"
 "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
-"                      [--user=<user> [--group=<group>]]\n"
+"                      [--detach] [--user=<user> [--group=<group>]]\n"
 "           [<directory>...]";
 
 /* List of acceptable pathname prefixes */
@@ -1128,8 +1128,8 @@ int main(int argc, char **argv)
 		/* avoid splitting a message in the middle */
 		setvbuf(stderr, NULL, _IOFBF, 4096);
 
-	if (inetd_mode && (group_name || user_name))
-		die("--user and --group are incompatible with --inetd");
+	if (inetd_mode && (detach || group_name || user_name))
+		die("--detach, --user and --group are incompatible with --inetd");
 
 	if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
 		die("--listen= and --port= are incompatible with --inetd");
-- 
1.7.3.2.162.g09d37
