Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10AA71F404
	for <e@80x24.org>; Sat, 27 Jan 2018 18:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeA0ScG (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 13:32:06 -0500
Received: from lucaswerkmeister.de ([94.130.58.99]:34536 "EHLO
        lucaswerkmeister.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeA0ScE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 13:32:04 -0500
Received: from localhost (unknown [IPv6:2a02:8109:9a3f:f575:be5f:f4ff:fecb:74cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mail@lucaswerkmeister.de)
        by lucaswerkmeister.de (Postfix) with ESMTPSA id 44C2819BA18;
        Sat, 27 Jan 2018 19:32:00 +0100 (CET)
Authentication-Results: lucaswerkmeister.de; dmarc=fail (p=none dis=none) header.from=lucaswerkmeister.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucaswerkmeister.de;
        s=mail; t=1517077920;
        bh=aCgR0XppyXLJh6g1aexJGU28jfi0qVRgciX9eeqIA5U=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding:From:Reply-To:
         Subject:Date:To:Cc:In-Reply-To:References:Message-Id:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version;
        b=s2qysStREf4toLpBJRYmCFjbhDj1pN84vfune5cpm7oMYYflleeFmRzYmFXAhulM4
         CJ0iLIN4fmkAQ5Q38en37Va2BPFSwv0ZnezuPZKZJib3/MC3suBqhZin8a/r6tGd/J
         gWYqvywi3Ar5deQMknb3L7xsPVuz0jfBfDzzqiJE=
From:   Lucas Werkmeister <mail@lucaswerkmeister.de>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Lucas Werkmeister <mail@lucaswerkmeister.de>
Subject: [PATCH v2] daemon: add --send-log-to=(stderr|syslog|none)
Date:   Sat, 27 Jan 2018 19:31:32 +0100
Message-Id: <20180127183132.19724-1-mail@lucaswerkmeister.de>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <xmqqtvvbds42.fsf@gitster.mtv.corp.google.com>
References: <xmqqtvvbds42.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it possible to use --inetd while still logging to standard
error. --syslog is retained as an alias for --send-log-to=syslog. A mode
to disable logging explicitly is also provided.

The combination of --inetd with --send-log-to=stderr is useful, for
instance, when running `git daemon` as an instanced systemd service
(with associated socket unit). In this case, log messages sent via
syslog are received by the journal daemon, but run the risk of being
processed at a time when the `git daemon` process has already exited
(especially if the process was very short-lived, e.g. due to client
error), so that the journal daemon can no longer read its cgroup and
attach the message to the correct systemd unit (see systemd/systemd#2913
[1]). Logging to stderr instead can solve this problem, because systemd
can connect stderr directly to the journal daemon, which then already
knows which unit is associated with this stream.

[1]: https://github.com/systemd/systemd/issues/2913

Signed-off-by: Lucas Werkmeister <mail@lucaswerkmeister.de>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
---

Notes:
    This was originally “daemon: add --no-syslog to undo implicit
    --syslog”, but Junio pointed out that combining --no-syslog with
    --detach isn’t especially useful and suggested --send-log-to=
    instead. Is Helped-by: the right credit for this or should it be
    something else?
    
    I’m also not quite sure if the systemd part of the commit message is
    accurate – see my comment on the linked issue [2]. TL;DR: this might
    no longer be necessary on systemd v235. (I’m experiencing the
    problem on Debian Stretch, systemd v232.) As in the last patch, feel
    free to remove that part of the commit message.
    
    [2]: https://github.com/systemd/systemd/issues/2913#issuecomment-361002589

 Documentation/git-daemon.txt | 23 +++++++++++++++++++++--
 daemon.c                     | 43 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 3c91db7be..e973f4390 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -20,6 +20,7 @@ SYNOPSIS
 	     [--inetd |
 	      [--listen=<host_or_ipaddr>] [--port=<n>]
 	      [--user=<user> [--group=<group>]]]
+	     [--send-log-to=(stderr|syslog|none)]
 	     [<directory>...]
 
 DESCRIPTION
@@ -110,8 +111,26 @@ OPTIONS
 	zero for no limit.
 
 --syslog::
-	Log to syslog instead of stderr. Note that this option does not imply
-	--verbose, thus by default only error conditions will be logged.
+	Short for `--send-log-to=syslog`.
+
+--send-log-to=<destination>::
+	Send log messages to the specified destination.
+	Note that this option does not imply --verbose,
+	thus by default only error conditions will be logged.
+	The <destination> defaults to `stderr`, and must be one of:
++
+--
+stderr::
+	Write to standard error.
+	Note that if `--detach` is specified,
+	the process disconnects from the real standard error,
+	making this destination effectively equivalent to `none`.
+syslog::
+	Write to syslog, using the `git-daemon` identifier.
+none::
+	Disable all logging.
+--
++
 
 --user-path::
 --user-path=<path>::
diff --git a/daemon.c b/daemon.c
index e37e343d0..3d8e16ede 100644
--- a/daemon.c
+++ b/daemon.c
@@ -9,7 +9,11 @@
 #define initgroups(x, y) (0) /* nothing */
 #endif
 
-static int log_syslog;
+static enum log_destination {
+	LOG_TO_NONE = -1,
+	LOG_TO_STDERR = 0,
+	LOG_TO_SYSLOG = 1,
+} log_destination;
 static int verbose;
 static int reuseaddr;
 static int informative_errors;
@@ -25,6 +29,7 @@ static const char daemon_usage[] =
 "           [--access-hook=<path>]\n"
 "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
 "                      [--detach] [--user=<user> [--group=<group>]]\n"
+"           [--send-log-to=(stderr|syslog|none)]\n"
 "           [<directory>...]";
 
 /* List of acceptable pathname prefixes */
@@ -74,11 +79,14 @@ static const char *get_ip_address(struct hostinfo *hi)
 
 static void logreport(int priority, const char *err, va_list params)
 {
-	if (log_syslog) {
+	switch (log_destination) {
+	case LOG_TO_SYSLOG: {
 		char buf[1024];
 		vsnprintf(buf, sizeof(buf), err, params);
 		syslog(priority, "%s", buf);
-	} else {
+		break;
+	}
+	case LOG_TO_STDERR: {
 		/*
 		 * Since stderr is set to buffered mode, the
 		 * logging of different processes will not overlap
@@ -88,6 +96,11 @@ static void logreport(int priority, const char *err, va_list params)
 		vfprintf(stderr, err, params);
 		fputc('\n', stderr);
 		fflush(stderr);
+		break;
+	}
+	case LOG_TO_NONE: {
+		break;
+	}
 	}
 }
 
@@ -1289,7 +1302,7 @@ int cmd_main(int argc, const char **argv)
 		}
 		if (!strcmp(arg, "--inetd")) {
 			inetd_mode = 1;
-			log_syslog = 1;
+			log_destination = LOG_TO_SYSLOG;
 			continue;
 		}
 		if (!strcmp(arg, "--verbose")) {
@@ -1297,9 +1310,25 @@ int cmd_main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "--syslog")) {
-			log_syslog = 1;
+			log_destination = LOG_TO_SYSLOG;
 			continue;
 		}
+		if (skip_prefix(arg, "--send-log-to=", &v)) {
+			if (!strcmp(v, "syslog")) {
+				log_destination = LOG_TO_SYSLOG;
+				continue;
+			}
+			else if (!strcmp(v, "stderr")) {
+				log_destination = LOG_TO_STDERR;
+				continue;
+			}
+			else if (!strcmp(v, "none")) {
+				log_destination = LOG_TO_NONE;
+				continue;
+			}
+			else
+				die("Unknown log destination %s", v);
+		}
 		if (!strcmp(arg, "--export-all")) {
 			export_all_trees = 1;
 			continue;
@@ -1356,7 +1385,7 @@ int cmd_main(int argc, const char **argv)
 		}
 		if (!strcmp(arg, "--detach")) {
 			detach = 1;
-			log_syslog = 1;
+			log_destination = LOG_TO_SYSLOG;
 			continue;
 		}
 		if (skip_prefix(arg, "--user=", &v)) {
@@ -1402,7 +1431,7 @@ int cmd_main(int argc, const char **argv)
 		usage(daemon_usage);
 	}
 
-	if (log_syslog) {
+	if (log_destination == LOG_TO_SYSLOG) {
 		openlog("git-daemon", LOG_PID, LOG_DAEMON);
 		set_die_routine(daemon_die);
 	} else
-- 
2.16.0

