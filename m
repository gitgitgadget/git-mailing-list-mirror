Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A73231FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 19:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754331AbcKUTFc (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 14:05:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53716 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752505AbcKUTFc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 14:05:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3644052688;
        Mon, 21 Nov 2016 14:05:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=/rvK
        TKCasxmpRF/IRXje+Suyok8=; b=U0MZCKqv4OtADgAqho615Y2Vz6KupWPLaDg/
        pILo8XDVkFYtK3Whdr4nviZVDd8yKzNnzvaKKdVJyFcbtGvGa8sxMTNaxpxbCHSa
        UIMO+OnLZw69G0dOTwOibrjUbW9nCxH6QYYM7bx4O+oZKQQWdwVmsoQDeaWsduGe
        cUwVpio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        IbatSAXg35OdKrrPisQOfEQ09l+LbG2yemxNSXEqstTdya+l6NXsFg0godMlLR7N
        dLd1uEz/78o+vLd6/PFubEQBTUOZi5tTtIHPNgFUvxyg9V3kiho221fOkaR+zlle
        KilSLw/MYbvMMNv8kPqLRzmF35tLUueXo2EqbDUZYY0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F03952687;
        Mon, 21 Nov 2016 14:05:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0C6752681;
        Mon, 21 Nov 2016 14:05:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/3] rebase -i: handle core.commentChar=auto
Date:   Mon, 21 Nov 2016 11:05:14 -0800
Message-Id: <20161121190514.18574-3-gitster@pobox.com>
X-Mailer: git-send-email 2.11.0-rc2-154-g95ba452916
In-Reply-To: <20161121190514.18574-1-gitster@pobox.com>
References: <xmqq7f7wk7x9.fsf@gitster.mtv.corp.google.com>
 <20161121190514.18574-1-gitster@pobox.com>
X-Pobox-Relay-ID: 7657C78C-B01D-11E6-ADF0-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When 84c9dc2 (commit: allow core.commentChar=auto for character auto
selection, 2014-05-17) extended the core.commentChar functionality to
allow for the value 'auto', it forgot that rebase -i was already taught to
handle core.commentChar, and in turn forgot to let rebase -i handle that
new value gracefully.

Reported by Taufiq Hoven.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh    | 13 +++++++++++--
 t/t3404-rebase-interactive.sh |  2 +-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 655ebaa471..c167bc36b3 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -93,8 +93,17 @@ eval '
 GIT_CHERRY_PICK_HELP="$resolvemsg"
 export GIT_CHERRY_PICK_HELP
 
-comment_char=$(git config --get core.commentchar 2>/dev/null | cut -c1)
-: ${comment_char:=#}
+comment_char=$(git config --get core.commentchar 2>/dev/null)
+case "$comment_char" in
+'' | auto)
+	comment_char="#"
+	;;
+?)
+	;;
+*)
+	comment_char=$(echo "$comment_char" | cut -c1)
+	;;
+esac
 
 warn () {
 	printf '%s\n' "$*" >&2
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d941f0a69f..5d0a7dca9d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -983,7 +983,7 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
-test_expect_failure 'rebase -i respects core.commentchar=auto' '
+test_expect_success 'rebase -i respects core.commentchar=auto' '
 	test_config core.commentchar auto &&
 	write_script copy-edit-script.sh <<-\EOF &&
 	cp "$1" edit-script
-- 
2.11.0-rc2-154-g95ba452916

