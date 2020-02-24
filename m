Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F4CC35671
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 14:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0940B20836
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 14:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="jyeGHhNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgBXOKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:10:17 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:58904 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgBXOKR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 09:10:17 -0500
Date:   Mon, 24 Feb 2020 14:10:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
        t=1582553414; bh=xzW9UHpKSOLAHn/tKTSYotGhS0JyjP7j91spiwccJhg=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=jyeGHhNQqa64flaovJoPJSRTn83MrSoGzJDTNKMt19kqFQp5cQbRo22nDYDq5Q5UQ
         dVIgr+LKZlgsfWkzltQDqVoEEytaKQIpd0DDyiKbT40gi1SAq0KN9q4Dhih8GirTS2
         9AQ6QoY1KBTosU/3BAIkU2PzHqFKgjkJOdKS0xXnZsVguEsy3c0kz99TSVv70IlFae
         yzXBQeThc7KnPO6MDiUovSv8TEoGyZ/sHYHuAcabzP36N18WNKD159ha0qOz9q7bTT
         15udIAOeSc0hCeD3Rjy37zbC39ZOuSFpCIR87l7kiX//8fCs23rU7KCWJXopUmeGmQ
         i1gOL6M57AN4g==
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Robin Moussu <moussu.robin@pm.me>
Reply-To: Robin Moussu <moussu.robin@pm.me>
Subject: Inconsistancy with `git rebase --preserve-merges`
Message-ID: <tmm3ViXf1QO5dCCNgDCHCHSZeUKUfiYvNoI9RMvdLlnOLk0oUt_w2SKgYu3LPh6no-wHhq1gXbVlBKgLcnGCR5HaTgWMx5se9KmJOKITUHk=@pm.me>
In-Reply-To: <v9k9hyJjfgQYYIczd9NqrjSdyOyxwqEB0iWyQ_TZCnobCZZoZ8_v6WB4KcWyW5xxRPdDUyEqEYfXylOnGI57CtK9KegMgp_0bz_5RrIIhHY=@pm.me>
References: <v9k9hyJjfgQYYIczd9NqrjSdyOyxwqEB0iWyQ_TZCnobCZZoZ8_v6WB4KcWyW5xxRPdDUyEqEYfXylOnGI57CtK9KegMgp_0bz_5RrIIhHY=@pm.me>
Feedback-ID: aDYrvZs6ibdj6QB6JtxRZ8AYBE8j1aX0UyUHN-MWnUOIKikRaDGhDP0rVqj8L64iRq3eEkXGqTYyWi8xkVrR9w==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi. I noticed that the position of the `--preserve-merges` option of
`git rebase` is significant (I think it shouldn't).

The following snippet doesn't preserve the merges:
```
$ git rebase --preserve-merges -i 412f07a~
pick 412f07a Work on dev branch
pick c6efccd Work on master branch
pick 71c8c37 Some work after the merge
```

Whereas this one does what I expect:
```
$ git rebase -i 412f07a~ --preserve-merges
pick 412f07a Work on dev branch
pick 616064c Merge branch 'master' into dev
pick 71c8c37 Some work after the merge
```

For reference:
```
$ git log --graph --oneline
* 71c8c37      (HEAD -> dev) Some work after the merge
*   616064c    Merge branch 'master' into dev
|\
| *   c6efccd  Work on master branch
| *   ... (more work on master)
* |   412f07a  Work on dev branch
* |   ... (more work on dev)
|/
* 4ee50cb Common ancestor
```

Step to reproduce:
```
mkdir temp
cd temp
git init
git commit --allow-empty -m 'Common ancestor'
git checkout -b dev
git commit --allow-empty -m 'Work on dev branch'
git tag some_commit
git checkout master
git commit --allow-empty -m 'Work on master branch'
git checkout dev
git merge master -m 'Merge branch 'master' into dev'
git commit --allow-empty -m 'Some work after the merge'
```
Then you will see that
    git rebase -i some_commit --preserve-merges
and
    git rebase --preserve-merges  -i some_commit
don't have the same output.

I am using git version 2.21.1 on Fedora 30.

Robin.




