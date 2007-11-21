From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] builtin-commit: Include the diff in the commit message when verbose.
Date: Wed, 21 Nov 2007 14:10:34 -0500
Message-ID: <1195672234-3919-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 21 20:18:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuv5e-00063L-9z
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 20:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbXKUTRJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 14:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbXKUTRI
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 14:17:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38117 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbXKUTRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 14:17:06 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lALJAfbE010742;
	Wed, 21 Nov 2007 14:10:41 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lALJAdUV002541;
	Wed, 21 Nov 2007 14:10:40 -0500
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lALJAdF3012043;
	Wed, 21 Nov 2007 14:10:39 -0500
X-Mailer: git-send-email 1.5.3.6.1865.g65bc6-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65691>

run_diff_index() and the entire diff machinery is hard coded to output
to stdout, so just redirect that and restore it when done.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-commit.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 446a252..d5b8479 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -277,6 +277,7 @@ static char *prepare_index(const char **files, cons=
t char *prefix)
 static int run_status(FILE *fp, const char *index_file, const char *pr=
efix)
 {
 	struct wt_status s;
+	int saved_stdout;
=20
 	wt_status_prepare(&s);
 	s.prefix =3D prefix;
@@ -290,8 +291,23 @@ static int run_status(FILE *fp, const char *index_=
file, const char *prefix)
 	s.index_file =3D index_file;
 	s.fp =3D fp;
=20
+	fflush(fp);
+
+	/* Sigh, the entire diff machinery is hardcoded to output to
+	 * stdout.  Do the dup-dance...*/
+	saved_stdout =3D dup(STDOUT_FILENO);
+	if (saved_stdout < 0 ||	dup2(fileno(fp), STDOUT_FILENO) < 0)
+		die("couldn't redirect stdout\n");
+
 	wt_status_print(&s);
=20
+	fflush(fp);
+	fflush(stdout);
+
+	if (dup2(saved_stdout, STDOUT_FILENO) < 0)
+		die("couldn't restore stdout\n");
+	close(saved_stdout);
+
 	return s.commitable;
 }
=20
@@ -661,7 +677,7 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
 	int header_len;
 	struct strbuf sb;
 	const char *index_file, *reflog_msg;
-	char *nl;
+	char *nl, *p;
 	unsigned char commit_sha1[20];
 	struct ref_lock *ref_lock;
=20
@@ -757,6 +773,12 @@ int cmd_commit(int argc, const char **argv, const =
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
--=20
1.5.3.4.206.g58ba4
