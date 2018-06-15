Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B8D1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 04:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeFOEbP (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 00:31:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56091 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeFOEbO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 00:31:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5CFB83939;
        Fri, 15 Jun 2018 00:31:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=sRT
        kw+EBXIqO/flqNFuiSt8pwDU=; b=i3Gwro7SN7PbZQMElmUi6Eud1GUkdpvCgZu
        xhYKxFuYEvuWl3J3Oi4WEICXoaP5HcaOCVjGuTsJ6l4AiSfVfKeRnYnUUNKDkU1V
        LarkfqWvdVDmrbqnM+G1c5VsGiDxpb8lNDAFkoFR5w7+ykvcZW637HSZplayAgF5
        Qnt6wIJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:mime-version:content-type; q=dns; s=sasl; b=
        RhoD1LHrA+rBYp0H+R1rkOhR+gLXyOyFQtT13fsL/6oKcWxTUMCwin660d3ilT2b
        1xwzpTNIHU0+c9FXkPSTKCWZ2dTQgAH1h9L3VcAd52QmJefqTP4ceCkYsOUDENX+
        tUbqGipo6AZtUQHd5hbksqyT/Ycaw9K8DMgAfCAWkz8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE27B83938;
        Fri, 15 Jun 2018 00:31:13 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49F0583937;
        Fri, 15 Jun 2018 00:31:13 -0400 (EDT)
Date:   Fri, 15 Jun 2018 00:31:11 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: BUG: sequencer.c:795: root commit without message -- when rewording
 root commit
Message-ID: <20180615043111.GS3094@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: EF90448C-7054-11E8-BF98-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

I was splitting a repository tonight and ran 'rebase -i
--root' to reword the initial commit. Then git died with
'BUG: sequencer.c:795: root commit without message.'

A simple test case to show the failure:

-- >8 --
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 59c766540..bc5e228b8 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -971,6 +971,14 @@ test_expect_success 'rebase -i --root fixup root commit' '
 	test 0 = $(git cat-file commit HEAD | grep -c ^parent\ )
 '
 
+test_expect_success 'rebase -i --root reword root commit' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout -b reword-root-branch master &&
+	set_fake_editor &&
+	FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" git rebase -i --root &&
+	git show HEAD^ | grep "A changed"
+'
+
 test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-interactive rebase' '
 	git reset --hard &&
 	git checkout conflict-branch &&
-- >8 --

Not surprisingly (among the commits which changed between
2.17.1 and 2.18.0-rc2, at least), git bisect points to
21d0764c82 ("rebase -i --root: let the sequencer handle even
the initial part", 2018-05-04).  With luck, the fix will be
obvious to trained eyes and can be added before 2.18.0. :)

Thanks,

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
All decent people live beyond their incomes nowadays, and those who
aren't respectable live beyond other peoples'.
    -- Saki

