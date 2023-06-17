Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0E3EB64DB
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 20:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjFQUmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 16:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjFQUmi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 16:42:38 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7A91737
        for <git@vger.kernel.org>; Sat, 17 Jun 2023 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687034547; x=1687639347; i=l.s.r@web.de;
 bh=VmtRWsVu4LfqGqKoZxlALNZjOvRBXNUNAQW8uav2GBE=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=jW0zavBe/SxNOHmuVA57SF4fZUhgXQIhLNGwKE3codZmkvfxJQllAzChVgTwR1fTPEfBy3f
 kEnlHV62ZRTQekwZdDr7F8H7if+uevfkQfRdGgTWPsEfzmUpJxta0uixKAVHDuXhOuurWjY9U
 oIzXjC84emOzXxREnUo0xYbFuAJJukazDkYrZwpAykwN/ApgKTZOqleAzG5FnNr4gneqtwNmp
 0EYcVq0LRGNgJT0F2hqzjfdObE6G6vJLX1CqBoesBkeAVdnaLSpRCMHas2TMEGBnxZYMdv422
 OQ63zlcpr/fmxh5lpy9wlLlcBkEoElo0so5haCzbZ5yFlwy/ETxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.195]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6FV-1qRTLb449d-00ImLB for
 <git@vger.kernel.org>; Sat, 17 Jun 2023 22:42:27 +0200
Message-ID: <5ce9513b-d463-6f62-db4e-f9f60a7c3e9f@web.de>
Date:   Sat, 17 Jun 2023 22:42:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: [PATCH 3/5] replace strbuf_expand_dict_cb() with strbuf_expand_step()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
In-Reply-To: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:99djNyvDpVPjN97QcnRy1s4LxDWzlyRsnVgEWN4pCgJ7xX1btkr
 7Md245VIxHRrTuXDHvdG/oYmg7LWB2epizK+GqEiDpdxKrIogZI514aHGMKTOUlsqWXjgOQ
 ukESXyFf9W1/Qk78xz4kGI2NoqRs6E6rSPrGOFujBrgFBJiQWdol3sqXuGpgS4StmJfbUwV
 H9ME17JPhMHpLBXFpkG+w==
UI-OutboundReport: notjunk:1;M01:P0:SMVzP8AvlvQ=;P4i3dPiXkhZywoLKHJM9C6SmDi3
 o579yMyyvqILX58k2uCgIN8YsjEMY3bdyR+30sDWY64F/nu4nCkWDpUnKKQaQmbs7WMFu1S1e
 N6NoD5rRZnyAPAFEpemmO285eu+5Cc46bxELzjhq+NL90AGQ+DnF9YLMungjh4JAvn2aGSVKW
 +isvqStJuW7NmjipfLGq8Za4vktX70w2WoCroeE4KhDrGWTcDszvnMApIQKsSe5yQCYhEN/9Y
 SgMcokZsyHyz4T7d8N4EveSaoQ19eKTikAUxV/OZ5cmMvEYcTB4WdozDzFRfX3ZKWVThRzZjX
 gLAe4vrj5NPSv5RlRmc3vOxgFwTs6aGwZ5+3L+BM2rWr7EWXIYByFveHEItz28aPETdE+9vTk
 P/vj5C/a0KHai21i/ls/nKpNxDQJoJQ3LPLHjQtJNz0AdOR1HBsocMX/qQIT4Yh4sy56pvAfM
 bZy+4vABkQ1pNAD/FSdxyqRTq72AsM2Xi/+rEBOwZnnwiv975xO2wV6cofUQX7UlhpBg59EFW
 c49acqgKDYz5oSNwZxNFps/hMsYT/HPn9XpRNT51jGz0QaSIFf+ThFsSCrW5wzAUgyN71CUBI
 S0Pp2nwiyt7ruhZtkp01yc5AS6+QNz2Y8A9W4yF1RdnuoJ2ePSqZWPn8xn3ud2XcztFxJX38N
 TSwE/VPmgn8eX3wdx08w7j2ZW48rATV9JTK5R7/k6qAf3tsIFh4joSIMr3xzpdByfcIR3QMjn
 RsLXxMAwg9tTZGdLqLU9soOjvQEiU37U61Vnp/30gOW3IKKc+QafOQe1vfSyZQPwGGDPhY/g+
 LWdQeixtjHxrZeZEQPI4WhQVMHlxWM8KSWoERhNMLa8vBwakC9/0lCeUF4BbdXpyIg6u0nXSi
 v2sTHPw1lOTjLsik1tXStQg8b4ImWNpHRE8rnBHXoKD+nWFeIo5mFzJh4BIK3NnxpD1jZDG56
 P3vjLKuHTNHxkP4HQRdYpst5nKk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid the overhead of setting up a dictionary and passing it via
