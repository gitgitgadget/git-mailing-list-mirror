Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF41C63777
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 22:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E494C2076E
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 22:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgK3W6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 17:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgK3W6L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 17:58:11 -0500
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84a3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852B8C0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 14:57:31 -0800 (PST)
Received: from app19-neu.ox.hosteurope.de ([92.51.170.153]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1kjs6q-0001w4-PN; Mon, 30 Nov 2020 23:57:28 +0100
Date:   Mon, 30 Nov 2020 23:57:27 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org
Message-ID: <1403797985.37893.1606777048311@ox.hosteurope.de>
In-Reply-To: <20201116041051.GA883199@coredump.intra.peff.net>
References: <20201113050631.GA744608@coredump.intra.peff.net>
 <323fd904-a7ee-061d-d846-5da5afbc88b2@virtuell-zuhause.de>
 <20201116041051.GA883199@coredump.intra.peff.net>
Subject: Re: [PATCH 0/5] handling 4GB .idx files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.4-Rev11
X-Originating-IP: 80.153.18.91
X-Originating-Client: open-xchange-appsuite
X-Originating-Sender: thomas@akwgegner.de
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1606777051;eaa07663;
X-HE-SMSGID: 1kjs6q-0001w4-PN
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jeff King <peff@peff.net> hat am 16.11.2020 05:10 geschrieben:

[...]

> So I dunno. I wouldn't be opposed to codifying some of that in 
> a script, but I can't imagine anybody ever running it unless they 
> were working on this specific problem.

Thanks for the pointers.

Below is what I came up with. It passes here. I've replaced awk with cut from the original draft, and also moved the perl script out of the test as I think the quoting is getting way too messy otherwise. And I've added --no-dangling to git fsck as otherwise it takes forever to output the obvious dangling blobs. The unpack limit is mostly for testing the test itself with a smaller amount of blobs. But I still think it is worthwile to force everything into a pack.

--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -97,4 +97,34 @@ test_expect_success 'index version config precedence' '
 	test_index_version 0 true 2 2
 '
 
+{
+	echo "#!$SHELL_PATH"
+	cat <<'EOF'
+	   "$PERL_PATH" -e '
+		for (0..154_000_000) {
+			print "blob\n";
+			print "data <<EOF\n";
+			print "$_\n";
+			print "EOF\n";
+		} '
+EOF
+
+} >dump
+chmod +x dump
+
+test_expect_success EXPENSIVE,PERL 'Test 4GB boundary for the index' '
+	test_config fastimport.unpacklimit 0 &&
+	./dump | git fast-import &&
+	blob=$(echo 0 | git hash-object --stdin) &&
+	git cat-file blob $blob >actual &&
+	echo 0 >expect &&
+	test_cmp expect actual &&
+	idx_pack=$(ls .git/objects/pack/*.idx) &&
+	test_file_not_empty $idx_pack &&
+	final=$(git show-index <$idx_pack | tail -1 | cut -d " " -f2) &&
+	git cat-file blob $final &&
+	git cat-file blob fffffff &&
+	git fsck --strict --no-dangling
+'
+
 test_done
--
