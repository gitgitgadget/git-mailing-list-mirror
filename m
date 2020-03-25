Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D7CC1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB91206F8
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgCYGLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:11:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:50406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725781AbgCYGLD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 02:11:03 -0400
Received: (qmail 23123 invoked by uid 109); 25 Mar 2020 06:11:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 25 Mar 2020 06:11:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 308 invoked by uid 111); 25 Mar 2020 06:20:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Mar 2020 02:20:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 25 Mar 2020 02:11:02 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Sommermann <dcsommer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [RFC PATCH] git-apply: Permit change of file mode when filename
 does not change
Message-ID: <20200325061102.GD651138@coredump.intra.peff.net>
References: <20200324160054.1535824-1-dcsommer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324160054.1535824-1-dcsommer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 09:00:54AM -0700, Daniel Sommermann wrote:

> The documentation for git's diff format does not expressly disallow
> changing the mode of a file without splitting it into a delete and
> create. Mercurial's `hg diff --git` in fact produces git diffs with such
> format. When applying such patches in Git, this assert can be hit. The check
> preventing this type of diff has been around since 2005 in
> 3cca928d4aae691572ef9a73dcc29a04f66900a1.

This description confused me for a moment, because in Git we generally
refer to "mode changes" as flipping the executable bit. And anything
further is a "type change" (and this isn't just academic; options like
--diff-filter distinguish the two).

And we do indeed allow a simple mode change like:

  $ git show c9d4999155700651a37f4eb577cec1f4b5b8d6be --format=
  diff --git a/t/perf/p0004-lazy-init-name-hash.sh b/t/perf/p0004-lazy-init-name-hash.sh
  old mode 100644
  new mode 100755

But you're talking about typechanges here, and we do always represent
those as a deletion/addition pair:

  $ git show --format= -D 2efbb7f5218d5ca9d50cbcb86a365a08b2981d77 RelNotes
  diff --git a/RelNotes b/RelNotes
  deleted file mode 100644
  index 007bc065dd..0000000000
  diff --git a/RelNotes b/RelNotes
  new file mode 120000
  index 0000000000..8d0b1654d2
  --- /dev/null
  +++ b/RelNotes
  @@ -0,0 +1 @@
  +Documentation/RelNotes/2.20.0.txt
  \ No newline at end of file

I don't think we'd want to switch how we generate these diffs, but I
can't offhand think of a reason why it would be a bad idea to accept
such a patch converting a file to a symlink or vice versa.

But...

> Simply deleting the check that prevents changing the mode when not
> renaming allows such diffs to work out of the box, as the attached test
> case shows.

What about other more exotic typechanges, like a directory becoming a
file?  Or a file to a gitlink? I guess we'd never mention a directory in
--patch format anyway, but I wonder to what degree these lines in
check_patch() are protecting downstream code from doing something
stupid.

If I fake a diff like:

  diff --git a/file b/file
  old mode 100644
  new mode 040000

we seem to silently accept it but not write any mode change (we do write
a content change to the file). Swapping 040000 (a tree) out for 160000
(a gitlink) seems to delete file but not apply any content-level change.

Also, I'm not sure your patch works for the reverse case: a symlink
becoming a file. If I add this to your test:

diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
index 593e6142b4..acd94a07a7 100755
--- a/t/t4115-apply-symlink.sh
+++ b/t/t4115-apply-symlink.sh
@@ -67,4 +67,20 @@ test_expect_success 'apply file-to-symlink patch' '
 
 '
 
+test_expect_success 'apply symlink-to-file patch' '
+
+	cat >reverse-patch <<-\EOF &&
+	diff --git a/file_to_be_link b/file_to_be_link
+	new mode 120000
+	old mode 100644
+	--- a/file_to_be_link
+	+++ b/file_to_be_link
+	@@ -1,1 +1,1 @@
+	-target
+	+file
+	EOF
+
+	git apply reverse-patch
+'
+
 test_done

it fails with "error: file_to_be_link: wrong type".

> diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
> index 872fcda6cb..593e6142b4 100755
> --- a/t/t4115-apply-symlink.sh
> +++ b/t/t4115-apply-symlink.sh

If we do go this route, two small fixes for the tests:

> @@ -44,4 +44,27 @@ test_expect_success 'apply --index symlink patch' '
>  
>  '
>  
> +cat >move_patch <<\EOF
> +diff --git a/file_to_be_link b/file_to_be_link
> +old mode 100644
> +new mode 120000
> +--- a/file_to_be_link
> ++++ b/file_to_be_link
> +@@ -0,0 +1,1 @@
> ++target
> +\ No newline at end of file
> +EOF

We prefer this kind of setup to go inside the test_expect_success block
(you can use "<<-\EOF" to strip leading tabs and get nice indentation).

Some older tests haven't been updated yet, so you may have picked this
up from a bad example, but we try to follow it when writing new ones.

> +test_expect_success 'apply file-to-symlink patch' '
> +
> +	git checkout -f master &&
> +	touch file_to_be_link &&
> +	git add file_to_be_link &&
> +	git commit -m initial &&
> +
> +	git apply move_patch &&
> +	test target = $(readlink file_to_be_link)
> +
> +'

This probably needs a SYMLINKS prerequisite, since we'd write the actual
symlink to the filesystem. We could work around that with "apply
--index", but I think it's important to test the full patch application.

-Peff
