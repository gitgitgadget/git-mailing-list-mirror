Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3683C1F461
	for <e@80x24.org>; Wed, 15 May 2019 22:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfEOWIn (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 18:08:43 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:58964 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfEOWIm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 18:08:42 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hR24g-0007zL-Co; Thu, 16 May 2019 07:08:34 +0900
Date:   Thu, 16 May 2019 07:08:34 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Closing fds twice when using remote helpers
Message-ID: <20190515220834.svurujspjt3bmath@glandium.org>
References: <20190515105609.sucfjvuumeyyrmjb@glandium.org>
 <87bm04vt81.fsf@evledraar.gmail.com>
 <b6ff2486-a1c2-4e89-4338-9e4e56d528bc@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6ff2486-a1c2-4e89-4338-9e4e56d528bc@kdbg.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 07:59:49PM +0200, Johannes Sixt wrote:
> Am 15.05.19 um 13:43 schrieb Ævar Arnfjörð Bjarmason:
> > 
> > On Wed, May 15 2019, Mike Hommey wrote:
> > 
> >> Hi,
> >>
> >> I started getting a weird error message during some test case involving
> >> git-cinnabar, which is a remote-helper to access mercurial
> >> repositories.
> >>
> >> The error says:
> >> fatal: mmap failed: Bad file descriptor
> >>
> >> ... which was not making much sense. Some debugging later, and it turns
> >> out this is what happens:
> >>
> >> - start_command is called for fast-import
> 
> I guess, you request fast_import->out = -1.
> 
> >> - start_command is called again for git-remote-hg, passing the
> >>   fast_import->out as cmd->in.
> 
> OK.
> 
> >> - in start_command, we end up on the line of code that does
> >>   close(cmd->in), so fast_import->out/cmd->in is now closed
> 
> Yes. That's how the interface is specified.
> 
> >> - much later, in disconnect_helper, we call close(data->helper->out),
> >>   where data->helper is the cmd for fast-import, and that fd was already
> >> closed above.
> 
> That must is wrong. Passing a fd to start_command() relinquishes
> responsibility.
> 
> >> - Except, well, fds being what they are, we in fact just closed a fd
> >>   from a packed_git->pack_fd. So, when use_pack is later called, and
> >>   tries to mmap data from that pack, it fails because the file
> >>   descriptor was closed.
> 
> Either dup() the file descriptor, or mmap() before you call the
> consuming start_command().

You seem to imply this is my code doing something. It's not. The process
that is doing all the things I noted above is an unmodified `git fetch`,
when using a remote-helper transport. The use_pack happens after the
transport is disposed because that's at the end of git fetch, when it
updates refs.

Anyway, it would seem the fix is to dup(out) when passing it as in to
start_command?

Mike
