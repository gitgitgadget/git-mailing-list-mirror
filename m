Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E3FC433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 00:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJVAVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 20:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJVAVT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 20:21:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C789F5466E
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 17:21:18 -0700 (PDT)
Received: (qmail 15186 invoked by uid 109); 22 Oct 2022 00:21:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 00:21:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18953 invoked by uid 111); 22 Oct 2022 00:21:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 20:21:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 20:21:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/5] repack tempfile-cleanup signal deadlock
Message-ID: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 05:41:02PM -0400, Jeff King wrote:

> Here's a series which should fix the deadlock Jan reported in:
> 
>   https://lore.kernel.org/git/00af268377fb7c3b8efd059482ee7449b71f48b1.camel@fnusa.cz/

And here's a re-roll based on feedback on v1. Poor Jan; I hope this
thread isn't blowing up your inbox. :) But thank you for reporting the
problem!

The changes from v1 are:

  - clarified rationale in patch 2
  - new patch 3 improves an error message and reduces scope of fname_old
  - patch 4 cleans up fname_old to use tempfile path

Range diff is below.

  [1/5]: repack: convert "names" util bitfield to array
  [2/5]: repack: populate extension bits incrementally
  [3/5]: repack: expand error message for missing pack files
  [4/5]: repack: use tempfiles for signal cleanup
  [5/5]: repack: drop remove_temporary_files()

 builtin/repack.c  | 90 +++++++++++++++--------------------------------
 t/t7700-repack.sh | 16 +++++++++
 2 files changed, 45 insertions(+), 61 deletions(-)

1:  6de9bd9d71 = 1:  affb21442f repack: convert "names" util bitfield to array
2:  7d72ed9a39 ! 2:  18d8318881 repack: populate extension bits incrementally
    @@ Commit message
         iterate over the "names" list (which contains hashes of packs generated
         by pack-objects), and call populate_pack_exts() for each.
     
    -    There are two small problems with this:
    +    There's one small problem with this. In repack_promisor_objects(), we
    +    may add entries to "names" and call populate_pack_exts() for them.
    +    Calling it again is mostly just wasteful, as we'll stat() the filename
    +    with each possible extension, get the same result, and just overwrite
    +    our bits.
     
    -      - repack_promisor_objects() may have added entries to "names", and
    -        already called populate_pack_exts() for them. This is mostly just
    -        wasteful, as we'll stat() the filename with each possible extension,
    -        get the same result, and just overwrite our bits. But it makes the
    -        code flow confusing, and it will become a problem if we try to make
    -        populate_pack_exts() do more things.
    +    So we could drop the call there, and leave the final loop to populate
    +    all of the bits. But instead, this patch does the reverse: drops the
    +    final loop, and teaches the other two sites to populate the bits as they
    +    add entries.
     
    -      - it would be nice to record the generated filenames as soon as
    -        possible. We don't currently use them for cleaning up from a failed
    -        operation, but a future patch will do so.
    +    This makes the code easier to reason about, as you never have to worry
    +    about when the util field is valid; it is always valid for each entry.
    +
    +    It also serves my ulterior purpose: recording the generated filenames as
    +    soon as possible will make it easier for a future patch to use them for
    +    cleaning up from a failed operation.
     
         Signed-off-by: Jeff King <peff@peff.net>
     
-:  ---------- > 3:  bbd7f82f88 repack: expand error message for missing pack files
3:  16448019ba ! 4:  7cd89d1575 repack: use tempfiles for signal cleanup
    @@ Commit message
         pack. Before this patch, the .tmp-* file for the main pack would have
         been left, but now we correctly clean it up.
     
    +    Two small subtleties on the implementation:
    +
    +      - in the renaming loop, we can stop re-constructing fname_old; we only
    +        use it when we have a tempfile to rename, so we can just ask the
    +        tempfile for its path (which, barring bugs, should be identical)
    +
    +      - when renaming fails, our error message mentions fname_old. But since
    +        a failed rename_tempfile() invalidates the tempfile struct, we'll
    +        lose access to that string. Instead, let's mention the destination
    +        filename, which is what most other callers do.
    +
         Reported-by: Jan Pokorný <poki@fnusa.cz>
         Signed-off-by: Jeff King <peff@peff.net>
     
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      
      	show_progress = !po_args.quiet && isatty(2);
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    - 			fname_old = mkpathdup("%s-%s%s",
    - 					packtmp, item->string, exts[ext].name);
    + 		struct generated_pack_data *data = item->util;
    + 
    + 		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
    +-			char *fname, *fname_old;
    ++			char *fname;
    + 
    + 			fname = mkpathdup("%s/pack-%s%s",
    + 					packdir, item->string, exts[ext].name);
    +-			fname_old = mkpathdup("%s-%s%s",
    +-					packtmp, item->string, exts[ext].name);
      
     -			if (data->exts[ext]) {
     +			if (data->tempfiles[ext]) {
    ++				const char *fname_old = get_tempfile_path(data->tempfiles[ext]);
      				struct stat statbuffer;
    ++
      				if (!stat(fname_old, &statbuffer)) {
      					statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
      					chmod(fname_old, statbuffer.st_mode);
      				}
      
     -				if (rename(fname_old, fname))
    +-					die_errno(_("renaming '%s' failed"), fname_old);
     +				if (rename_tempfile(&data->tempfiles[ext], fname))
    - 					die_errno(_("renaming '%s' failed"), fname_old);
    ++					die_errno(_("renaming pack to '%s' failed"), fname);
      			} else if (!exts[ext].optional)
    - 				die(_("missing required file: %s"), fname_old);
    + 				die(_("pack-objects did not write a '%s' file for pack %s-%s"),
    + 				    exts[ext].name, packtmp, item->string);
    + 			else if (unlink(fname) < 0 && errno != ENOENT)
    + 				die_errno(_("could not unlink: %s"), fname);
    + 
    + 			free(fname);
    +-			free(fname_old);
    + 		}
    + 	}
    + 	/* End of pack replacement. */
     
      ## t/t7700-repack.sh ##
     @@ t/t7700-repack.sh: test_expect_success TTY '--quiet disables progress' '
4:  c7b0f3823d = 5:  d7e9225b8e repack: drop remove_temporary_files()
