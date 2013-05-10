From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 8/8] rebase: implement --[no-]autostash and rebase.autostash
Date: Fri, 10 May 2013 10:41:05 -0400
Message-ID: <CAPig+cQuWTfDqoF4G_Sk5_9VWKffpqmGC2WxXeF9DCyDxLx16A@mail.gmail.com>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
	<1368196005-5354-9-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 16:41:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoVm-0008HG-44
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756954Ab3EJOlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:41:11 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:57658 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820Ab3EJOlI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:41:08 -0400
Received: by mail-lb0-f180.google.com with SMTP id v1so4215854lbd.25
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=LbHZIZzWPJrJlKJw4FisOHvFM9HquCUudKD2bFxu6Sk=;
        b=qmZQxRHI4Jn3SJSanbf8AsolF45WeX4F/NroWnZG0JQ9PMQG9XYNs340GORnTUre0b
         WW0drvWra1eZ6KBZL78BqfiL1Eki5yYFGIKs++py0sBD/tObHxxdvbo2JmC4orsv8GJw
         ZQbi/GZ14eyFpIUt680z4Oyhb1trnhEfnXbD7TiweQptp+xtkHKdytfAGpoU2zeLE+1Q
         O+uGuEd4xlPn/Aw1x7viLD//BOeNHZWMuDP9xuZ7D39UgNxyWGChD+r4a8hq5xlXktmN
         vTadEFt2AJ6+e562SLsx/+p5JURC972voNfOdKtqG9k5ZoaWHmSj1gAva53wOF0DEkpK
         +9gA==
X-Received: by 10.112.137.9 with SMTP id qe9mr7728155lbb.64.1368196865901;
 Fri, 10 May 2013 07:41:05 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Fri, 10 May 2013 07:41:05 -0700 (PDT)
In-Reply-To: <1368196005-5354-9-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: 2OxSj9mICLywXJXNrpDS_0ST15c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223856>

On Fri, May 10, 2013 at 10:26 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> new file mode 100755
> index 0000000..8386998
> --- /dev/null
> +++ b/t/t3420-rebase-autostash.sh
> @@ -0,0 +1,148 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2013 Ramkumar Ramachandra
> +#
> +
> +test_description='git rebase --autostash tests'
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +       echo hello-world >file0 &&
> +       git add . &&
> +       test_tick &&
> +       git commit -m "initial commit" &&
> +       git checkout -b feature-branch &&
> +       echo another-hello >file1 &&
> +       echo goodbye >file2 &&
> +       git add . &&
> +       test_tick &&
> +       git commit -m "second commit" &&
> +       echo final-goodbye >file3 &&
> +       git add . &&
> +       test_tick &&
> +       git commit -m "third commit"

Broken &&-chain.

> +       git checkout -b unrelated-onto-branch master &&
> +       echo unrelated >file4 &&
> +       git add . &&
> +       test_tick &&
> +       git commit -m "unrelated commit"

Broken &&-chain.

> +       git checkout -b related-onto-branch master &&
> +       echo conflicting-change >file2 &&
> +       git add . &&
> +       test_tick &&
> +       git commit -m "related commit"
> +'
> +
> +testrebase() {
> +       type=$1
> +       dotest=$2
> +
> +       test_expect_success "rebase$type: dirty worktree, non-conflicting rebase" '
> +               test_config rebase.autostash true &&
> +               git reset --hard &&
> +               git checkout -b rebased-feature-branch feature-branch &&
> +               test_when_finished git branch -D rebased-feature-branch &&
> +               echo dirty >>file3 &&
> +               git rebase$type unrelated-onto-branch &&
> +               grep unrelated file4 &&
> +               grep dirty file3 &&
> +               git checkout feature-branch
> +       '
> +
> +       test_expect_success "rebase$type: dirty index, non-conflicting rebase" '
> +               test_config rebase.autostash true &&
> +               git reset --hard &&
> +               git checkout -b rebased-feature-branch feature-branch &&
> +               test_when_finished git branch -D rebased-feature-branch

Broken &&-chain.

> +               echo dirty >>file3 &&
> +               git add file3 &&
> +               git rebase$type unrelated-onto-branch &&
> +               grep unrelated file4 &&
> +               grep dirty file3 &&
> +               git checkout feature-branch
> +       '
> +
> +       test_expect_success "rebase$type: conflicting rebase" '
> +               test_config rebase.autostash true &&
> +               git reset --hard &&
> +               git checkout -b rebased-feature-branch feature-branch &&
> +               test_when_finished git branch -D rebased-feature-branch &&
> +               echo dirty >>file3 &&
> +               test_must_fail git rebase$type related-onto-branch &&
> +               test_path_is_file $dotest/autostash &&
> +               ! grep dirty file3 &&
> +               rm -rf $dotest &&
> +               git reset --hard &&
> +               git checkout feature-branch
> +       '
> +
> +       test_expect_success "rebase$type: --continue" '
> +               test_config rebase.autostash true &&
> +               git reset --hard &&
> +               git checkout -b rebased-feature-branch feature-branch &&
> +               test_when_finished git branch -D rebased-feature-branch &&
> +               echo dirty >>file3 &&
> +               test_must_fail git rebase$type related-onto-branch &&
> +               test_path_is_file $dotest/autostash &&
> +               ! grep dirty file3 &&
> +               echo "conflicting-plus-goodbye" >file2 &&
> +               git add file2 &&
> +               git rebase --continue &&
> +               test_path_is_missing $dotest/autostash &&
> +               grep dirty file3 &&
> +               git checkout feature-branch
> +       '
> +
> +       test_expect_success "rebase$type: --skip" '
> +               test_config rebase.autostash true &&
> +               git reset --hard &&
> +               git checkout -b rebased-feature-branch feature-branch &&
> +               test_when_finished git branch -D rebased-feature-branch &&
> +               echo dirty >>file3 &&
> +               test_must_fail git rebase$type related-onto-branch &&
> +               test_path_is_file $dotest/autostash &&
> +               ! grep dirty file3 &&
> +               git rebase --skip &&
> +               test_path_is_missing $dotest/autostash &&
> +               grep dirty file3 &&
> +               git checkout feature-branch
> +       '
> +
> +       test_expect_success "rebase$type: --abort" '
> +               test_config rebase.autostash true &&
> +               git reset --hard &&
> +               git checkout -b rebased-feature-branch feature-branch &&
> +               test_when_finished git branch -D rebased-feature-branch &&
> +               echo dirty >>file3 &&
> +               test_must_fail git rebase$type related-onto-branch &&
> +               test_path_is_file $dotest/autostash &&
> +               ! grep dirty file3 &&
> +               git rebase --abort &&
> +               test_path_is_missing $dotest/autostash &&
> +               grep dirty file3 &&
> +               git checkout feature-branch
> +       '
> +
> +       test_expect_success "rebase$type: non-conflicting rebase, conflicting stash" '
> +               test_config rebase.autostash true &&
> +               git reset --hard &&
> +               git checkout -b rebased-feature-branch feature-branch &&
> +               test_when_finished git branch -D rebased-feature-branch &&
> +               echo dirty >file4 &&
> +               git add file4 &&
> +               git rebase$type unrelated-onto-branch &&
> +               test_path_is_missing $dotest &&
> +               git reset --hard &&
> +               grep unrelated file4 &&
> +               ! grep dirty file4 &&
> +               git checkout feature-branch &&
> +               git stash pop &&
> +               grep dirty file4
> +       '
> +}
> +
> +testrebase "" .git/rebase-apply
> +testrebase " --merge" .git/rebase-merge
> +testrebase " --interactive" .git/rebase-merge
> +
> +test_done
