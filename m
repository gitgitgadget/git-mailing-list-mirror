From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 06/10] transport->progress: use flag authoritatively
Date: Thu, 18 Feb 2010 20:37:07 +0800
Message-ID: <1266496631-3980-7-git-send-email-rctay89@gmail.com>
References: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 13:38:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni5e5-0004Ez-3p
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 13:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758195Ab0BRMhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 07:37:54 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:59462 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758149Ab0BRMhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 07:37:52 -0500
Received: by ywh35 with SMTP id 35so914453ywh.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 04:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=m3W4ORUv4DYmWBARg/3Ood01Ko6tLbNLVSlUBl4s5bc=;
        b=sbYoYNUN6zG1PfdouFLrV0AD9jcVTbiaAorcTnpoejLf8yeyYCRbTociGT3lGqwi9Z
         HCvpN8BLMLvESbZjv25FQ5tvcs0wcvD7obaIq7pFFyqf4p2utPIP+qPY4IOYki22pSxw
         4nd9MUcbSvIAeHOvWSXiuAIivlKb8fiAPbYoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=yEitY2sSIoOW1VDLwlgGNHhBoqVVPbu3/hOVH/gJ5kDmJWPtq5VI5/KlO3OLRea421
         +lN36cfIqfWZPRbneWzUWgXQ6J+ZpPQiKndWE82BpILQPXM4JhJB3q4GZfS6x8gtbsh1
         f+bb9olOV587/XdNnkFoaaQbt4NF0DMZ0Gjhk=
Received: by 10.101.5.12 with SMTP id h12mr1716854ani.52.1266496671249;
        Thu, 18 Feb 2010 04:37:51 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 21sm381013ywh.17.2010.02.18.04.37.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 04:37:50 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140327>

Set transport->progress in transport.c::transport_set_verbosity() after
checking for the appropriate conditions (eg. --progress, isatty(2)),
and thereafter use it without having to check again.

The rules used are as follows (processing aborts when a rule is
satisfied):

  1. Report progress, if force_progress is 1 (ie. --progress).
  2. Don't report progress, if verbosity < 0 (ie. -q/--quiet).
  3. Report progress if isatty(2) is 1.

This changes progress reporting behaviour such that if both --progress
and --quiet are specified, progress is reported.

In two areas, the logic to determine whether to *not* show progress is
changed to simply use the negation of transport->progress. This changes
behaviour in some ways (see previous paragraph for details).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin-clone.c    |    5 +----
 builtin-fetch.c    |    2 +-
 builtin-push.c     |    2 +-
 transport-helper.c |    3 +--
 transport.c        |   17 +++++++++++++++--
 transport.h        |   10 ++++++++--
 6 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 959fe4b..05f8fb4 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -525,10 +525,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			transport_set_option(transport, TRANS_OPT_DEPTH,
 					     option_depth);
 
-		transport_set_verbosity(transport, option_verbosity);
-
-		if (option_progress)
-			transport->progress = 1;
+		transport_set_verbosity(transport, option_verbosity, option_progress);
 
 		if (option_upload_pack)
 			transport_set_option(transport, TRANS_OPT_UPLOADPACK,
diff --git a/builtin-fetch.c b/builtin-fetch.c
index d23ea2a..6b96b41 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -823,7 +823,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 		die("Where do you want to fetch from today?");
 
 	transport = transport_get(remote, NULL);
-	transport_set_verbosity(transport, verbosity);
+	transport_set_verbosity(transport, verbosity, 0);
 	if (upload_pack)
 		set_option(TRANS_OPT_UPLOADPACK, upload_pack);
 	if (keep)
diff --git a/builtin-push.c b/builtin-push.c
index 0082dad..dce3152 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -107,7 +107,7 @@ static int push_with_options(struct transport *transport, int flags)
 	int err;
 	int nonfastforward;
 
-	transport_set_verbosity(transport, verbosity);
+	transport_set_verbosity(transport, verbosity, 0);
 
 	if (receivepack)
 		transport_set_option(transport,
diff --git a/transport-helper.c b/transport-helper.c
index 3d33697..3e69ebd 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -279,9 +279,8 @@ static void standard_options(struct transport *t)
 	char buf[16];
 	int n;
 	int v = t->verbose;
-	int no_progress = v < 0 || (!t->progress && !isatty(2));
 
-	set_helper_option(t, "progress", !no_progress ? "true" : "false");
+	set_helper_option(t, "progress", t->progress ? "true" : "false");
 
 	n = snprintf(buf, sizeof(buf), "%d", v + 1);
 	if (n >= sizeof(buf))
diff --git a/transport.c b/transport.c
index 0655f65..e2cfabd 100644
--- a/transport.c
+++ b/transport.c
@@ -526,7 +526,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.include_tag = data->options.followtags;
 	args.verbose = (transport->verbose > 0);
 	args.quiet = (transport->verbose < 0);
-	args.no_progress = args.quiet || (!transport->progress && !isatty(2));
+	args.no_progress = !transport->progress;
 	args.depth = data->options.depth;
 
 	for (i = 0; i < nr_heads; i++)
@@ -915,6 +915,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	const char *helper;
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
+	ret->progress = isatty(2);
+
 	if (!remote)
 		die("No remote provided to transport_get()");
 
@@ -1013,12 +1015,23 @@ int transport_set_option(struct transport *transport,
 	return 1;
 }
 
-void transport_set_verbosity(struct transport *transport, int verbosity)
+void transport_set_verbosity(struct transport *transport, int verbosity,
+	int force_progress)
 {
 	if (verbosity >= 2)
 		transport->verbose = verbosity <= 3 ? verbosity : 3;
 	if (verbosity < 0)
 		transport->verbose = -1;
+
+	/**
+	 * Rules used to determine whether to report progress (processing aborts
+	 * when a rule is satisfied):
+	 *
+	 *   1. Report progress, if force_progress is 1 (ie. --progress).
+	 *   2. Don't report progress, if verbosity < 0 (ie. -q/--quiet ).
+	 *   3. Report progress if isatty(2) is 1.
+	 **/
+	transport->progress = force_progress || (verbosity >= 0 && isatty(2));
 }
 
 int transport_push(struct transport *transport,
diff --git a/transport.h b/transport.h
index c0743b1..de2745a 100644
--- a/transport.h
+++ b/transport.h
@@ -74,7 +74,12 @@ struct transport {
 	int (*disconnect)(struct transport *connection);
 	char *pack_lockfile;
 	signed verbose : 3;
-	/* Force progress even if stderr is not a tty */
+	/**
+	 * Transports should not set this directly, and should use this
+	 * value without having to check isatty(2), -q/--quiet
+	 * (transport->verbose < 0), etc. - checking has already been done
+	 * in transport_set_verbosity().
+	 **/
 	unsigned progress : 1;
 	/*
 	 * If transport is at least potentially smart, this points to
@@ -120,7 +125,8 @@ struct transport *transport_get(struct remote *, const char *);
  **/
 int transport_set_option(struct transport *transport, const char *name,
 			 const char *value);
-void transport_set_verbosity(struct transport *transport, int verbosity);
+void transport_set_verbosity(struct transport *transport, int verbosity,
+	int force_progress);
 
 int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
-- 
1.7.0.27.g5d71b
