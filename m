Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A44C3F2CE
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 21:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181E120674
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 21:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lRXkulNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbgCPV3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:29:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51222 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbgCPV3F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 17:29:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40BD7C030A;
        Mon, 16 Mar 2020 17:29:03 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=sXp5zjDPnKHDmUbXRaPWFgldt
        FQ=; b=lRXkulNv/TSiXwh3R9E8xSPPeYmG5bHfHF2Qp0mxL3LtIQYPkeE9MwBhH
        8qF4ZtZyO0oIJDWO0ggn4mtmKjqf9+8dTuuSmQzmyzcGwbHPQKzBhdbElMVYpE/q
        hIUR9t2BP0HHvSYWp3PpUP8oqUUiCHdM1v/rs/LlFAzuPXt9Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=c/5DhrcBb97bbgGpb2q
        56rdQ/WxTpfWIZ+oNyHsWy26jeYJmmETx72IXr51hMUQR/7LirE7BDU30/ozBAlB
        zOFFjh+EtoFWRkcBIxDikoMUUn/Qkk4JxTLReiZY9YIcMKTbnSzYco6H2KKw/5xf
        YqjSLILJOF5m8vvPUmZ9sjP4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 398A0C0309;
        Mon, 16 Mar 2020 17:29:03 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7FC77C0303;
        Mon, 16 Mar 2020 17:29:00 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] parse-options: teach "git cmd -h" to show alias as alias
Date:   Mon, 16 Mar 2020 14:28:55 -0700
Message-Id: <20200316212857.259093-2-gitster@pobox.com>
X-Mailer: git-send-email 2.26.0-rc1-11-g30e9940356
In-Reply-To: <20200316212857.259093-1-gitster@pobox.com>
References: <20200316212857.259093-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 26D0994E-67CD-11EA-BA25-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a long-standing NEEDSWORK comment that complains about
inconsistency between how an aliased option ("git clone --recurse"
which is the only one that currently exists) gives a help text in
a usage-error message vs "git cmd -h").  Get rid of it and then
make sure we say an option is an alias for another, instead of
repeating the same short help text for both, which leads to "they
seem to do the same---is there any subtle difference?" puzzlement
to end-users.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I couldn't easily see how to trigger usage_with_options() with
   the original options[], which is the potential cause of the
   inconsistency the NEEDSWORK comment mentions.  But if there were,
   this should take care of it.  Our test suite did not have an
   example, though.

 parse-options.c          | 9 +++------
 t/t0040-parse-options.sh | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 63d6bab60c..c57618d537 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -648,6 +648,7 @@ static struct option *preprocess_options(struct parse=
_opt_ctx_t *ctx,
 		int short_name;
 		const char *long_name;
 		const char *source;
+		struct strbuf help =3D STRBUF_INIT;
 		int j;
=20
 		if (newopt[i].type !=3D OPTION_ALIAS)
@@ -659,6 +660,7 @@ static struct option *preprocess_options(struct parse=
_opt_ctx_t *ctx,
=20
 		if (!long_name)
 			BUG("An alias must have long option name");
+		strbuf_addf(&help, _("alias of --%s"), source);
=20
 		for (j =3D 0; j < nr; j++) {
 			const char *name =3D options[j].long_name;
@@ -669,15 +671,10 @@ static struct option *preprocess_options(struct par=
se_opt_ctx_t *ctx,
 			if (options[j].type =3D=3D OPTION_ALIAS)
 				BUG("No please. Nested aliases are not supported.");
=20
-			/*
-			 * NEEDSWORK: this is a bit inconsistent because
-			 * usage_with_options() on the original options[] will print
-			 * help string as "alias of %s" but "git cmd -h" will
-			 * print the original help string.
-			 */
 			memcpy(newopt + i, options + j, sizeof(*newopt));
 			newopt[i].short_name =3D short_name;
 			newopt[i].long_name =3D long_name;
+			newopt[i].help =3D strbuf_detach(&help, NULL);
 			break;
 		}
=20
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 3483b72db4..f8178ee4e3 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -54,7 +54,7 @@ Alias
     -A, --alias-source <string>
                           get a string
     -Z, --alias-target <string>
-                          get a string
+                          alias of --alias-source
=20
 EOF
=20
--=20
2.26.0-rc1-11-g30e9940356

