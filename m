Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A91F21FE4E
	for <e@80x24.org>; Sun, 26 Jun 2016 08:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbcFZIyB (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 04:54:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43870 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbcFZIx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 04:53:59 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C611FE4E;
	Sun, 26 Jun 2016 08:53:47 +0000 (UTC)
Date:	Sun, 26 Jun 2016 08:53:47 +0000
From:	Eric Wong <e@80x24.org>
To:	David Turner <novalis@novalis.org>
Cc:	Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v12 04/20] index-helper: new daemon for caching index and
 related stuff
Message-ID: <20160626085347.GA4053@dcvr.yhbt.net>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
 <1463694357-6503-5-git-send-email-dturner@twopensource.com>
 <CACsJy8CftPGmrKP8Yeok90T9=whzj69bfE3_X6wHyWOEp6vRzg@mail.gmail.com>
 <576ED9A2.8070202@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <576ED9A2.8070202@novalis.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Turner <novalis@novalis.org> wrote:
> On 06/25/2016 10:33 AM, Duy Nguyen wrote:
> >>+               /*
> >>+                * Our connection to the client is blocking since a client
> >>+                * can always be killed by SIGINT or similar.
> >>+                */
> >>+               set_socket_blocking_flag(client_fd, 0);
> >
> >Out of curiosity, do we really need this? I thought default behavior
> >was always blocking (and checked linux kernel, it seemed to agree with
> >me). Maybe for extra safety because other OSes may default to
> >something else?
> 
> Yes -- see this bug report for details:
> https://bugs.python.org/issue7995

I realize it's an issue with BSDs, but it still seems
unnecessary, here:

1) the packet_read => get_packet_data => read_in_full => xread
   call chain already poll()s on EAGAIN/EWOULDBLOCK.
   write_in_full => xwrite busy loops on EAGAIN/EWOULDBLOCK.
   xwrite should probably poll, too; but I guess EAGAIN is
   uncommon with small writes.

2) you create the listen fd you call accept on and never set
   non-blocking on it.  It might be an issue one day if
   we use socket activation and inherit a socket, but the
   retries mentioned in 1) should cover that case.
