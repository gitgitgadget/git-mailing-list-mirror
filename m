From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 02/13] Allow programs to not depend on remotes having urls
Date: Wed,  4 Nov 2009 20:48:07 +0100
Message-ID: <1257364098-1685-3-git-send-email-srabbelier@gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:50:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lrn-0000NL-4M
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758074AbZKDTtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758021AbZKDTtE
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:49:04 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:61042 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758071AbZKDTtC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:49:02 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3490470ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 11:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Do6aPRpxwNimRvqmFwejfEeXbaihclOdnT4EwyRpXhk=;
        b=mRB/6FekrIgQo6fs0j8biEVfBjK8auBogBd4F7JrfI5ksHDoCWdEjq/MfpoNWLnBeK
         +4ncN2xWYtCgnr7suERov9Gzqp919llw1HZaLWTGZEH2IBHRsQQjcUJCTP2L9jdqpIXN
         GqOx/faB93GTBiI+WNihzaOnpqRc1HqoO19U4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KjetqTIfSKa5guLpOd2eyCsOqQ710khYcNAChGM+MxmHcC0oHV0QCtwK8rVTKcFE0k
         lccJJ2Mkbz3hpTL4CWT/xjaicSy8DzAjsWm7OV5ygkQPbNBY3PA0b68lZQbhW0gnZ1IL
         Q06Y11Z9/b+xrP3jvk/QoZtQxNM8KtpUOZHGs=
Received: by 10.213.25.77 with SMTP id y13mr2261479ebb.48.1257364147186;
        Wed, 04 Nov 2009 11:49:07 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 5sm4314489eyh.2.2009.11.04.11.49.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 11:49:06 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
In-Reply-To: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132134>

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

	Unchanged.

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
index 8631c06..88dd9f5 100644
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
index 644a30a..9daa686 100644
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
1.6.5.2.295.g0d105
