From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Wed, 12 Oct 2011 16:09:16 -0400
Message-ID: <20111012200916.GA1502@sigill.intra.peff.net>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 22:09:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE57E-0007fn-Up
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 22:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab1JLUJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 16:09:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58790
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717Ab1JLUJT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 16:09:19 -0400
Received: (qmail 16227 invoked by uid 107); 12 Oct 2011 20:09:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 16:09:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 16:09:16 -0400
Content-Disposition: inline
In-Reply-To: <1317678909-19383-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183409>

On Tue, Oct 04, 2011 at 08:55:09AM +1100, Nguyen Thai Ngoc Duy wrote:

> The message is chosen to avoid leaking information, yet let users know
> that they are deliberately not allowed to use the service, not a fault
> in service configuration or the service itself.

I do think this is an improvement, but I wonder if the verbosity should
be configurable. Then open sites like kernel.org could be friendlier to
their users. Something like this instead:

---
 daemon.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index 4c8346d..ec88fd0 100644
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
+	packet_write(1, "ERR %s: %s", dir, msg);
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
@@ -1167,6 +1176,10 @@ int main(int argc, char **argv)
 			make_service_overridable(arg + 18, 0);
 			continue;
 		}
+		if (!prefixcmp(arg, "--informative-errors")) {
+			informative_errors = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
-- 
1.7.7.rc2.21.gb9948
