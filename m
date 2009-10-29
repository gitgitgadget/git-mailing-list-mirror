From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [UNSTABLE PATCH 03/19] Allow programs to not depend on remotes having urls
Date: Thu, 29 Oct 2009 11:01:11 -0700
Message-ID: <1256839287-19016-4-git-send-email-srabbelier@gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:02:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZKj-0004ac-Ve
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbZJ2SCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753815AbZJ2SCV
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:21 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:43668 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbZJ2SCN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:13 -0400
Received: by mail-pz0-f188.google.com with SMTP id 26so1412783pzk.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GFojB8XJAJpQcz6xDH/+WP8Uk6y1LJhuT1GCyPCeqWk=;
        b=qi8skdd8OmN+0tx0xyU69b6S80nFUftmJLTGdPFnedqbFxZaCt9I4eBz6w8uU/CnrI
         kbD10Nga1PyhSUb5BWpMWIficTb4hQsz5hRycD/hCbrlo1CxyQ3EgD+IMnryXl93TSnt
         LCgizpipJlSBlRJI/UL3PCeLvUQ8YK99d6z7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tPe6m/iGn4qfya1GGiOx5HXPTmTLvrBwDBy5Aara7a7OPsFe+yb3yvGBqYvxy2xCou
         w4f2EYTzUScXVAT1g2l8QvQ3eUcriQNc9U0VvWDolagRKgMMqvM7XX0cFCUgzsFGZFBR
         Ytc21y8Y9aVZL0offmqGXHbr0M0hwPHBuQM4w=
Received: by 10.114.242.5 with SMTP id p5mr275964wah.66.1256839338238;
        Thu, 29 Oct 2009 11:02:18 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Barkalow <barkalow@iabervon.org>

For fetch and ls-remote, which use the first url of a remote, have
transport_get() determine this by passing a remote and passing NULL
for the url. For push, which uses every url of a remote, use each url
in turn if there are any, and use NULL if there are none.

This will allow the transport code to do something different if the
location is not specified with a url.

Also, have the message for a fetch say "foreign" if there is no url.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	I rebased this on master and had major conflicts with the
	recent 'advice' series, Daniel, please have a look at this to
	see whether it is sane at all.

 builtin-fetch.c     |    7 +++-
 builtin-ls-remote.c |    4 +-
 builtin-push.c      |   68 +++++++++++++++++++++++++++++++-------------------
 transport.c         |    3 ++
 4 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index a35a6f8..013a6ba 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -309,7 +309,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	if (!fp)
 		return error("cannot open %s: %s\n", filename, strerror(errno));
 
-	url = transport_anonymize_url(raw_url);
+	if (raw_url)
+		url = transport_anonymize_url(raw_url);
+	else
+		url = xstrdup("foreign");
 	for (rm = ref_map; rm; rm = rm->next) {
 		struct ref *ref = NULL;
 
@@ -704,7 +707,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (!remote)
 		die("Where do you want to fetch from today?");
 
-	transport = transport_get(remote, remote->url[0]);
+	transport = transport_get(remote, NULL);
 	if (verbosity >= 2)
 		transport->verbose = 1;
 	if (verbosity < 0)
diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 78a88f7..4c6fc58 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -87,9 +87,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		}
 	}
 	remote = nongit ? NULL : remote_get(dest);
-	if (remote && !remote->url_nr)
+	if (!nongit && !remote)
 		die("remote %s has no configured URL", dest);
-	transport = transport_get(remote, remote ? remote->url[0] : dest);
+	transport = transport_get(remote, remote ? NULL : dest);
 	if (uploadpack != NULL)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
 
diff --git a/builtin-push.c b/builtin-push.c
index b5cd2cd..d86b93d 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -88,6 +88,36 @@ static void setup_default_push_refspecs(void)
 	}
 }
 
+static int push_with_options(struct transport *transport, int flags)
+{
+	int err;
+	int nonfastforward;
+	if (receivepack)
+		transport_set_option(transport,
+				     TRANS_OPT_RECEIVEPACK, receivepack);
+	if (thin)
+		transport_set_option(transport, TRANS_OPT_THIN, "yes");
+
+	if (flags & TRANSPORT_PUSH_VERBOSE)
+		fprintf(stderr, "Pushing to %s\n", transport->url);
+	err = transport_push(transport, refspec_nr, refspec, flags,
+			     &nonfastforward);
+	err |= transport_disconnect(transport);
+
+	if (!err)
+		return 0;
+
+	error("failed to push some refs to '%s'", transport->url);
+
+	if (nonfastforward && advice_push_nonfastforward) {
+		printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
+		       "Merge the remote changes before pushing again.  See the 'non-fast forward'\n"
+		       "section of 'git push --help' for details.\n");
+	}
+
+	return 1;
+}
+
 static int do_push(const char *repo, int flags)
 {
 	int i, errs;
@@ -136,33 +166,19 @@ static int do_push(const char *repo, int flags)
 		url = remote->url;
 		url_nr = remote->url_nr;
 	}
-	for (i = 0; i < url_nr; i++) {
-		struct transport *transport =
-			transport_get(remote, url[i]);
-		int err;
-		int nonfastforward;
-		if (receivepack)
-			transport_set_option(transport,
-					     TRANS_OPT_RECEIVEPACK, receivepack);
-		if (thin)
-			transport_set_option(transport, TRANS_OPT_THIN, "yes");
-
-		if (flags & TRANSPORT_PUSH_VERBOSE)
-			fprintf(stderr, "Pushing to %s\n", url[i]);
-		err = transport_push(transport, refspec_nr, refspec, flags,
-				     &nonfastforward);
-		err |= transport_disconnect(transport);
-
-		if (!err)
-			continue;
-
-		error("failed to push some refs to '%s'", url[i]);
-		if (nonfastforward && advice_push_nonfastforward) {
-			printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
-			       "Merge the remote changes before pushing again.  See the 'non-fast forward'\n"
-			       "section of 'git push --help' for details.\n");
+	if (url_nr) {
+		for (i = 0; i < url_nr; i++) {
+			struct transport *transport =
+				transport_get(remote, url[i]);
+			if (push_with_options(transport, flags))
+				errs++;
 		}
-		errs++;
+	} else {
+		struct transport *transport =
+			transport_get(remote, NULL);
+
+		if (push_with_options(transport, flags))
+			errs++;
 	}
 	return !!errs;
 }
diff --git a/transport.c b/transport.c
index 3822fc7..5ae8db6 100644
--- a/transport.c
+++ b/transport.c
@@ -813,6 +813,9 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
 	ret->remote = remote;
+
+	if (!url && remote && remote->url)
+		url = remote->url[0];
 	ret->url = url;
 
 	if (!prefixcmp(url, "rsync:")) {
-- 
1.6.5.2.291.gf76a3
