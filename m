Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09B920179
	for <e@80x24.org>; Sun, 26 Jun 2016 23:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbcFZXZB (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 19:25:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58388 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbcFZXZA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 19:25:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E4BF20179;
	Sun, 26 Jun 2016 23:25:00 +0000 (UTC)
Date:	Sun, 26 Jun 2016 23:25:00 +0000
From:	Eric Wong <e@80x24.org>
To:	David Turner <novalis@novalis.org>
Cc:	Duy Nguyen <pclouds@gmail.com>, kamggg@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH v12 04/20] index-helper: new daemon for caching index and
 related stuff
Message-ID: <20160626232500.GA3426@dcvr.yhbt.net>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
 <1463694357-6503-5-git-send-email-dturner@twopensource.com>
 <CACsJy8CftPGmrKP8Yeok90T9=whzj69bfE3_X6wHyWOEp6vRzg@mail.gmail.com>
 <576ED9A2.8070202@novalis.org>
 <20160626085347.GA4053@dcvr.yhbt.net>
 <577015C5.8070407@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <577015C5.8070407@novalis.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Turner <novalis@novalis.org> wrote:
> On 06/26/2016 04:53 AM, Eric Wong wrote:
> >David Turner <novalis@novalis.org> wrote:
> >>On 06/25/2016 10:33 AM, Duy Nguyen wrote:
> >>>>+               /*
> >>>>+                * Our connection to the client is blocking since a client
> >>>>+                * can always be killed by SIGINT or similar.
> >>>>+                */
> >>>>+               set_socket_blocking_flag(client_fd, 0);
> >>>
> >>>Out of curiosity, do we really need this? I thought default behavior
> >>>was always blocking (and checked linux kernel, it seemed to agree with
> >>>me). Maybe for extra safety because other OSes may default to
> >>>something else?
> >>
> >>Yes -- see this bug report for details:
> >>https://bugs.python.org/issue7995
> >
> >I realize it's an issue with BSDs, but it still seems
> >unnecessary, here:
> >
> >1) the packet_read => get_packet_data => read_in_full => xread
> >    call chain already poll()s on EAGAIN/EWOULDBLOCK.
> >    write_in_full => xwrite busy loops on EAGAIN/EWOULDBLOCK.
> >    xwrite should probably poll, too; but I guess EAGAIN is
> >    uncommon with small writes.
> 
> That is a CPU-burning busy loop on a non-blocking socket.

Indeed, fixes proposed in (xread was also broken(!)):
http://mid.gmane.org/20160626232112.721-3-e@80x24.org
http://mid.gmane.org/20160626232112.721-2-e@80x24.org
http://mid.gmane.org/20160626232112.721-1-e@80x24.org
