Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404381FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 16:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933737AbdDFQph (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 12:45:37 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:21220 "EHLO rs224.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933143AbdDFQpb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 12:45:31 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Apr 2017 12:45:31 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=nallar.me; q=dns/txt; s=k1;
 t=1491497124; h=Content-Type: To: Subject: Message-ID: Date: From:
 MIME-Version: Sender; bh=U4PI+ipL6Yq/fYWo1qGB176soevego4QuEqEmFM/8nA=;
 b=nM0qNNTagpBs5apTQoTdorbidYJ8UBbNj+yaSHjgslBz8uhTa6l/t7VCEh+iTmT7ohL+MGqg
 XtywtH54eVBtBzHwSMjgex5/RuRl0gjUJ/Tflh4gp51kLScthcAsWwu/9vGRKYxbH7YXhZP8
 ikzfzZLTxhjqXZ1WAktEe5ijJhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=nallar.me; s=k1; q=dns;
 h=Sender: MIME-Version: From: Date: Message-ID: Subject: To:
 Content-Type;
 b=AApmdgQZJ9LmsS2oE3pHvGfZ+4OmQmItPtJmbFDhSNuVNjPYelt1zxkiTgROYE77hFEMmL
 14K+qYP5VQruamJx7il0Dsy4g3XalBTYkgh+WuLkAN4p5JSHH6cLXcAMjVtjuZL5CewmVIql
 wbBbPDf8+enh6IT4nq6oPeRn7nAYA=
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyI3OWYwNSIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJiZGU3Il0=
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com [209.85.128.176])
 by mxa.mailgun.org with ESMTP id 58e66f72.7f2ec87852b0-smtp-out-n03;
 Thu, 06 Apr 2017 16:40:18 -0000 (UTC)
Received: by mail-wr0-f176.google.com with SMTP id w11so64768696wrc.3
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 09:40:18 -0700 (PDT)
X-Gm-Message-State: AFeK/H29yEGRlBeG3wg6EqKIKh+OkvO494fTjvEVOVwZlgxprQebrsMewJGuaGTs/evPaDCeVzciwv93P/17pw==
X-Received: by 10.223.164.83 with SMTP id e19mr32555773wra.154.1491496816872;
 Thu, 06 Apr 2017 09:40:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.145.88 with HTTP; Thu, 6 Apr 2017 09:39:56 -0700 (PDT)
From:   Ross Allan <ross@nallar.me>
Date:   Thu, 6 Apr 2017 17:39:56 +0100
X-Gmail-Original-Message-ID: <CABZvOEps9HvViW2bKXEUtTbzy1+UbtM_2muBBycDSwBXOTtF7Q@mail.gmail.com>
Message-ID: <CABZvOEps9HvViW2bKXEUtTbzy1+UbtM_2muBBycDSwBXOTtF7Q@mail.gmail.com>
Subject: Sparse-checkout excluded files show as deleted in git status after
 some operations
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sometimes when working on a repository with files excluded using the
sparse checkout feature, the skip-worktree flag is incorrectly unset
causing files to show as deleted in git status.

Initially I reported this to git-for-windows at
https://github.com/git-for-windows/git/issues/811 but was recommended
to go here as it is not a windows specific issue (my mistake there).

It has happened a few times when merging and cherry picking. Here is
an example repository which can be used to demonstrate the issue:
https://github.com/nallar/git-issue-sparse-checkout

The following commands run into the issue.

git clone https://github.com/nallar/git-issue-sparse-checkout.git
mcve-sparse-checkout
cd mcve-sparse-checkout
git config core.sparseCheckout true
cp sparse-checkout .git/info/sparse-checkout
git checkout -f master
git reset --hard HEAD
# We now have sparse checkout enabled, so the folder "excluded-folder"
should not be present
ls
# We should have no changes so far
git status
# Cherry-pick top commit from the other branch
git cherry-pick other
# That cherry-pick succeeded with no conflicts. We should have no
unstaged changes
git status
# Oh dear, now it shows 'deleted:    excluded-folder/1.txt'
# Workaround, set skip-worktree which for some reason got unset:
git update-index --skip-worktree excluded-folder/1.txt
# Now it's showing the correct result again
git status
# no changes

Full log demonstrating issue:
https://gist.github.com/anonymous/e1e29f0eb9df25b506fdf555827c73ac

Thanks
Ross Allan
