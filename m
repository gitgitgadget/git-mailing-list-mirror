From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make http-backend REMOTE_USER configurable
Date: Thu, 29 Mar 2012 18:26:32 -0400
Message-ID: <20120329222632.GC1413@sigill.intra.peff.net>
References: <1333051139-14262-1-git-send-email-willsk@bnl.gov>
 <7vzkazoyk3.fsf@alter.siamese.dyndns.org>
 <20120329222230.GB1413@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Strecker-Kellogg <willsk@bnl.gov>,
	Git List <git@vger.kernel.org>, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 00:26:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDNnl-0003lN-Sa
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 00:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760049Ab2C2W0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 18:26:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39764
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759487Ab2C2W0g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 18:26:36 -0400
Received: (qmail 7342 invoked by uid 107); 29 Mar 2012 22:26:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Mar 2012 18:26:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2012 18:26:32 -0400
Content-Disposition: inline
In-Reply-To: <20120329222230.GB1413@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194301>

On Thu, Mar 29, 2012 at 06:22:30PM -0400, Jeff King wrote:

> I think an even better thing would be for http-backend to leave
> GIT_COMMITTER_* alone if it exists; that is the usual well-known
> interface for setting such things. And then you could specify a
> detailed committer name and email if you want, or leave them blank to
> pull from $REMOTE_USER as we do now. As it is now, even if you specify
> GIT_COMMITTER_EMAIL, it gets overwritten with
> "$REMOTE_USER@http.$REMOTE_ADDR".

That patch would look something like this:

---
diff --git a/http-backend.c b/http-backend.c
index 869d515..aa892e6 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -318,7 +318,7 @@ static void run_service(const char **argv)
 	const char *user = getenv("REMOTE_USER");
 	const char *host = getenv("REMOTE_ADDR");
 	char *env[3];
-	struct strbuf buf = STRBUF_INIT;
+	int num_env = 0;
 	int gzipped_request = 0;
 	struct child_process cld;
 
@@ -332,13 +332,17 @@ static void run_service(const char **argv)
 	if (!host || !*host)
 		host = "(none)";
 
-	memset(&env, 0, sizeof(env));
-	strbuf_addf(&buf, "GIT_COMMITTER_NAME=%s", user);
-	env[0] = strbuf_detach(&buf, NULL);
-
-	strbuf_addf(&buf, "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
-	env[1] = strbuf_detach(&buf, NULL);
-	env[2] = NULL;
+	if (!getenv("GIT_COMMITTER_NAME")) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "GIT_COMMITTER_NAME=%s", user);
+		env[num_env++] = strbuf_detach(&buf, NULL);
+	}
+	if (!getenv("GIT_COMMITTER_EMAIL")) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
+		env[num_env++] = strbuf_detach(&buf, NULL);
+	}
+	env[num_env] = NULL;
 
 	memset(&cld, 0, sizeof(cld));
 	cld.argv = argv;
@@ -359,7 +363,6 @@ static void run_service(const char **argv)
 		exit(1);
 	free(env[0]);
 	free(env[1]);
-	strbuf_release(&buf);
 }
 
 static int show_text_ref(const char *name, const unsigned char *sha1,
