Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39001F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 09:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeKPTzd (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 14:55:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:41894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727398AbeKPTzd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 14:55:33 -0500
Received: (qmail 1220 invoked by uid 109); 16 Nov 2018 09:44:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Nov 2018 09:44:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28324 invoked by uid 111); 16 Nov 2018 09:43:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Nov 2018 04:43:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Nov 2018 04:43:59 -0500
Date:   Fri, 16 Nov 2018 04:43:59 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?R2HDq2w=?= Lhez <gael.lhez@gmail.com>
Subject: [PATCH] bundle: dup() output descriptor closer to point-of-use
Message-ID: <20181116094358.GA6054@sigill.intra.peff.net>
References: <pull.79.v2.git.gitgitgadget@gmail.com>
 <c88887f05a145709be9e86d56f4c1e620eb5ea89.1542209112.git.gitgitgadget@gmail.com>
 <CAN0heSqsjKksKnBHjffVMDEyX4A2DAY6Naw4tbBXEm+AdhOLtA@mail.gmail.com>
 <CAGZ79kZ_wrQ=OdJ6xWbL+F5RDb38YAmzc87o8A=Zb8zBywMJBQ@mail.gmail.com>
 <20181115043409.GA3419@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811151354150.41@tvgsbejvaqbjf.bet>
 <20181115133749.GA26164@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811151725310.41@tvgsbejvaqbjf.bet>
 <20181115164300.GA29290@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811152059060.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1811152059060.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 09:01:07PM +0100, Johannes Schindelin wrote:

> > It seems like we should be checking that the stale lockfile isn't left,
> > which is the real problem (the warning is annoying, but is a symptom of
> > the same thing). I.e., something like:
> > 
> >   test_must_fail git bundle create foobar.bundle master..master &&
> >   test_path_is_missing foobar.bundle.lock
> > 
> > That would already pass on non-Windows platforms, but that's OK. It will
> > never give a false failure.
> > 
> > If you don't mind, can you confirm that the test above fails without
> > either of the two patches under discussion?
> 
> This test succeeds with your patch as well as with Gaël's, and fails when
> neither patch is applied. So you're right, it is the much better test.

Thanks for checking!

> > > Do you want to integrate this test into your patch and run with it, or
> > > do you want me to shepherd your patch?
> > 
> > I'll wrap it up with a commit message and a test.

Actually, I realized there's an even simpler way to do this. Here it is.

-- >8 --
Subject: [PATCH] bundle: dup() output descriptor closer to point-of-use

When writing a bundle to a file, the bundle code actually creates
"your.bundle.lock" using our lockfile interface. We feed that output
descriptor to a child git-pack-objects via run-command, which has the
quirk that it closes the output descriptor in the parent.

To avoid confusing the lockfile code (which still thinks the descriptor
is valid), we dup() it, and operate on the duplicate.

However, this has a confusing side effect: after the dup() but before we
call pack-objects, we have _two_ descriptors open to the lockfile. If we
call die() during that time, the lockfile code will try to clean up the
partially-written file. It knows to close() the file before unlinking,
since on some platforms (i.e., Windows) the open file would block the
deletion. But it doesn't know about the duplicate descriptor. On
Windows, triggering an error at the right part of the code will result
in the cleanup failing and the lockfile being left in the filesystem.

We can solve this by moving the dup() much closer to start_command(),
shrinking the window in which we have the second descriptor open. It's
easy to place this in such a way that no die() is possible. We could
still die due to a signal in the exact wrong moment, but we already
tolerate races there (e.g., a signal could come before we manage to put
the file on the cleanup list in the first place).

As a bonus, this shields create_bundle() itself from the duplicate-fd
trick, and we can simplify its error handling (note that the lock
rollback now happens unconditionally, but that's OK; it's a noop if we
didn't open the lock in the first place).

The included test uses an empty bundle to cause a failure at the right
spot in the code, because that's easy to trigger (the other likely
errors are write() problems like ENOSPC).  Note that it would already
pass on non-Windows systems (because they are happy to unlink an
already-open file).

Based-on-a-patch-by: Gaël Lhez <gael.lhez@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 bundle.c                | 39 ++++++++++++++++++---------------------
 t/t5607-clone-bundle.sh |  6 ++++++
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/bundle.c b/bundle.c
index 1ef584b93b..6b0f6d8f10 100644
--- a/bundle.c
+++ b/bundle.c
@@ -243,7 +243,7 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 }
 
 
-/* Write the pack data to bundle_fd, then close it if it is > 1. */
+/* Write the pack data to bundle_fd */
 static int write_pack_data(int bundle_fd, struct rev_info *revs)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
@@ -256,6 +256,20 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs)
 	pack_objects.in = -1;
 	pack_objects.out = bundle_fd;
 	pack_objects.git_cmd = 1;
+
+	/*
+	 * start_command() will close our descriptor if it's >1. Duplicate it
+	 * to avoid surprising the caller.
+	 */
+	if (pack_objects.out > 1) {
+		pack_objects.out = dup(pack_objects.out);
+		if (pack_objects.out < 0) {
+			error_errno(_("unable to dup bundle descriptor"));
+			child_process_clear(&pack_objects);
+			return -1;
+		}
+	}
+
 	if (start_command(&pack_objects))
 		return error(_("Could not spawn pack-objects"));
 
@@ -421,21 +435,10 @@ int create_bundle(struct bundle_header *header, const char *path,
 	bundle_to_stdout = !strcmp(path, "-");
 	if (bundle_to_stdout)
 		bundle_fd = 1;
-	else {
+	else
 		bundle_fd = hold_lock_file_for_update(&lock, path,
 						      LOCK_DIE_ON_ERROR);
 
-		/*
-		 * write_pack_data() will close the fd passed to it,
-		 * but commit_lock_file() will also try to close the
-		 * lockfile's fd. So make a copy of the file
-		 * descriptor to avoid trying to close it twice.
-		 */
-		bundle_fd = dup(bundle_fd);
-		if (bundle_fd < 0)
-			die_errno("unable to dup file descriptor");
-	}
-
 	/* write signature */
 	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
 
@@ -463,10 +466,8 @@ int create_bundle(struct bundle_header *header, const char *path,
 		goto err;
 
 	/* write pack */
-	if (write_pack_data(bundle_fd, &revs)) {
-		bundle_fd = -1; /* already closed by the above call */
+	if (write_pack_data(bundle_fd, &revs))
 		goto err;
-	}
 
 	if (!bundle_to_stdout) {
 		if (commit_lock_file(&lock))
@@ -474,11 +475,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	}
 	return 0;
 err:
-	if (!bundle_to_stdout) {
-		if (0 <= bundle_fd)
-			close(bundle_fd);
-		rollback_lock_file(&lock);
-	}
+	rollback_lock_file(&lock);
 	return -1;
 }
 
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 348d9b3bc7..cf39e9e243 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -71,4 +71,10 @@ test_expect_success 'prerequisites with an empty commit message' '
 	git bundle verify bundle
 '
 
+test_expect_success 'failed bundle creation does not leave cruft' '
+	# This fails because the bundle would be empty.
+	test_must_fail git bundle create fail.bundle master..master &&
+	test_path_is_missing fail.bundle.lock
+'
+
 test_done
-- 
2.19.1.1636.gc7a073d580

