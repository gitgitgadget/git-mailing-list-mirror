Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FCDC77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 19:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjEJTKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 15:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbjEJTKG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 15:10:06 -0400
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FF930DE
        for <git@vger.kernel.org>; Wed, 10 May 2023 12:10:05 -0700 (PDT)
From:   Toon Claes <toon@iotcl.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1683745260;
        bh=AnzwLvyDdH6v08aYflE4HllM+EcqPfT9W9BO/W3kt/o=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=eL+a0SZAlxmo/JAEM+vJZron6rZFJh68cuNXmPlpPj7C265InVzV1rraSD5MH1mPx
         k85T+d/cM0DcnGzQbKeMu+82ljQU8NQe0CFJYp37X3jovgzuOQOanP9qaJlWdkP5XN
         t77jrHh9bcx922yKW8h7p76C3bbxCb1QFFOAqgzGk9/co7NPpDeyitj1pZeATdHxpQ
         FZCv+wKZEQIVtCz0Ef6zsyvoQTPmkZZFDCO7rnyqhDVRLwyBTiPvYKqIeDgE5QuMld
         Rw6gT4ObmTuPjfL9WRQoMRNmzspmexfaFzCXeBada36Ev18PyGycugnXnh2nN+yyIH
         JpEi0PiR2o3jQ==
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Toon Claes <toon@iotcl.com>
Subject: [PATCH v5 0/1] cat-file: quote-format name in error when using -z
Date:   Wed, 10 May 2023 21:01:15 +0200
Message-Id: <20230510190116.795641-1-toon@iotcl.com>
In-Reply-To: <xmqqilfhctrr.fsf@gitster.g>
References: <xmqqilfhctrr.fsf@gitster.g>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the fifth revision of this patch. The code changes are identical to v3,
but there was one comment[1] about adding test coverage for
batch_object_write(). In v4 I tried another approach, but that didn't work well.
So for this version I'm just adding the test to version 3 as requested. See
below the range-diff against v3, ignoring v4 ever happened.

Kind regards,
Toon

[1]: https://public-inbox.org/git/2a2a46f0-a9bc-06a6-72e1-28800518777c@dunelm.org.uk/

Toon Claes (1):
  cat-file: quote-format name in error when using -z

 builtin/cat-file.c  | 19 +++++++++++++++++++
 t/t1006-cat-file.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

Range-diff against v3:
1:  16f7a123d8 ! 1:  14bccfa9fd cat-file: quote-format name in error when using -z
    @@ t/t1006-cat-file.sh: test_expect_success FUNNYNAMES '--batch-check, -z with newl
     +	printf "\"HEAD:newline\\\\nmissing\" missing\n" >expect &&
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success FUNNYNAMES '--batch-check, -z with missing object having newline in name' '
    ++	git init missing-object-newline &&
    ++	(
    ++		cd missing-object-newline &&
    ++		file="newline${LF}embedded" &&
    ++		echo_without_newline "hello" > $file &&
    ++		git add "$file" &&
    ++		git commit -m "file with newline embedded" &&
    ++		test_tick &&
    ++
    ++		sha1=$(git rev-parse HEAD:"$file") &&
    ++		rm .git/objects/$(test_oid_to_path $sha1) &&
    ++		printf "HEAD:$file" >in &&
    ++		git cat-file --batch-check -z <in >actual &&
    ++		printf "\"HEAD:newline\\\\nembedded\" missing\n" >expect &&
    ++		test_cmp expect actual
    ++	)
    ++'
     +
      batch_command_multiple_info="info $hello_sha1
      info $tree_sha1
--
2.40.1
