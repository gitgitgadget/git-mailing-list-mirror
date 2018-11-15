Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C175D1F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 13:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbeKOXpp (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 18:45:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:40560 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729034AbeKOXpp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 18:45:45 -0500
Received: (qmail 29870 invoked by uid 109); 15 Nov 2018 13:37:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Nov 2018 13:37:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15732 invoked by uid 111); 15 Nov 2018 13:37:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Nov 2018 08:37:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2018 08:37:49 -0500
Date:   Thu, 15 Nov 2018 08:37:49 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?R2HDq2w=?= Lhez <gael.lhez@gmail.com>
Subject: Re: [PATCH v2 1/1] bundle: cleanup lock files on error
Message-ID: <20181115133749.GA26164@sigill.intra.peff.net>
References: <pull.79.git.gitgitgadget@gmail.com>
 <pull.79.v2.git.gitgitgadget@gmail.com>
 <c88887f05a145709be9e86d56f4c1e620eb5ea89.1542209112.git.gitgitgadget@gmail.com>
 <CAN0heSqsjKksKnBHjffVMDEyX4A2DAY6Naw4tbBXEm+AdhOLtA@mail.gmail.com>
 <CAGZ79kZ_wrQ=OdJ6xWbL+F5RDb38YAmzc87o8A=Zb8zBywMJBQ@mail.gmail.com>
 <20181115043409.GA3419@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811151354150.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1811151354150.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 01:57:45PM +0100, Johannes Schindelin wrote:

> > I looked at the test to see if it would pass, but it is not even
> > checking anything about lockfiles! It just checks that we exit 1 by
> > returning up the callstack instead of calling die(). And of course it
> > would not have a problem under Linux either way. But if I run something
> > similar under strace, I see:
> > 
> >   $ strace ./git bundle create foobar.bundle HEAD..HEAD
> >   [...]
> >   openat(AT_FDCWD, "/home/peff/compile/git/foobar.bundle.lock", O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) = 3
> >   [...]
> >   close(3)                                = 0
> >   unlink("/home/peff/compile/git/foobar.bundle.lock") = 0
> >   exit_group(128)                         = ?
> > 
> > which seems right.
> 
> Without the fix, the added regression test fails thusly:
> 
> -- snip --
> [...]
> ++ test_expect_code 1 git bundle create foobar.bundle master..master
> ++ want_code=1
> ++ shift
> ++ git bundle create foobar.bundle master..master
> fatal: Refusing to create empty bundle.
> warning: unable to unlink 'C:/git-sdk-64/usr/src/git/wip2/t/trash directory.t5607-clone-bundle/foobar.bundle.lock': Permission denied

Hmph. So who has it open, and why isn't the tempfile code working as
designed?

Aha, I see the problem. We dup() the descriptor in create_bundle(). So
the patch _is_ necessary and (fairly) correct. But the explanation
probably ought to be something like:

  In create_bundle(), we duplicate the lockfile descriptor via dup().
  This means that even though the lockfile code carefully calls close()
  before unlinking the lockfile, we may still have the file open. Unix
  systems don't care, but under Windows, this prevents the unlink
  (causing an annoying warning and a stale lockfile).

But that also means that all of the other places we could die (e.g., in
write_or_die) are going to have the same problem. We've fixed only one.
Is there a way we can avoid doing the dup() in the first place?

The comment there explains that we duplicate because write_pack_data()
will close the descriptor. Unfortunately, that's hard to change because
it comes from run-command. But we don't actually need the descriptor
ourselves after it's closed; we're just trying to appease the lockfile
code; see e54c347c1c (create_bundle(): duplicate file descriptor to
avoid closing it twice, 2015-08-10).

We just need some reasonable way of telling the lock code what's
happening. Something like the patch below, which is a moral revert of
e54c347c1c, but instead wrapping the "lock->fd = -1" in an official API.

Does this make your warning go away?

diff --git a/bundle.c b/bundle.c
index 1ef584b93b..dc26551b83 100644
--- a/bundle.c
+++ b/bundle.c
@@ -244,7 +244,7 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 
 
 /* Write the pack data to bundle_fd, then close it if it is > 1. */
-static int write_pack_data(int bundle_fd, struct rev_info *revs)
+static int write_pack_data(int bundle_fd, struct lock_file *lock, struct rev_info *revs)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
 	int i;
@@ -256,6 +256,14 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs)
 	pack_objects.in = -1;
 	pack_objects.out = bundle_fd;
 	pack_objects.git_cmd = 1;
+
+	/*
+	 * At this point we know that start_command is going to close our
+	 * bundle_fd, whether successful or not. Tell the lock code that
+	 * it is no longer in charge of it, so we don't try to double-close.
+	 */
+	lock_file_release_descriptor(lock);
+
 	if (start_command(&pack_objects))
 		return error(_("Could not spawn pack-objects"));
 
@@ -421,21 +429,10 @@ int create_bundle(struct bundle_header *header, const char *path,
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
 
@@ -463,10 +460,8 @@ int create_bundle(struct bundle_header *header, const char *path,
 		goto err;
 
 	/* write pack */
-	if (write_pack_data(bundle_fd, &revs)) {
-		bundle_fd = -1; /* already closed by the above call */
+	if (write_pack_data(bundle_fd, &lock, &revs))
 		goto err;
-	}
 
 	if (!bundle_to_stdout) {
 		if (commit_lock_file(&lock))
@@ -474,11 +469,7 @@ int create_bundle(struct bundle_header *header, const char *path,
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
 
diff --git a/lockfile.h b/lockfile.h
index 35403ccc0d..968cd0e4f6 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -304,4 +304,14 @@ static inline void rollback_lock_file(struct lock_file *lk)
 	delete_tempfile(&lk->tempfile);
 }
 
+/*
+ * Release the file descriptor and/or file pointer for an open lockfile,
+ * passing ownership to the caller (who is responsible for closing it). It's a
+ * NOOP to call this on an inactive or already-closed lockfile.
+ */
+static inline void lock_file_release_descriptor(struct lock_file *lk)
+{
+	tempfile_release_descriptor(lk->tempfile);
+}
+
 #endif /* LOCKFILE_H */
diff --git a/tempfile.c b/tempfile.c
index d43ad8c191..59bbdcf4ba 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -319,3 +319,9 @@ void delete_tempfile(struct tempfile **tempfile_p)
 	deactivate_tempfile(tempfile);
 	*tempfile_p = NULL;
 }
+
+void tempfile_release_descriptor(struct tempfile *tempfile)
+{
+	tempfile->fd = -1;
+	tempfile->fp = NULL;
+}
diff --git a/tempfile.h b/tempfile.h
index 61d8dc4d1b..7489c5e4e9 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -262,4 +262,11 @@ extern void delete_tempfile(struct tempfile **tempfile_p);
  */
 extern int rename_tempfile(struct tempfile **tempfile_p, const char *path);
 
+/*
+ * Release the file descriptor and/or file pointer for an open tempfile,
+ * passing ownership to the caller (who is responsible for closing it). It's a
+ * NOOP to call this on an inactive or already-closed tempfile.
+ */
+void tempfile_release_descriptor(struct tempfile *tempfile);
+
 #endif /* TEMPFILE_H */
