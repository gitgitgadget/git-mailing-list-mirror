From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/9] Add skeleton SVN client and Makefile
Date: Wed, 14 Jul 2010 01:36:09 +0200
Message-ID: <1279064176-6645-3-git-send-email-artagnon@gmail.com>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 14 01:36:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYp1q-0008BW-4G
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 01:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756969Ab0GMXg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 19:36:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43675 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756651Ab0GMXgX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 19:36:23 -0400
Received: by eya25 with SMTP id 25so898848eya.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 16:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gTD0A/8tmA3Z2k35rou+PpLaxo8rQcFqT0n54hNUeGc=;
        b=tSKlquyAPSOl24EqOQd3AxhdeQ5lICCGAmR4MmWxs939E0ZfMwYGCXH66BU6KEJMUE
         SKneLbYT+pdlsy3KpUaer97WIR0/Z0cTWu4pvTIA+L9gIrmi+hAqzyxXQ6tYApicqoib
         IAEtcXy6dB77/nTYtzMA3lb+2sKh7NOUPmjFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GDMMRhrGjZmT4nZ3uTQ8MzDxVzOob3YUTqzEZmCX4UmymTvChtxnNRAe7o9ot88rvc
         cheZDyeJkSwwAZInu4kC+GsJ/1xPZiHk3EK2bCmLBfHVxx8Ur5i5UNLekkrm//vlMOP5
         tjJ4dkJsNh7pUCyKki/vXbOyNmvZZO614LzU8=
Received: by 10.213.22.18 with SMTP id l18mr489715ebb.58.1279064181733;
        Tue, 13 Jul 2010 16:36:21 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id v8sm51491498eeh.8.2010.07.13.16.36.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 16:36:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150942>

Add a basic SVN command-line client along with a Makefile that does
just enough to establish a connection with the ASF subversion server;
it initializes a memory pool, sees that configuration files are in
order, builds up a context object, sets up an authentication baton,
and finally opens a session to the subversion server.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile   |    8 +++++
 svnrdump.c |  102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 0 deletions(-)
 create mode 100644 Makefile
 create mode 100644 svnrdump.c

diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000..55f28e5
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,8 @@
+svnrdump: *.c
+	$(CC) -Wall -Werror -DAPR_POOL_DEBUG -ggdb3 -O0 -o $@ svnrdump.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
+
+svnrdump_bench: *.c
+	$(CC) -O2 -o $@ svnrdump.c -lsvn_client-1 -I. -I/usr/include/subversion-1 -I/usr/include/apr-1.0
+
+clean:
+	$(RM) svnrdump svnrdump_bench
diff --git a/svnrdump.c b/svnrdump.c
new file mode 100644
index 0000000..35c1a73
--- /dev/null
+++ b/svnrdump.c
@@ -0,0 +1,102 @@
+/* Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "svn_pools.h"
+#include "svn_cmdline.h"
+#include "svn_client.h"
+#include "svn_ra.h"
+#include "svn_repos.h"
+#include "svn_path.h"
+
+static int verbose = 0;
+static apr_pool_t *pool = NULL;
+static svn_client_ctx_t *ctx = NULL;
+static svn_ra_session_t *session = NULL;
+
+static svn_error_t *open_connection(const char *url)
+{
+	SVN_ERR(svn_config_ensure (NULL, pool));
+	SVN_ERR(svn_client_create_context (&ctx, pool));
+	SVN_ERR(svn_ra_initialize(pool));
+
+	SVN_ERR(svn_config_get_config(&(ctx->config), NULL, pool));
+
+	/* Default authentication providers for non-interactive use */
+	SVN_ERR(svn_cmdline_create_auth_baton(&(ctx->auth_baton), TRUE,
+					      NULL, NULL, NULL, FALSE,
+					      FALSE, NULL, NULL, NULL,
+					      pool));
+	SVN_ERR(svn_client_open_ra_session(&session, url, ctx, pool));
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision)
+{
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *usage(FILE *out_stream)
+{
+	fprintf(out_stream,
+		"usage: svnrdump URL [-r LOWER[:UPPER]]\n\n"
+		"Dump the contents of repository at remote URL to stdout in a 'dumpfile'\n"
+		"v3 portable format.  Dump revisions LOWER rev through UPPER rev.\n"
+		"LOWER defaults to 1 and UPPER defaults to the highest possible revision\n"
+		"if omitted.\n");
+	return SVN_NO_ERROR;
+}
+
+
+int main(int argc, const char **argv)
+{
+	int i;
+	const char *url = NULL;
+	char *revision_cut = NULL;
+	svn_revnum_t start_revision = svn_opt_revision_unspecified;
+	svn_revnum_t end_revision = svn_opt_revision_unspecified;
+
+	if (svn_cmdline_init ("svnrdump", stderr) != EXIT_SUCCESS)
+		return EXIT_FAILURE;
+
+	pool = svn_pool_create(NULL);
+
+	for (i = 1; i < argc; i++) {
+		if (!strncmp("-r", argv[i], 2)) {
+			revision_cut = strchr(argv[i] + 2, ':');
+			if (revision_cut) {
+				start_revision = (svn_revnum_t) strtoul(argv[i] + 2, &revision_cut, 10);
+				end_revision = (svn_revnum_t) strtoul(revision_cut + 1, NULL, 10);
+			}
+			else
+				start_revision = (svn_revnum_t) strtoul(argv[i] + 2, NULL, 10);
+		} else if (!strcmp("-v", argv[i]) || !strcmp("--verbose", argv[i])) {
+			verbose = 1;
+		} else if (!strcmp("help", argv[i]) || !strcmp("--help", argv[i])) {
+			SVN_INT_ERR(usage(stdout));
+			return EXIT_SUCCESS;
+		} else if (*argv[i] == '-' || url) {
+			SVN_INT_ERR(usage(stderr));
+			return EXIT_FAILURE;
+		} else
+			url = argv[i];
+	}
+
+	if (!url || !svn_path_is_url(url)) {
+		usage(stderr);
+		return EXIT_FAILURE;
+	}
+	SVN_INT_ERR(open_connection(url));
+
+	/* Have sane start_revision and end_revision defaults if unspecified */
+	if (start_revision == svn_opt_revision_unspecified)
+		start_revision = 1;
+	if (end_revision == svn_opt_revision_unspecified)
+		SVN_INT_ERR(svn_ra_get_latest_revnum(session, &end_revision, pool));
+
+	SVN_INT_ERR(replay_range(start_revision, end_revision));
+
+	svn_pool_destroy(pool);
+	
+	return 0;
+}
-- 
1.7.1
