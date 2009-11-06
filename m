From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 02/12] Allow programs to not depend on remotes having urls
Date: Fri,  6 Nov 2009 23:52:36 +0100
Message-ID: <1257547966-14603-3-git-send-email-srabbelier@gmail.com>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-2-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 23:53:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Xgn-000813-I5
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 23:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760009AbZKFWxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 17:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbZKFWxe
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 17:53:34 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:44637 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbZKFWxa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 17:53:30 -0500
Received: by ewy3 with SMTP id 3so1557937ewy.37
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 14:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uszlPoyWTVrwzhiIjZsqLNAK9Dey+wV9VwZtwxRGdDE=;
        b=YiGK0GDGadl/ORhzdKoqq0g8PSq+noNXHH4IDpClzRVEFGsfOuKbYaeJsEZEo+H07a
         1i89VdaBrqxFuf8o7/cu+WU9YPEvriPYkwLdjAzqicvP1kwQ4R0HymSfoeT66pvYeLH0
         HD5LR9PWnWx0YQgiWrEgvPs7hpozizAPNDDgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WCoXHoQDEK3Lbm/xlJRclR7ryRnlfavGRzQTPJWd+xqckfgakODODlMLiPj3SdkArD
         VcQHY6Y8UBK058H/bZ18d2JnKfEHgQEhiOS3bK/8kkG6XMTBDhcyDaPZbpsQyF2oJjZJ
         1of95TOy9yC7TYGyI93WQwkrMfxMYWtxMSF2E=
Received: by 10.213.2.84 with SMTP id 20mr5710863ebi.46.1257548014481;
        Fri, 06 Nov 2009 14:53:34 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 7sm1501175eyb.40.2009.11.06.14.53.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 14:53:32 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.158.g6dacb
In-Reply-To: <1257547966-14603-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132329>

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
1.6.5.2.158.g6dacb