strbuf_expand() to strbuf_expand_dict_cb() by using strbuf_expand_step()
in a loop instead.  It requires explicit handling of %% and unrecognized
placeholders, but is more direct and simpler overall, and expands only
on demand.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 convert.c  | 22 ++++++++++------------
 ll-merge.c | 32 ++++++++++++++++++--------------
 strbuf.c   | 16 ----------------
 strbuf.h   | 14 --------------
 4 files changed, 28 insertions(+), 56 deletions(-)

diff --git a/convert.c b/convert.c
index 9ee79fe469..455d05cf6b 100644
=2D-- a/convert.c
+++ b/convert.c
@@ -633,23 +633,21 @@ static int filter_buffer_or_fd(int in UNUSED, int ou=
t, void *data)
 	 */
 	struct child_process child_process =3D CHILD_PROCESS_INIT;
 	struct filter_params *params =3D (struct filter_params *)data;
+	const char *format =3D params->cmd;
 	int write_err, status;

 	/* apply % substitution to cmd */
 	struct strbuf cmd =3D STRBUF_INIT;
-	struct strbuf path =3D STRBUF_INIT;
-	struct strbuf_expand_dict_entry dict[] =3D {
-		{ "f", NULL, },
-		{ NULL, NULL, },
-	};
-
-	/* quote the path to preserve spaces, etc. */
-	sq_quote_buf(&path, params->path);
-	dict[0].value =3D path.buf;

-	/* expand all %f with the quoted path */
-	strbuf_expand(&cmd, params->cmd, strbuf_expand_dict_cb, &dict);
-	strbuf_release(&path);
+	/* expand all %f with the quoted path; quote to preserve space, etc. */
+	while (strbuf_expand_step(&cmd, &format)) {
+		if (skip_prefix(format, "%", &format))
+			strbuf_addch(&cmd, '%');
+		else if (skip_prefix(format, "f", &format))
+			sq_quote_buf(&cmd, params->path);
+		else
+			strbuf_addch(&cmd, '%');
+	}

 	strvec_push(&child_process.args, cmd.buf);
 	child_process.use_shell =3D 1;
