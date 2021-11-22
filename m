Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD34C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhKVWkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:40:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:36778 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231591AbhKVWkf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:40:35 -0500
Received: (qmail 22504 invoked by uid 109); 22 Nov 2021 22:37:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 22:37:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26582 invoked by uid 111); 22 Nov 2021 22:37:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Nov 2021 17:37:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Nov 2021 17:37:26 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 1/3] object-name: remove unreachable "unknown type"
 handling
Message-ID: <YZwbphPpfGk78w2f@coredump.intra.peff.net>
References: <cover-v3-0.3-00000000000-20211008T193041Z-avarab@gmail.com>
 <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com>
 <patch-v4-1.3-2e7090c09f9-20211122T175219Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v4-1.3-2e7090c09f9-20211122T175219Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 06:53:23PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Remove unreachable "unknown type" handling in the code that displays
> the ambiguous object list. See [1] for the current output, and [1] for
> the commit that added the "unknown type" handling.
> 
> The reason this code wasn't reachable is because we're not passing in
> OBJECT_INFO_ALLOW_UNKNOWN_TYPE, so we'll die in sort_ambiguous()
> before we get to show_ambiguous_object():
> 
>     $ git rev-parse 8315
>     error: short object ID 8315 is ambiguous
>     hint: The candidates are:
>     fatal: invalid object type

I'm not so sure about this reasoning. In the code we are getting the
type fresh from oid_object_info():

> @@ -361,6 +361,8 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
>  		return 0;
>  
>  	type = oid_object_info(ds->repo, oid, NULL);
> +	assert(type == OBJ_TREE || type == OBJ_COMMIT ||
> +	       type == OBJ_BLOB || type == OBJ_TAG);

so at the very least we have to worry about the answer changing between
the two spots. You talk above about ALLOW_UNKNOWN_TYPE, but can't we
just get a straight "-1" if there's an error opening the object?

I'm also confused about the mention of die in sort_ambiguous(). It looks
like it would just produce a funny sort order in that case.

Here's a case that triggers the difference:

  git init repo
  cd repo

  one=$(echo 851 | git hash-object -w --stdin)
  two=$(echo 872 | git hash-object -w --stdin)
  oid=$(echo $two | cut -c1-4)

  fn=.git/objects/$(echo $two | perl -pe 's{..}{$&/}')
  chmod +w $fn
  echo broken >$fn

  git show $oid

Without your patch, it produces:

  error: short object ID ee3d is ambiguous
  hint: The candidates are:
  error: inflate: data stream error (incorrect header check)
  error: unable to unpack ee3d8abaa95a7395b373892b2593de2f426814e2 header
  error: inflate: data stream error (incorrect header check)
  error: unable to unpack ee3d8abaa95a7395b373892b2593de2f426814e2 header
  hint:   ee3d8ab unknown type
  hint:   ee3de99 blob

With your patch:

  error: short object ID ee3d is ambiguous
  hint: The candidates are:
  error: inflate: data stream error (incorrect header check)
  error: unable to unpack ee3d8abaa95a7395b373892b2593de2f426814e2 header
  error: inflate: data stream error (incorrect header check)
  error: unable to unpack ee3d8abaa95a7395b373892b2593de2f426814e2 header
  git: object-name.c:364: show_ambiguous_object: Assertion `type == OBJ_TREE || type == OBJ_COMMIT || type == OBJ_BLOB || type == OBJ_TAG' failed.
  Aborted

-Peff
