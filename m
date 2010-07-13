From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/9] Drive the debug editor
Date: Wed, 14 Jul 2010 01:36:11 +0200
Message-ID: <1279064176-6645-5-git-send-email-artagnon@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Jul 14 01:36:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYp1q-0008BW-P3
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 01:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086Ab0GMXg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 19:36:29 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43675 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756651Ab0GMXg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 19:36:27 -0400
Received: by mail-ey0-f174.google.com with SMTP id 25so898848eya.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nwdU8NlFJkkhYXqGD90ngdjMEKLTYFuUkC+HWqKcurY=;
        b=F9/M39NBhwgZLXDlXpHZN/mvSaVEcxwB2I/0DcprxJ77JL5jMX4oDDkosOkYgp9+HY
         lAFn7BvgIvvptY4SKKlkPxVzPmgyAB+vm9rYOHljkqVZMSupCi5YEBCo/u7Pw/e4H2Uy
         pq8CmIN3RKyvJbcs/DvfJYllSZViP0+v1HXbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AiX10cpDINNjI+nySrzNVF0Q1NOXzKiFB/8TWPnJK6EFasddqeaHBsxOAS35OmdDoi
         W0rcGgsnwFpuWN+ea3i3dYw4MQaMQXkF1x06kFW4jL6paylN25Ykt/7uTt7ooD1whBTo
         OfpoOfyVliVtoTrXQssL1L5Yp1TBu44J8I2Ts=
Received: by 10.213.28.72 with SMTP id l8mr530353ebc.54.1279064186769;
        Tue, 13 Jul 2010 16:36:26 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id x54sm51482664eeh.11.2010.07.13.16.36.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 16:36:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150943>

Wrap the dummy dump editor in the debug editor and drive the debug
editor to print out all the actions that occur during the replay to
stderr. In replay_revstart, extract and set editor/ edit_baton from
the replay_baton; they must persist across all the callback functions
while replaying a revision.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dumpr_util.h |    5 +++++
 svnrdump.c   |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/dumpr_util.h b/dumpr_util.h
index 199c9c4..8f494c1 100644
--- a/dumpr_util.h
+++ b/dumpr_util.h
@@ -1,6 +1,11 @@
 #ifndef DUMPR_UTIL_H_
 #define DUMPR_UTIL_H_
 
+struct replay_baton {
+	const svn_delta_editor_t *editor;
+	void *edit_baton;
+};
+
 struct dump_edit_baton {
 	svn_stream_t *stream;
 	svn_revnum_t current_rev;
diff --git a/svnrdump.c b/svnrdump.c
index 35c1a73..e184fee 100644
--- a/svnrdump.c
+++ b/svnrdump.c
@@ -9,11 +9,39 @@
 #include "svn_repos.h"
 #include "svn_path.h"
 
+#include "debug_editor.h"
+#include "dump_editor.h"
+#include "dumpr_util.h"
+
 static int verbose = 0;
 static apr_pool_t *pool = NULL;
 static svn_client_ctx_t *ctx = NULL;
 static svn_ra_session_t *session = NULL;
 
+static svn_error_t *replay_revstart(svn_revnum_t revision,
+                                    void *replay_baton,
+                                    const svn_delta_editor_t **editor,
+                                    void **edit_baton,
+                                    apr_hash_t *rev_props,
+                                    apr_pool_t *pool)
+{
+	struct replay_baton *rb = replay_baton;
+	*editor = rb->editor;
+	*edit_baton = rb->edit_baton;
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *replay_revend(svn_revnum_t revision,
+                                  void *replay_baton,
+                                  const svn_delta_editor_t *editor,
+                                  void *edit_baton,
+                                  apr_hash_t *rev_props,
+                                  apr_pool_t *pool)
+{
+	return SVN_NO_ERROR;
+}
+
 static svn_error_t *open_connection(const char *url)
 {
 	SVN_ERR(svn_config_ensure (NULL, pool));
@@ -33,6 +61,25 @@ static svn_error_t *open_connection(const char *url)
 
 static svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision)
 {
+	const svn_delta_editor_t *dump_editor, *debug_editor;
+	void *debug_baton, *dump_baton;
+
+	SVN_ERR(get_dump_editor(&dump_editor,
+	                        &dump_baton, start_revision, pool));
+
+	SVN_ERR(svn_delta__get_debug_editor(&debug_editor,
+	                                    &debug_baton,
+	                                    dump_editor,
+	                                    dump_baton, pool));
+
+	struct replay_baton *replay_baton = apr_palloc(pool, sizeof(struct replay_baton));
+	replay_baton->editor = debug_editor;
+	replay_baton->edit_baton = debug_baton;
+	SVN_ERR(svn_cmdline_printf(pool, SVN_REPOS_DUMPFILE_MAGIC_HEADER ": %d\n",
+				   SVN_REPOS_DUMPFILE_FORMAT_VERSION));
+	SVN_ERR(svn_ra_replay_range(session, start_revision, end_revision,
+	                            0, TRUE, replay_revstart, replay_revend,
+	                            replay_baton, pool));
 	return SVN_NO_ERROR;
 }
 
-- 
1.7.1
