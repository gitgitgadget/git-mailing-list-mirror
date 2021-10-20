Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16BCC433FE
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917AF60F9E
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJTBIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 21:08:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37020 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229741AbhJTBIr (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Oct 2021 21:08:47 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E186360DE2;
        Wed, 20 Oct 2021 01:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634691993;
        bh=S4IMMovLTKF9YmTInA45gWjXq7INKAXkYrxCInX1wkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=nrG1eQN9YPZ5dI3NfbvqqhKM1eSTUTPx670/IRokuMIXsSfOZl90MtsTZGpTAgQAo
         Rai6vafz7qMkUPxada4BNGFlijCl5Qx1CLb32r2RpTwlv3a3JK72M4BCkxeXvg1nZl
         mSTk5k4goW7UPh2YrehKcoXfZPyzLcOOcUN8deIZ0rYGollQxpxiVQZ7Wb697Y/Dys
         jTII8hFKd3DpV83g3SA/j8hB+2UGkaY0m6q+r/cFMYEUJbg8obBN6zfX7dG2RhXVXP
         O9H8ZvIKx/ErxmCidQasmm3yWEB9oZKK8HU9lwIl9S9FNj4Jsbviv6ub98/c4WLpMO
         z1IXVAUOAkjlT6L2G7TDcM11lGXem/3hlZ7XE0Up1yailtzOaEgQouAT+H0IgJwaHm
         jFjydnzPd+nS9AnlsO/IXKBhWunf0twVkKOPY0k9woLVA8soHA89Uee4kLP/beo+Jm
         Ju9ENtAPJCOvQFe6uk3mC/MyHq+Sa/oyQHpHP4nVZa1WjJXxNCZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 4/4] gitfaq: add entry about syncing working trees
Date:   Wed, 20 Oct 2021 01:06:24 +0000
Message-Id: <20211020010624.675562-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2
In-Reply-To: <20211020010624.675562-1-sandals@crustytoothpaste.net>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users very commonly want to sync their working tree across machines,
often to carry across in-progress work or stashes.  Despite this not
being a recommended approach, users want to do it and are not dissuaded
by suggestions not to, so let's recommend a sensible technique.

The technique that many users are using is their preferred cloud syncing
service, which is a bad idea.  Users have reported problems where they
end up with duplicate files that won't go away (with names like "file.c
2"), broken references, oddly named references that have date stamps
appended to them, missing objects, and general corruption and data loss.
That's because almost all of these tools sync file by file, which is a
great technique if your project is a single word processing document or
spreadsheet, but is utterly abysmal for Git repositories because they
don't necessarily snapshot the entire repository correctly.  They also
tend to sync the files immediately instead of when the repository is
quiescent, so writing multiple files, as occurs during a commit or a gc,
can confuse the tools and lead to corruption.

We know that the old standby, rsync, is up to the task, provided that
the repository is quiescent, so let's suggest that and dissuade people
from using cloud syncing tools.  Let's tell people about common things
they should be aware of before doing this and that this is still
potentially risky.  Additionally, let's tell people that Git's security
model does not permit sharing working trees across users in case they
planned to do that.  While we'd still prefer users didn't try to do
this, hopefully this will lead them in a safer direction.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 43 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 85ac99c7b2..4a8a46f980 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -83,8 +83,8 @@ Windows would be the configuration `"C:\Program Files\Vim\gvim.exe" --nofork`,
 which quotes the filename with spaces and specifies the `--nofork` option to
 avoid backgrounding the process.
 
-Credentials
------------
+Credentials and Transfers
+-------------------------
 
 [[http-credentials]]
 How do I specify my credentials when pushing over HTTP?::
@@ -185,6 +185,45 @@ Then, you can adjust your push URL to use `git@example_author` or
 `git@example_committer` instead of `git@example.org` (e.g., `git remote set-url
 git@example_author:org1/project1.git`).
 
+[[sync-working-tree]]
+How do I sync a working tree across systems?::
+	First, decide whether you want to do this at all.  Git usually works better
+	when you push or pull your work using the typical `git push` and `git fetch`
+	commands and isn't designed to share a working tree across systems.  Doing so
+	can cause `git status` to need to re-read every file in the working tree.
+	Additionally, Git's security model does not permit sharing a working tree
+	across untrusted users, so it is only safe to sync a working tree if it will
+	only be used by a single user across all machines.
++
+Therefore, it's better to push your work to either the other system or a central
+server using the normal push and pull mechanism.  However, this doesn't always
+preserve important data, like stashes, so some people prefer to share a working
+tree across systems.
++
+It is important not to use a cloud syncing service to sync any portion of a Git
+repository, since this can cause corruption, such as missing objects, changed
+or added files, broken refs, and a wide variety of other corruption.  These
+services tend to sync file by file and don't understand the structure of a Git
+repository.  This is especially bad if they sync the repository in the middle of
+it being updated, since that is very likely to cause incomplete or partial
+updates and therefore data loss.
++
+The recommended approach is to use `rsync -a --delete-after` (ideally with an
+encrypted connection such as with `ssh`) on the root of repository.  You should
+ensure several things when you do this:
++
+* There are no additional worktrees enabled for your repository.
+* You are not using a separate Git directory outside of your repository root.
+* You are comfortable with the destination directory being an exact copy of the
+	source directory, _deleting any data that is already there_.
+* The repository is in a quiescent state for the duration of the transfer (that
+	is, no operations of any sort are taking place on it, including background
+	operations like `git gc`).
++
+Be aware that even with these recommendations, syncing in this way is
+potentially risky since it bypasses Git's normal integrity checking for
+repositories, so having backups is advised.
+
 Common Issues
 -------------
 
