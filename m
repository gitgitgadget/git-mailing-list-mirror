Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03859B41
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089448; cv=none; b=F3EhbOFImBA13uA7gy5lAVI7Vbx6P7wud/nzixbq1IZhGfYMXj9A4kFllATmxVTq2rSZRlb1gqoAAwZ+5SYmKAGMCQ1MxLzQC58DD9dqeSLhlDlq1WIUXP2a1FO7EDYhXyfzRIbRImZrQ+hZMsvLG5fjOtbta9n8MIQ53YYOK2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089448; c=relaxed/simple;
	bh=s4xYC8AJVp8m0y/8iyRYtyDiBQ9XPjxt2ULo71PSj58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQ4yGwWTBBJiprQvLT9AAplwm0HJQSs/ZwNcDS33RTddC9war/UWX5HZPCxOmZw2QVaply1llBi0Mw1+jCviuqyevH5+m+wJnY8qaGAPb7NUeGxE2aIGtPHoYIUi6ozLYCmFewW9xF+99e3oGVsbh/79n6xZFfS/JVaM13gg3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7358 invoked by uid 109); 2 Apr 2024 20:24:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Apr 2024 20:24:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1265 invoked by uid 111); 2 Apr 2024 20:24:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Apr 2024 16:24:08 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Apr 2024 16:24:05 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/t7700-repack.sh: fix test breakages with
 `GIT_TEST_MULTI_PACK_INDEX=1`
Message-ID: <20240402202405.GC875182@coredump.intra.peff.net>
References: <7e8d435d58eea19d2aae0be366720f5956d29a5d.1712075189.git.me@ttaylorr.com>
 <xmqqr0fn4nmx.fsf@gitster.g>
 <ZgxSSKGdAicfVhGA@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgxSSKGdAicfVhGA@nand.local>

On Tue, Apr 02, 2024 at 02:45:28PM -0400, Taylor Blau wrote:

> I have generally considered the `--write-midx` and
> `GIT_TEST_MULTI_PACK_INDEX` options to be orthogonal to each other. The
> latter is a developer-oriented option that forces Git to write a MIDX
> post-repack regardless of the command-line option.
> 
> It predates the `--write-midx` option by a number of years, and IIUC was
> introduced to enhance test coverage while the MIDX was being originally
> developed.
> 
> I would argue that GIT_TEST_MULTI_PACK_INDEX should be on the list of
> GIT_TEST_-variables to get rid of as it has served its purpose.

Hmm. Obviously it is of little value in this explicit --write-midx
test, but I thought the main value was just exercising all of the
_other_ tests with a midx in place. Doesn't that potentially have value
(just like testing with SPLIT_INDEX, etc, gets more coverage)?

If it is worth keeping (and I do not really have a strong opinion
there), the real issue seems to me that it does not behave like
--write-midx. That is the source of the problem here, but also makes
test runs with it unrealistic, since the command-line option is how
real-world users would trigger it.

I.e., I would have expected something like this, so that the variables
takes precedence over config but under command-line options:

diff --git a/builtin/repack.c b/builtin/repack.c
index 15e4cccc45..4b02d9cb77 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1197,6 +1197,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	git_config(repack_config, &cruft_po_args);
 
+	write_midx = git_env_bool(GIT_TEST_MULTI_PACK_INDEX, write_midx);
+	if (write_midx)
+		write_bitmaps = git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP,
+					     write_bitmaps);
+
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
 
@@ -1214,10 +1219,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (!write_midx &&
 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
 			write_bitmaps = 0;
-	} else if (write_bitmaps &&
-		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0) &&
-		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0)) {
-		write_bitmaps = 0;
 	}
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps > 0 && !write_midx;
@@ -1515,13 +1516,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (run_update_server_info)
 		update_server_info(0);
 
-	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0)) {
-		unsigned flags = 0;
-		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0))
-			flags |= MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX;
-		write_midx_file(get_object_directory(), NULL, NULL, flags);
-	}
-
 cleanup:
 	string_list_clear(&names, 1);
 	existing_packs_release(&existing);

But it gets weird because some tests (like t7700.2) explicitly ask for
bitmaps on the command line and want pack bitmaps but _not_ midx
bitmaps.

So I dunno. Maybe this is a can of worms that is not worth falling into.
After all, these are not "real" environment variables that we expect
users to use. I just wonder if the ci runs with them are buying us
anything for all of the tests outside of t7700.

-Peff
