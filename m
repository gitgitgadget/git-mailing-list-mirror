Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB65C678DB
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 10:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCDKzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 05:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCDKzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 05:55:16 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9617E8A45
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 02:55:14 -0800 (PST)
Received: (qmail 17013 invoked by uid 109); 4 Mar 2023 10:55:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Mar 2023 10:55:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3954 invoked by uid 111); 4 Mar 2023 10:55:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Mar 2023 05:55:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Mar 2023 05:55:13 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: [RFC/PATCH] bundle: turn on --all-progress-implied by default
Message-ID: <ZAMjkffYmp+DNmr+@coredump.intra.peff.net>
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
 <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
 <xmqqv8jhcvrq.fsf@gitster.g>
 <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net>
 <xmqqpm9pcu6t.fsf@gitster.g>
 <ZAKexHiit5vOmv7M@coredump.intra.peff.net>
 <ZAKi8MzGWk5PZUJk@coredump.intra.peff.net>
 <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 04, 2023 at 05:22:40AM -0500, Jeff King wrote:

>   [2/5]: bundle: document handling of "-" as stdin
> 
>     One half of the doc-fixes discussed earlier, but of course covering
>     all operations now.

And here's the other one. I split it out into its own series because
it's quite a bit more complicated, and there's no textual dependency.

