Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 104E31F462
	for <e@80x24.org>; Tue, 30 Jul 2019 17:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfG3Rbw (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 13:31:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63755 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfG3Rbv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 13:31:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BA37173783;
        Tue, 30 Jul 2019 13:31:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6l6P+QurhduEfLgTItMm4z1qLbk=; b=lktaOO
        ARkmUSu3BIDm4lOcp8okKitVaRtjP/ctoNwB1CcQR3skHvAv453td+DtiB7Gaxc6
        zuhyPzs8jNXK9T+LtU/PlaF+1gMA++EpKc3keHWE1bNyO7OAuqahd/gjRGa/NnAe
        tzxN1vpf3AIzbJdFhRMJ1XTMJZF5H60k8J3fY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gl9imFu8dTwJf1jm0dFjZi/knZJosyD5
        /vT6MjcTNXx5yZbBgGL5zk2GkrAV3cVscTrKH6M1Kd7Ds4A0WeYwMaNIEJT+EigP
        ogw8/2vHf0NG5VjYKERvDXcPUHSmNYuf/e9YgJw8yUl8XnG1OmTZuQ+jiazcSMRl
        oTJbj+KTOaw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92C75173782;
        Tue, 30 Jul 2019 13:31:44 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F41ED173781;
        Tue, 30 Jul 2019 13:31:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>, <git-packagers@googlegroups.com>
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
Date:   Tue, 30 Jul 2019 10:31:42 -0700
In-Reply-To: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com> (Randall
        S. Becker's message of "Tue, 30 Jul 2019 13:08:37 -0400")
Message-ID: <xmqq7e7zton5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E62D944C-B2EF-11E9-A6D2-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> t0066: dir-iterator
>
> Subtest 4 depends on a non-portable error code. ENOENT is not guaranteed ...
> Subtest 5 also depends on a non-portable error code. ENOTDIR is not gua...

Yikes, and sorry.  I've become somewhat complacent after relying on
how good our other reviewers are, pretty much ignored the new code
in fringes like t/helper/, and failed catch an obvious amateurish
mistake like this one.

I do not think of a portable way to map an int ENOENT to a string
"ENOENT", but there are only only two errors test-dir-iterator test
code cares about, so perhaps a patch like the following may be
sufficient.

I wonder if a tool like sparse can help us catch a pattern that
feeds errno to "%d" format.

 t/helper/test-dir-iterator.c | 11 ++++++++++-
 t/t0066-dir-iterator.sh      |  4 ++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index a5b96cb0dc..c7c30664da 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -4,6 +4,15 @@
 #include "iterator.h"
 #include "dir-iterator.h"
 
+static const char *error_name(int error_number)
+{
+	switch (error_number) {
+	case ENOENT: return "ENOENT";
+	case ENOTDIR: return "ENOTDIR";
+	default: return "ESOMETHINGELSE";
+	}
+}
+
 /*
  * usage:
  * tool-test dir-iterator [--follow-symlinks] [--pedantic] directory_path
@@ -31,7 +40,7 @@ int cmd__dir_iterator(int argc, const char **argv)
 	diter = dir_iterator_begin(path.buf, flags);
 
 	if (!diter) {
-		printf("dir_iterator_begin failure: %d\n", errno);
+		printf("dir_iterator_begin failure: %s\n", error_name(errno));
 		exit(EXIT_FAILURE);
 	}
 
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 9354d3f1ed..92910e4e6c 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -55,13 +55,13 @@ test_expect_success 'dir-iterator should list files in the correct order' '
 test_expect_success 'begin should fail upon inexistent paths' '
 	test_must_fail test-tool dir-iterator ./inexistent-path \
 		>actual-inexistent-path-output &&
-	echo "dir_iterator_begin failure: 2" >expected-inexistent-path-output &&
+	echo "dir_iterator_begin failure: ENOENT" >expected-inexistent-path-output &&
 	test_cmp expected-inexistent-path-output actual-inexistent-path-output
 '
 
 test_expect_success 'begin should fail upon non directory paths' '
 	test_must_fail test-tool dir-iterator ./dir/b >actual-non-dir-output &&
-	echo "dir_iterator_begin failure: 20" >expected-non-dir-output &&
+	echo "dir_iterator_begin failure: ENOTDIR" >expected-non-dir-output &&
 	test_cmp expected-non-dir-output actual-non-dir-output
 '
 
