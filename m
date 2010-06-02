From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH] Add a skeleton RA SVN client
Date: Wed,  2 Jun 2010 15:08:36 +0200
Message-ID: <1275484116-32520-2-git-send-email-artagnon@gmail.com>
References: <1275484116-32520-1-git-send-email-artagnon@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 15:07:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJnfM-0001Mv-9j
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 15:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757980Ab0FBNHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 09:07:22 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:49775 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757704Ab0FBNHU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 09:07:20 -0400
Received: by mail-ew0-f223.google.com with SMTP id 23so623455ewy.1
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 06:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bNEZOrGw8DRUUWwc4LTo5iYSCHDaLiIOIBthV7gs6VU=;
        b=DreP8oOHL7Iplo4U7bx7WbZqHwOiT6ab4yT+u+UFHf1ah4X1nSjSqMfs6PWL77HZzC
         SdfruxHCB7QCVjEcd0P/2Dv1RHQauO9wPuQhR3OfaBvhhA2Hcn1fnS5TWba98YPlM2Do
         tOLm0yceACG4QuFnmAzsPpTvDLxjXTFky9AkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=swfHnQ2aA48CmvXX8sRogkrfKmWL0UbHLyhh/9WrfwMLsK9meKmtZeP/nUvh6x+hQy
         /qiWRjXXY1rV1cKJtWyjk6rQj7J9nX1yLy43HG6EjSnVcl88wSUCIzbLr4SyCeIh4WeV
         pLz7oNd03/1+bmyz4moIhQ0/vhKONStUhWwDI=
Received: by 10.213.29.1 with SMTP id o1mr691377ebc.43.1275484039202;
        Wed, 02 Jun 2010 06:07:19 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id 16sm4459385ewy.11.2010.06.02.06.07.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 06:07:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275484116-32520-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148250>

The SVN client uses the RA API to connect to a remote server and
replay revisions. In future, it will dump the data in every revision
to stdout in dumpfile format (hopefully) without resorting to the FS
API and svn_repos_dump_fs2.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile       |    2 +
 svnclient_ra.c |  113 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 Makefile
 create mode 100644 svnclient_ra.c

diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000..480c526
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,2 @@
+svnclient_ra: svnclient_ra.c
+	cc -Wall -Werror -ggdb -O1 -o $@ -lsvn_client-1 svnclient_ra.c -I/usr/include/subversion-1 -I/usr/include/apr-1.0
diff --git a/svnclient_ra.c b/svnclient_ra.c
new file mode 100644
index 0000000..4113cb8
--- /dev/null
+++ b/svnclient_ra.c
@@ -0,0 +1,113 @@
+#include "svn_pools.h"
+#include "svn_cmdline.h"
+#include "svn_client.h"
+#include "svn_ra.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+
+static apr_pool_t *pool = NULL;
+static svn_client_ctx_t *ctx = NULL;
+static svn_ra_session_t *session = NULL;
+
+static svn_error_t *replay_start(svn_revnum_t revision,
+                                 void *replay_baton,
+                                 const svn_delta_editor_t **editor,
+                                 void **edit_baton,
+                                 apr_hash_t *rev_props,
+                                 apr_pool_t *pool)
+{
+	/* TODO: Dump the data in revision to stdout in dumpfile
+	 * format so it can be parsed by the exporter
+	 */
+	return SVN_NO_ERROR;
+}
+static svn_error_t *replay_end(svn_revnum_t revision,
+                               void *replay_baton,
+                               const svn_delta_editor_t *editor,
+                               void *edit_baton,
+                               apr_hash_t *rev_props,
+                               apr_pool_t *pool)
+{
+	SVN_ERR(editor->close_edit(edit_baton, pool));
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *build_auth_baton()
+{
+	svn_auth_provider_object_t *provider;
+	apr_array_header_t *providers
+		= apr_array_make (pool, 4, sizeof (svn_auth_provider_object_t *));
+
+	svn_auth_get_simple_prompt_provider (&provider,
+	                                     NULL,
+	                                     NULL,
+	                                     2,
+	                                     pool);
+	APR_ARRAY_PUSH (providers, svn_auth_provider_object_t *) = provider;
+
+	svn_auth_get_username_prompt_provider (&provider,
+	                                       NULL,
+	                                       NULL,
+	                                       2,
+	                                       pool);
+	APR_ARRAY_PUSH (providers, svn_auth_provider_object_t *) = provider;
+
+	svn_auth_open (&ctx->auth_baton, providers, pool);
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *populate_context()
+{
+	SVN_ERR(svn_config_get_config(&(ctx->config), NULL, pool));
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
+	SVN_ERR(build_auth_baton());
+	SVN_ERR(svn_client_open_ra_session(&session, url, ctx, pool));
+	return SVN_NO_ERROR;
+}
+
+svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision)
+{
+	svn_revnum_t latest_revision;
+	SVN_ERR(svn_ra_get_latest_revnum(session, &latest_revision, pool));
+	printf("%ld\n", latest_revision);
+	SVN_ERR(svn_ra_replay_range(session, start_revision, end_revision,
+	                            0, TRUE, replay_start, replay_end, NULL, pool));
+	return SVN_NO_ERROR;
+}
+
+void close_connection()
+{
+	svn_pool_destroy(pool);
+}
+
+int main()
+{
+	const char url[] = "http://svn.apache.org/repos/asf/subversion/trunk";
+	svn_revnum_t start_revision = 0, end_revision = 5;
+	if (svn_cmdline_init ("svnclient_ra", stderr) != EXIT_SUCCESS)
+		return EXIT_FAILURE;
+	pool = svn_pool_create(NULL);
+
+	if(open_connection(url) != SVN_NO_ERROR)
+		return 1;
+	if(replay_range(start_revision, end_revision) != SVN_NO_ERROR)
+		return 1;
+
+	close_connection();
+	return 0;
+}
-- 
1.7.1
