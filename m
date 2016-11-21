Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEA4D1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 19:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754193AbcKUTF2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 14:05:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65500 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752505AbcKUTF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 14:05:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38B4D4ECC4;
        Mon, 21 Nov 2016 14:05:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=DGPM
        oSZZONYU7Hxa2oUABLkv7X0=; b=sqEob6V/pGBHRQBwD6AgFrODj/xos21dOzvv
        BIaC/4k55okhoKdamNqWud9LREEPg9m8nek6Qv8Yhg444v3PzPJ6OCEGsrTF7gF6
        zA7aDzul7cg9s8PFmkdSrg7XvKtMYZaS0WXAlxU4HirJIM4UtFP5O7YIpxxUBIsK
        65t8fDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        G51KL4V3SrfCHRv48iQbRTrp4+vQWcRcJNc6feI4DKn0MGmCB1yBRyB6ohTQVN0q
        ke3EgadlH5YyMmeu6hikt3gMcgHmZS1W2eyUJvWzW+fK2GEetmzjwLFgfUHd4NvI
        vB4jj/foIgLcHzA8CMbJdY0lMcjfFebEM2Cj40sUvWk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 302A64ECC1;
        Mon, 21 Nov 2016 14:05:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD4424ECBF;
        Mon, 21 Nov 2016 14:05:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/3] stripspace: respect repository config
Date:   Mon, 21 Nov 2016 11:05:13 -0800
Message-Id: <20161121190514.18574-2-gitster@pobox.com>
X-Mailer: git-send-email 2.11.0-rc2-154-g95ba452916
In-Reply-To: <20161121190514.18574-1-gitster@pobox.com>
References: <xmqq7f7wk7x9.fsf@gitster.mtv.corp.google.com>
 <20161121190514.18574-1-gitster@pobox.com>
X-Pobox-Relay-ID: 735A929E-B01D-11E6-87FB-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The way "git stripspace" reads the configuration was not quite
correct, in that it forgot to probe for a possibly existing
repository (note: stripspace is designed to be usable outside the
repository as well) before doing so.  Due to this, .git/config was
read only when the command was run from the top-level of the working
tree.  

A recent change b9605bc4f2 ("config: only read .git/config from
configured repos", 2016-09-12) stopped reading the repository-local
configuration file ".git/config" unless the repository discovery
process is done, and ".git/config" is no longer read even when run
from the top-level, which exposed the bug even more.

When rebasing interactively with a commentChar defined in the
current repository's config, the help text at the bottom of the edit
script potentially used an incorrect comment character. This was not
only funny-looking, but also resulted in tons of warnings like this
one:

	Warning: the command isn't recognized in the following line
	 - #

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/stripspace.c  | 4 +++-
 t/t0030-stripspace.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 15e716ef43..1e62a008cb 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -44,8 +44,10 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 	if (argc)
 		usage_with_options(stripspace_usage, options);
 
-	if (mode == STRIP_COMMENTS || mode == COMMENT_LINES)
+	if (mode == STRIP_COMMENTS || mode == COMMENT_LINES) {
+		setup_git_directory_gently(NULL);
 		git_config(git_default_config, NULL);
+	}
 
 	if (strbuf_read(&buf, 0, 1024) < 0)
 		die_errno("could not read the input");
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index c1f6411eb2..bbf3e39e3d 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -432,7 +432,7 @@ test_expect_success '-c with changed comment char' '
 	test_cmp expect actual
 '
 
-test_expect_failure '-c with comment char defined in .git/config' '
+test_expect_success '-c with comment char defined in .git/config' '
 	test_config core.commentchar = &&
 	printf "= foo\n" >expect &&
 	printf "foo" | (
-- 
2.11.0-rc2-154-g95ba452916

