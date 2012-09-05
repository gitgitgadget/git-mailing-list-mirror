From: Dan Johnson <computerdruid@gmail.com>
Subject: [PATCHv2] fetch --all: pass --tags/--no-tags through to each remote
Date: Wed,  5 Sep 2012 17:22:19 -0400
Message-ID: <1346880139-2281-1-git-send-email-ComputerDruid@gmail.com>
References: <20120901112251.GA11445@sigill.intra.peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <ossi@kde.org>,
	Dan Johnson <ComputerDruid@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 05 23:22:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9N3Q-0001dW-2z
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 23:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759492Ab2IEVWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 17:22:24 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:55773 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab2IEVWX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 17:22:23 -0400
Received: by ghrr11 with SMTP id r11so189132ghr.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 14:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jCuzvzFYxHrwMXdjfvRhTp3Foj14qUwzk15+/39IAwQ=;
        b=bFdfc45gvMnlGBXG3UbpINNd0TvajHJKRGhCbVLGg+Dhcyi7QZgKSS08Lk4xnnoQFN
         4gXCG524wtveMRG+oSzJKXaxHsoeJVZBsOcgGEprMiUF2GoejOHk39fc60CrFd3kRSdZ
         ZdpZDG5N6dSmmBP/EsCAqx8jlFJgUoABjfYACprgzuIZFYs4YVvBf0tL/pqNDaoX0vMo
         4h37hh8bu01rM8rVwr2+6epvQI9iSeesXloma9FJIAjVJGpePpNvHG45t4/QUlP0S+dV
         LlA12LG6hFoeLOqqMjw2d6x7S+uIX9ZAuYFPyRJN84a3p3FsKWK2KTV9myh4ea0dYd6Z
         5RrQ==
Received: by 10.236.115.102 with SMTP id d66mr23951460yhh.67.1346880142722;
        Wed, 05 Sep 2012 14:22:22 -0700 (PDT)
Received: from spidermine.utk.edu (spidermine.nomad.utk.edu. [216.96.181.180])
        by mx.google.com with ESMTPS id b46sm256206yhm.3.2012.09.05.14.22.20
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 14:22:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.146.g16d26b1
In-Reply-To: <20120901112251.GA11445@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204848>

When fetch is invoked with --all, we need to pass the tag-following
preference to each individual fetch; without this, we will always
auto-follow tags, preventing us from fetching the remote tags into a
remote-specific namespace, for example.

Reported-by: Oswald Buddenhagen <ossi@kde.org>
Signed-off-by: Dan Johnson <ComputerDruid@gmail.com>
---
On Sat, Sep 1, 2012 at 7:22 AM, Jeff King <peff@peff.net> wrote:
>Hmm. We allocate argv in fetch_multiple like this:
>
>  const char *argv[12] = { "fetch", "--append" };
>
>and then add a bunch of options to it, along with the name of the
>remote. By my count, the current code can hit exactly 12 (including the
>terminating NULL) if all options are set. Your patch would make it
>possible to overflow. Of course, I may be miscounting since it is
>extremely error-prone to figure out the right number by tracing each
>possible conditional.
>
>Maybe we should switch it to a dynamic argv_array? Like this:
>
>  [1/2]: argv-array: add pop function
>  [2/2]: fetch: use argv_array instead of hand-building arrays

This version is re-rolled to be on top of jk/argv-array, avoiding the issue of
the fixed-size array entirely. If needed, we could of course use the old
version of this patch and bump the number, but I figure this is preferable.

I've also added some test cases to cover this behavior, but I'm not entirely
happy with them. I'm not sure if/how we should be testing the pass-through
behavior of various arguments with fetch --all, but if so, we should probably do
so more thouroughly than I have here, but that just seems like combining
together tests of two unrelated things. It might just make more sense to ignore
it and drop these tests, I don't know.

Sorry this took me a few days to send, I just kept not getting around to it.

 builtin/fetch.c           |  4 ++++
 t/t5514-fetch-multiple.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6196e91..4494aed 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -858,6 +858,10 @@ static void add_options_to_argv(struct argv_array *argv)
 		argv_array_push(argv, "--recurse-submodules");
 	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
 		argv_array_push(argv, "--recurse-submodules=on-demand");
+	if (tags == TAGS_SET)
+		argv_array_push(argv, "--tags");
+	else if (tags == TAGS_UNSET)
+		argv_array_push(argv, "--no-tags");
 	if (verbosity >= 2)
 		argv_array_push(argv, "-v");
 	if (verbosity >= 1)
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 227dd56..cbd2460 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -151,4 +151,33 @@ test_expect_success 'git fetch --multiple (ignoring skipFetchAll)' '
 	 test_cmp ../expect output)
 '
 
+cat > expect << EOF
+EOF
+
+test_expect_success 'git fetch --all --no-tags' '
+	(git clone one test5 &&
+	 git clone test5 test6 &&
+	 (cd test5 && git tag test-tag) &&
+	 cd test6 &&
+	 git fetch --all --no-tags &&
+	 git tag >output &&
+	 test_cmp ../expect output)
+'
+
+cat > expect << EOF
+test-tag
+EOF
+
+test_expect_success 'git fetch --all --tags' '
+	(git clone one test7 &&
+	 git clone test7 test8 &&
+	 (cd test7 &&
+      test_commit test-tag &&
+      git reset --hard HEAD^) &&
+	 cd test8 &&
+	 git fetch --all --tags &&
+	 git tag >output &&
+	 test_cmp ../expect output)
+'
+
 test_done
-- 
1.7.11.1
