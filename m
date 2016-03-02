From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] bundle v3: the beginning
Date: Wed,  2 Mar 2016 12:32:41 -0800
Message-ID: <1456950761-19759-5-git-send-email-gitster@pobox.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
 <1456950761-19759-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 21:33:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abDS8-00070y-FG
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 21:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbcCBUcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 15:32:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756059AbcCBUcv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 15:32:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 64F3448088;
	Wed,  2 Mar 2016 15:32:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xIvC
	niUJMxwXzBI0li+Pqa+dyc8=; b=ubNuSOWUkRH0bErNAfLUgZhtPXhl5qriKEAb
	II1scdlETSZjIsVnKNg8KJ3aJEDBBSnUvTXwxS56MyHd47fhYen3eS3V2R25Wf+b
	QClSK1YpDj1fHm7YSHTb72ADGDlsoMSLKd1jWjOyPObowyRmBGbhW2mSaSv/nD8V
	4AQWd/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=aWi5VU
	9KLTTRlAQBoamAbuMXDG8IZKqgR+GUP8YQIB1viZLNoWVhew+LAY22kub3c8u7df
	LgABKdaNjXP9D6/2me2EVA6f1v5hAm3Ldox3Rlwvm2Sj1ZFpS872RyeNlxLe8rDX
	lYaSp7V+4w14EofFhjABPMkj3p7DF0XgYD2/I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D6B148087;
	Wed,  2 Mar 2016 15:32:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BAFCC48086;
	Wed,  2 Mar 2016 15:32:49 -0500 (EST)
X-Mailer: git-send-email 2.8.0-rc0-114-g0b3e5e5
In-Reply-To: <1456950761-19759-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EE625DEC-E0B5-11E5-8A70-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288151>

The bundle v3 format introduces an ability to have the bundle header
(which describes what references in the bundled history can be
fetched, and what objects the receiving repository must have in
order to unbundle it successfully) in one file, and the bundled pack
stream data in a separate file.

A v3 bundle file begins with a line with "# v3 git bundle", followed
by zero or more "extended header" lines, and an empty line, finally
followed by the list of prerequisites and references in the same
format as v2 bundle.  If it uses the "split bundle" feature, there
is a "data: $URL" extended header line, and nothing follows the list
of prerequisites and references.  Also, "sha1: " extended header
line may exist to help validating that the pack stream data matches
the bundle header.

A typical expected use of a split bundle is to help initial clone
that involves a huge data transfer, and would go like this:

 - Any repository people would clone and fetch from would regularly
   be repacked, and it is expected that there would be a packfile
   without prerequisites that holds all (or at least most) of the
   history of it (call it pack-$name.pack).

 - After arranging that packfile to be downloadable over popular
   transfer methods used for serving static files (such as HTTP or
   HTTPS) that are easily resumable as $URL/pack-$name.pack, a v3
   bundle file (call it $name.bndl) can be prepared with an extended
   header "data: $URL/pack-$name.pack" to point at the download
   location for the packfile, and be served at "$URL/$name.bndl".

 - An updated Git client, when trying to "git clone" from such a
   repository, may be redirected to $URL/$name.bndl", which would be
   a tiny text file (when split bundle feature is used).

 - The client would then inspect the downloaded $name.bndl, learn
   that the corresponding packfile exists at $URL/pack-$name.pack,
   and downloads it as pack-$name.pack, until the download succeeds.
   This can easily be done with "wget --continue" equivalent over an
   unreliable link.  The checksum recorded on the "sha1: " header
   line is expected to be used by this downloader (not written yet).

 - After fully downloading $name.bndl and pack-$name.pack and
   storing them next to each other, the client would clone from the
   $name.bndl; this would populate the newly created repository with
   reasonably recent history.

 - Then the client can issue "git fetch" against the original
   repository to obtain the most recent part of the history created
   since the bundle was made.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bundle.c          | 103 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 bundle.h          |   3 ++
 t/t5704-bundle.sh |  64 +++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 9 deletions(-)

diff --git a/bundle.c b/bundle.c
index 32bdb01..480630d 100644
--- a/bundle.c
+++ b/bundle.c
@@ -10,7 +10,8 @@
 #include "refs.h"
 #include "argv-array.h"
 
