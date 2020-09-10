Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16DCC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B0C20C09
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kcAnp7rX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgIJRDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:03:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54126 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgIJRCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:02:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1ED29FEEC1;
        Thu, 10 Sep 2020 13:02:04 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=uiNB0oEqXzAONBh11oqZqy2hL
        sg=; b=kcAnp7rXeBGaWRZLwKLNzByYSEMD3tYZ6iA7izeuqaLFf0FXx462aUvXf
        tuJ8U2uktWlu3XI2s0f6j1deXaLQettczMRhYeZaJVYs/29IxWutYLT1at1nzy+v
        Wrurc5o0YjGI0k7hAXu/ZCyXEIwF78zNBMQB7+CQPLRjkUQUic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=L5IktmMUuCflQEdLH82
        LTNnFA5sAHaFiDdjTyxwAABuZW+m2hJkyo4gspXEdULz+rI/V4CiyAaKaEVBUDAy
        RsowK8ip4T4kXC9ceq0/OWLe3fnPbQdEgDOJBdvwuHHE8d84yYZNsaeENGwvxTjf
        ur8ynXC2ofcJLH/7PXvu9RIw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 161B3FEEC0;
        Thu, 10 Sep 2020 13:02:04 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 579E0FEEBE;
        Thu, 10 Sep 2020 13:02:01 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 0/7] quote_path() clean-ups
Date:   Thu, 10 Sep 2020 10:01:52 -0700
Message-Id: <20200910170159.1278781-1-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-603-ga98dad7d4d
In-Reply-To: <20200908205224.4126551-1-gitster@pobox.com>
References: <20200908205224.4126551-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 582D8916-F387-11EA-AEB4-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is an update, after seeing Peff's review.

The overall structure of the series stays the same.

 * The second patch lost an incorrect use of 'flags' parameter down
   to quote_c_style_counted() from quote_path().  In the function
   declaration of quote_path(), the flags parameter is now named.

 * The third patch that moves the "optionally quote path with SP in
   it" logic to quote_path() is essentialy unchanged.

 * But the fourth patch rewrites the implementation to avoid
   shifting the output bytes with insertstr().

 * The fifth patch (formerly the fourth) that teachs "status --short"
   to consistently quote hasn't changed, except that we test also
   for the ignored paths.

 * The last two patches are unchanged.  They are optional clean-ups
   that are not required.

We might want to add a bit more tests for:

 - how conflicted "funny" paths are shown.

 - how doubly funny paths (those that quote_c_style_counted() needs
   to use backslash quoting *and* that contain SP) are shown.

but I'd say that is outside the scope of this round.  Seeing what is
done in t3300, the latter test cannot be written portably as far as
I can tell.


Junio C Hamano (7):
  quote_path: rename quote_path_relative() to quote_path()
  quote_path: give flags parameter to quote_path()
  quote_path: optionally allow quoting a path with SP in it
  quote_path: code clarification
  wt-status: consistently quote paths in "status --short" output
  quote: rename misnamed sq_lookup[] to cq_lookup[]
  quote: turn 'nodq' parameter into a set of flags

 builtin/clean.c   | 22 +++++++++++-----------
 builtin/grep.c    |  2 +-
 diff.c            |  8 ++++----
 quote.c           | 47 +++++++++++++++++++++++++++++++----------------
 quote.h           | 11 +++++++----
 t/t7508-status.sh | 27 +++++++++++++++++++++++++++
 wt-status.c       | 37 +++++++++++++------------------------
 7 files changed, 94 insertions(+), 60 deletions(-)

