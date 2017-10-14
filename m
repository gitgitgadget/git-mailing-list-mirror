Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B44BC20437
	for <e@80x24.org>; Sat, 14 Oct 2017 02:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753247AbdJNCUO (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 22:20:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53896 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752769AbdJNCUN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 22:20:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6B3099288;
        Fri, 13 Oct 2017 22:20:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vf6ToWHNFD39FR/ISBVVVyfLHaY=; b=tWQZOU
        itBGKxNJiMNhxuUUXfqLLCO+pblTQtqhWn0vuo8OyHeq0GpAnaX2KXgK+uvulbQb
        jcQ9NN7wAA8fK+Ps0Wyr59jvOHMyzPBbhdeS+xhjeHuhtLznLm61wNH1dzRnGVXo
        gU1G/PXxRrqh5Udnj/N3nIw0XEBJekr4yAdyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kL0OZ4+CI+mHqK7OQTh1Fn+L91JVjaTV
        84wvQAcua59wAc+GHZpDx9CEcOxEs/Rf8jK+XpUzbLOnkA/3RGQ0UpqBkf328jZz
        B5oD/yP3BwMk4asyxGkvCJcmOag1TDg0uSkK7Cyvu/xDKT0QkFVnKB6yIEErzEXd
        /VttmwMeHYU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE3A699287;
        Fri, 13 Oct 2017 22:20:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D56099284;
        Fri, 13 Oct 2017 22:20:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] branch: forbid refs/heads/HEAD
References: <20171013051132.3973-1-gitster@pobox.com>
        <20171013051132.3973-4-gitster@pobox.com>
        <20171013131501.3qarwhanktfvgjqd@sigill.intra.peff.net>
        <xmqqefq6v5qj.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 14 Oct 2017 11:20:11 +0900
In-Reply-To: <xmqqefq6v5qj.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 14 Oct 2017 11:11:00 +0900")
Message-ID: <xmqqa80uv5b8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35318BC0-B086-11E7-8B0B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Should we test that:
>>
>>   git update-ref refs/heads/HEAD HEAD^
>>
>> continues to work?
>
> Perhaps.  Also we may want to make sure that "git branch -D HEAD"
> still works as a way to recover from historical mistakes.

The only difference is improved tests where we use show-ref to make
sure refs/heads/HEAD does not exist when it shouldn't, exercise
update-ref to create and delete refs/heads/HEAD, and also make sure
it can be deleted with "git branch -d".

-- >8 --
strbuf_check_branch_ref() is the central place where many codepaths
see if a proposed name is suitable for the name of a branch.  It was
designed to allow us to get stricter than the check_refname_format()
check used for refnames in general, and we already use it to reject
a branch whose name begins with a '-'.

Use it to also reject "HEAD" as a branch name.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c             |  2 +-
 t/t1430-bad-ref-name.sh | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index c7c5ab376c..1b8c503095 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1332,7 +1332,7 @@ void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
 int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 {
 	strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
-	if (name[0] == '-')
+	if (*name == '-' || !strcmp(name, "HEAD"))
 		return -1;
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
 	return check_refname_format(sb->buf, 0);
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index e88349c8a0..4556aa66b8 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -331,4 +331,27 @@ test_expect_success 'update-ref --stdin -z fails delete with bad ref name' '
 	grep "fatal: invalid ref format: ~a" err
 '
 
+test_expect_success 'branch rejects HEAD as a branch name' '
+	test_must_fail git branch HEAD HEAD^ &&
+	test_must_fail git show-ref refs/heads/HEAD
+'
+
+test_expect_success 'checkout -b rejects HEAD as a branch name' '
+	test_must_fail git checkout -B HEAD HEAD^ &&
+	test_must_fail git show-ref refs/heads/HEAD
+'
+
+test_expect_success 'update-ref can operate on refs/heads/HEAD' '
+	git update-ref refs/heads/HEAD HEAD^ &&
+	git show-ref refs/heads/HEAD &&
+	git update-ref -d refs/heads/HEAD &&
+	test_must_fail git show-ref refs/heads/HEAD
+'
+
+test_expect_success 'branch -d can remove refs/heads/HEAD' '
+	git update-ref refs/heads/HEAD HEAD^ &&
+	git branch -d HEAD &&
+	test_must_fail git show-ref refs/heads/HEAD
+'
+
 test_done
-- 
2.15.0-rc1-158-gbd035ae683

