Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7030A1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 19:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754009AbcKUTFW (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 14:05:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60950 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752505AbcKUTFV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 14:05:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DDF65267C;
        Mon, 21 Nov 2016 14:05:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=echH
        WPS+1eksYgHOMpP819eQKNw=; b=rqnLanH+B4qP0ZawrY4uRnmID5XQaDRM7gTD
        yxwEYGATvnMhUNoh6mS0BEN2e9vz+CbBOzcCYvftw8uYVcQQCz6AEtGwE3Q8gI9B
        73CVK7VMACSlyrUgShYVSwHUHMJXAUxw/uHc6k6NvHzgwwMFdo5yuOiQX+rAX3ht
        7AsmJEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        dfNAIIFCrC/HlWXIeI3DXAVtifBvTU3zsBXzu1s2JFLNf9duoIEoAI/QMAnnrlJ+
        6zoLfARO/DHvugzfEOGFo5rnZToaK796Qvcku3lvnOi4ItCZKJJKjQmpN9+KwWK3
        yNU0R/pjtdsWk7zmEuE1iacM87v/uJ1v3MnlepW6+VE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 329355267B;
        Mon, 21 Nov 2016 14:05:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B46185267A;
        Mon, 21 Nov 2016 14:05:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/3] rebase -i: highlight problems with core.commentchar
Date:   Mon, 21 Nov 2016 11:05:12 -0800
Message-Id: <20161121190514.18574-1-gitster@pobox.com>
X-Mailer: git-send-email 2.11.0-rc2-154-g95ba452916
In-Reply-To: <xmqq7f7wk7x9.fsf@gitster.mtv.corp.google.com>
References: <xmqq7f7wk7x9.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: 6FCBE02E-B01D-11E6-9D66-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The interactive rebase does not currently play well with
core.commentchar. Let's add some tests to highlight those problems
that will be fixed in the remainder of the series.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0030-stripspace.sh         |  9 +++++++++
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 29e91d861c..c1f6411eb2 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -432,6 +432,15 @@ test_expect_success '-c with changed comment char' '
 	test_cmp expect actual
 '
 
+test_expect_failure '-c with comment char defined in .git/config' '
+	test_config core.commentchar = &&
+	printf "= foo\n" >expect &&
+	printf "foo" | (
+		mkdir sub && cd sub && git stripspace -c
+	) >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'avoid SP-HT sequence in commented line' '
 	printf "#\tone\n#\n# two\n" >expect &&
 	printf "\tone\n\ntwo\n" | git stripspace -c >actual &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d6d65a3a94..d941f0a69f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -983,6 +983,17 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_failure 'rebase -i respects core.commentchar=auto' '
+	test_config core.commentchar auto &&
+	write_script copy-edit-script.sh <<-\EOF &&
+	cp "$1" edit-script
+	EOF
+	test_set_editor "$(pwd)/copy-edit-script.sh" &&
+	test_when_finished "git rebase --abort || :" &&
+	git rebase -i HEAD^ &&
+	test -z "$(grep -ve "^#" -e "^\$" -e "^pick" edit-script)"
+'
+
 test_expect_success 'rebase -i, with <onto> and <upstream> specified as :/quuxery' '
 	test_when_finished "git branch -D torebase" &&
 	git checkout -b torebase branch1 &&
-- 
2.11.0-rc2-154-g95ba452916

