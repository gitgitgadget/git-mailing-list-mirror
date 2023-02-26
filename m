Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9ECC64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 23:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBZXQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 18:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBZXQK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 18:16:10 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6865712859
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 15:16:07 -0800 (PST)
Received: (qmail 2225 invoked by uid 109); 26 Feb 2023 23:16:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Feb 2023 23:16:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9994 invoked by uid 111); 26 Feb 2023 23:16:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Feb 2023 18:16:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 26 Feb 2023 18:16:06 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Henry <git@drmikehenry.com>
Cc:     git@vger.kernel.org
Subject: Re: `git bundle create -` may not write to `stdout`
Message-ID: <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2023 at 07:58:33AM -0500, Michael Henry wrote:

> Summary
> =======
> 
> Using `-` to create a bundle file on `stdout` works only when the
> current working directory is at the root of the repository; when in a
> subdirectory, `-` is treated as the name of a file instead.

Hmm, yeah. The problem is that we call prefix_filename() to accommodate
the fact that we'll have changed directory to the root of the working
tree, and it has no knowledge that "-" is special for bundle creation.

The most directed fix is this:

diff --git a/builtin/bundle.c b/builtin/bundle.c
index acceef6200..145b814f48 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -59,7 +59,9 @@ static int parse_options_cmd_bundle(int argc,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	if (!argc)
 		usage_msg_opt(_("need a <file> argument"), usagestr, options);
-	*bundle_file = prefix_filename(prefix, argv[0]);
+	*bundle_file = strcmp(argv[0], "-") ?
+		       prefix_filename(prefix, argv[0]) :
+		       xstrdup(argv[0]);
 	return argc;
 }
 

though I wonder if there are similar cases for other commands,
especially ones where the call to prefix_filename() is lurking behind an
OPT_FILENAME() option.

It's tempting to treat this name as special at that level, like:

diff --git a/abspath.c b/abspath.c
index 39e06b5848..e89697c85f 100644
--- a/abspath.c
+++ b/abspath.c
@@ -269,7 +269,7 @@ char *prefix_filename(const char *pfx, const char *arg)
 
 	if (!pfx_len)
 		; /* nothing to prefix */
-	else if (is_absolute_path(arg))
+	else if (is_absolute_path(arg) || !strcmp(arg, "-"))
 		pfx_len = 0;
 	else
 		strbuf_add(&path, pfx, pfx_len);

but I suspect that may bite us in the long run. Something like:

  git mv -- foo -

should treat "-" literally, and not as some special token (stdout does
not even make sense in this context).

> Anything else you want to add:
> ==============================
> 
> It's unclear to me whether creating a bundle file to `stdout` is documented
> behavior.  I can't find direct mention of it in
> `Documentation/git-bundle.txt`,
> though that document does have this text:
> 
>     --all-progress::
>             When --stdout is specified then progress report is
>             displayed during the object count and compression phases
>             but inhibited during the write-out phase. The reason is
>             that in some cases the output stream is directly linked
>             to another command which may wish to display progress
>             status of its own as it processes incoming pack data.
>             This flag is like --progress except that it forces progress
>             report for the write-out phase as well even if --stdout is
>             used.
> 
> The switch `--stdout` doesn't seem to exist, though; perhaps it was a past
> feature that got removed but the documentation hung around?

It comes from 79862b6b77 (bundle-create: progress output control,
2019-11-10), which I think was trying to copy the explanation from the
similar options in pack-objects (which underlies git-bundle, and we just
forward those options to it).

Every reference to "--stdout" there should probably be replaced with
"when writing a bundle to stdout" (or alternatively, these should
perhaps just be pointers to the pack-objects equivalents).

And yes, we should document "-" (probably when discussing <file> in the
"create" section of OPTIONS), as I don't see any mention of it. Its
behavior is intentional (it goes all the way back to 2e0afafebd (Add
git-bundle: move objects and references by archive, 2007-02-22)).

I think having "--stdout" would have been a nicer choice to avoid this
ambiguity, but at this point it is probably not worth going through
deprecation dance to get rid of it.

> I find the ability to create a bundle to `stdout` a useful feature,
> though a niche use case: I'm post-processing the bundle file's
> contents before writing to a file, and bundling to `stdout` saves the
> creation of a potentially large temporary file.  I'm currently using
> the temporary file approach, however, because I'm not sure that
> bundling to `stdout` is intended as a supported feature; I'll leave
> that for you to determine.

I think bundling to stdout is perfectly reasonable. Even without
post-processing, if you need to use a command to get it to its ultimate
storage spot (e.g., by piping into a network command like "nc" or
something), it's nice to avoid the temporary file because it could
potentially be huge.

So it seems like we'd want a three-patch series:

  1. The first hunk I showed above, along with a test to demonstrate the
     fix.

  2. Remove bogus references to --stdout in the docs.

  3. Document "-".

Do you want to try your hand at that? (It's OK if not, but I like to
trick^W give opportunities to new folks to contribute).

-Peff
