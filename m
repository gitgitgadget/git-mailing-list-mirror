Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395C01F461
	for <e@80x24.org>; Wed, 15 May 2019 10:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfEOK4N (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 06:56:13 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:42980 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfEOK4M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 06:56:12 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hQrZx-0003s8-21
        for git@vger.kernel.org; Wed, 15 May 2019 19:56:09 +0900
Date:   Wed, 15 May 2019 19:56:09 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: Closing fds twice when using remote helpers
Message-ID: <20190515105609.sucfjvuumeyyrmjb@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I started getting a weird error message during some test case involving
git-cinnabar, which is a remote-helper to access mercurial
repositories.

The error says:
fatal: mmap failed: Bad file descriptor

... which was not making much sense. Some debugging later, and it turns
out this is what happens:

- start_command is called for fast-import
- start_command is called again for git-remote-hg, passing the
  fast_import->out as cmd->in.
- in start_command, we end up on the line of code that does
  close(cmd->in), so fast_import->out/cmd->in is now closed
- much later, in disconnect_helper, we call close(data->helper->out),
  where data->helper is the cmd for fast-import, and that fd was already
closed above.
- Except, well, fds being what they are, we in fact just closed a fd
  from a packed_git->pack_fd. So, when use_pack is later called, and
  tries to mmap data from that pack, it fails because the file
  descriptor was closed.

I'm not entirely sure how to address this... Any ideas?

Relatedly, use_pack calls xmmap, which does its own error handling and
die()s in case of error, but then goes on to do its own check with a
different error message (which, in fact, could be more useful in other
cases). It seems like it should call xmmap_gently instead.

Cheers,

Mike
