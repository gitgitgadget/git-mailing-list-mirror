Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879F41F404
	for <e@80x24.org>; Sat,  3 Feb 2018 23:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeBCXIf (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Feb 2018 18:08:35 -0500
Received: from lucaswerkmeister.de ([94.130.58.99]:42854 "EHLO
        lucaswerkmeister.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752701AbeBCXId (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Feb 2018 18:08:33 -0500
Received: from localhost (unknown [IPv6:2a02:8109:9a3f:f575:be5f:f4ff:fecb:74cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mail@lucaswerkmeister.de)
        by lucaswerkmeister.de (Postfix) with ESMTPSA id 2838A1A8626;
        Sun,  4 Feb 2018 00:08:26 +0100 (CET)
Authentication-Results: lucaswerkmeister.de; dmarc=fail (p=none dis=none) header.from=lucaswerkmeister.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucaswerkmeister.de;
        s=mail; t=1517699307;
        bh=NeoiBoWAEbOyfCrDZ+kGjp9UIgh0CxOkm2VIlIXPFE4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding:From:Reply-To:
         Subject:Date:To:Cc:In-Reply-To:References:Message-Id:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version;
        b=to5BMEy1Xcmyg4YbpykxT5smHEazNccSPG/0PSsKfyTJKga5Fl7koVQgGuM273HHR
         fBYgMZWFV6Yo6b+FDFZibBQGe+nSXSAWcBz1eRDzOBnu8EQ4+6QemZS2TpGq8IfbKp
         Gk+xMgwtqP4bLR2VTCsHZw6fiGEL8BNZQPCQ3A2U=
From:   Lucas Werkmeister <mail@lucaswerkmeister.de>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Lucas Werkmeister <mail@lucaswerkmeister.de>
Subject: [PATCH v3] daemon: add --log-destination=(stderr|syslog|none)
Date:   Sun,  4 Feb 2018 00:08:01 +0100
Message-Id: <20180203230801.30345-1-mail@lucaswerkmeister.de>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <CAPig+cR1VXtc-wZxv3mZGsbTAzmtPbhnRPtBX97-8Rm9b6rpHQ@mail.gmail.com>
References: <CAPig+cR1VXtc-wZxv3mZGsbTAzmtPbhnRPtBX97-8Rm9b6rpHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new option can be used to override the implicit --syslog of
--inetd, or to disable all logging. (While --detach also implies
--syslog, --log-destination=stderr with --detach is useless since
--detach disassociates the process from the original stderr.) --syslog
is retained as an alias for --log-destination=syslog.

--log-destination always overrides implicit --syslog regardless of
option order. This is different than the “last one wins” logic that
applies to some implicit options elsewhere in Git, but should hopefully
be less confusing. (I also don’t know if *all* implicit options in Git
follow “last one wins”.)

The combination of --inetd with --log-destination=stderr is useful, for
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

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Lucas Werkmeister <mail@lucaswerkmeister.de>
---

Notes:
    Next version on my quest to make git-daemon logging more reliable :)
    many thanks to Eric Sunshine for review. Main changes this version:
    
    - Rename --send-log-to to --log-destination, following the
      postgresql option. A cursory search didn’t turn up any other
      daemons with a similar option – suggestions welcome!
    - Make explicit --log-destination always override implicit --syslog,
      regardless of option order.

 Documentation/git-daemon.txt | 26 ++++++++++++++++++++++---
 daemon.c                     | 45 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 3c91db7be..a0106e6aa 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -20,6 +20,7 @@ SYNOPSIS
 	     [--inetd |
 	      [--listen=<host_or_ipaddr>] [--port=<n>]
 	      [--user=<user> [--group=<group>]]]
+	     [--log-destination=(stderr|syslog|none)]
 	     [<directory>...]
 
 DESCRIPTION
@@ -80,7 +81,8 @@ OPTIONS
 	do not have the 'git-daemon-export-ok' file.
 
 --inetd::
-	Have the server run as an inetd service. Implies --syslog.
+	Have the server run as an inetd service. Implies --syslog (may be
+	overridden with `--log-destination=`).
 	Incompatible with --detach, --port, --listen, --user and --group
 	options.
 
@@ -110,8 +112,26 @@ OPTIONS
 	zero for no limit.
 
 --syslog::
-	Log to syslog instead of stderr. Note that this option does not imply
-	--verbose, thus by default only error conditions will be logged.
+	Short for `--log-destination=syslog`.
+
+--log-destination=<destination>::
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
index e37e343d0..f28400e3f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -9,7 +9,12 @@
 #define initgroups(x, y) (0) /* nothing */
 #endif
 
-static int log_syslog;
+static enum log_destination {
+	LOG_DESTINATION_UNSET = -1,
+	LOG_DESTINATION_NONE = 0,
+	LOG_DESTINATION_STDERR = 1,
+	LOG_DESTINATION_SYSLOG = 2,
+} log_destination;
 static int verbose;
 static int reuseaddr;
 static int informative_errors;
@@ -25,6 +30,7 @@ static const char daemon_usage[] =
 "           [--access-hook=<path>]\n"
 "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
 "                      [--detach] [--user=<user> [--group=<group>]]\n"
+"           [--log-destination=(stderr|syslog|none)]\n"
 "           [<directory>...]";
 
 /* List of acceptable pathname prefixes */
@@ -74,11 +80,14 @@ static const char *get_ip_address(struct hostinfo *hi)
 
 static void logreport(int priority, const char *err, va_list params)
 {
-	if (log_syslog) {
+	switch (log_destination) {
+	case LOG_DESTINATION_SYSLOG: {
 		char buf[1024];
 		vsnprintf(buf, sizeof(buf), err, params);
 		syslog(priority, "%s", buf);
-	} else {
+		break;
+	}
+	case LOG_DESTINATION_STDERR:
 		/*
 		 * Since stderr is set to buffered mode, the
 		 * logging of different processes will not overlap
@@ -88,6 +97,10 @@ static void logreport(int priority, const char *err, va_list params)
 		vfprintf(stderr, err, params);
 		fputc('\n', stderr);
 		fflush(stderr);
+		break;
+	case LOG_DESTINATION_NONE:
+	case LOG_DESTINATION_UNSET:
+		break;
 	}
 }
 
@@ -1289,7 +1302,6 @@ int cmd_main(int argc, const char **argv)
 		}
 		if (!strcmp(arg, "--inetd")) {
 			inetd_mode = 1;
-			log_syslog = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--verbose")) {
@@ -1297,9 +1309,22 @@ int cmd_main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "--syslog")) {
-			log_syslog = 1;
+			log_destination = LOG_DESTINATION_SYSLOG;
 			continue;
 		}
+		if (skip_prefix(arg, "--log-destination=", &v)) {
+			if (!strcmp(v, "syslog")) {
+				log_destination = LOG_DESTINATION_SYSLOG;
+				continue;
+			} else if (!strcmp(v, "stderr")) {
+				log_destination = LOG_DESTINATION_STDERR;
+				continue;
+			} else if (!strcmp(v, "none")) {
+				log_destination = LOG_DESTINATION_NONE;
+				continue;
+			} else
+				die("Unknown log destination %s", v);
+		}
 		if (!strcmp(arg, "--export-all")) {
 			export_all_trees = 1;
 			continue;
@@ -1356,7 +1381,6 @@ int cmd_main(int argc, const char **argv)
 		}
 		if (!strcmp(arg, "--detach")) {
 			detach = 1;
-			log_syslog = 1;
 			continue;
 		}
 		if (skip_prefix(arg, "--user=", &v)) {
@@ -1402,7 +1426,14 @@ int cmd_main(int argc, const char **argv)
 		usage(daemon_usage);
 	}
 
-	if (log_syslog) {
+	if (log_destination == LOG_DESTINATION_UNSET) {
+		if (inetd_mode || detach)
+			log_destination = LOG_DESTINATION_SYSLOG;
+		else
+			log_destination = LOG_DESTINATION_STDERR;
+	}
+
+	if (log_destination == LOG_DESTINATION_SYSLOG) {
 		openlog("git-daemon", LOG_PID, LOG_DAEMON);
 		set_die_routine(daemon_die);
 	} else
-- 
2.16.1