-static const char bundle_signature[] = "# v2 git bundle\n";
+static const char bundle_signature_v2[] = "# v2 git bundle\n";
+static const char bundle_signature_v3[] = "# v3 git bundle\n";
 
 static void add_to_ref_list(const unsigned char *sha1, const char *name,
 		struct ref_list *list)
@@ -33,16 +34,55 @@ static int parse_bundle_header(int fd, struct bundle_header *header, int quiet)
 	int status = 0;
 
 	/* The bundle header begins with the signature */
-	if (strbuf_getwholeline_fd(&buf, fd, '\n') ||
-	    strcmp(buf.buf, bundle_signature)) {
+	if (strbuf_getwholeline_fd(&buf, fd, '\n')) {
+	bad_bundle:
 		if (!quiet)
-			error(_("'%s' does not look like a v2 bundle file"),
+			error(_("'%s' does not look like a supported bundle file"),
 			      header->filename);
 		status = -1;
 		goto abort;
 	}
 
-	/* The bundle header ends with an empty line */
+	if (!strcmp(buf.buf, bundle_signature_v2))
+		header->bundle_version = 2;
+	else if (!strcmp(buf.buf, bundle_signature_v3))
+		header->bundle_version = 3;
+	else
+		goto bad_bundle;
+
+	if (header->bundle_version == 3) {
+		/*
+		 * bundle version v3 has extended headers before the
+		 * list of prerequisites and references.  The extended
+		 * headers end with an empty line.
+		 */
+		while (!strbuf_getwholeline_fd(&buf, fd, '\n')) {
+			const char *cp;
+			if (buf.len && buf.buf[buf.len - 1] == '\n')
+				buf.buf[--buf.len] = '\0';
+			if (!buf.len)
+				break;
+			if (skip_prefix(buf.buf, "data: ", &cp)) {
+				header->datafile = xstrdup(cp);
+				continue;
+			}
+			if (skip_prefix(buf.buf, "sha1: ", &cp)) {
+				unsigned char sha1[GIT_SHA1_RAWSZ];
+				if (get_sha1_hex(cp, sha1) ||
+				    cp[GIT_SHA1_HEXSZ])
+					goto bad_bundle;
+				hashcpy(header->csum, sha1);
+				continue;
+			}
+
+			goto bad_bundle;
+		}
+	}
+
+	/*
+	 * The bundle header lists prerequisites and
+	 * references, and the list ends with an empty line.
+	 */
 	while (!strbuf_getwholeline_fd(&buf, fd, '\n') &&
 	       buf.len && buf.buf[0] != '\n') {
 		unsigned char sha1[20];
@@ -77,7 +117,8 @@ static int parse_bundle_header(int fd, struct bundle_header *header, int quiet)
 
  abort:
 	if (status) {
-		close(fd);
+		if (0 <= fd)
+			close(fd);
 		fd = -1;
 	}
 	strbuf_release(&buf);
@@ -426,6 +467,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	int bundle_to_stdout;
 	int ref_count = 0;
 	struct rev_info revs;
+	const char *bundle_signature = bundle_signature_v2;
 
 	bundle_to_stdout = !strcmp(path, "-");
 	if (bundle_to_stdout)
@@ -480,22 +522,65 @@ int create_bundle(struct bundle_header *header, const char *path,
 	return 0;
 }
 
+/*
+ * v3 "split bundle" allows a separate packfile to be named
+ * as "data: $URL/$name_of_the_packfile".  This file is expected
+ * to be downloaded next to the bundle header file when the
+ * bundle is used.  Hence we find the path to the directory
+ * that contains the bundle header file, and append the basename
+ * part of the bundle_data_file to it, to form the name of the
+ * file that holds the pack data stream.
+ */
+static int open_bundle_data(struct bundle_header *header)
+{
+	const char *cp;
+	struct strbuf filename = STRBUF_INIT;
+	int fd;
+
+	assert(header->datafile);
+
+	cp = find_last_dir_sep(header->filename);
+	if (cp)
+		strbuf_add(&filename, header->filename,
+			   (cp - header->filename) + 1);
+	cp = find_last_dir_sep(header->datafile);
+	if (!cp)
+		cp = header->datafile;
+	strbuf_addstr(&filename, cp);
+
+	fd = open(filename.buf, O_RDONLY);
+	strbuf_release(&filename);
+	return fd;
+}
+
 int unbundle(struct bundle_header *header, int bundle_fd, int flags)
 {
 	const char *argv_index_pack[] = {"index-pack",
 					 "--fix-thin", "--stdin", NULL, NULL};
 	struct child_process ip = CHILD_PROCESS_INIT;
+	int status = 0, data_fd = -1;
 
 	if (flags & BUNDLE_VERBOSE)
 		argv_index_pack[3] = "-v";
 
 	if (verify_bundle(header, 0))
 		return -1;
+
+	if (header->datafile) {
+		data_fd = open_bundle_data(header);
+		if (data_fd < 0)
+			return error(_("bundle data not found"));
+		ip.in = data_fd;
+	} else {
+		ip.in = bundle_fd;
+	}
+
 	ip.argv = argv_index_pack;
-	ip.in = bundle_fd;
 	ip.no_stdout = 1;
 	ip.git_cmd = 1;
 	if (run_command(&ip))
-		return error(_("index-pack died"));
-	return 0;
+		status = error(_("index-pack died"));
+	if (0 <= data_fd)
+		close(data_fd);
+	return status;
 }
diff --git a/bundle.h b/bundle.h
index e059ccf..db55dc7 100644
--- a/bundle.h
+++ b/bundle.h
@@ -10,7 +10,10 @@ struct ref_list {
 };
 
 struct bundle_header {
+	int bundle_version;
 	const char *filename;
+	const char *datafile;
+	unsigned char csum[GIT_SHA1_RAWSZ];
 	struct ref_list prerequisites;
 	struct ref_list references;
 };
diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index 348d9b3..e68523c 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -71,4 +71,68 @@ test_expect_success 'prerequisites with an empty commit message' '
 	git bundle verify bundle
 '
 
+# bundle v3 (experimental)
+test_expect_success 'clone from v3' '
+
+	# as "bundle create" does not exist yet for v3
+	# prepare it by hand here
+	head=$(git rev-parse HEAD) &&
+	name=$(echo $head | git pack-objects --revs v3) &&
+	test_when_finished "rm v3-$name.pack v3-$name.idx" &&
+	cat >v3.bndl <<-EOF &&
+	# v3 git bundle
+	data: v3-$name.pack
+
+	$head HEAD
+	$head refs/heads/master
+	EOF
+
+	git bundle verify v3.bndl &&
+	git bundle list-heads v3.bndl >actual &&
+	cat >expect <<-EOF &&
+	$head HEAD
+	$head refs/heads/master
+	EOF
+	test_cmp expect actual &&
+
+	git clone v3.bndl v3dst &&
+	git -C v3dst for-each-ref --format="%(objectname) %(refname)" >actual &&
+	cat >expect <<-EOF &&
+	$head refs/heads/master
+	$head refs/remotes/origin/HEAD
+	$head refs/remotes/origin/master
+	EOF
+	test_cmp expect actual &&
+	git -C v3dst fsck &&
+
+	# an "inline" v3 is still possible.
+	cat >v3i.bndl <<-EOF &&
+	# v3 git bundle
+
+	$head HEAD
+	$head refs/heads/master
+
+	EOF
+	cat v3-$name.pack >>v3i.bndl &&
+	test_when_finished "rm v3i.bndl" &&
+
+	git bundle verify v3i.bndl &&
+	git bundle list-heads v3i.bndl >actual &&
+	cat >expect <<-EOF &&
+	$head HEAD
+	$head refs/heads/master
+	EOF
+	test_cmp expect actual &&
+
+	git clone v3i.bndl v3idst &&
+	git -C v3idst for-each-ref --format="%(objectname) %(refname)" >actual &&
+	cat >expect <<-EOF &&
+	$head refs/heads/master
+	$head refs/remotes/origin/HEAD
+	$head refs/remotes/origin/master
+	EOF
+	test_cmp expect actual &&
+	git -C v3idst fsck
+'
+
 test_done
-- 
2.8.0-rc0-114-g0b3e5e5
