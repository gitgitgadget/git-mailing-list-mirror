Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B4FC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 15:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjCIP7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 10:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjCIP7S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 10:59:18 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02817F3670
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 07:59:13 -0800 (PST)
Received: (qmail 10484 invoked by uid 109); 9 Mar 2023 15:59:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 15:59:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32533 invoked by uid 111); 9 Mar 2023 15:59:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 10:59:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 10:59:12 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] receive-pack: fix stale packfile locks when dying
Message-ID: <ZAoCUPsHbstSJ0+B@coredump.intra.peff.net>
References: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2023 at 02:09:23PM +0100, Patrick Steinhardt wrote:

> Now in production systems we have observed that those `.keep` files are
> sometimes not getting deleted as expected, where the result is that
> repositories tend to grow packfiles that are never deleted over time.
> This seems to be caused by a race when git-receive-pack(1) is killed
> after we have migrated the kept packfile from the quarantine directory
> into the main object database. While this race window is typically small
> it can be extended for example by installing a `proc-receive` hook.

That makes sense, and I think this is a good direction.

> Fix this race by installing an atexit(3P) handler that unlinks the keep
> file.

This will work if we call die(), but I think you'd be better off using
the tempfile subsystem:

  - this patch doesn't handle signal death, and I don't see any reason
    you wouldn't want to handle it there (in fact, from your
    description, it sounds like signal death is the culprit you suspect)

  - this will double-unlink in most cases; once when we intend to after
    calling execute_commands(), and then it will try again (and
    presumably fail) at exit. Probably not a huge deal, but kind of
    ugly. You could set it to NULL after unlinking, but...

  - as the variable is not marked as volatile, a signal that causes an
    exit could cause the handler to see an inconsistent state if you
    modify it after setting up the handler. The tempfile code gets this
    right and is pretty battle-tested.

I think you'd just want something like this (totally untested):

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cd5c7a28eff..22bbce573e9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2184,7 +2184,7 @@ static const char *parse_pack_header(struct pack_header *hdr)
 	}
 }
 
-static const char *pack_lockfile;
+static struct tempfile *pack_lockfile;
 
 static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 {
@@ -2198,6 +2198,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 	const char *hdr_err;
 	int status;
 	struct child_process child = CHILD_PROCESS_INIT;
+	char *lockfile;
 	int fsck_objects = (receive_fsck_objects >= 0
 			    ? receive_fsck_objects
 			    : transfer_fsck_objects >= 0
@@ -2280,7 +2281,9 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		status = start_command(&child);
 		if (status)
 			return "index-pack fork failed";
-		pack_lockfile = index_pack_lockfile(child.out, NULL);
+		lockfile = index_pack_lockfile(child.out, NULL);
+		pack_lockfile = register_tempfile(lockfile);
+		free(lockfile);
 		close(child.out);
 		status = finish_command(&child);
 		if (status)
@@ -2568,8 +2571,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		use_keepalive = KEEPALIVE_ALWAYS;
 		execute_commands(commands, unpack_status, &si,
 				 &push_options);
-		if (pack_lockfile)
-			unlink_or_warn(pack_lockfile);
+		delete_tempfile(&pack_lockfile);
 		sigchain_push(SIGPIPE, SIG_IGN);
 		if (report_status_v2)
 			report_v2(commands, unpack_status);

The unconditional call to delete_tempfile() should be OK. If we don't
have a file (because we did unpack-objects instead), then it's a noop.

I think one could also make an argument that index_pack_lockfile()
should return a tempfile struct itself, but I didn't look too closely at
the other caller on the fetch side (but it should be conceptually the
same).

-Peff
