From: Jeff King <peff@peff.net>
Subject: [PATCHv3] daemon: give friendlier error messages to clients
Date: Fri, 14 Oct 2011 17:19:21 -0400
Message-ID: <20111014211921.GB16429@sigill.intra.peff.net>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net>
 <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net>
 <20111014192326.GA7713@sigill.intra.peff.net>
 <20111014210251.GD16371@elie.hsd1.il.comcast.net>
 <20111014211244.GA16429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 23:19:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REpAA-0001a7-S4
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 23:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238Ab1JNVT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 17:19:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60906
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754616Ab1JNVT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 17:19:26 -0400
Received: (qmail 15303 invoked by uid 107); 14 Oct 2011 21:19:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Oct 2011 17:19:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2011 17:19:21 -0400
Content-Disposition: inline
In-Reply-To: <20111014211244.GA16429@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183614>

When the git-daemon is asked about an inaccessible
repository, it simply hangs up the connection without saying
anything further. This makes it hard to distinguish between
a repository we cannot access (e.g., due to typo), and a
service or network outage.

Instead, let's print an "ERR" line, which git clients
understand since v1.6.1 (2008-12-24).

Because there is a risk of leaking information about
non-exported repositories, by default all errors simply say
"access denied". Sites which don't have hidden repositories,
or don't care, can pass a flag to turn on more specific
messages.

Signed-off-by: Jeff King <peff@peff.net>
---
Minor tweaks to the documentation and code style to make Jonathan happy.
:)

Note: I labeled this "v3", as it is the third one posted, but the prior
ones were not labeled with versions at all.

 Documentation/git-daemon.txt |   10 ++++++++++
 daemon.c                     |   25 +++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 69a1e4a..31b28fc 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -161,6 +161,16 @@ the facility of inet daemon to achieve the same before spawning
 	repository configuration.  By default, all the services
 	are overridable.
 
+--informative-errors::
+--no-informative-errors::
+	When informative errors are turned on, git-daemon will report
+	more verbose errors to the client, differentiating conditions
+	like "no such repository" from "repository not exported". This
+	is more convenient for clients, but may leak information about
+	the existence of unexported repositories.  When informative
+	errors are not enabled, all errors report "access denied" to the
+	client. The default is --no-informative-errors.
+
 <directory>::
 	A directory to add to the whitelist of allowed directories. Unless
 	--strict-paths is specified this will also include subdirectories
diff --git a/daemon.c b/daemon.c
index 4c8346d..6f111af 100644
--- a/daemon.c
+++ b/daemon.c
@@ -20,6 +20,7 @@
 static int log_syslog;
 static int verbose;
 static int reuseaddr;
+static int informative_errors;
 
 static const char daemon_usage[] =
 "git daemon [--verbose] [--syslog] [--export-all]\n"
@@ -247,6 +248,14 @@ static int git_daemon_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+static int daemon_error(const char *dir, const char *msg)
+{
+	if (!informative_errors)
+		msg = "access denied";
+	packet_write(1, "ERR %s: %s", msg, dir);
+	return -1;
+}
+
 static int run_service(char *dir, struct daemon_service *service)
 {
 	const char *path;
@@ -257,11 +266,11 @@ static int run_service(char *dir, struct daemon_service *service)
 	if (!enabled && !service->overridable) {
 		logerror("'%s': service not enabled.", service->name);
 		errno = EACCES;
-		return -1;
+		return daemon_error(dir, "service not enabled");
 	}
 
 	if (!(path = path_ok(dir)))
-		return -1;
+		return daemon_error(dir, "no such repository");
 
 	/*
 	 * Security on the cheap.
@@ -277,7 +286,7 @@ static int run_service(char *dir, struct daemon_service *service)
 	if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
 		logerror("'%s': repository not exported.", path);
 		errno = EACCES;
-		return -1;
+		return daemon_error(dir, "repository not exported");
 	}
 
 	if (service->overridable) {
@@ -291,7 +300,7 @@ static int run_service(char *dir, struct daemon_service *service)
 		logerror("'%s': service not enabled for '%s'",
 			 service->name, path);
 		errno = EACCES;
-		return -1;
+		return daemon_error(dir, "service not enabled");
 	}
 
 	/*
@@ -1167,6 +1176,14 @@ int main(int argc, char **argv)
 			make_service_overridable(arg + 18, 0);
 			continue;
 		}
+		if (!prefixcmp(arg, "--informative-errors")) {
+			informative_errors = 1;
+			continue;
+		}
+		if (!prefixcmp(arg, "--no-informative-errors")) {
+			informative_errors = 0;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
-- 
1.7.6.4.37.g43b58b
