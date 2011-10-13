From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Thu, 13 Oct 2011 15:45:44 +1100
Message-ID: <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 13 06:46:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REDBH-0004bS-95
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 06:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583Ab1JMEp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 00:45:56 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34600 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab1JMEpy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 00:45:54 -0400
Received: by ywb5 with SMTP id 5so766286ywb.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 21:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=APEasraNF+WMjhTMCGI5+GPWxeLkChhRmrz3d/dtCGU=;
        b=hhL/VEoU4+Bu2/TEG1g5jhp0Oibr2H9pogiNxCMQv0KEp/RfEty99sdk6bhf/KlRNL
         YM/zQ/pam8PWi9CUpfqAu8hfsi+PA5VXqkDTI3jTv9VdqTTi0dynGC7c20mG1xWZaBp4
         uEMicFPgVtYB4H01sv9Vr2YpTL09deITbaFsk=
Received: by 10.236.124.11 with SMTP id w11mr2346430yhh.130.1318481154320;
        Wed, 12 Oct 2011 21:45:54 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id p8sm5793768yhe.17.2011.10.12.21.45.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Oct 2011 21:45:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 13 Oct 2011 15:45:44 +1100
Content-Disposition: inline
In-Reply-To: <20111012200916.GA1502@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183439>

On Wed, Oct 12, 2011 at 04:09:16PM -0400, Jeff King wrote:
> On Tue, Oct 04, 2011 at 08:55:09AM +1100, Nguyen Thai Ngoc Duy wrote:
> 
> > The message is chosen to avoid leaking information, yet let users know
> > that they are deliberately not allowed to use the service, not a fault
> > in service configuration or the service itself.
> 
> I do think this is an improvement, but I wonder if the verbosity should
> be configurable. Then open sites like kernel.org could be friendlier to
> their users. Something like this instead:

How about allow users to select which messages they want to print? We
can even go further, allowing users to specify the messages themselves..

I don't know. I'm not a real server admin so maybe I'm just too
paranoid. Any admins care to speak up?

On the other hand, grouping all messages at one place may be easier to
audit, even if we don't allow customization.

Anyway, two cents on top of your patch..

-- 8< --
diff --git a/daemon.c b/daemon.c
index ec88fd0..a846ef1 100644
--- a/daemon.c
+++ b/daemon.c
@@ -17,10 +17,25 @@
 #define initgroups(x, y) (0) /* nothing */
 #endif
 
+/* Must match messages[] order below */
+#define MSG_SERVICE_NOT_ENABLED     0
+#define MSG_NO_SUCH_REPOSITORY      1
+#define MSG_REPOSITORY_NOT_EXPORTED 2
+
+static struct daemon_message
+{
+	const char *message;
+	const char *config;
+	int enabled;
+} messages[] = {
+	{ "service not enabled", "message.serviceNotEnabled" },
+	{ "no such repository", "message.noSuchRepository" },
+	{ "repository not exported", "message.repositoryNotExported" },
+};
+
 static int log_syslog;
 static int verbose;
 static int reuseaddr;
-static int informative_errors;
 
 static const char daemon_usage[] =
 "git daemon [--verbose] [--syslog] [--export-all]\n"
@@ -238,20 +253,31 @@ static int service_enabled;
 
 static int git_daemon_config(const char *var, const char *value, void *cb)
 {
+	int i;
+
 	if (!prefixcmp(var, "daemon.") &&
 	    !strcmp(var + 7, service_looking_at->config_name)) {
 		service_enabled = git_config_bool(var, value);
 		return 0;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(messages); i++)
+		if (!strcmp(var, messages[i].config)) {
+			messages[i].enabled = git_config_bool(var, value);
+			return 0;
+		}
+
 	/* we are not interested in parsing any other configuration here */
 	return 0;
 }
 
-static int daemon_error(const char *dir, const char *msg)
+static int daemon_error(const char *dir, int msg_id)
 {
-	if (!informative_errors)
+	const char *msg;
+	if (!messages[msg_id].enabled)
 		msg = "access denied";
+	else
+		msg = messages[msg_id].message;
 	packet_write(1, "ERR %s: %s", dir, msg);
 	return -1;
 }
@@ -266,11 +292,11 @@ static int run_service(char *dir, struct daemon_service *service)
 	if (!enabled && !service->overridable) {
 		logerror("'%s': service not enabled.", service->name);
 		errno = EACCES;
-		return daemon_error(dir, "service not enabled");
+		return daemon_error(dir, MSG_SERVICE_NOT_ENABLED);
 	}
 
 	if (!(path = path_ok(dir)))
-		return daemon_error(dir, "no such repository");
+		return daemon_error(dir, MSG_NO_SUCH_REPOSITORY);
 
 	/*
 	 * Security on the cheap.
@@ -286,7 +312,7 @@ static int run_service(char *dir, struct daemon_service *service)
 	if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
 		logerror("'%s': repository not exported.", path);
 		errno = EACCES;
-		return daemon_error(dir, "repository not exported");
+		return daemon_error(dir, MSG_REPOSITORY_NOT_EXPORTED);
 	}
 
 	if (service->overridable) {
@@ -300,7 +326,7 @@ static int run_service(char *dir, struct daemon_service *service)
 		logerror("'%s': service not enabled for '%s'",
 			 service->name, path);
 		errno = EACCES;
-		return daemon_error(dir, "service not enabled");
+		return daemon_error(dir, MSG_SERVICE_NOT_ENABLED);
 	}
 
 	/*
@@ -1177,7 +1203,9 @@ int main(int argc, char **argv)
 			continue;
 		}
 		if (!prefixcmp(arg, "--informative-errors")) {
-			informative_errors = 1;
+			int i;
+			for (i = 0; i < ARRAY_SIZE(messages); i++)
+				messages[i].enabled = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--")) {
-- 8< --
