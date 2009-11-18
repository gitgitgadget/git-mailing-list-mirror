From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 02/12] Allow programs to not depend on remotes having urls
Date: Wed, 18 Nov 2009 02:42:22 +0100
Message-ID: <1258508552-20752-3-git-send-email-srabbelier@gmail.com>
References: <1258508552-20752-1-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-2-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 02:43:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAZa4-0000gW-D6
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 02:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793AbZKRBn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 20:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756721AbZKRBn1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 20:43:27 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:61082 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997AbZKRBn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 20:43:26 -0500
Received: by fg-out-1718.google.com with SMTP id d23so2012402fga.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 17:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=v8nDPMSym+jjMuWr2tggYbKlZhRzujMrU4nHfhKhLm8=;
        b=gyRZ+iIIEN/pQcqt/TI1OjTxtF07TkzJMiPpHcspWp2Y1T9gL1U3TPaKEuV9JikCV6
         BSib29dgsVD3dDwZ3OrQ/CcOvvMRoycNmyKu39u6AtFJi+O9On7efn6TrNwdij5uxg+L
         63xZ/bHAMIS6d0BXO6f4ph/c8ehL8FupTplB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=taW8QOXzF53W+TtULxYSa6PTRLi/8WUu3PMsbUCsoJh9mlRZ7wUQnHYICdxvFUuRG3
         THMbAcM/dlJEvyjqGeDaBB2ZPfGCcDe5H59IGHm0zok4OhaYjVrfvezPiy8e1vXIfgl/
         kk/AjjYpsQt9CdzPuWbvudRkq7Cqrpz5KcijA=
Received: by 10.216.89.131 with SMTP id c3mr1243836wef.197.1258508610514;
        Tue, 17 Nov 2009 17:43:30 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 28sm2372670eye.3.2009.11.17.17.43.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 17:43:28 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1258508552-20752-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133125>

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

	Rebased against master again, Daniel, please verify that I
	didn't mess resolving conflicts.

 builtin-fetch.c     |    7 +++-
 builtin-ls-remote.c |    2 +-
 builtin-push.c      |   68 +++++++++++++++++++++++++++++++-------------------
 transport.c         |    3 ++
 4 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index f871f2b..99bc3b9 100644
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
index b5bad0c..70f5622 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -89,7 +89,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	remote = remote_get(dest);
 	if (!remote->url_nr)
 		die("remote %s has no configured URL", dest);
-	transport = transport_get(remote, remote->url[0]);
+	transport = transport_get(remote, NULL);
 	if (uploadpack != NULL)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
 
diff --git a/builtin-push.c b/builtin-push.c
index 356d7c1..a21e46c 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -87,6 +87,36 @@ static void setup_default_push_refspecs(void)
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
+		       "Merge the remote changes before pushing again.  See the 'non-fast-forward'\n"
+		       "section of 'git push --help' for details.\n");
+	}
+
+	return 1;
+}
+
 static int do_push(const char *repo, int flags)
 {
 	int i, errs;
@@ -135,33 +165,19 @@ static int do_push(const char *repo, int flags)
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
-			       "Merge the remote changes before pushing again.  See the 'non-fast-forward'\n"
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
index d249203..4987555 100644
--- a/transport.c
+++ b/transport.c
@@ -816,6 +816,9 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		die("No remote provided to transport_get()");
 
 	ret->remote = remote;
+
+	if (!url && remote && remote->url)
+		url = remote->url[0];
 	ret->url = url;
 
 	if (!prefixcmp(url, "rsync:")) {
-- 
1.6.5.3.164.g07b0c
