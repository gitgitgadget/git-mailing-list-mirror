Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013DDC77B71
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 08:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjDOIwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 04:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDOIwO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 04:52:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9540F1
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 01:52:09 -0700 (PDT)
Received: (qmail 28515 invoked by uid 109); 15 Apr 2023 08:52:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 Apr 2023 08:52:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2979 invoked by uid 111); 15 Apr 2023 08:52:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 Apr 2023 04:52:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 Apr 2023 04:52:07 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Bock <bockthom@cs.uni-saarland.de>
Cc:     git@vger.kernel.org
Subject: Re: Weird behavior of 'git log --before' or 'git log --date-order':
 Commits from 2011 are treated to be before 1980
Message-ID: <20230415085207.GA656008@coredump.intra.peff.net>
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023 at 01:37:57PM +0200, Thomas Bock wrote:

> Example to reproduce:
> 
> git clone git@github.com:LibreOffice/core.git libreoffice
> cd libreoffice
> git log --no-merges --before="1980-01-01T00:00:00+0000"
> --format=%H,%ct,%ci,%ad

Thanks for providing a clear example and reproduction recipe. It's an
interesting case. The commits _are_ malformed, but only slightly. For
example:

  $ git cat-file commit d3b03514dde317473db0d247f21405b5db6a727e
  tree c7526375c71327a195714e9e325b66a9ad013d74
  parent 61099481271709723469421181f65e6219cbc271
  author Andre Fischer<andre.f.fischer <Andre Fischer<andre.f.fischer@oracle.com>> 1297247749 +0100
  committer Andre Fischer<andre.f.fischer <Andre Fischer<andre.f.fischer@oracle.com>> 1297247749 +0100

There's an extra weird set of angle brackets in both the author and
committer lines.

But here's the really quirky part: there actually two parsers being used
in Git here. One is in parse_commit_buffer(), which does the minimum to
fill in the fields of a "struct commit": parents, tree, and committer
timestamp.  That parser calls parse_commit_date(), which finds the first
">" and then tries to parse "> 1297247749 +0100" as a timestamp, which
fails. So it uses the sentinel value "0" (aka 1970-01-01). And that's
what gets used for "--before" (and "--since", and things like queue
order for showing commits).

But then when we actually _display_ the commit, we have a whole
pretty-printing system. There we usually end up in split_ident_line(),
which is a bit more forgiving, due to 03818a4a94 (split_ident: parse
timestamp from end of line, 2013-10-14). It finds the trailing ">" from
the right-hand side, which in this case yields the correct timestamp.

We could probably use the same trick in parse_commit_date(), something
like:

diff --git a/commit.c b/commit.c
index 6d844da9a6..72d21a2bb8 100644
--- a/commit.c
+++ b/commit.c
@@ -95,6 +95,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 static timestamp_t parse_commit_date(const char *buf, const char *tail)
 {
 	const char *dateptr;
+	const char *eol;
 
 	if (buf + 6 >= tail)
 		return 0;
@@ -106,16 +107,22 @@ static timestamp_t parse_commit_date(const char *buf, const char *tail)
 		return 0;
 	if (memcmp(buf, "committer", 9))
 		return 0;
-	while (buf < tail && *buf++ != '>')
+
+	/*
+	 * parse to end-of-line and then walk backwards, which
+	 * handles some malformed cases. Alternatively, once
+	 * we have eol, we could just call split_ident_line()
+	 */
+	eol = buf;
+	while (eol < tail && *eol++ != '\n')
 		/* nada */;
-	if (buf >= tail)
+	if (eol >= tail)
 		return 0;
-	dateptr = buf;
-	while (buf < tail && *buf++ != '\n')
+	for (dateptr = eol; dateptr > buf && dateptr[-1] != '>'; dateptr--)
 		/* nada */;
-	if (buf >= tail)
+	if (dateptr == buf || dateptr == eol)
 		return 0;
-	/* dateptr < buf && buf[-1] == '\n', so parsing will stop at buf-1 */
+	/* dateptr < eol && *eol == '\n', so parsing will stop at eol */
 	return parse_timestamp(dateptr, NULL, 10);
 }
 

which makes your case behave as expected. It may make sense to use
split_ident_line(), which I think has a few other rules (it actually
checks for something that looks like numbers, for instance).

There may be also cases where the two diverge. Obviously having two
parsers isn't ideal. I think sharing the code may involve a lot of work,
though. The pretty-print parser is interested in pulling out more
information, and is less focused on performance. Parsing commits is
traditionally a hot path, as we historically had to parse every commit,
even if we weren't showing it (including non-log operations like
computing merge bases, reachability, and so forth).

But that may not matter so much. One, we already inflate the whole
commit object, not just the header. So even if we spend a few extra
instructions on parsing, it may not be noticeable. And two, these days
we often cache commit metadata in the commit-graph files, which avoids
loading the commit message entirely (and thus this parsing) for most
operations.

Of course it may also be reasonable to consider this mystery solved and
leave the code as-is. These objects _are_ malformed. I note they're all
at least a decade old, and most of them are from a handful of committers
(who presumably had misconfigured idents for a while). These days I
think Git wouldn't allow them (I don't think it rejects the commit, but
it does screen out the syntactically bogus characters).

-Peff
