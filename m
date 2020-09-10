Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9270DC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7BB20719
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CMmj5q1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgIJRDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:03:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58819 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgIJRCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:02:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 369E3FEEC6;
        Thu, 10 Sep 2020 13:02:09 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=uPojmkT63GDILw3NFaTePXV+m
        CY=; b=CMmj5q1E08iV+CKzan5+3hhmwIpCcfQe+VcsFxHdXqSSu9PuzcvbQHwea
        itac8E9TXYs6uFVgwhBXCUMVEy0X+Qcr6FgtOVbYFWMNltPkr5aR26hCsBNKhGY2
        Tlu38mm+4WcXUmN/TMK7i+sjhJANDYCubOa/YNHP/LqWMj3N4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=jQcKhCaWb5qUxz8tyRC
        fEs3Sdl5KjS42LRp3lAmbQM55gwYIlyVUnHb6HrzS63y3N2zzTewh+xyOF+xE2kF
        YotU/Ivqkn5aaLUTiWY8eaJ16QcV8o6XyWTKoewjnsHB5HSdeADmu9ozigVDWVBx
        dYuRXS9ZpqyKnN4cvdb23+BU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E76BFEEC5;
        Thu, 10 Sep 2020 13:02:09 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6BFC2FEEC2;
        Thu, 10 Sep 2020 13:02:06 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/7] quote_path: give flags parameter to quote_path()
Date:   Thu, 10 Sep 2020 10:01:54 -0700
Message-Id: <20200910170159.1278781-3-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-603-ga98dad7d4d
In-Reply-To: <20200910170159.1278781-1-gitster@pobox.com>
References: <20200908205224.4126551-1-gitster@pobox.com>
 <20200910170159.1278781-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 5B3523BC-F387-11EA-90F7-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The quote_path() function computes a path (relative to its base
directory) and c-quotes the result if necessary.  Teach it to take a
flags parameter to allow its behaviour to be enriched later.

No behaviour change intended.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 22 +++++++++++-----------
 builtin/grep.c  |  2 +-
 quote.c         |  2 +-
 quote.h         |  2 +-
 wt-status.c     | 24 ++++++++++++------------
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index dee44fff6e..687ab473c2 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -162,7 +162,7 @@ static int remove_dirs(struct strbuf *path, const cha=
r *prefix, int force_flag,
 	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
 	    is_nonbare_repository_dir(path)) {
 		if (!quiet) {
-			quote_path(path->buf, prefix, &quoted);
+			quote_path(path->buf, prefix, &quoted, 0);
 			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
 					quoted.buf);
 		}