diff --git a/ll-merge.c b/ll-merge.c
index 07ec16e8e5..b307ad293c 100644
=2D-- a/ll-merge.c
+++ b/ll-merge.c
@@ -192,24 +192,15 @@ static enum ll_merge_result ll_ext_merge(const struc=
t ll_merge_driver *fn,
 			const struct ll_merge_options *opts,
 			int marker_size)
 {
-	char temp[4][50];
+	char temp[3][50];
 	struct strbuf cmd =3D STRBUF_INIT;
-	struct strbuf_expand_dict_entry dict[6];
-	struct strbuf path_sq =3D STRBUF_INIT;
+	const char *format =3D fn->cmdline;
 	struct child_process child =3D CHILD_PROCESS_INIT;
 	int status, fd, i;
 	struct stat st;
 	enum ll_merge_result ret;
 	assert(opts);

-	sq_quote_buf(&path_sq, path);
-	dict[0].placeholder =3D "O"; dict[0].value =3D temp[0];
-	dict[1].placeholder =3D "A"; dict[1].value =3D temp[1];
-	dict[2].placeholder =3D "B"; dict[2].value =3D temp[2];
-	dict[3].placeholder =3D "L"; dict[3].value =3D temp[3];
-	dict[4].placeholder =3D "P"; dict[4].value =3D path_sq.buf;
-	dict[5].placeholder =3D NULL; dict[5].value =3D NULL;
-
 	if (!fn->cmdline)
 		die("custom merge driver %s lacks command line.", fn->name);

@@ -218,9 +209,23 @@ static enum ll_merge_result ll_ext_merge(const struct=
 ll_merge_driver *fn,
 	create_temp(orig, temp[0], sizeof(temp[0]));
 	create_temp(src1, temp[1], sizeof(temp[1]));
 	create_temp(src2, temp[2], sizeof(temp[2]));
-	xsnprintf(temp[3], sizeof(temp[3]), "%d", marker_size);

-	strbuf_expand(&cmd, fn->cmdline, strbuf_expand_dict_cb, &dict);
+	while (strbuf_expand_step(&cmd, &format)) {
+		if (skip_prefix(format, "%", &format))
+			strbuf_addch(&cmd, '%');
+		else if (skip_prefix(format, "O", &format))
+			strbuf_addstr(&cmd, temp[0]);
+		else if (skip_prefix(format, "A", &format))
+			strbuf_addstr(&cmd, temp[1]);
+		else if (skip_prefix(format, "B", &format))
+			strbuf_addstr(&cmd, temp[2]);
+		else if (skip_prefix(format, "L", &format))
+			strbuf_addf(&cmd, "%d", marker_size);
+		else if (skip_prefix(format, "P", &format))
+			sq_quote_buf(&cmd, path);
+		else
+			strbuf_addch(&cmd, '%');
+	}

 	child.use_shell =3D 1;
 	strvec_push(&child.args, cmd.buf);
@@ -242,7 +247,6 @@ static enum ll_merge_result ll_ext_merge(const struct =
ll_merge_driver *fn,
 	for (i =3D 0; i < 3; i++)
 		unlink_or_warn(temp[i]);
 	strbuf_release(&cmd);
-	strbuf_release(&path_sq);
 	ret =3D (status > 0) ? LL_MERGE_CONFLICT : status;
 	return ret;
 }
diff --git a/strbuf.c b/strbuf.c
index a90b597da1..972366b410 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -468,22 +468,6 @@ size_t strbuf_expand_literal_cb(struct strbuf *sb,
 	return 0;
 }

-size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder,
-		void *context)
-{
-	struct strbuf_expand_dict_entry *e =3D context;
-	size_t len;
-
-	for (; e->placeholder && (len =3D strlen(e->placeholder)); e++) {
-		if (!strncmp(placeholder, e->placeholder, len)) {
-			if (e->value)
-				strbuf_addstr(sb, e->value);
-			return len;
-		}
-	}
-	return 0;
-}
-
 void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *=
src)
 {
 	size_t i, len =3D src->len;
diff --git a/strbuf.h b/strbuf.h
index a189f12b84..e293117f07 100644
=2D-- a/strbuf.h
+++ b/strbuf.h
@@ -357,20 +357,6 @@ size_t strbuf_expand_literal_cb(struct strbuf *sb,
 				const char *placeholder,
 				void *context);

-/**
- * Used as callback for `strbuf_expand()`, expects an array of
- * struct strbuf_expand_dict_entry as context, i.e. pairs of
- * placeholder and replacement string.  The array needs to be
- * terminated by an entry with placeholder set to NULL.
- */
-struct strbuf_expand_dict_entry {
-	const char *placeholder;
-	const char *value;
-};
-size_t strbuf_expand_dict_cb(struct strbuf *sb,
-			     const char *placeholder,
-			     void *context);
-
 /**
  * If the string pointed to by `formatp` contains a percent sign ("%"),
  * advance it to point to the character following the next one and
=2D-
2.41.0