Range-diff against v1:
1:  a9306429f4 =3D 1:  a9306429f4 quote_path: rename quote_path_relative(=
) to quote_path()
2:  c2784628a4 ! 2:  179d12d16f quote_path: give flags parameter to quote=
_path()
    @@ quote.c: void write_name_quoted_relative(const char *name, const c=
har *prefix,
      {
      	struct strbuf sb =3D STRBUF_INIT;
      	const char *rel =3D relative_path(in, prefix, &sb);
    - 	strbuf_reset(out);
    --	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
    -+	quote_c_style_counted(rel, strlen(rel), out, NULL, flags);
    - 	strbuf_release(&sb);
    -=20
    - 	return out->buf;
    =20
      ## quote.h ##
     @@ quote.h: void write_name_quoted_relative(const char *name, const =
char *prefix,
    @@ quote.h: void write_name_quoted_relative(const char *name, const c=
har *prefix,
     =20
      /* quote path as relative to the given prefix */
     -char *quote_path(const char *in, const char *prefix, struct strbuf =
*out);
    -+char *quote_path(const char *in, const char *prefix, struct strbuf =
*out, unsigned);
    ++char *quote_path(const char *in, const char *prefix, struct strbuf =
*out, unsigned flags);
     =20
      /* quoting as a string literal for other languages */
      void perl_quote_buf(struct strbuf *sb, const char *src);
3:  640673148e ! 3:  d566c38d2f quote_path: optionally allow quoting a pa=
th with SP in it
    @@ Commit message
    =20
      ## quote.c ##
     @@ quote.c: char *quote_path(const char *in, const char *prefix, str=
uct strbuf *out, unsigne
    - 	struct strbuf sb =3D STRBUF_INIT;
    - 	const char *rel =3D relative_path(in, prefix, &sb);
    - 	strbuf_reset(out);
    --	quote_c_style_counted(rel, strlen(rel), out, NULL, flags);
    -+	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
    + 	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
      	strbuf_release(&sb);
     =20
     +	if ((flags & QUOTE_PATH_QUOTE_SP) &&
    @@ quote.h
     @@ quote.h: void write_name_quoted_relative(const char *name, const =
char *prefix,
     =20
      /* quote path as relative to the given prefix */
    - char *quote_path(const char *in, const char *prefix, struct strbuf =
*out, unsigned);
    + char *quote_path(const char *in, const char *prefix, struct strbuf =
*out, unsigned flags);
     +#define QUOTE_PATH_QUOTE_SP 01
     =20
      /* quoting as a string literal for other languages */
-:  ---------- > 4:  f3769b7cf4 quote_path: code clarification
4:  ac9a0c4a33 ! 5:  498bed71e4 wt-status: consistently quote paths in "s=
tatus --short" output
    @@ Commit message
         output, but untracked, ignored, and unmerged paths weren't.
    =20
         The test was stolen from a patch to fix output for the 'untracke=
d'
    -    paths by brian m. carlson.
    +    paths by brian m. carlson, with similar tests added for 'ignored=
'
    +    ones.
    =20
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
    @@ t/t7508-status.sh: test_expect_success 'status -s without relative=
 paths' '
     +	test_when_finished "git rm --cached \"file with spaces\"; rm -f fi=
le*" &&
     +	>"file with spaces" &&
     +	>"file with spaces 2" &&
    ++	>"expect with spaces" &&
     +	git add "file with spaces" &&
    ++
     +	git status -s >output &&
    -+	test_cmp expect output
    ++	test_cmp expect output &&
     +
    ++	git status -s --ignored >output &&
    ++	grep "^!! \"expect with spaces\"$" output &&
    ++	grep -v "^!! " output >output-wo-ignored &&
    ++	test_cmp expect output-wo-ignored
     +'
     +
      test_expect_success 'dry-run of partial commit excluding new file i=
n index' '
5:  57c6294695 =3D 6:  e74186bbd7 quote: rename misnamed sq_lookup[] to c=
q_lookup[]
6:  480152cfe4 ! 7:  d87d7dd561 quote: turn 'nodq' parameter into a set o=
f flags
    @@ quote.c: static size_t quote_c_style_counted(const char *name, ssi=
ze_t maxlen,
      		if (!nodq)
      			strbuf_addch(sb, '"');
      	} else {
    +@@ quote.c: char *quote_path(const char *in, const char *prefix, str=
uct strbuf *out, unsigne
    + 	 */
    + 	if (force_dq)
    + 		strbuf_addch(out, '"');
    +-	quote_c_style_counted(rel, strlen(rel), out, NULL, !!force_dq);
    ++	quote_c_style_counted(rel, strlen(rel), out, NULL,
    ++			      force_dq ? CQUOTE_NODQ : 0);
    + 	if (force_dq)
    + 		strbuf_addch(out, '"');
    + 	strbuf_release(&sb);
    =20
      ## quote.h ##
     @@ quote.h: struct strvec;
--=20
2.28.0-603-ga98dad7d4d

