From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v6 15/16] daemon: make --inetd and --detach incompatible
Date: Wed,  3 Nov 2010 17:31:33 +0100
Message-ID: <1288801894-1168-16-git-send-email-kusmabite@gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 17:33:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgGX-0002aC-N0
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088Ab0KCQc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:32:27 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37501 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755766Ab0KCQcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:32:25 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so391724ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=c38H0jqTfvQ6HA1yVwfAcZU+4lgosMy6qse3ZDHsG4k=;
        b=YuUP2X6QNazEL5+vhv1fXIAke8T6fWjR9W9ukPmAirkkquBAbgHlhLPxNSTTUjNb+n
         rOKPdbuKfgoOVOXZwKv9f+qLRpEpa8g0uZPamWuo9tfIL72G1NdBCOqhYnxVDWS719qA
         XruszoqwF4V/LgtYl3/nDilukJcsC9Sh8kD+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VXPuDAuDCc3y88G6fBH1vw8bt99BerNVOSY+RG5Dkw1CbUgamEHthoauDKFJilG38h
         jvxBiR/y6MJYbi8RvMsWFUHMmJSF8CTjpatHi6C31fkyRU8GC/yBscvtifBomOqO1Knm
         b2NiKweB0KolAnFbQUh6+kYoQXb0sy0evi2tw=
Received: by 10.213.22.66 with SMTP id m2mr699119ebb.56.1288801942096;
        Wed, 03 Nov 2010 09:32:22 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id v56sm6712612eeh.20.2010.11.03.09.32.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:32:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.2.g22c0a
In-Reply-To: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160625>

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
index 5b30a2e..485bec5 100644
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
1.7.3.2.161.gd6e00
