From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] bundle: keep a copy of bundle file name in the in-core bundle header
Date: Tue, 01 Mar 2016 15:36:26 -0800
Message-ID: <xmqqr3ft6a9x.fsf@gitster.mtv.corp.google.com>
References: <xmqqvb556abd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 00:36:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aatqD-0003sd-J9
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 00:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbcCAXga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 18:36:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751097AbcCAXg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 18:36:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 74C9549F2B;
	Tue,  1 Mar 2016 18:36:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EH2kHNZHVrcB4h52hNZbstXWdl0=; b=xXgUvc
	U3jvgIx1P4Y4RAUDMzykcBRGL7k5x0e9Ra2NV+j6dAQ5j1OUXfGEZi3Eeyw1G0P0
	Bku8EtfjOY9538wxEbvmyellA5nMQlljkUoKgZBgsXG94UIAKdFmsWIupilB/4du
	i01yyGjPsxVK0a6JtjEvp8V6G8HJlLh3jQ5QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TzGeTErSqBMuezME+ki7BXtLeC+FIbP4
	HioalXdsnpifrY0+SpHcgs4qNrwi0RJ+VLv56VIAGWqdNKGzJwb+KlvhU0qr6Ru6
	wWxskN/9QIaJhE+snw99PdAccJD5l6giofbnw16SGxr5D74k/PX7eA1d6erFJTFE
	0YZ4oH++ST4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D6DC49F2A;
	Tue,  1 Mar 2016 18:36:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DF27649F29;
	Tue,  1 Mar 2016 18:36:27 -0500 (EST)
In-Reply-To: <xmqqvb556abd.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 01 Mar 2016 15:35:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B4C4594-E006-11E5-84FC-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288081>

This will be necessary when we start reading from a split bundle
where the header and the thin-pack data live in different files.

The in-core bundle header will read from a file that has the header,
and will record the path to that file.  We would find the name of
the file that hosts the thin-pack data from the header, and we would
take that name as relative to the file we read the header from.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/bundle.c |  5 +++--
 bundle.c         | 21 +++++++++++----------
 bundle.h         |  3 ++-
 transport.c      |  3 ++-
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 4883a43..e63388d 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -36,8 +36,9 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 	}
 
 	memset(&header, 0, sizeof(header));
-	if (strcmp(cmd, "create") && (bundle_fd =
-				read_bundle_header(bundle_file, &header)) < 0)
+	header.bundle_file = bundle_file;
+	if (strcmp(cmd, "create") &&
+	    (bundle_fd = read_bundle_header(&header)) < 0)
 		return 1;
 
 	if (!strcmp(cmd, "verify")) {
diff --git a/bundle.c b/bundle.c
index 9c5a6f0..efe19e0 100644
--- a/bundle.c
+++ b/bundle.c
@@ -21,8 +21,7 @@ static void add_to_ref_list(const unsigned char *sha1, const char *name,
 	list->nr++;
 }
 
-static int parse_bundle_header(int fd, struct bundle_header *header,
-			       const char *report_path)
+static int parse_bundle_header(int fd, struct bundle_header *header, int quiet)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int status = 0;
@@ -30,9 +29,9 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 	/* The bundle header begins with the signature */
 	if (strbuf_getwholeline_fd(&buf, fd, '\n') ||
 	    strcmp(buf.buf, bundle_signature)) {
-		if (report_path)
+		if (!quiet)
 			error(_("'%s' does not look like a v2 bundle file"),
-			      report_path);
+			      header->bundle_file);
 		status = -1;
 		goto abort;
 	}
@@ -57,7 +56,7 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 		if (get_sha1_hex(buf.buf, sha1) ||
 		    (buf.len > 40 && !isspace(buf.buf[40])) ||
 		    (!is_prereq && buf.len <= 40)) {
-			if (report_path)
+			if (!quiet)
 				error(_("unrecognized header: %s%s (%d)"),
 				      (is_prereq ? "-" : ""), buf.buf, (int)buf.len);
 			status = -1;
@@ -79,13 +78,13 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 	return fd;
 }
 
-int read_bundle_header(const char *path, struct bundle_header *header)
+int read_bundle_header(struct bundle_header *header)
 {
-	int fd = open(path, O_RDONLY);
+	int fd = open(header->bundle_file, O_RDONLY);
 
 	if (fd < 0)
-		return error(_("could not open '%s'"), path);
-	return parse_bundle_header(fd, header, path);
+		return error(_("could not open '%s'"), header->bundle_file);
+	return parse_bundle_header(fd, header, 0);
 }
 
 int is_bundle(const char *path, int quiet)
@@ -96,7 +95,7 @@ int is_bundle(const char *path, int quiet)
 	if (fd < 0)
 		return 0;
 	memset(&header, 0, sizeof(header));
-	fd = parse_bundle_header(fd, &header, quiet ? NULL : path);
+	fd = parse_bundle_header(fd, &header, quiet);
 	if (fd >= 0)
 		close(fd);
 	return (fd >= 0);
@@ -112,6 +111,8 @@ void release_bundle_header(struct bundle_header *header)
 	for (i = 0; i < header->references.nr; i++)
 		free(header->references.list[i].name);
 	free(header->references.list);
+
+	free((void *)header->bundle_file);
 }
 
 static int list_refs(struct ref_list *r, int argc, const char **argv)
diff --git a/bundle.h b/bundle.h
index f7ce23b..cf771df 100644
--- a/bundle.h
+++ b/bundle.h
@@ -10,12 +10,13 @@ struct ref_list {
 };
 
 struct bundle_header {
+	const char *bundle_file;
 	struct ref_list prerequisites;
 	struct ref_list references;
 };
 
 int is_bundle(const char *path, int quiet);
-int read_bundle_header(const char *path, struct bundle_header *header);
+int read_bundle_header(struct bundle_header *header);
 int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv);
 int verify_bundle(struct bundle_header *header, int verbose);
diff --git a/transport.c b/transport.c
index 08e15c5..03ce149 100644
--- a/transport.c
+++ b/transport.c
@@ -81,7 +81,8 @@ static struct ref *get_refs_from_bundle(struct transport *transport, int for_pus
 
 	if (data->fd > 0)
 		close(data->fd);
-	data->fd = read_bundle_header(transport->url, &data->header);
+	data->header.bundle_file = xstrdup(transport->url);
+	data->fd = read_bundle_header(&data->header);
 	if (data->fd < 0)
 		die ("Could not read bundle '%s'.", transport->url);
 	for (i = 0; i < data->header.references.nr; i++) {
-- 
2.8.0-rc0-114-g0b3e5e5
