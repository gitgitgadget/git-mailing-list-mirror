Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B0181F43C
	for <e@80x24.org>; Thu,  9 Nov 2017 03:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbdKID0Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 22:26:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65095 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751915AbdKID0X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 22:26:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B94ABA4E18;
        Wed,  8 Nov 2017 22:26:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ok50xKuBB0WR
        43HzrXv/yYGKCrM=; b=t1jXdURp65XUOwVwmGQWA001Uiy13agA+iEOGD3nmyQY
        snbp30AG2LR/oVBy4i+JvfPXHoj/ntYIecRwq5V016dxujFuvgJawSLQ50vFHi9N
        GbK3LRc/DZwyE4XPKnW8GBNb8c8yPeS8P7HgKYjRdrkvxGtx4DKkF/mVEXlBGFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RvP5yi
        WYRV06a4KOOM+jNBrCCaVspEBkZt2jTLs/3+zdLJLCw2JWfw73s5yF7Up2ucvjGT
        xm7c/ip/6biwLkI5bBXELKWCrAV+Lagfl5LY27fN0/7ETb9U2aDlvIaOniQP4gAE
        /Dfb0ytQ5kf+r0/Qgb8xPSTynOyPul7gCrfkc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B25C9A4E17;
        Wed,  8 Nov 2017 22:26:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C1D4A4E16;
        Wed,  8 Nov 2017 22:26:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joseph Strauss <josephst@bhphoto.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug - Status - Space in Filename
References: <655aaa9d2abf4be1b6ade0574d88c999@EXMBX01B.bhphotovideo.local>
Date:   Thu, 09 Nov 2017 12:26:20 +0900
In-Reply-To: <655aaa9d2abf4be1b6ade0574d88c999@EXMBX01B.bhphotovideo.local>
        (Joseph Strauss's message of "Wed, 8 Nov 2017 17:27:24 +0000")
Message-ID: <xmqqvaikjfoj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C23265B8-C4FD-11E7-A44E-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joseph Strauss <josephst@bhphoto.com> writes:

> I believe I have found a bug in the way git status -s lists filenames.
>
> According to the documentation:
>   The fields (including the ->) are separated from each other by a sing=
le space. If a filename contains whitespace or other nonprintable charact=
ers,   that field will be quoted in the manner of a C string literal: sur=
rounded by ASCII double quote (34) characters, and with interior special =
characters backslash-escaped.
>
> While this is true in most situations, it does not seem to apply to mer=
ge conflicts. When a file has merge conflicts I am getting the following:
>  $ git status -s
>  UU some/path/with space/in/the/name
>  M=C2=A0 "another/path/with space/in/the/name "
>
> I found the same problem for the following versions:
> . git version 2.15.0.windows.1
> . git version 2.10.0

Thanks.

wt_shortstatus_status() has this code:

	if (s->null_termination) {
		fprintf(stdout, "%s%c", it->string, 0);
		if (d->head_path)
			fprintf(stdout, "%s%c", d->head_path, 0);
	} else {
		struct strbuf onebuf =3D STRBUF_INIT;
		const char *one;
		if (d->head_path) {
			one =3D quote_path(d->head_path, s->prefix, &onebuf);
			if (*one !=3D '"' && strchr(one, ' ') !=3D NULL) {
				putchar('"');
				strbuf_addch(&onebuf, '"');
				one =3D onebuf.buf;
			}
			printf("%s -> ", one);
			strbuf_release(&onebuf);
		}
		one =3D quote_path(it->string, s->prefix, &onebuf);
		if (*one !=3D '"' && strchr(one, ' ') !=3D NULL) {
			putchar('"');
			strbuf_addch(&onebuf, '"');
			one =3D onebuf.buf;
		}
		printf("%s\n", one);
		strbuf_release(&onebuf);
	}

But the corresponding part in wt_shortstatus_unmerged() reads like
this:

	if (s->null_termination) {
		fprintf(stdout, " %s%c", it->string, 0);
	} else {
		struct strbuf onebuf =3D STRBUF_INIT;
		const char *one;
		one =3D quote_path(it->string, s->prefix, &onebuf);
		printf(" %s\n", one);
		strbuf_release(&onebuf);
	}

The difference in d->head_path part is dealing about renames, which
is irrelevant for showing unmerged paths, but the key difference is
that the _unmerged() forgets to add the enclosing "" around the
result of quote_path().

It seems that wt_shortstatus_other() shares the same issue.  Perhaps
this will "fix" it?

Having said all that, the whole "quote path using c-style" was
designed very deliberately to treat SP (but not other kind of
whitespaces like HT) as something we do *not* have to quote (and
more importantly, do not *want* to quote, as pathnames with SP in it
are quite common for those who are used to "My Documents/" etc.), so
it is arguably that what is broken and incorrect is the extra
quoting with dq done in wt_shortstatus_status().  It of course is
too late to change the rules this late in the game, though.

Perhaps a better approach is to refactor the extra quoting I moved
to this emit_with_optional_dq() helper into quote_path() which
currently is just aliased to quote_path_relative().  It also is
possible that we may want to extend the "no_dq" parameter that is
given to quote_c_style() helper from a boolean to a set of flag
bits, and allow callers to request "I want SP added to the set of
bytes that triggers the quoting".


 wt-status.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index bedef256ce..472d53d596 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1671,6 +1671,20 @@ static void wt_longstatus_print(struct wt_status *=
s)
 		wt_longstatus_print_stash_summary(s);
 }