@@ -177,7 +177,7 @@ static int remove_dirs(struct strbuf *path, const cha=
r *prefix, int force_flag,
 		res =3D dry_run ? 0 : rmdir(path->buf);
 		if (res) {
 			int saved_errno =3D errno;
-			quote_path(path->buf, prefix, &quoted);
+			quote_path(path->buf, prefix, &quoted, 0);
 			errno =3D saved_errno;
 			warning_errno(_(msg_warn_remove_failed), quoted.buf);
 			*dir_gone =3D 0;
@@ -202,7 +202,7 @@ static int remove_dirs(struct strbuf *path, const cha=
r *prefix, int force_flag,
 			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
 				ret =3D 1;
 			if (gone) {
-				quote_path(path->buf, prefix, &quoted);
+				quote_path(path->buf, prefix, &quoted, 0);
 				string_list_append(&dels, quoted.buf);
 			} else
 				*dir_gone =3D 0;
@@ -210,11 +210,11 @@ static int remove_dirs(struct strbuf *path, const c=
har *prefix, int force_flag,
 		} else {
 			res =3D dry_run ? 0 : unlink(path->buf);
 			if (!res) {
-				quote_path(path->buf, prefix, &quoted);
+				quote_path(path->buf, prefix, &quoted, 0);
 				string_list_append(&dels, quoted.buf);
 			} else {
 				int saved_errno =3D errno;
-				quote_path(path->buf, prefix, &quoted);
+				quote_path(path->buf, prefix, &quoted, 0);
 				errno =3D saved_errno;
 				warning_errno(_(msg_warn_remove_failed), quoted.buf);
 				*dir_gone =3D 0;
@@ -238,7 +238,7 @@ static int remove_dirs(struct strbuf *path, const cha=
r *prefix, int force_flag,
 			*dir_gone =3D 1;
 		else {
 			int saved_errno =3D errno;
-			quote_path(path->buf, prefix, &quoted);
+			quote_path(path->buf, prefix, &quoted, 0);
 			errno =3D saved_errno;
 			warning_errno(_(msg_warn_remove_failed), quoted.buf);
 			*dir_gone =3D 0;
@@ -266,7 +266,7 @@ static void pretty_print_dels(void)
 	struct column_options copts;
=20
 	for_each_string_list_item(item, &del_list) {
-		qname =3D quote_path(item->string, NULL, &buf);
+		qname =3D quote_path(item->string, NULL, &buf, 0);
 		string_list_append(&list, qname);
 	}
=20
@@ -753,7 +753,7 @@ static int ask_each_cmd(void)
 	for_each_string_list_item(item, &del_list) {
 		/* Ctrl-D should stop removing files */
 		if (!eof) {
-			qname =3D quote_path(item->string, NULL, &buf);
+			qname =3D quote_path(item->string, NULL, &buf, 0);
 			/* TRANSLATORS: Make sure to keep [y/N] as is */
 			printf(_("Remove %s [y/N]? "), qname);
 			if (git_read_line_interactively(&confirm) =3D=3D EOF) {
@@ -1047,19 +1047,19 @@ int cmd_clean(int argc, const char **argv, const =
char *prefix)
 			if (remove_dirs(&abs_path, prefix, rm_flags, dry_run, quiet, &gone))
 				errors++;
 			if (gone && !quiet) {
-				qname =3D quote_path(item->string, NULL, &buf);
+				qname =3D quote_path(item->string, NULL, &buf, 0);
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		} else {
 			res =3D dry_run ? 0 : unlink(abs_path.buf);
 			if (res) {
 				int saved_errno =3D errno;
-				qname =3D quote_path(item->string, NULL, &buf);
+				qname =3D quote_path(item->string, NULL, &buf, 0);
 				errno =3D saved_errno;
 				warning_errno(_(msg_warn_remove_failed), qname);
 				errors++;
 			} else if (!quiet) {
-				qname =3D quote_path(item->string, NULL, &buf);
+				qname =3D quote_path(item->string, NULL, &buf, 0);
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		}
diff --git a/builtin/grep.c b/builtin/grep.c
index 9a91ad643a..c8037388c6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -319,7 +319,7 @@ static void grep_source_name(struct grep_opt *opt, co=
nst char *filename,
 	}
=20
 	if (opt->relative && opt->prefix_length)
-		quote_path(filename + tree_name_len, opt->prefix, out);
+		quote_path(filename + tree_name_len, opt->prefix, out, 0);
 	else
 		quote_c_style(filename + tree_name_len, out, NULL, 0);
=20
diff --git a/quote.c b/quote.c
index 7bb519c1a7..a86f9f22a2 100644
--- a/quote.c
+++ b/quote.c
@@ -352,7 +352,7 @@ void write_name_quoted_relative(const char *name, con=
st char *prefix,
 }
=20
 /* quote path as relative to the given prefix */
-char *quote_path(const char *in, const char *prefix, struct strbuf *out)
+char *quote_path(const char *in, const char *prefix, struct strbuf *out,=
 unsigned flags)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *rel =3D relative_path(in, prefix, &sb);
diff --git a/quote.h b/quote.h
index 837cb42a71..4687b5daf4 100644
--- a/quote.h
+++ b/quote.h
@@ -72,7 +72,7 @@ void write_name_quoted_relative(const char *name, const=
 char *prefix,
 				FILE *fp, int terminator);
=20
 /* quote path as relative to the given prefix */
-char *quote_path(const char *in, const char *prefix, struct strbuf *out)=
;
+char *quote_path(const char *in, const char *prefix, struct strbuf *out,=
 unsigned flags);
=20
 /* quoting as a string literal for other languages */
 void perl_quote_buf(struct strbuf *sb, const char *src);
diff --git a/wt-status.c b/wt-status.c
index 6b87592856..d6ca7bd52c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -336,7 +336,7 @@ static void wt_longstatus_print_unmerged_data(struct =
wt_status *s,
 		memset(padding, ' ', label_width);
 	}
=20
-	one =3D quote_path(it->string, s->prefix, &onebuf);
+	one =3D quote_path(it->string, s->prefix, &onebuf, 0);
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
=20
 	how =3D wt_status_unmerged_status_string(d->stagemask);
@@ -402,8 +402,8 @@ static void wt_longstatus_print_change_data(struct wt=
_status *s,
 	if (d->rename_status =3D=3D status)
 		one_name =3D d->rename_source;
=20
-	one =3D quote_path(one_name, s->prefix, &onebuf);
-	two =3D quote_path(two_name, s->prefix, &twobuf);
+	one =3D quote_path(one_name, s->prefix, &onebuf, 0);
+	two =3D quote_path(two_name, s->prefix, &twobuf, 0);
=20
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	what =3D wt_status_diff_status_string(status);
@@ -964,7 +964,7 @@ static void wt_longstatus_print_other(struct wt_statu=
s *s,
 		struct string_list_item *it;
 		const char *path;
 		it =3D &(l->items[i]);
-		path =3D quote_path(it->string, s->prefix, &buf);
+		path =3D quote_path(it->string, s->prefix, &buf, 0);
 		if (column_active(s->colopts)) {
 			string_list_append(&output, path);
 			continue;
@@ -1848,7 +1848,7 @@ static void wt_shortstatus_unmerged(struct string_l=
ist_item *it,
 	} else {
 		struct strbuf onebuf =3D STRBUF_INIT;
 		const char *one;
-		one =3D quote_path(it->string, s->prefix, &onebuf);
+		one =3D quote_path(it->string, s->prefix, &onebuf, 0);
 		printf(" %s\n", one);
 		strbuf_release(&onebuf);
 	}
@@ -1877,7 +1877,7 @@ static void wt_shortstatus_status(struct string_lis=
t_item *it,
 		const char *one;
=20
 		if (d->rename_source) {
-			one =3D quote_path(d->rename_source, s->prefix, &onebuf);
+			one =3D quote_path(d->rename_source, s->prefix, &onebuf, 0);
 			if (*one !=3D '"' && strchr(one, ' ') !=3D NULL) {
 				putchar('"');
 				strbuf_addch(&onebuf, '"');
@@ -1886,7 +1886,7 @@ static void wt_shortstatus_status(struct string_lis=
t_item *it,
 			printf("%s -> ", one);
 			strbuf_release(&onebuf);
 		}
-		one =3D quote_path(it->string, s->prefix, &onebuf);
+		one =3D quote_path(it->string, s->prefix, &onebuf, 0);
 		if (*one !=3D '"' && strchr(one, ' ') !=3D NULL) {
 			putchar('"');
 			strbuf_addch(&onebuf, '"');
@@ -1905,7 +1905,7 @@ static void wt_shortstatus_other(struct string_list=
_item *it,
 	} else {
 		struct strbuf onebuf =3D STRBUF_INIT;
 		const char *one;
-		one =3D quote_path(it->string, s->prefix, &onebuf);
+		one =3D quote_path(it->string, s->prefix, &onebuf, 0);
 		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
 		printf(" %s\n", one);
 		strbuf_release(&onebuf);
@@ -2222,9 +2222,9 @@ static void wt_porcelain_v2_print_changed_entry(
 		 */
 		sep_char =3D '\t';
 		eol_char =3D '\n';
-		path =3D quote_path(it->string, s->prefix, &buf);
+		path =3D quote_path(it->string, s->prefix, &buf, 0);
 		if (d->rename_source)
-			path_from =3D quote_path(d->rename_source, s->prefix, &buf_from);
+			path_from =3D quote_path(d->rename_source, s->prefix, &buf_from, 0);
 	}
=20
 	if (path_from)
@@ -2310,7 +2310,7 @@ static void wt_porcelain_v2_print_unmerged_entry(
 	if (s->null_termination)
 		path_index =3D it->string;
 	else
-		path_index =3D quote_path(it->string, s->prefix, &buf_index);
+		path_index =3D quote_path(it->string, s->prefix, &buf_index, 0);
=20
 	fprintf(s->fp, "%c %s %s %06o %06o %06o %06o %s %s %s %s%c",
 			unmerged_prefix, key, submodule_token,
@@ -2343,7 +2343,7 @@ static void wt_porcelain_v2_print_other(
 		path =3D it->string;
 		eol_char =3D '\0';
 	} else {
-		path =3D quote_path(it->string, s->prefix, &buf);
+		path =3D quote_path(it->string, s->prefix, &buf, 0);
 		eol_char =3D '\n';
 	}
=20
--=20
2.28.0-603-ga98dad7d4d

