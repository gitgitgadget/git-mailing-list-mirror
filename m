From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] diff-no-index: DWIM "diff D F" into "diff D/F F"
Date: Wed, 25 Mar 2015 23:20:31 -0700
Message-ID: <1427350832-17005-2-git-send-email-gitster@pobox.com>
References: <xmqqiodtd3b4.fsf@gitster.dls.corp.google.com>
 <1427350832-17005-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 07:20:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb19t-00054c-Pz
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 07:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbbCZGUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 02:20:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751334AbbCZGUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 02:20:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1480F3C8C8;
	Thu, 26 Mar 2015 02:20:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bkxu
	mBVBetciYs0FlsbfNjBmomg=; b=HQQqAQhSYTaSwxX0vCqR90ieY4AOW/YkGB1C
	NCChz1oz138arAupSvvNZeVc6kEcyhU0lN+KJRRyWy77Fnht3GnxoBV/IvErv8//
	tp2X7v20CQVeWfi0dYpt9qZJhB+GbR5qOv3jKPpfDIaX6onIBoO07JJTTV7/10V1
	6VuGMUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=daIRJ5
	/5PKN5X80vGySXnePwbevMhn58aHdSER5BzPxnBcoDZ4/pLj6H1cDNFPTuvRecPk
	xSTIIK2gqMEraQY+aZUkVlmmCubsE0qVBekkA5xbYBaVn2z1/ibhNT/Yo98xWdqI
	o+r1MV96a0QEuzeFYow1gG/RIzlocM62uDiY0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F35CE3C8C5;
	Thu, 26 Mar 2015 02:20:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 504AC3C8C3;
	Thu, 26 Mar 2015 02:20:36 -0400 (EDT)
X-Mailer: git-send-email 2.3.4-477-g2c00653
In-Reply-To: <1427350832-17005-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 37343A20-D380-11E4-B19B-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266317>

"git diff --no-index" was supposed to be a poor-man's approach to
allow using Git diff goodies outside of a Git repository, without
having to patch mainstream diff implementations.

Unlike a POSIX diff that treats "diff D F" (or "diff F D") as a
request to compare D/F and F (or F and D/F) when D is a directory
and F is a file, however, we did not accept such a command line and
instead barfed with "file/directory conflict".

Imitate what POSIX diff does and append the basename of the file
after the name of the directory before comparing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-no-index.c          | 43 +++++++++++++++++++++++++++++++++++++++++++
 t/t4053-diff-no-index.sh | 22 ++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/diff-no-index.c b/diff-no-index.c
index 265709b..49c4536 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -182,12 +182,50 @@ static int queue_diff(struct diff_options *o,
 	}
 }
 
+/* append basename of F to D */
+static void append_basename(struct strbuf *path, const char *dir, const char *file)
+{
+	const char *tail = strrchr(file, '/');
+
+	strbuf_addstr(path, dir);
+	while (path->len && path->buf[path->len - 1] == '/')
+		path->len--;
+	strbuf_addch(path, '/');
+	strbuf_addstr(path, tail ? tail + 1 : file);
+}
+
+/*
+ * DWIM "diff D F" into "diff D/F F" and "diff F D" into "diff F D/F"
+ * Note that we append the basename of F to D/, so "diff a/b/file D"
+ * becomes "diff a/b/file D/file", not "diff a/b/file D/a/b/file".
+ */
+static void fixup_paths(const char **path, struct strbuf *replacement)
+{
+	unsigned int isdir0, isdir1;
+
+	if (path[0] == file_from_standard_input ||
+	    path[1] == file_from_standard_input)
+		return;
+	isdir0 = is_directory(path[0]);
+	isdir1 = is_directory(path[1]);
+	if (isdir0 == isdir1)
+		return;
+	if (isdir0) {
+		append_basename(replacement, path[0], path[1]);
+		path[0] = replacement->buf;
+	} else {
+		append_basename(replacement, path[1], path[0]);
+		path[1] = replacement->buf;
+	}
+}
+
 void diff_no_index(struct rev_info *revs,
 		   int argc, const char **argv,
 		   const char *prefix)
 {
 	int i, prefixlen;
 	const char *paths[2];
+	struct strbuf replacement = STRBUF_INIT;
 
 	diff_setup(&revs->diffopt);
 	for (i = 1; i < argc - 2; ) {
@@ -217,6 +255,9 @@ void diff_no_index(struct rev_info *revs,
 			p = xstrdup(prefix_filename(prefix, prefixlen, p));
 		paths[i] = p;
 	}
+
+	fixup_paths(paths, &replacement);
+
 	revs->diffopt.skip_stat_unmatch = 1;
 	if (!revs->diffopt.output_format)
 		revs->diffopt.output_format = DIFF_FORMAT_PATCH;
@@ -235,6 +276,8 @@ void diff_no_index(struct rev_info *revs,
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 
+	strbuf_release(&replacement);
+
 	/*
 	 * The return code for --no-index imitates diff(1):
 	 * 0 = no changes, 1 = changes, else error
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 2ab3c48..01eca4c 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -55,4 +55,26 @@ test_expect_success 'git diff --no-index executed outside repo gives correct err
 	)
 '
 
+test_expect_success 'diff D F and diff F D' '
+	(
+		cd repo &&
+		echo in-repo >a &&
+		echo non-repo >../non/git/a &&
+		mkdir sub &&
+		echo sub-repo >sub/a &&
+
+		test_must_fail git diff --no-index sub/a ../non/git/a >expect &&
+		test_must_fail git diff --no-index sub/a ../non/git/ >actual &&
+		test_cmp expect actual &&
+
+		test_must_fail git diff --no-index a ../non/git/a >expect &&
+		test_must_fail git diff --no-index a ../non/git/ >actual &&
+		test_cmp expect actual &&
+
+		test_must_fail git diff --no-index ../non/git/a a >expect &&
+		test_must_fail git diff --no-index ../non/git a >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.3.4-475-g3180e2e