I'm marking it as "RFC" because it's undoing some of what Robin (cc'd)
did in the commit referenced below. But I remain unconvinced that it's a
useful direction.

-- >8 --
Subject: bundle: turn on --all-progress-implied by default

In 79862b6b77c (bundle-create: progress output control, 2019-11-10),
"bundle create" learned about the --all-progress and
--all-progress-implied options, which were copied from pack-objects.
I think these were a mistake.

In pack-objects, "all-progress-implied" is about switching the behavior
between a regular on-disk "git repack" and the use of pack-objects for
push/fetch (where a fetch does not want progress from the server during
the write stage; the client will print progress as it receives the
data). But there's no such distinction for bundles. Prior to
79862b6b77c, we always printed the write stage. Afterwards, a vanilla:

  git bundle create foo.bundle

omits the write progress, appearing to hang (especially if your
repository is large or your disk is slow). That seems like a regression.

It's possible that the flexibility to disable the write-phase progress
_could_ be useful for bundle. E.g., if you did something like:

  ssh some-host git bundle create foo.bundle |
  git bundle unbundle

But if you are running both in real-time, why are you using bundles in
the first place? You're better off doing a real fetch.

But even if we did want to support that, it should be the exception, and
vanilla "bundle create" should display the full progress. So we'd want
to name the option "--no-write-progress" or something.

The "--all-progress" option itself is even worse. It exists in
pack-objects only for historical reasons. It's a mistake because it
implies "--progress", and we added "--all-progress-implied" to fix that.
There is no reason to propagate that mistake to new commands.

Likewise, the documentation for these options was pulled from
pack-objects. But it doesn't make any sense in this context. It talks
about "--stdout", but that is not even an option that git-bundle
supports.

This patch flips the default for "--all-progress-implied" back to
"true", fixing the regression in 79862b6b77c. This turns that option
into a noop, and means that "--all-progress" is really the same as
"--progress". We _could_ drop them completely, but since they've been
shipped with Git since v2.25.0, it's polite to continue accepting them.

I didn't implement any sort of "--no-write-progress" here. I'm not at
all convinced it's necessary, and the discussion from the original
thread:

  https://lore.kernel.org/git/20191110204126.30553-2-robbat2@gentoo.org/

shows that that the main focus was on getting --progress and --quiet
support, and not any kind of clever "real-time bundle over the network"
feature. But technically this patch is making it impossible to do
something that you _could_ do post-79862b6b77c.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm actually kind of confused about what happened with 79862b6b77c. If
you go to the subthread linked above, you can see that I made similar
arguments there, and Junio seemed to agree. Then the next thing I could
find is the series appearing in What's cooking:

  https://lore.kernel.org/git/xmqqftikxs4z.fsf@gitster-ct.c.googlers.com/

marked as "will merge to master". Is there more discussion I couldn't
find? Was it accidentally graduated?

 Documentation/git-bundle.txt | 18 +-----------------
 builtin/bundle.c             | 15 ++++++++-------
 t/t6020-bundle-misc.sh       |  6 ++++++
 3 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 18a022b4b40..a4227b6561d 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -9,7 +9,7 @@ git-bundle - Move objects and refs by archive
 SYNOPSIS
 --------
 [verse]
-'git bundle' create [-q | --quiet | --progress | --all-progress] [--all-progress-implied]
+'git bundle' create [-q | --quiet | --progress]
 		    [--version=<version>] <file> <git-rev-list-args>
 'git bundle' verify [-q | --quiet] <file>
 'git bundle' list-heads <file> [<refname>...]
@@ -115,22 +115,6 @@ unbundle <file>::
 	is specified. This flag forces progress status even if
 	the standard error stream is not directed to a terminal.
 
---all-progress::
-	When --stdout is specified then progress report is
-	displayed during the object count and compression phases
-	but inhibited during the write-out phase. The reason is
-	that in some cases the output stream is directly linked
-	to another command which may wish to display progress
-	status of its own as it processes incoming pack data.
-	This flag is like --progress except that it forces progress
-	report for the write-out phase as well even if --stdout is
-	used.
-
---all-progress-implied::
-	This is used to imply --all-progress whenever progress display
-	is activated.  Unlike --all-progress this flag doesn't actually
-	force any progress display by itself.
-
 --version=<version>::
 	Specify the bundle version.  Version 2 is the older format and can only be
 	used with SHA-1 repositories; the newer version 3 contains capabilities that
diff --git a/builtin/bundle.c b/builtin/bundle.c
index acceef62001..c2b916e027a 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -12,7 +12,7 @@
  */
 
 #define BUILTIN_BUNDLE_CREATE_USAGE \
-	N_("git bundle create [-q | --quiet | --progress | --all-progress] [--all-progress-implied]\n" \
+	N_("git bundle create [-q | --quiet | --progress]\n" \
 	   "                  [--version=<version>] <file> <git-rev-list-args>")
 #define BUILTIN_BUNDLE_VERIFY_USAGE \
 	N_("git bundle verify [-q | --quiet] <file>")
@@ -64,7 +64,7 @@ static int parse_options_cmd_bundle(int argc,
 }
 
 static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
-	int all_progress_implied = 0;
+	int all_progress_implied = 1;
 	int progress = isatty(STDERR_FILENO);
 	struct strvec pack_opts;
 	int version = -1;
@@ -74,11 +74,12 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 			    N_("do not show progress meter"), 0),
 		OPT_SET_INT(0, "progress", &progress,
 			    N_("show progress meter"), 1),
-		OPT_SET_INT(0, "all-progress", &progress,
-			    N_("show progress meter during object writing phase"), 2),
-		OPT_BOOL(0, "all-progress-implied",
-			 &all_progress_implied,
-			 N_("similar to --all-progress when progress meter is shown")),
+		OPT_SET_INT_F(0, "all-progress", &progress,
+			      N_("historical; same as --progress"), 2,
+			      PARSE_OPT_HIDDEN),
+		OPT_HIDDEN_BOOL(0, "all-progress-implied",
+				&all_progress_implied,
+				N_("historical; does nothing")),
 		OPT_INTEGER(0, "version", &version,
 			    N_("specify bundle format version")),
 		OPT_END()
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 7d40994991e..978c5b17ba5 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -606,4 +606,10 @@ test_expect_success 'verify catches unreachable, broken prerequisites' '
 	)
 '
 
+test_expect_success 'bundle progress includes write phase' '
+	GIT_PROGRESS_DELAY=0 \
+		git bundle create --progress out.bundle --all 2>err &&
+	grep 'Writing' err
+'
+
 test_done
-- 
2.40.0.rc1.500.g967c04631e

