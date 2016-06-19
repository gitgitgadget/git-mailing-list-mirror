Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE59A20189
	for <e@80x24.org>; Sun, 19 Jun 2016 20:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbcFSUwB (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 16:52:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751487AbcFSUwA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 16:52:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CFE224376;
	Sun, 19 Jun 2016 16:51:59 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xzQ9lw3+8S7iN0JR7zJUhS1xtLQ=; b=OvEG7H
	cmOGg+tj/tMyIqttly8ucorNLuZpy+sLdtPNxgu/DywQY/T3q3JW+1t8C10qbYoN
	5L74N/Iw9u5zFdmljOsDi+moiAP1/mUn7f8Fuyi24kxuYoLEX/UKnQ/Za+4kXJBs
	zV/HTx4oEIjHouk/nn9toSfLxSRASpZfmZfb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jLj/3feD9VEFF37viexhO5cNaH9IiG2O
	WgNg0v6jT5iELklc8qgiC+nfDikSDqLJ7uMB1jsqy6r5kzuGv5RXN1AQaZ3G9Jlo
	CUQbT5iffbeHJG1IaszGBkAZ+lETJptoaB+hEuhF00v7bqfjD0ElWaHFxNW3+EGD
	CVACwjoILdg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1637524375;
	Sun, 19 Jun 2016 16:51:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 931D924374;
	Sun, 19 Jun 2016 16:51:58 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Cc:	Vadim Eisenberg <VADIME@il.ibm.com>, git@vger.kernel.org
Subject: Re: [BUG REPORT] git 2.9.0 clone --recursive fails on cloning a submodule
References: <OFC76C15DC.FC882C57-ONC2257FD7.00261552-C2257FD7.002660FC@LocalDomain>
	<OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com>
	<20160619100051.GA14584@sigill.intra.peff.net>
Date:	Sun, 19 Jun 2016 13:51:56 -0700
In-Reply-To: <20160619100051.GA14584@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 19 Jun 2016 06:00:51 -0400")
Message-ID: <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA2B26F4-365F-11E6-AFC0-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Stefan, I think it might be worth revisiting the default set by d22eb04
> to propagate shallowness from the super-project clone. In an ideal
> world, we would be asking each submodule for the actual commit we are
> interested in, and shallowness would not matter. But until
> uploadpack.allowReachableSHA1InWant works everywhere, I suspect this is
> going to be a problem.

Yup, something like this on top of d22eb04 to be merged before
v2.9.1 for the maintenance track would be necessary.

-- >8 --
Subject: clone: do not let --depth imply --shallow-submodules

In v2.9.0, we prematurely flipped the default to force cloning
submodules shallowly, when the superproject is getting cloned
shallowly.  This is likely to fail when the upstream repositories
submodules are cloned from a repository that is not prepared to
serve histories that ends at a commit that is not at the tip of a
branch, and we know the world is not yet ready.

Use a safer default to clone the submodules fully, unless the user
tells us that she knows that the upstream repository of the
submodules are willing to cooperate with "--shallow-submodules"
option.

Noticed-by: Vadim Eisenberg <VADIME@il.ibm.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-clone.txt | 5 ++---
 builtin/clone.c             | 5 ++---
 t/t5614-clone-submodules.sh | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index e1a21b7..c5a1ce2 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -192,9 +192,8 @@ objects from the source repository into a pack in the cloned repository.
 	Create a 'shallow' clone with a history truncated to the
 	specified number of revisions. Implies `--single-branch` unless
 	`--no-single-branch` is given to fetch the histories near the
-	tips of all branches. This implies `--shallow-submodules`. If
-	you want to have a shallow superproject clone, but full submodules,
-	also pass `--no-shallow-submodules`.
+	tips of all branches. If you want to clone submodules shallowly,
+	also pass `--shallow-submodules`.
 
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
diff --git a/builtin/clone.c b/builtin/clone.c
index ecdf308..f267742 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -40,7 +40,7 @@ static const char * const builtin_clone_usage[] = {
 
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
 static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
-static int option_shallow_submodules = -1;
+static int option_shallow_submodules;
 static char *option_template, *option_depth;
 static char *option_origin = NULL;
 static char *option_branch = NULL;
@@ -730,8 +730,7 @@ static int checkout(void)
 		struct argv_array args = ARGV_ARRAY_INIT;
 		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
 
-		if (option_shallow_submodules == 1
-		    || (option_shallow_submodules == -1 && option_depth))
+		if (option_shallow_submodules == 1)
 			argv_array_push(&args, "--depth=1");
 
 		if (max_jobs != -1)
diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
index 62044c5..f7c630b 100755
--- a/t/t5614-clone-submodules.sh
+++ b/t/t5614-clone-submodules.sh
@@ -37,9 +37,9 @@ test_expect_success 'nonshallow clone implies nonshallow submodule' '
 	)
 '
 
-test_expect_success 'shallow clone implies shallow submodule' '
+test_expect_success 'shallow clone does not imply shallow submodule' '
 	test_when_finished "rm -rf super_clone" &&
-	git clone --recurse-submodules --depth 2 "file://$pwd/." super_clone &&
+	git clone --recurse-submodules --depth 2 --shallow-submodules "file://$pwd/." super_clone &&
 	(
 		cd super_clone &&
 		git log --oneline >lines &&
