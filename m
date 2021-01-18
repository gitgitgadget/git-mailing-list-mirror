Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA73C433E9
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D062122E00
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388997AbhARVHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 16:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389945AbhARVD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 16:03:26 -0500
X-Greylist: delayed 147 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jan 2021 13:02:37 PST
Received: from dandelion.mymedia.su (unknown [IPv6:2604:180:2:1574::c9e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E662C061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 13:02:37 -0800 (PST)
Received: from dandelion.mymedia.su (localhost.localdomain [127.0.0.1])
        by dandelion.mymedia.su (8.15.2/8.15.2/Debian-3) with ESMTP id 10IL054O024920;
        Tue, 19 Jan 2021 00:00:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=guriev.su; s=default;
        t=1611003606; bh=T8i/p75Hagey49gEz3nund4g2VcBg50mFNCF73AlG2U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Yl5AanTQDYpOj8UvmFRq6AhLY80LRTHLBdwiByrkvZ/Jg4zaH3aT8Z0WwMURE787/
         DZidbYrMWto0rjngV0M/Zc+EXrU5N9S96EhRexWat3yWHhSEzuGycJtqr0xU+rj1lx
         ieNFMddvgxbQRjcSrbC7s9yci0mula5kD8S3jddA=
Received: (from mymedia@localhost)
        by dandelion.mymedia.su (8.15.2/8.15.2/Submit) id 10IL04DX024919;
        Tue, 19 Jan 2021 00:00:04 +0300
From:   Nicholas Guriev <nicholas@guriev.su>
To:     git@vger.kernel.org
Subject: [RFC PATCH v2 0/3] implement tabbed mode in difftools
Date:   Tue, 19 Jan 2021 00:00:00 +0300
Message-Id: <20210118210003.3071205-1-nicholas@guriev.su>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <2fb58fd30ae730ccd3e88ec51b5fe6d80ab7a8c7.camel@guriev.su>
References: <2fb58fd30ae730ccd3e88ec51b5fe6d80ab7a8c7.camel@guriev.su>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this mode the "git difftool" command opens all compared files via single
invocation of an editor passing to it entire list of the changed files. I find
it useful, and it allows a user to switch easily forward and back between the
files. You will find some screenshots demonstrating the feature in my previous
message.

The patch series looks better now, and the two problems mentioned earlier have
been solved. I added a new static function, forget_tempfile, into the diff.c
file. It cleans diff_temp structures and do not remove the temporary files.
They anyway would be deleted in an atexit handler. In this way, I can collect
content of all changed files before running the editor.

For solving the second problem with spaces, I am separating file names with
line-feeds, '\n', that are less common. This restriction is the same with the
"git mergetool" command. I think it is acceptable at the present stage.

I have also repaired prompting in the tabbed mode. In such case, the command
asks a user only once right before starting the editor. And I have described
briefly the new changes to the best of my ability.

Alas, some other problems still remain. First, some automated tests failed that
related to the difftool.prompt setting. I have modified its behavior a bit and
it now contains a loop. Second, there are no new tests, yet I am going to add
them later. And third, the main remaining problem is the method of calling of
the difftool helper. I do not like that I have to write temporary files in the
helper code to store its state between invocations. But maybe, someone offer a
better solution that is easy to incorporate into the current architecture.

In conclusion, the patches are still not ready for merging, and any comments or
testing are welcome.


Nicholas Guriev (3):
  mergetools: support difftool.tabbed setting
  difftool-helper: conciliate difftool.tabbed and difftool.prompt
    settings
  doc: describe new difftool.tabbed feature

 Documentation/config/difftool.txt |  6 +++
 Documentation/git-difftool.txt    | 19 ++++++++--
 Documentation/git.txt             |  4 ++
 builtin/difftool.c                |  7 +++-
 diff.c                            | 10 ++++-
 git-difftool--helper.sh           | 39 ++++++++++++-------
 git-mergetool--lib.sh             | 62 ++++++++++++++++++++++++++++++-
 mergetools/meld                   |  4 ++
 mergetools/vimdiff                | 17 +++++++++
 9 files changed, 148 insertions(+), 20 deletions(-)

-- 
2.27.0

