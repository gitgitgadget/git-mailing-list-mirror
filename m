From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 02/13] Add skeleton SVN client and Makefile
Date: Wed,  7 Jul 2010 02:14:42 +0200
Message-ID: <1278461693-3828-3-git-send-email-artagnon@gmail.com>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 07 02:13:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWIGY-0004eS-U8
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 02:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab0GGAN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 20:13:26 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39519 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab0GGANZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 20:13:25 -0400
Received: by ewy23 with SMTP id 23so1968051ewy.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 17:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VWugdii4oxuG7vzLvtm3rqKgzJpOVSvqI7ibBPyMNhc=;
        b=AJiMr9FrmG8ecOybubIi3hiry5dukFaUorU+TBPmNuGT3mEuw/jLDtiL1tC4OSuwdu
         oQZFo49Y0DYQdUG37W/TR3MxvriUiZwj0XhCwftydUORRNz/XYq3bOaoWJgCjpqnAM6v
         L44P5o3C/FYUPJzCFPSdQO1L3+oLiPkITQ/J0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=M6C/kXNcvcFIm8mNfrTd3FJeZ8cok6gPavjxIyZPWwy2LRZ+yey5FtBLiT+jMAEGT+
         /C2fJpv1ZbBWfvJsmBr8h1bITohctrEmDSgtpIany3Z+VXAFuMXYQ0/YF7mVu/wttpil
         m8h60elQdSBZPjiFo23hx13s5izUYn70Z9q58=
Received: by 10.213.13.20 with SMTP id z20mr4749277ebz.31.1278461603518;
        Tue, 06 Jul 2010 17:13:23 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id a48sm55887081eei.7.2010.07.06.17.13.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 17:13:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150422>

Add a basic SVN command-line client along with a Makefile that does
just enough to establish a connection with the ASF subversion server;
it initializes a memory pool, sees that configuration files are in
order, builds up a context object, sets up an authentication baton,
and finally opens a session to the subversion server.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile   |    8 +++++++
 svndumpr.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 Makefile
 create mode 100644 svndumpr.c

diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000..a6022f7
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,8 @@
+svndumpr: *.c *.h
+	$(CC) -Wall -Werror -DAPR_POOL_DEBUG -ggdb3 -O0 -o $@ svndumpr.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
+
+svndumpr_bench: *.c *.h
+	$(CC) -O2 -o $@ svndumpr.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
+
+clean:
+	$(RM) svndumpr svndumpr_bench
diff --git a/svndumpr.c b/svndumpr.c
new file mode 100644
index 0000000..737c4aa
--- /dev/null
+++ b/svndumpr.c
@@ -0,0 +1,68 @@
+/* Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "svn_pools.h"
+#include "svn_cmdline.h"
+#include "svn_client.h"
+#include "svn_ra.h"
+#include "svn_repos.h"
+
+static apr_pool_t *pool = NULL;
+static svn_client_ctx_t *ctx = NULL;
+static svn_ra_session_t *session = NULL;
+
+svn_error_t *populate_context()
+{
+	const char *http_library;
+	
+	SVN_ERR(svn_config_get_config(&(ctx->config), NULL, pool));
+	
+	http_library = getenv("SVN_HTTP_LIBRARY");
+	if (http_library)
+		svn_config_set(apr_hash_get(ctx->config, "servers", APR_HASH_KEY_STRING),
+		               "global", "http-library", http_library);
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *open_connection(const char *url)
+{
+	SVN_ERR(svn_config_ensure (NULL, pool));
+	SVN_ERR(svn_client_create_context (&ctx, pool));
+	SVN_ERR(svn_ra_initialize(pool));
+
+#if defined(WIN32) || defined(__CYGWIN__)
+	if (getenv("SVN_ASP_DOT_NET_HACK"))
+		SVN_ERR(svn_wc_set_adm_dir("_svn", pool));
+#endif
+
+	SVN_ERR(populate_context());
+	SVN_ERR(svn_cmdline_create_auth_baton(&(ctx->auth_baton), TRUE,
+					      NULL, NULL, NULL, FALSE,
+					      FALSE, NULL, NULL, NULL,
+					      pool));
+	SVN_ERR(svn_client_open_ra_session(&session, url, ctx, pool));
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision)
+{
+	return SVN_NO_ERROR;
+}
+
+int main()
+{
+	const char url[] = "http://svn.apache.org/repos/asf";
+	svn_revnum_t start_revision = 1, end_revision = 500;
+	if (svn_cmdline_init ("svndumpr", stderr) != EXIT_SUCCESS)
+		return 1;
+
+	pool = svn_pool_create(NULL);
+
+	SVN_INT_ERR(open_connection(url));
+	SVN_INT_ERR(replay_range(start_revision, end_revision));
+
+	svn_pool_destroy(pool);
+	
+	return 0;
+}
-- 
1.7.1