=20
+static const char *emit_with_optional_dq(const char *in, const char *pre=
fix,=20
+					  struct strbuf *out)
+{
+	const char *one;
+
+	one =3D quote_path(in, prefix, out);
+	if (*one !=3D '"' && strchr(one, ' ') !=3D NULL) {
+		putchar('"');
+		strbuf_addch(out, '"');
+		one =3D out->buf;
+	}
+	return one;
+}
+
 static void wt_shortstatus_unmerged(struct string_list_item *it,
 			   struct wt_status *s)
 {
@@ -1692,8 +1706,9 @@ static void wt_shortstatus_unmerged(struct string_l=
ist_item *it,
 	} else {
 		struct strbuf onebuf =3D STRBUF_INIT;
 		const char *one;
-		one =3D quote_path(it->string, s->prefix, &onebuf);
-		printf(" %s\n", one);
+		putchar(' ');
+		one =3D emit_with_optional_dq(it->string, s->prefix, &onebuf);
+		printf("%s\n", one);
 		strbuf_release(&onebuf);
 	}
 }
@@ -1720,21 +1735,11 @@ static void wt_shortstatus_status(struct string_l=
ist_item *it,
 		struct strbuf onebuf =3D STRBUF_INIT;
 		const char *one;
 		if (d->head_path) {
-			one =3D quote_path(d->head_path, s->prefix, &onebuf);
-			if (*one !=3D '"' && strchr(one, ' ') !=3D NULL) {
-				putchar('"');
-				strbuf_addch(&onebuf, '"');
-				one =3D onebuf.buf;
-			}
+			one =3D emit_with_optional_dq(d->head_path, s->prefix, &onebuf);
 			printf("%s -> ", one);
 			strbuf_release(&onebuf);
 		}
-		one =3D quote_path(it->string, s->prefix, &onebuf);
-		if (*one !=3D '"' && strchr(one, ' ') !=3D NULL) {
-			putchar('"');
-			strbuf_addch(&onebuf, '"');
-			one =3D onebuf.buf;
-		}
+		one =3D emit_with_optional_dq(it->string, s->prefix, &onebuf);
 		printf("%s\n", one);
 		strbuf_release(&onebuf);
 	}
@@ -1748,9 +1753,10 @@ static void wt_shortstatus_other(struct string_lis=
t_item *it,
 	} else {
 		struct strbuf onebuf =3D STRBUF_INIT;
 		const char *one;
-		one =3D quote_path(it->string, s->prefix, &onebuf);
 		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
-		printf(" %s\n", one);
+		putchar(' ');
+		one =3D emit_with_optional_dq(it->string, s->prefix, &onebuf);
+		printf("%s\n", one);
 		strbuf_release(&onebuf);
 	}
 }
