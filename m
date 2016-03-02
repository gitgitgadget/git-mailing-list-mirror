From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] bundle: keep a copy of bundle file name in the in-core bundle header
Date: Wed,  2 Mar 2016 12:32:40 -0800
Message-ID: <1456950761-19759-4-git-send-email-gitster@pobox.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
 <1456950761-19759-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 21:33:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abDS7-00070y-SS
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 21:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078AbcCBUcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 15:32:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755863AbcCBUct (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 15:32:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA40B48085;
	Wed,  2 Mar 2016 15:32:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=wnhY
	a9jON/UfxjVh72cV3eoPd78=; b=bmLFCRfsjJeN0oll25FhnVQx0x1BYH/3Hs1L
	K6MAtM8h0t/OhsogoG9YRi9PVWE961JeOCf0OCEfS54vVRfc6kz84FhtracV0hP1
	iemoDlWCFY2wGJVeY78kUPMRiQlRzExcAH/D7esbeXCRVeOQaxatpnLLD0Ep4x9V
	uyHNHYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ORY19j
	YTIX4E4KmghEGJXXMDj+UPMwhuhzSONcXCn9fKq/VKPzCbxhWMG8m2e/A7IAUd7b
	We0FtTbyx63o5tgDm95CURaKttiWFCv7C2M6g9frrnBT3rq3+E13kbIeoUVYHqQc
	1velsDWmTNyf/Mh5ISh+cyzZ8a9h5tK87ro1U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A02E548084;
	Wed,  2 Mar 2016 15:32:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C57114807F;
	Wed,  2 Mar 2016 15:32:47 -0500 (EST)
X-Mailer: git-send-email 2.8.0-rc0-114-g0b3e5e5
In-Reply-To: <1456950761-19759-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: ED37D8F2-E0B5-11E5-9B4C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288153>

This will be necessary when we start reading from a split bundle
where the header and the thin-pack data live in different files.

The in-core bundle header will read from a file that has the header,
and will record the path to that file.  We would find the name of
the file that hosts the thin-pack data from the header, and we would
take that name as relative to the file we read the header from.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/bundle.c |  6 +++---
 bundle.c         | 27 +++++++++++++++++----------
 bundle.h         |  4 +++-
 transport.c      |  3 ++-
 4 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 4883a43..c9ede65 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -35,9 +35,9 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 		bundle_file = buffer;
 	}
 
-	memset(&header, 0, sizeof(header));
-	if (strcmp(cmd, "create") && (bundle_fd =
-				read_bundle_header(bundle_file, &header)) < 0)
+	init_bundle_header(&header, bundle_file);
+	if (strcmp(cmd, "create") &&
+	    (bundle_fd = read_bundle_header(&header)) < 0)
 		return 1;
 
 	if (!strcmp(cmd, "verify")) {
diff --git a/bundle.c b/bundle.c
index 9c5a6f0..32bdb01 100644
--- a/bundle.c
+++ b/bundle.c
@@ -21,8 +21,13 @@ static void add_to_ref_list(const unsigned char *sha1, const char *name,
 	list->nr++;
 }
 
-static int parse_bundle_header(int fd, struct bundle_header *header,
-			       const char *report_path)
+void init_bundle_header(struct bundle_header *header, const char *name)
+{
+	memset(header, '\0', sizeof(*header));
+	header->filename = xstrdup(name);
+}
+
+static int parse_bundle_header(int fd, struct bundle_header *header, int quiet)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int status = 0;
@@ -30,9 +35,9 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 	/* The bundle header begins with the signature */
 	if (strbuf_getwholeline_fd(&buf, fd, '\n') ||
 	    strcmp(buf.buf, bundle_signature)) {
-		if (report_path)
+		if (!quiet)
 			error(_("'%s' does not look like a v2 bundle file"),
-			      report_path);
+			      header->filename);
 		status = -1;
 		goto abort;
 	}
@@ -57,7 +62,7 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 		if (get_sha1_hex(buf.buf, sha1) ||
 		    (buf.len > 40 && !isspace(buf.buf[40])) ||
 		    (!is_prereq && buf.len <= 40)) {
-			if (report_path)
+			if (!quiet)
 				error(_("unrecognized header: %s%s (%d)"),
 				      (is_prereq ? "-" : ""), buf.buf, (int)buf.len);
 			status = -1;
@@ -79,13 +84,13 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 	return fd;
 }
 
-int read_bundle_header(const char *path, struct bundle_header *header)
+int read_bundle_header(struct bundle_header *header)
 {
-	int fd = open(path, O_RDONLY);
+	int fd = open(header->filename, O_RDONLY);
 
 	if (fd < 0)
-		return error(_("could not open '%s'"), path);
-	return parse_bundle_header(fd, header, path);
+		return error(_("could not open '%s'"), header->filename);
+	return parse_bundle_header(fd, header, 0);
 }
 
 int is_bundle(const char *path, int quiet)
@@ -96,7 +101,7 @@ int is_bundle(const char *path, int quiet)
 	if (fd < 0)
 		return 0;
 	memset(&header, 0, sizeof(header));
-	fd = parse_bundle_header(fd, &header, quiet ? NULL : path);
+	fd = parse_bundle_header(fd, &header, quiet);
 	if (fd >= 0)
 		close(fd);
 	return (fd >= 0);
@@ -112,6 +117,8 @@ void release_bundle_header(struct bundle_header *header)
 	for (i = 0; i < header->references.nr; i++)
 		free(header->references.list[i].name);
 	free(header->references.list);
+
+	free((void *)header->filename);
 }
 
 static int list_refs(struct ref_list *r, int argc, const char **argv)
diff --git a/bundle.h b/bundle.h
index f7ce23b..e059ccf 100644
--- a/bundle.h
+++ b/bundle.h
@@ -10,12 +10,14 @@ struct ref_list {
 };
 
 struct bundle_header {
+	const char *filename;
 	struct ref_list prerequisites;
 	struct ref_list references;
 };
 
 int is_bundle(const char *path, int quiet);
-int read_bundle_header(const char *path, struct bundle_header *header);
+void init_bundle_header(struct bundle_header *, const char *filename);
+int read_bundle_header(struct bundle_header *header);
 int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv);
 int verify_bundle(struct bundle_header *header, int verbose);
diff --git a/transport.c b/transport.c
index 08e15c5..7bd3206 100644
--- a/transport.c
+++ b/transport.c
@@ -81,7 +81,8 @@ static struct ref *get_refs_from_bundle(struct transport *transport, int for_pus
 
 	if (data->fd > 0)
 		close(data->fd);
-	data->fd = read_bundle_header(transport->url, &data->header);
+	init_bundle_header(&data->header, transport->url);
+	data->fd = read_bundle_header(&data->header);
 	if (data->fd < 0)
 		die ("Could not read bundle '%s'.", transport->url);
 	for (i = 0; i < data->header.references.nr; i++) {
-- 
2.8.0-rc0-114-g0b3e5e5
