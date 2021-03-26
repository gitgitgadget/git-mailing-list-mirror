Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE03AC433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 11:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC656193B
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 11:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhCZLbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 07:31:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:49802 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhCZLb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 07:31:27 -0400
Received: (qmail 32401 invoked by uid 109); 26 Mar 2021 11:31:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 11:31:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4881 invoked by uid 111); 26 Mar 2021 11:31:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 07:31:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 07:31:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: git diff --text does not work during rebase for binary files
Message-ID: <YF3GDgYSo889TaRJ@coredump.intra.peff.net>
References: <6afc8f1365627f08247f73da7e7e362c0b8ea560.camel@aegee.org>
 <4ef94ca7-ec69-f350-1d76-6bb8745786f1@gmail.com>
 <3807b29f442ab7026418511f058ff9513ee200ec.camel@aegee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3807b29f442ab7026418511f058ff9513ee200ec.camel@aegee.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 10:45:39AM +0200, Дилян Палаузов wrote:

> And now `git diff` and `git diff --text` both print:
> 
> diff --cc a.txt
> index ee95164,d7db2f0..0000000
> Binary files differ

I think the "combined diff" code isn't ready to handle the "--text"
flag.

An easier reproduction than rebase is to just do a merge with a
conflict:

  git init
  printf 'base\0' >file && git add file && git commit -m base
  printf 'one\0' >file && git commit -am one
  git checkout -b side HEAD^
  printf 'two\0' >file && git commit -am two
  git merge master

Now "git diff --text" will try to show a combined diff, but it doesn't
work. Likewise if you complete the merge:

  printf 'new\0' >file && git commit -a --no-edit

then "git show --text" will not show a binary combined diff, even though
"git show --text HEAD^" will happily show a normal two-endpoint diff.

Curiously old versions of Git would show broken binary combined diffs,
until 4d5f347199 (combine-diff: handle binary files as binary,
2011-05-23). So the binary detection there looks mostly sane, but it's
just not respecting the "--text" flag.

Something like this helps a bit:

diff --git a/combine-diff.c b/combine-diff.c
index 06635f91bc..940c5c43ff 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1128,6 +1128,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 
 	if (textconv)
 		is_binary = 0;
+	else if (opt->flags.text)
+		is_binary = 0;
 	else if (userdiff->binary != -1)
 		is_binary = userdiff->binary;
 	else {

but I don't think that's the full story. It looks like the combined-diff
code is too eager to treat the content as NUL-terminated strings. A
regular diff shows the NULs:

  $ git show --format= --text HEAD^  | cat -A
  diff --git a/file b/file$
  index d249428..a9382c3 100644$
  --- a/file$
  +++ b/file$
  @@ -1 +1 @@$
  -base^@$
  \ No newline at end of file$
  +two^@$
  \ No newline at end of file$

but the combined diff doesn't:

  $ git show --format= --text HEAD | cat -A
  diff --cc file$
  index a9382c3,f33a432..c984a04$
  --- a/file$
  +++ b/file$
  @@@ -1,1 -1,1 +1,1 @@@$
  - two$
   -one$
  ++new$

So I suspect the code is simply not read to handle the NULs, and the
current behavior of ignoring --text is better than producing truncated
or bogus output until those deeper problems are fixed. We could issue a
warning that --text was ignored, I suppose, but that doesn't really
solve your problem. :)

-Peff
