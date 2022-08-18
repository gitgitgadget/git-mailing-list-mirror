Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF45C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 06:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243595AbiHRGQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 02:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbiHRGQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 02:16:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA793522
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 23:16:10 -0700 (PDT)
Received: (qmail 12054 invoked by uid 109); 18 Aug 2022 06:16:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Aug 2022 06:16:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23464 invoked by uid 111); 18 Aug 2022 06:16:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Aug 2022 02:16:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Aug 2022 02:16:09 -0400
From:   Jeff King <peff@peff.net>
To:     Jinwook Jeong <vustthat@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bugreport: "git config --global" fails if an invalid .git file
 present
Message-ID: <Yv3ZKcD0L0dSIavr@coredump.intra.peff.net>
References: <CAA3Q-aYfn0om2tXjwH-9ayaX57Yj6xkKw1hpi2asthgHvWovsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA3Q-aYfn0om2tXjwH-9ayaX57Yj6xkKw1hpi2asthgHvWovsw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2022 at 01:16:44AM +0900, Jinwook Jeong wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> Executing `git config --global ...` and $PWD/.git exists as a file and
> is invalid.
> 
> What did you expect to happen? (Expected behavior)
> 
> Git reads from or writes to the global config store.
> 
> What happened instead? (Actual behavior)
> 
> It prints:
>   fatal: invalid gitfile format: $PWD/.git
> 
> What's different between what you expected and what actually happened?
> 
> Git fails to access the global config even if the current directory's
> `.git` file has nothing to do with the global config.

I agree this isn't entirely friendly, but I think things are working as
designed. Even though you're only asking to change global config, we do
still speculatively check for a repository when running git-config at
all, as various options could impact its behavior. So the backtrace
looks like this:

  0  die (err=0x5555558e5c33 "invalid gitfile format: %s") at usage.c:175
  #1  0x00005555557fbc87 in read_gitfile_error_die (error_code=5, path=0x5555559abbd0 "/home/peff/.git", dir=0x0)
      at setup.c:786
  #2  0x00005555557fbfaa in read_gitfile_gently (path=0x5555559abbd0 "/home/peff/.git", return_error_code=0x0)
      at setup.c:875
  #3  0x00005555557fce4d in setup_git_directory_gently_1 (dir=0x7fffffffe160, gitdir=0x7fffffffe140,
      report=0x7fffffffe120, die_on_error=1) at setup.c:1298
  #4  0x00005555557fd4d6 in setup_git_directory_gently (nongit_ok=0x7fffffffe1ec) at setup.c:1455
  #5  0x0000555555574a32 in run_builtin (p=0x55555596e9f0 <commands+624>, argc=4, argv=0x7fffffffe570) at git.c:436
  #6  0x000055555557505f in handle_builtin (argc=4, argv=0x7fffffffe570) at git.c:720

and when we hit the error, we have not even started running code
specific to git-config, let alone seen that the "--global" option is in
use.

There's another more subtle question lurking here. The config builtin is
marked as RUN_SETUP_GENTLY, so it will run even if we are not inside a
repository at all. But you can see in the backtrace above that we pass
die_on_error=1 to setup_git_directory_gently_1(). That is, the "gentle"
form here means "it is OK not to be in a repository", but if we see
something that indicates we should be in a repository (like a .git
file), but we hit an error examining it, we bail immediately. We _could_
say "well, it's not a valid .git file, let's keep looking".

And that would make your case Just Work. But it's also more dangerous;
if a misconfiguration or transient error caused us to set up an
unexpected environment, then the results could be quite wrong and
confusing. Maybe less so for "git config", but for destructive
operations it's a scarier concept.

So a patch like the one below does what you want, but I'm not sure it's
a good idea for the reasons given above.

In your case, the right resolution is probably to delete the bogus .git
file.

-Peff

---
diff --git a/setup.c b/setup.c
index cefd5f63c4..aafb1e1e99 100644
--- a/setup.c
+++ b/setup.c
@@ -1452,7 +1452,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die_errno(_("Unable to read current working directory"));
 	strbuf_addbuf(&dir, &cwd);
 
-	switch (setup_git_directory_gently_1(&dir, &gitdir, &report, 1)) {
+	switch (setup_git_directory_gently_1(&dir, &gitdir, &report, !nongit_ok)) {
 	case GIT_DIR_EXPLICIT:
 		prefix = setup_explicit_git_dir(gitdir.buf, &cwd, &repo_fmt, nongit_ok);
 		break;
@@ -1503,6 +1503,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		*nongit_ok = 1;
 		break;
+	case GIT_DIR_INVALID_GITFILE:
+		if (!nongit_ok)
+			BUG("read_gitfile_gently() should have died on error");
+		*nongit_ok = 1;
+		break;
 	case GIT_DIR_NONE:
 		/*
 		 * As a safeguard against setup_git_directory_gently_1 returning
