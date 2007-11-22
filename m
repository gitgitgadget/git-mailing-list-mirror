From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH v2] builtin-commit: Include the diff in the commit message when verbose.
Date: Wed, 21 Nov 2007 21:54:49 -0500
Message-ID: <1195700089-8326-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 22 03:09:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv1VO-0000kO-9u
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 03:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbXKVCJE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 21:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753535AbXKVCJD
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 21:09:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56508 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753383AbXKVCJB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 21:09:01 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lAM28xcq032384;
	Wed, 21 Nov 2007 21:08:59 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lAM28xHI017043;
	Wed, 21 Nov 2007 21:08:59 -0500
Received: from localhost.localdomain (sebastian-int.corp.redhat.com [172.16.52.221])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lAM28weK007884;
	Wed, 21 Nov 2007 21:08:58 -0500
X-Mailer: git-send-email 1.5.3.6.1993.gf154-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65734>

run_diff_index() and the entire diff machinery is hard coded to output
to stdout, so just redirect that and restore it when done.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---

Thinking about this, the dup-dance really belongs in wt-status.c since
that interface promises that it can redirect to a FILE *.  Also the
fflush()'es in the earlier patch could go wrong if stdout ends up flush=
ing
during run_diff_index() and fp has unflushed data.

 builtin-commit.c |    8 +++++++-
 wt-status.c      |   16 ++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index e8893f8..39764ae 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -662,7 +662,7 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
 	int header_len;
 	struct strbuf sb;
 	const char *index_file, *reflog_msg;
-	char *nl;
+	char *nl, *p;
 	unsigned char commit_sha1[20];
 	struct ref_lock *ref_lock;
=20
@@ -758,6 +758,12 @@ int cmd_commit(int argc, const char **argv, const =
char *prefix)
 		rollback_index_files();
 		exit(1);
 	}
+
+	/* Truncate the message just before the diff, if any. */
+	p =3D strstr(sb.buf, "\ndiff --git a/");
+	if (p !=3D NULL)
+		strbuf_setlen(&sb, p - sb.buf);
+
 	stripspace(&sb, 1);
 	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
 		rollback_index_files();
diff --git a/wt-status.c b/wt-status.c
index d3c10b8..0e0439f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -315,12 +315,28 @@ static void wt_status_print_untracked(struct wt_s=
tatus *s)
 static void wt_status_print_verbose(struct wt_status *s)
 {
 	struct rev_info rev;
+	int saved_stdout;
+
+	fflush(s->fp);
+
+	/* Sigh, the entire diff machinery is hardcoded to output to
+	 * stdout.  Do the dup-dance...*/
+	saved_stdout =3D dup(STDOUT_FILENO);
+	if (saved_stdout < 0 ||dup2(fileno(s->fp), STDOUT_FILENO) < 0)
+		die("couldn't redirect stdout\n");
+
 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev, s->reference);
 	rev.diffopt.output_format |=3D DIFF_FORMAT_PATCH;
 	rev.diffopt.detect_rename =3D 1;
 	wt_read_cache(s);
 	run_diff_index(&rev, 1);
+
+	fflush(stdout);
+
+	if (dup2(saved_stdout, STDOUT_FILENO) < 0)
+		die("couldn't restore stdout\n");
+	close(saved_stdout);
 }
=20
 void wt_status_print(struct wt_status *s)
--=20
1.5.3.4
