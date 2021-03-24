Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F7AC433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 22:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ACAD61A1F
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 22:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbhCXWl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 18:41:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:48154 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235465AbhCXWln (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 18:41:43 -0400
Received: (qmail 16130 invoked by uid 109); 24 Mar 2021 22:41:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Mar 2021 22:41:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22725 invoked by uid 111); 24 Mar 2021 22:41:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Mar 2021 18:41:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Mar 2021 18:41:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git <git@vger.kernel.org>, jost.schulte@tutanota.com
Subject: Re: Configure default merge message
Message-ID: <YFvAJU3Euxhjb+uw@coredump.intra.peff.net>
References: <MW_aJot--3-2@tutanota.com>
 <xmqqk0pwxqvt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk0pwxqvt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 24, 2021 at 01:01:42PM -0700, Junio C Hamano wrote:

> > I'd like to configure git to omit the "of https://bitbucket.org/repository-name" part. How can I do that?
> 
> Ævar, is this something we recently made it impossible with 4e168333
> (shortlog: remove unused(?) "repo-abbrev" feature, 2021-01-12), or
> is there more to it than resurrecting that "feature" to do what Jost
> seems to want?

IIRC, in that earlier discussion Linus said he used a prepare-commit-msg
hook these days instead of repo-abbrev. And it should be able to handle
this case, as well.

Something like this seems to work for me:

  $ cat .git/hooks/prepare-commit-msg
  #!/bin/sh
  case "$2" in
  merge)
  	perl -i -pe '
  	  s{Merge (.*) of https://github.com/gitster/git}{Merge $1}
  	' "$1"
  	;;
  esac

  $ git pull https://github.com/gitster/git next
  [...]
  $ git log -1 --format=%s
  Merge branch 'next'

-Peff
