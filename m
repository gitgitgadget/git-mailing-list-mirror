Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B84DC433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 09:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJCI75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 04:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiJCI7b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 04:59:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91BE62E4
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 01:45:07 -0700 (PDT)
Received: (qmail 30378 invoked by uid 109); 3 Oct 2022 08:45:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Oct 2022 08:45:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21703 invoked by uid 111); 3 Oct 2022 08:45:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Oct 2022 04:45:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Oct 2022 04:45:05 -0400
From:   Jeff King <peff@peff.net>
To:     "Michael V. Scovetta" <michael.scovetta@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH] sequencer: detect author name errors in read_author_script()
Message-ID: <YzqhEcTDwMwa8dQX@coredump.intra.peff.net>
References: <CADG3Mza_QU+ceTUsMYxJ3PzsEqi8M98oOBAzzz0GHRJ-F7vkpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADG3Mza_QU+ceTUsMYxJ3PzsEqi8M98oOBAzzz0GHRJ-F7vkpA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 02, 2022 at 11:39:16PM -0700, Michael V. Scovetta wrote:

> In commit 2a7d63a2, sequencer.c:912 looks like:
> 912  if (name_i == -2)
> 913      error(_("missing 'GIT_AUTHOR_NAME'"));
> 914  if (email_i == -2)
> 915      error(_("missing 'GIT_AUTHOR_EMAIL'"));
> 916  if (date_i == -2)
> 917      error(_("missing 'GIT_AUTHOR_DATE'"));
> 918  if (date_i < 0 || email_i < 0 || date_i < 0 || err)    <-- date_i
> is referenced here twice
> 919      goto finish;
> 
> I'm fairly sure that line 918 should be:
> 918  if (name_i < 0 || email_i < 0 || date_i < 0 || err)

Agreed, but +cc Phillip as the original author.

> I haven't validated this, but I suspect that if
> `rebase-merge/author-script` contained two GIT_AUTHOR_NAME fields,
> then name_i would be set to -1 (by the error function), but control
> wouldn't flow to finish, but instead to line 920 ( *name =
> kv.items[name_i].util; ) where it would attempt to access memory
> slightly outside of items' memory space.

Correct. It also happens if GIT_AUTHOR_NAME is missing.

> I haven't been able to actually trigger the bug, but strongly suspect
> I'm just not familiar enough with how rebasing works under the covers.

It's a little tricky, because we avoid writing and reading the
author-script file unless necessary. An easy way to need it is to break
with a conflict (which writes it), and then resume with "git rebase
--continue" (which reads it back while committing).

Here's a patch to fix it. Thanks for your report!

-- >8 --
Subject: sequencer: detect author name errors in read_author_script()

As we parse the author-script file, we check for missing or duplicate
lines for GIT_AUTHOR_NAME, etc. But after reading the whole file, our
final error conditional checks "date_i" twice and "name_i" not at all.
This not only leads to us failing to abort, but we may do an
out-of-bounds read on the string_list array.

The bug goes back to 442c36bd08 (am: improve author-script error
reporting, 2018-10-31), though the code was soon after moved to this
spot by bcd33ec25f (add read_author_script() to libgit, 2018-10-31).
It was presmably just a typo in 442c36bd08.

We'll add test coverage for all the error cases here, though only the
GIT_AUTHOR_NAME ones fail (even in a vanilla build they to segfault
consistently, but certainly with SANITIZE=address).

Reported-by: Michael V. Scovetta <michael.scovetta@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
The tests kind of feel like overkill, as this is such a specific
condition and I doubt we'd regress to have the same bug twice. But it
was nice at least to confirm the bug and the fix now.

 sequencer.c                    |  2 +-
 t/t3438-rebase-broken-files.sh | 53 ++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100755 t/t3438-rebase-broken-files.sh

diff --git a/sequencer.c b/sequencer.c
index d26ede83c4..83e0425b04 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -915,7 +915,7 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 		error(_("missing 'GIT_AUTHOR_EMAIL'"));
 	if (date_i == -2)
 		error(_("missing 'GIT_AUTHOR_DATE'"));
-	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
+	if (name_i < 0 || email_i < 0 || date_i < 0 || err)
 		goto finish;
 	*name = kv.items[name_i].util;
 	*email = kv.items[email_i].util;
diff --git a/t/t3438-rebase-broken-files.sh b/t/t3438-rebase-broken-files.sh
new file mode 100755
index 0000000000..e68aac4b36
--- /dev/null
+++ b/t/t3438-rebase-broken-files.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+test_description='rebase behavior when on-disk files are broken'
+. ./test-lib.sh
+
+test_expect_success 'set up conflicting branches' '
+	test_commit base file &&
+	git checkout -b branch1 &&
+	test_commit one file &&
+	git checkout -b branch2 HEAD^ &&
+	test_commit two file
+'
+
+check_broken_author () {
+	title=$1; shift
+	script=$1; shift
+
+	test_expect_success "$title" '
+		# create conflicted state
+		test_when_finished "git rebase --abort" &&
+		git checkout -B tmp branch2 &&
+		test_must_fail git rebase branch1 &&
+
+		# break author-script
+		'"$script"' &&
+
+		# resolving notices broken author-script
+		echo resolved >file &&
+		git add file &&
+		test_must_fail git rebase --continue
+	'
+}
+
+for item in NAME EMAIL DATE
+do
+	check_broken_author "detect missing GIT_AUTHOR_$item" '
+		grep -v $item .git/rebase-merge/author-script >tmp &&
+		mv tmp .git/rebase-merge/author-script'
+done
+
+for item in NAME EMAIL DATE
+do
+	check_broken_author "detect duplicate GIT_AUTHOR_$item" '
+		grep -i $item .git/rebase-merge/author-script >tmp &&
+		cat tmp >>.git/rebase-merge/author-script'
+done
+
+check_broken_author 'unknown key in author-script' '
+	echo "GIT_AUTHOR_BOGUS=${SQ}whatever${SQ}" \
+		>>.git/rebase-merge/author-script'
+
+
+test_done
-- 
2.38.0.rc2.657.gc449b89570

