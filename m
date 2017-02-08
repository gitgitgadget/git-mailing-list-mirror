Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 013561FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 20:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbdBHU7D (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 15:59:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:51769 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751217AbdBHU7D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 15:59:03 -0500
Received: (qmail 28343 invoked by uid 109); 8 Feb 2017 20:52:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 20:52:21 +0000
Received: (qmail 3814 invoked by uid 111); 8 Feb 2017 20:52:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 15:52:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 15:52:19 -0500
Date:   Wed, 8 Feb 2017 15:52:19 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/11] reducing resource usage of for_each_alternate_ref
Message-ID: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a minor re-roll of the patches from:

  http://public-inbox.org/git/20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net/

(which got some review, but I don't think was picked up for even 'pu').

I won't repeat the numbers and background from that message, but the
gist of it is that this reduces memory usage significantly when your
alternate has a lot of refs in it.

This version makes two minor changes:

  - it drops the save_commit_buffer patch to clone; it's redundant with
    what fetch_pack() is doing internally, and I wasn't able to measure
    any improvement

  - it adds a missing "static" to an internal function

The only other possible change from the review would be sorting the
expected output in the test of the final script. I'm on the fence
whether it is a feature that we expect a particular ordering. It's not
set in stone ,but it _is_ deterministic, and if we change the order, it
might be worth somebody actually noticing.

  [01/11]: for_each_alternate_ref: handle failure from real_pathdup()
  [02/11]: for_each_alternate_ref: stop trimming trailing slashes
  [03/11]: for_each_alternate_ref: use strbuf for path allocation
  [04/11]: for_each_alternate_ref: pass name/oid instead of ref struct
  [05/11]: for_each_alternate_ref: replace transport code with for-each-ref
  [06/11]: fetch-pack: cache results of for_each_alternate_ref
  [07/11]: add oidset API
  [08/11]: receive-pack: use oidset to de-duplicate .have lines
  [09/11]: receive-pack: fix misleading namespace/.have comment
  [10/11]: receive-pack: treat namespace .have lines like alternates
  [11/11]: receive-pack: avoid duplicates between our refs and alternates

 Makefile               |  1 +
 builtin/receive-pack.c | 41 +++++++++++++++-------------
 fetch-pack.c           | 48 ++++++++++++++++++++++++++++-----
 object.h               |  2 +-
 oidset.c               | 49 ++++++++++++++++++++++++++++++++++
 oidset.h               | 45 +++++++++++++++++++++++++++++++
 t/t5400-send-pack.sh   | 38 ++++++++++++++++++++++++++
 transport.c            | 72 +++++++++++++++++++++++++++++++++++---------------
 transport.h            |  2 +-
 9 files changed, 249 insertions(+), 49 deletions(-)
 create mode 100644 oidset.c
 create mode 100644 oidset.h

