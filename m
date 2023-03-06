Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA201C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 08:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCFIky (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 03:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCFIkw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 03:40:52 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC81921281
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 00:40:46 -0800 (PST)
Received: (qmail 5223 invoked by uid 109); 6 Mar 2023 08:40:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Mar 2023 08:40:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27661 invoked by uid 111); 6 Mar 2023 08:40:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Mar 2023 03:40:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Mar 2023 03:40:45 -0500
From:   Jeff King <peff@peff.net>
To:     Marcel Partap <mpartap@gmx.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] add -p: obey diff.noprefix option if set
Message-ID: <ZAWnDUkgO5clf6qu@coredump.intra.peff.net>
References: <20230304123900.358048-1-mpartap@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230304123900.358048-1-mpartap@gmx.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 04, 2023 at 01:39:00PM +0100, Marcel Partap wrote:

> If the user has set the diff.noprefix option, he likely will expect
> this display setting to also apply when interactively adding hunks.

I think it's reasonable for the interactive display to respect the
configured preferences here. But unfortunately, it's not quite as simple
as your patch.

> diff --git add-patch.c add-patch.c
> index a86a92e164..520faae9cb 100644

A semi-aside: I note that this patch was also generated with
diff.noprefix. It has to be applied with "git am -p0" (and anybody
receiving it has to know to do that).

The "aside" part is that this is (IMHO) a bug or at least a misfeature
in format-patch. Looks like it has come up a few times recently, too
(though AFAICT it has been this way since the option was added in 2010):

  https://lore.kernel.org/git/xmqqr1auvs7m.fsf@gitster.g/

  https://lore.kernel.org/git/CAAHpriMPdahH2xbrrQbeCJPYpLhr6tuvT6xsG3nACmskKF1v2w@mail.gmail.com/

The not-aside part is that this same problem is important for what your
patch is trying to do. ;)

If we generate the diff with "--no-prefix", then it has to be applied
with "-p0". But your patch touches only the generation side, so it
doesn't work at all:

  $ echo foo >>Makefile
  $ ./git -c diff.noprefix add -p
  diff --git Makefile Makefile
  [...etc...]
  +foo
  (1/1) Stage this hunk [y,n,q,a,d,e,?]? y
  error: git diff header lacks filename information when removing 1 leading pathname component (line 5)
  error: 'git apply' failed

There are two options, I think.

One is that we have a similar issue with color. To handle that, we
generate the diff twice, once with color and once without. We could
probably do the same thing here, by sticking the "--no-prefix" part with
the color setup. Though it turns out to be a little tricky to do because
of the way the code is written, and IIRC there are probably some corner
cases lurking (e.g., after splitting, I think we'll try to re-colorize
the diff headers ourselves).

The second is to just remember that we set noprefix and to add the
matching "-p0". Unfortunately we have to do so in a few places, but it's
not _too_ bad (and possibly some refactoring could make it less ugly).
Something like:

diff --git a/add-patch.c b/add-patch.c
index 520faae9cba..6e5390621c0 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1189,13 +1189,16 @@ static int run_apply_check(struct add_p_state *s,
 			   struct file_diff *file_diff)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
+	int noprefix;
 
 	strbuf_reset(&s->buf);
 	reassemble_patch(s, file_diff, 1, &s->buf);
 
 	setup_child_process(s, &cp,
 			    "apply", "--check", NULL);
 	strvec_pushv(&cp.args, s->mode->apply_check_args);
+	if (!git_config_get_bool("diff.noprefix", &noprefix) && noprefix)
+		strvec_pushf(&cp.args, "-p1");
 	if (pipe_command(&cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0))
 		return error(_("'git apply --cached' failed"));
 
@@ -1695,7 +1698,10 @@ static int patch_update_file(struct add_p_state *s,
 			apply_for_checkout(s, &s->buf,
 					   s->mode->is_reverse);
 		else {
+			int noprefix;
 			setup_child_process(s, &cp, "apply", NULL);
+			if (!git_config_get_bool("diff.noprefix", &noprefix) && noprefix)
+				strvec_pushf(&cp.args, "-p0");
 			strvec_pushv(&cp.args, s->mode->apply_args);
 			if (pipe_command(&cp, s->buf.buf, s->buf.len,
 					 NULL, 0, NULL, 0))

>  add-patch.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

We'd probably want at least one test using "add -p" with diff.noprefix
(probably in t3701). That would demonstrate that the feature works, as
well as protect it from future regressions (the test suite doesn't fail
even with your broken patch because no test sets noprefix).

-Peff
