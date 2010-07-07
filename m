From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 05/13] Drive the debug editor
Date: Wed,  7 Jul 2010 02:14:45 +0200
Message-ID: <1278461693-3828-6-git-send-email-artagnon@gmail.com>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	dev@subversion.apache.org
To: Git Mailing List <git@vger.kernel.org>
X-From: dev-return-4819-gcvsd-dev=m.gmane.org@subversion.apache.org Wed Jul 07 02:14:04 2010
Return-path: <dev-return-4819-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@lo.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-4819-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1OWIH5-0004vD-N3
	for gcvsd-dev@lo.gmane.org; Wed, 07 Jul 2010 02:14:04 +0200
Received: (qmail 97141 invoked by uid 500); 7 Jul 2010 00:14:02 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 97131 invoked by uid 99); 7 Jul 2010 00:14:01 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 00:14:01 +0000
X-ASF-Spam-Status: No, hits=0.0 required=10.0
	tests=FREEMAIL_FROM,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: domain of artagnon@gmail.com designates 209.85.215.171 as permitted sender)
Received: from [209.85.215.171] (HELO mail-ey0-f171.google.com) (209.85.215.171)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 00:13:52 +0000
Received: by eyg7 with SMTP id 7so174629eyg.16
        for <dev@subversion.apache.org>; Tue, 06 Jul 2010 17:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=thxWg3l2AmOfFHcXEYKloj/G+zwL9qbFnlgauyf8Dnw=;
        b=QW6dExbWricQGgQEfgFx3CRGDJoyB8NtbM4qWhph33L5TYFP+ISdUpwFfQAEqrahKI
         qIIlQpIDegjxwET7NSGOVrFC4B5xjc8K69Zo3NGp0eGa/sVr0KUjeftLRhEogMVo2gks
         F33iXHG/VmCk54U+tsT0+3IBQSPW+pouDMMLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JnLd3v0q5uaYfBUj1n3fm9C/59+LkKLqyBDdc3HM2mz42CgjO63pRvIh98LARJU29Z
         EeLzKZBT+LVTsMKLBBgQXGLjbkGJi3iW4+clvdO9xO65e6i2X5Bn7whb0gb79qCj1U3J
         idjKlEYAnVnJgc15ZkMFo3WZSbAuzOflROP90=
Received: by 10.213.108.65 with SMTP id e1mr5037611ebp.47.1278461611310;
        Tue, 06 Jul 2010 17:13:31 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id x54sm55855312eeh.23.2010.07.06.17.13.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 17:13:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150429>

Wrap the dummy dump editor in the debug editor and drive the debug
editor to print out all the actions that occur during the replay to
stderr.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dump_editor.c |    2 +-
 dumpr_util.h  |    5 +++++
 svndumpr.c    |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/dump_editor.c b/dump_editor.c
index 2fdf93c..70d6c0b 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -128,7 +128,7 @@ svn_error_t *get_dump_editor(const svn_delta_editor_t **editor,
 	de->close_directory = close_directory;
 	de->change_dir_prop = change_dir_prop;
 	de->change_file_prop = change_file_prop;
-	de->apply_textdelta = apply_textdelta;
+	/* de->apply_textdelta = apply_textdelta; */
 	de->add_file = add_file;
 	de->open_file = open_file;
 	de->close_file = close_file;
diff --git a/dumpr_util.h b/dumpr_util.h
index d206c19..166e214 100644
--- a/dumpr_util.h
+++ b/dumpr_util.h
@@ -1,6 +1,11 @@
 #ifndef DUMPR_UTIL_H_
 #define DUMPR_UTIL_H_
 
+struct replay_baton {
+	const svn_delta_editor_t *editor;
+	void *baton;
+};
+
 struct edit_baton {
 	/* The stream to dump to: stdout */
 	svn_stream_t *stream;
diff --git a/svndumpr.c b/svndumpr.c
index 737c4aa..853facd 100644
--- a/svndumpr.c
+++ b/svndumpr.c
@@ -8,10 +8,40 @@
 #include "svn_ra.h"
 #include "svn_repos.h"
 
+#include "debug_editor.h"
+#include "dump_editor.h"
+#include "dumpr_util.h"
+
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
+	/* Extract editor and editor_baton from the replay_baton and
+	   set them so that the editor callbacks can use them */
+	struct replay_baton *rb = replay_baton;
+	*editor = rb->editor;
+	*edit_baton = rb->baton;
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
 svn_error_t *populate_context()
 {
 	const char *http_library;
@@ -47,6 +77,25 @@ svn_error_t *open_connection(const char *url)
 
 svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision)
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
+	replay_baton->baton = debug_baton;
+	SVN_ERR(svn_cmdline_printf(pool, SVN_REPOS_DUMPFILE_MAGIC_HEADER ": %d\n",
+				   SVN_REPOS_DUMPFILE_FORMAT_VERSION));
+	SVN_ERR(svn_ra_replay_range(session, start_revision, end_revision,
+	                            0, TRUE, replay_revstart, replay_revend,
+	                            replay_baton, pool));
 	return SVN_NO_ERROR;
 }
 
-- 
1.7.1
