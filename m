Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 3745 invoked by uid 107); 18 Feb 2010 19:36:58 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Thu, 18 Feb 2010 14:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758272Ab0BRTgh (ORCPT <rfc822;peff@peff.net>);
	Thu, 18 Feb 2010 14:36:37 -0500
Received: from gv-out-0910.google.com ([216.239.58.190]:52037 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758055Ab0BRTgf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 14:36:35 -0500
Received: by gv-out-0910.google.com with SMTP id y18so281206gvf.37
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 11:36:33 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=x3U11Bkj51dmtubSVM7V/a5NQZsGq2zsKk0y4rRl5gk=;
        b=iGlUqaAtmgMG3wVC1wDjccqclofiBrwwAVeLlGhUIB+HxJ3M9bmQHePCJqcX16MOge
         sw8/uDGXf540E+g79NrkT9bfFkHzw4VdLjL5MyBKp+xgkTLTtC6n1ORRRLXb+3BDXfb1
         xme8AnE8SOLgtJAULezSDvhVwtFaF9N4DuV/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=s+CbmCIvegHeFL1AcT7AlS+JrdkPdcmwqIBL7Wu1RHXu1pSB2QRReONe8m7XKSBWyq
         REHhA4bfbDCkB/7v+3MqZqYVmi1D2wXk9G1faxp2CipMYWM2i9WivuY6aV6fjPc2B6z9
         Rv51ChLIFj57bojdvqh/eHBSoCZLMi7EmKvN4=
Received: by 10.87.21.22 with SMTP id y22mr15565671fgi.52.1266521792551;
        Thu, 18 Feb 2010 11:36:32 -0800 (PST)
Received: from localhost (drsd-4db3f587.pool.mediaWays.net [77.179.245.135])
        by mx.google.com with ESMTPS id 3sm16878991fge.6.2010.02.18.11.36.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 11:36:32 -0800 (PST)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC] (reverse) combined diff conflict style
Date:	Thu, 18 Feb 2010 20:36:29 +0100
Message-Id: <1266521789-3617-1-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.6.6.420.ga81b8
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi All,

as I mentioned in my reply[1] to Junio about a reversed combined diff, I've
done this with the intended use case to display merge conflicts this way.

The algorithm is pretty much the same as the diff --cc/-c one and most of the
code too. I have currently too proof-of-concept tools for this:

 * git cdiff <base> <targets>..
   This command takes files as parameters and generates a combined diff from
   the <base> to all <targets>. No hunking is done.

 * git cdiff-conflict-filter
   This filters it input stream and looks for merge conflict markers and
   replaces the conflict with the output of the cdiff. It needs the diff3
   conflict style for this. Here is a simple example:

----- input -----

1
<<<<<<<
2
|||||||
2
3
=======
3
>>>>>>>
4

----- output ----

1
<<<<<<<
 -2
- 3
>>>>>>>
4

------ end ------

As you can see, the conflict region is way smaller as the diff3 one, but keeps
all information.

I'm not doing much merges myself, so there are probably people out there who
can better judge the usefulness of this style.

Bert

[1]: http://article.gmane.org/gmane.comp.version-control.git/138108

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 .gitignore      |    2 +
 Makefile        |    2 +
 builtin-cdiff.c |  387 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h       |    2 +
 git.c           |    2 +
 5 files changed, 395 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 8df8f88..ce685ce 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,6 +17,8 @@
 /git-branch
 /git-bundle
 /git-cat-file
+/git-cdiff
+/git-cdiff-conflict-filter
 /git-check-attr
 /git-check-ref-format
 /git-checkout
diff --git a/Makefile b/Makefile
index 7bf2fca..cd5df9e 100644
--- a/Makefile
+++ b/Makefile
@@ -384,6 +384,7 @@ BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-whatchanged$X
+BUILT_INS += git-cdiff-conflict-filter$X
 
 # what 'all' will build and 'install' will install in gitexecdir,
 # excluding programs for built-in commands
@@ -681,6 +682,7 @@ BUILTIN_OBJS += builtin-var.o
 BUILTIN_OBJS += builtin-verify-pack.o
 BUILTIN_OBJS += builtin-verify-tag.o
 BUILTIN_OBJS += builtin-write-tree.o
