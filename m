Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8369A1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 10:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeHTNpg (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 09:45:36 -0400
Received: from forward102o.mail.yandex.net ([37.140.190.182]:45002 "EHLO
        forward102o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726060AbeHTNpg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Aug 2018 09:45:36 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2018 09:45:33 EDT
Received: from mxback3g.mail.yandex.net (mxback3g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:164])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id 7B4A95A04359
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 13:22:43 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback3g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id h2S08dPI6L-MhHuOLG2;
        Mon, 20 Aug 2018 13:22:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1534760563;
        bh=P308eRHK2Tmfgo+I4INxiEmD6jae9FOl0TglPFgeEFM=;
        h=To:From:Subject:Message-ID:Date;
        b=OseSXR8cbktSUjvNemKbxZ/0v2tI+tgcvx6b2J8l9kMubBafnXngaFVT0dSj0FDL3
         vk87TqepvBwOWtbuOwOrI6A6gS0cclS/2e5Xp3QzsjYL/3cH4Rhwot0zGJfutC1V0q
         3i/gNsdUZrX6pW7asgm7hnuWCqa0z/5BUDC7UmL4=
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id qNFUXY1h6V-MgpC0LQo;
        Mon, 20 Aug 2018 13:22:42 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1534760562;
        bh=P308eRHK2Tmfgo+I4INxiEmD6jae9FOl0TglPFgeEFM=;
        h=To:From:Subject:Message-ID:Date;
        b=T4GA9+VhoLtPSI/ihwRBb456+imE1ZtYSjTNMmfdpdC99ZwNnCNwWldsXwfuRC5iL
         1CINOI4JZM2mcbiTwGIUa1gC4tNqqf3BDV2vnbIFEDag/UM5Dv/lRwMSUdhcYqk6VH
         aDi59ldkMkGtLid/nl5LnuU4NXCmtn0Se7gl7I4o=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
To:     git@vger.kernel.org
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
Subject: Do not raise conflict when a code in a patch was already added
Message-ID: <fae8346d-398f-e984-5aa5-e3dc3ee71d70@yandex.ru>
Date:   Mon, 20 Aug 2018 13:22:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, steps-to-reproduce below rather full of trivia like setting up a
repo, but the TL;DR is:

Upon using `git rebase -i HEAD~1` and then `git add -p` to add part of a
"hunk" as one commit, and then using `git rebase --continue` so the
other part of hunk would be left in top commit; git raises a conflict.

It's spectacular, that content of one of inserted conflict markers is
empty, so all you have to do is to remove the markers, and use `git add`
on the file, and then `git rebase --continue`

Its a lot of unncessary actions, git could just figure that the code it
sees in the patch is already there, being a part of another commit.

Maybe git could issue a warning, or to question a user interactively 
(y/n); but raising a conflict IMO is unnecessary.

# Steps to reproduce

In empty dir execute:

	$ git init
	$ touch test
	Initialized empty Git repository in /tmp/test/.git/
	$ git add test
	$ git commit
	[master (root-commit) a7ce543] 1st commit
	 1 file changed, 2 insertions(+)
	 create mode 100644 test
	$ echo -e "foo\nbar" > test             # content you'll want to break
	$ git add -u && git commit
	[detached HEAD 9e28331] 2-nd commit
	 1 file changed, 2 insertions(+)
	$ git rebase -i --root
	Stopped at a7ce543...  1st commit
	You can amend the commit now, with

	  git commit --amend

	Once you are satisfied with your changes, run

	  git rebase --continue

Put "edit" for the 2-nd commit

	$ git reset HEAD^
	Unstaged changes after reset:
	M       test
	$ git add -p
	diff --git a/test b/test
	index e69de29..3bd1f0e 100644
	--- a/test
	+++ b/test
	@@ -0,0 +1,2 @@
	+foo
	+bar
	Stage this hunk [y,n,q,a,d,e,?]? e

	╭─constantine@constantine-N61Ja  /tmp/test ‹node-›  ‹› (e721fa3*)
	╰─$ git commit
	[detached HEAD 27b2f63] add foo
	 1 file changed, 1 insertion(+)
	╭─constantine@constantine-N61Ja  /tmp/test ‹node-›  ‹› (27b2f63*)
	╰─$ git rebase --continue
	test: needs update
	You must edit all merge conflicts and then
	mark them as resolved using git add

What happened is that it's obvious that the hunk was broken to multiple
commits, and git should figure that out, and not to raise a conflict.

Side note: for some reason in the test git didn't insert conflict
markers. It did in real-world usecase though, and there was simply no
content inside one of them.
