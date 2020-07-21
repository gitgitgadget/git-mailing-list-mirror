Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7DEC433E3
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 01:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534D220717
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 01:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OiNJVgq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgGUB0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:26:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40440 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726021AbgGUB0T (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Jul 2020 21:26:19 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6B09A6044E;
        Tue, 21 Jul 2020 01:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595294747;
        bh=ap4oDX6up55fGnIs5p4R5dPwvfBcpqPrT2cF9HQhQAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=OiNJVgq47zeHfGCkN4emvlmIqJk4zM/tdN/LOuUEv/U3Z3VbCglFHj0/W5RuRaaHR
         3JArqAecLOLJkb4GKdEi2Sz/wbGnh4yTXwdGdzWN3er4+usXkVAgj/rVI/JNsYYiZn
         e4NoRWq+qOcN/IaoFpbWb9qaczHHMZTNooM885vscH4tC9axfkSG6Rv7ekLlu2gOiO
         wM7GuEXz2BSHyF7gj61JNCWfXzu7YNscEkP2lRVHtWIzGzX97H8X7Eznfg7KfE9XuI
         zc2mIU1nuaV8nVBmcimMhr7HDgjpzA6EMfTT1gh3n/fpfiaKeUBcWBokO77/xI0E9e
         W0QGdTz8HxOJ7QNGLmv08bJC8rRM1LvqLPkQrp21F0oazC8fRnOJiUqFrG+CqZDJMK
         wqRtpzg/EyrsVDqs/fd5rEJtvQXYCeAqiy64QOigzMD+6VB/OTDJezAPHi1iZ73oJ6
         jodOXwKzk6z6twtn832HGxiCFUI+85akJjoCFHcFDwBUMHCQu+S
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Frej Bjon <frej.bjon@nemit.fi>
Subject: [PATCH v2] remote-curl: make --force-with-lease work with non-ASCII ref names
Date:   Tue, 21 Jul 2020 01:15:11 +0000
Message-Id: <20200721011511.1649048-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <CAP8P1T+JQUTVDXsJbrWkiZ2AWZmoptFSRdKssANYrNSFa+Egmg@mail.gmail.com>
References: <CAP8P1T+JQUTVDXsJbrWkiZ2AWZmoptFSRdKssANYrNSFa+Egmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we invoke a remote transport helper and pass an option with an
argument, we quote the argument as a C-style string if necessary.  This
is the case for the cas option, which implements the --force-with-lease
command-line flag, when we're passing a non-ASCII refname.

However, the remote curl helper isn't designed to parse such an
argument, meaning that if we try to use --force-with-lease with an HTTP
push and a non-ASCII refname, we get an error like this:

  error: cannot parse expected object name '0000000000000000000000000000000000000000"'

Note the double quote, which get_oid has reminded us is not valid in an
hex object ID.

Even if we had been able to parse it, we would send the wrong data to
the server: we'd send an escaped ref, which would not behave as the user
wanted and might accidentally result in updating or deleting a ref we
hadn't intended.

Since we need to expect a quoted C-style string here, just check if the
first argument is a double quote, and if so, unquote it.  Note that if
the refname contains a double quote, then we will have double-quoted it
already, so there is no ambiguity.

We test for this case only in the smart protocol, since the DAV-based
protocol is not capable of handling this capability.  We use UTF-8
because this is nicer in our tests and friendlier to Windows, but the
code should work for all non-ASCII refs.

While we're at it, since the name of the option is now well established
and isn't going to change, let's inline it instead of using the #define
constant.

Reported-by: Frej Bjon <frej.bjon@nemit.fi>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c              |  6 +++++-
 t/t5541-http-push-smart.sh | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 5cbc6e5002..c9921c552c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -121,7 +121,11 @@ static int set_option(const char *name, const char *value)
 	}
 	else if (!strcmp(name, "cas")) {
 		struct strbuf val = STRBUF_INIT;
-		strbuf_addf(&val, "--" CAS_OPT_NAME "=%s", value);
+		strbuf_addstr(&val, "--force-with-lease=");
+		if (*value != '"')
+			strbuf_addstr(&val, value);
+		else if (unquote_c_style(&val, value, NULL))
+			return -1;
 		string_list_append(&cas_options, val.buf);
 		strbuf_release(&val);
 		return 0;
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 463d0f12e5..187454f5dd 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -479,6 +479,21 @@ test_expect_success 'clone/fetch scrubs password from reflogs' '
 	! grep "$HTTPD_URL_USER_PASS" reflog
 '
 
+test_expect_success 'Non-ASCII branch name can be used with --force-with-lease' '
+	cd "$ROOT_PATH" &&
+	git clone "$HTTPD_URL_USER_PASS/smart/test_repo.git" non-ascii &&
+	cd non-ascii &&
+	git checkout -b rama-de-árbol &&
+	test_commit F &&
+	git push --force-with-lease origin rama-de-árbol &&
+	git ls-remote origin refs/heads/rama-de-árbol >actual &&
+	git ls-remote . refs/heads/rama-de-árbol >expect &&
+	test_cmp expect actual &&
+	git push --delete --force-with-lease origin rama-de-árbol &&
+	git ls-remote origin refs/heads/rama-de-árbol >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'colorize errors/hints' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_must_fail git -c color.transport=always -c color.advice=always \