+BUILTIN_OBJS += builtin-cdiff.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
diff --git a/builtin-cdiff.c b/builtin-cdiff.c
new file mode 100644
index 0000000..950065a
--- /dev/null
+++ b/builtin-cdiff.c
@@ -0,0 +1,387 @@
+#include "cache.h"
+#include "builtin.h"
+#include "xdiff-interface.h"
+#include "strbuf.h"
+
+/* new line in target */
+struct nline {
+	struct nline *next;
+	int len;
+	unsigned long targets_map;
+	char line[FLEX_ARRAY];
+};
+
+/* Origin lines */
+struct oline {
+	struct nline *new_head, **new_tail;
+	char *bol; /* buffer of line */
+	int len;
+	/* bit 0 up to (N-1) are on if the target has not this line (i.e.
+	 * it will be removed).
+	 */
+	unsigned long targets_map;
+	/* unsigned long *p_lno; */ /* ?parent line number */
+};
+
+struct combine_diff_state {
+	unsigned long lno;
+	/* int num_parent; */
+	int n;
+	struct oline *oline;
+};
+
+static void append_new(struct oline *oline, int n, const char *line, int len)
+{
+	struct nline *nline;
+	unsigned long this_mask = (1UL<<n);
+	if (line[len-1] == '\n')
+		len--;
+
+	nline = xmalloc(sizeof(*nline) + len + 1);
+	nline->len = len;
+	nline->next = NULL;
+	nline->targets_map = this_mask;
+	memcpy(nline->line, line, len);
+	nline->line[len] = 0;
+	*oline->new_tail = nline;
+	oline->new_tail = &nline->next;
+}
+
+static void consume_line(void *state_, char *line, unsigned long len)
+{
+	struct combine_diff_state *state = state_;
+
+	if (5 < len && !memcmp("@@ -", line, 4)) {
+		int ob, on, nb, nn;
+		if (parse_hunk_header(line, len, &ob, &on, &nb, &nn))
+			return;
+		if (!on)
+			state->lno = ob;
+		else
+			state->lno = ob - !!ob;
+		return;
+	}
+	switch (line[0]) {
+	case '-':
+		state->oline[++state->lno].targets_map |= (1lu << state->n);
+		break;
+	case '+':
+		append_new(&state->oline[state->lno], state->n, line+1, len-1);
+		break;
+	}
+}
+
+static void build_oline(mmfile_t *origin_file, struct oline **oline_p,
+		unsigned long *cnt_p)
+{
+	struct oline *oline;
+	unsigned long cnt, lno, origin_size;
+	char *origin, *cp;
+
+	origin      = origin_file->ptr;
+	origin_size = origin_file->size;
+
+	for (cnt = 0, cp = origin; cp < origin + origin_size; cp++) {
+		if (*cp == '\n')
+			cnt++;
+	}
+	if (origin_size && origin[origin_size-1] != '\n')
+		cnt++; /* incomplete line */
+
+	oline = xcalloc(cnt+1, sizeof(*oline));
+	*oline_p = oline;
+	*cnt_p = cnt;
+
+	for (lno = 0; lno <= cnt; lno++) {
+		oline[lno].new_tail = &oline[lno].new_head;
+		oline[lno].targets_map = 0;
+	}
+
+	if (!origin_size)
+		return;
+
+	oline[1].bol = origin;
+	for (lno = 1, cp = origin; cp < origin + origin_size; cp++) {
+		if (*cp == '\n') {
+			oline[lno].len = cp - oline[lno].bol;
+			lno++;
+			if (lno <= cnt)
+				oline[lno].bol = cp + 1;
+		}
+	}
+	if (origin_size && origin[origin_size-1] != '\n')
+		oline[cnt].len = origin_size - (oline[cnt].bol - origin);
+
+}
+
+static void dump_oline(const struct oline *oline, unsigned long cnt,
+		int num_targets)
+{
+	unsigned long lno;
+	int i;
+	struct nline *nline;
+
+	for (lno = 0; lno <= cnt; lno++) {
+		if (1 <= lno) {
+			for (i = 0; i < num_targets; i++)
+				if (oline[lno].targets_map & (1lu << i))
+					putchar('-');
+				else
+					putchar(' ');
+			printf("%.*s\n", (int)oline[lno].len, oline[lno].bol);
+		}
+
+		nline = oline[lno].new_head;
+		while (nline) {
+			for (i = 0; i < num_targets; i++)
+				if (nline->targets_map & (1lu << i))
+					putchar('+');
+				else
+					putchar(' ');
+			printf("%s\n", nline->line);
+
+			nline = nline->next;
+		}
+	}
+}
+
+static void free_oline(struct oline *oline, unsigned long cnt)
+{
+	unsigned long lno;
+
+	for (lno = 0; lno <= cnt; lno++) {
+		while (oline[lno].new_head) {
+			struct nline *nline = oline[lno].new_head;
+			oline[lno].new_head = nline->next;
+			free(nline);
+		}
+	}
+	free(oline);
+}
+
+static void do_cdiff_step(struct oline *oline, mmfile_t *origin_file,
+		mmfile_t *target_file, int i)
+{
+	xdemitconf_t xecfg;
+	xdemitcb_t ecb;
+	xpparam_t xpp;
+	struct combine_diff_state state;
+
+	memset(&state, 0, sizeof(state));
+	state.oline = oline;
+	state.lno = 1;
+	state.n = i;
+
+	memset(&xpp, 0, sizeof(xpp));
+	xpp.flags = XDF_NEED_MINIMAL;
+	memset(&xecfg, 0, sizeof(xecfg));
+	memset(&ecb, 0, sizeof(ecb));
+
+	xdi_diff_outf(origin_file, target_file, consume_line, &state,
+			&xpp, &xecfg, &ecb);
+}
+
+static void do_path_cdiff(const char *origin_name, const char **target_names,
+		int num_targets)
+{
+	mmfile_t origin_file, target_file;
+	struct oline *oline = NULL; /* origin lines */
+	unsigned long cnt;
+	int i;
+
+	if (num_targets > (sizeof(unsigned long) * 8))
+		die("Can only handle %zu targets.", (sizeof(unsigned long) * 8));
+
+	if (read_mmfile(&origin_file, origin_name))
+		die_errno("can't read `%s'", origin_name);
+
+	/* build origin image */
+	build_oline(&origin_file, &oline, &cnt);
+
+	for (i = 0; i < num_targets; i++) {
+
+		if (read_mmfile(&target_file, target_names[i]))
+			die_errno("can't read `%s'", target_names[i]);
+
+		do_cdiff_step(oline, &origin_file, &target_file, i);
+
+		free(target_file.ptr);
+	}
+	dump_oline(oline, cnt, num_targets);
+
+	free_oline(oline, cnt);
+
+	free(origin_file.ptr);
+}
+
+static unsigned long put_line(char *dest, char *line, unsigned long len,
+		unsigned long map, int marker, int num_targets)
+{
+	int i;
+
+	for (i = 0; i < num_targets; i++)
+		if (map & (1lu << i))
+			*dest++ = marker;
+		else
+			*dest++ = ' ';
+	memcpy(dest, line, len);
+	dest[len] = '\n';
+
+	return len + num_targets + 1;
+}
+
+static unsigned long oline_to_buf(const struct oline *oline, unsigned long cnt,
+		int num_targets, char *dest)
+{
+	unsigned long lno;
+	struct nline *nline;
+	unsigned long size = 0;
+
+	for (lno = 0; lno <= cnt; lno++) {
+		if (1 <= lno) {
+			if (!dest) {
+				size += num_targets + oline[lno].len + 1;
+			} else {
+				size += put_line(dest + size, oline[lno].bol,
+						oline[lno].len,
+						oline[lno].targets_map, '-',
+						num_targets);
+			}
+		}
+
+		nline = oline[lno].new_head;
+		while (nline) {
+			if (!dest) {
+				size += num_targets + nline->len + 1;
+			} else {
+				size += put_line(dest + size, nline->line,
+						nline->len, nline->targets_map,
+						'+', num_targets);
+			}
+
+			nline = nline->next;
+		}
+	}
+
+	return size;
+}
+
+unsigned long do_buf_cdiff(mmfile_t *origin_file, mmfile_t *target_files,
+		int num_targets, char *dest)
+{
+	struct oline *oline = NULL; /* origin lines */
+	unsigned long cnt, size;
+	int i;
+
+	if (num_targets > (sizeof(unsigned long) * 8))
+		die("Can only handle %zu targets.", (sizeof(unsigned long) * 8));
+
+	/* build origin image */
+	build_oline(origin_file, &oline, &cnt);
+
+	for (i = 0; i < num_targets; i++)
+		do_cdiff_step(oline, origin_file, &target_files[i], i);
+
+	size = oline_to_buf(oline, cnt, num_targets, dest);
+
+	free_oline(oline, cnt);
+
+	return size;
+}
+
+int cmd_cdiff(int argc, const char **argv, const char *prefix)
+{
+	do_path_cdiff(argv[1], argv + 2, argc - 2);
+
+	return 0;
+}
+
+static void mmfile_from_strbuf(mmfile_t *mmfile, struct strbuf *strbuf)
+{
+	size_t sz;
+
+	/* force allocated buffer */
+	strbuf_grow(strbuf, 0);
+	mmfile->ptr  = strbuf_detach(strbuf, &sz);
+	mmfile->size = sz;
+}
+
+int cmd_cdiff_conflict_filter(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf input = STRBUF_INIT;
+	struct strbuf collector = STRBUF_INIT;
+	mmfile_t base_file, target_files[2];
+	enum {
+		IN_CONTEXT,
+		IN_OURS,
+		IN_BASE,
+		IN_THEIRS
+	} state = IN_CONTEXT;
+	unsigned long lno = 0;
+
+	while (strbuf_getwholeline(&input, stdin, '\n') != EOF) {
+		lno++;
+
+		if (input.len > 7 && !memcmp(input.buf, "<<<<<<<", 7)) {
+			if (state != IN_CONTEXT)
+				die("Malformed input:%lu: unexpected start of conflict.", lno);
+			state = IN_OURS;
+
+			goto do_put;
+		} else if (input.len > 7 && !memcmp(input.buf, "|||||||", 7)) {
+			if (state != IN_OURS)
+				die("Malformed input:%lu: unexpected start of pre image.", lno);
+			state = IN_BASE;
+
+			mmfile_from_strbuf(&target_files[0], &collector);
+
+			goto no_put;
+		} else if (input.len > 7 && !memcmp(input.buf, "=======", 7)) {
+			if (state != IN_BASE)
+				die("Malformed input:%lu: expected diff3 conflict style.", lno);
+			state = IN_THEIRS;
+
+			mmfile_from_strbuf(&base_file, &collector);
+
+			goto no_put;
+		} else if (input.len > 7 && !memcmp(input.buf, ">>>>>>>", 7)) {
+			unsigned long len;
+			char *dest;
+
+			if (state != IN_THEIRS)
+				die("Malformed input:%lu: unexpected end of conflict.", lno);
+			state = IN_CONTEXT;
+
+			mmfile_from_strbuf(&target_files[1], &collector);
+
+			len = do_buf_cdiff(&base_file, target_files, 2, NULL);
+			dest = xmalloc(len);
+			do_buf_cdiff(&base_file, target_files, 2, dest);
+			write_or_die(fileno(stdout), dest, len);
+			free(dest);
+			free(base_file.ptr);
+			free(target_files[0].ptr);
+			free(target_files[1].ptr);
+
+			goto do_put;
+		}
+
+		switch (state) {
+		case IN_OURS:
+		case IN_BASE:
+		case IN_THEIRS:
+			strbuf_addbuf(&collector, &input);
+			goto no_put;
+		}
+
+	do_put:
+		write_or_die(fileno(stdout), input.buf, input.len);
+	no_put:
+		strbuf_reset(&input);
+	}
+
+	if (state != IN_CONTEXT)
+		die("Malformed input:%lu: unexpected end of input.", lno);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index e8202f3..5ec84b8 100644
--- a/builtin.h
+++ b/builtin.h
@@ -121,5 +121,7 @@ extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
 extern int cmd_replace(int argc, const char **argv, const char *prefix);
+extern int cmd_cdiff(int argc, const char **argv, const char *prefix);
+extern int cmd_cdiff_conflict_filter(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/git.c b/git.c
index 90c6daf..6fb7d84 100644
--- a/git.c
+++ b/git.c
@@ -386,6 +386,8 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "verify-pack", cmd_verify_pack },
 		{ "show-ref", cmd_show_ref, RUN_SETUP },
 		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
+		{ "cdiff", cmd_cdiff },
+		{ "cdiff-conflict-filter", cmd_cdiff_conflict_filter },
 	};
 	int i;
 	static const char ext[] = STRIP_EXTENSION;
-- 
tg: (6d81630..) bw/cdiff-conflict-style (depends on: master)
