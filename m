Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE6BE7B611
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 13:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242523AbjJDNLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 09:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjJDNLP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 09:11:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A190A1
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 06:11:12 -0700 (PDT)
Received: (qmail 7218 invoked by uid 109); 4 Oct 2023 13:11:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Oct 2023 13:11:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4841 invoked by uid 111); 4 Oct 2023 13:11:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Oct 2023 09:11:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Oct 2023 09:11:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [silly] loose, pack, and another thing?
Message-ID: <20231004131110.GA607079@coredump.intra.peff.net>
References: <xmqqbkdometi.fsf@gitster.g>
 <20230928214010.3502838-1-jonathantanmy@google.com>
 <20231003190955.GA1562@coredump.intra.peff.net>
 <xmqqo7hfwg6m.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7hfwg6m.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 02:26:41PM -0700, Junio C Hamano wrote:

> > You can get some safety with the immutable attribute (which applies to
> > the inode itself, and thus any path that hardlinks to it). But setting
> > that usually requires being root. And it creates other irritations for
> > normal use (you have to unset it before even removing the hardlink).
> 
> As a regular user, "chmod a-w" has the same characteristics (works
> at the inode level) but without "cannot remove it" downside.  It
> used to be sufficient in RCS and CVS days, though, as a signal that
> you are only to look at it without touching it, to "chmod a-w" a
> path that is checked out but not for modifying.  Some editors even
> offer to do chmod u+w for you when saving, so if we want absolute
> safety, it may not be enough.

Ah, right. For some reason I was thinking that only affected the link
entry, but of course the mode bits are on the linked inode itself.  So
that does easily give some protection, though I agree that many programs
are happy to circumvent it for you.

It has been a long time since I've used it, but I think there may be
some prior at in git-annex:

  https://git-annex.branchable.com/

IIRC it can work in a "copy" mode where contents are copied into the
working tree. But since the point is to deal with large data sets, it
also has a linking mode (maybe even symlinks?) that point directly from
the working tree into the annex storage. If we are considering a similar
feature, we might be able to learn from their experience.

-Peff
