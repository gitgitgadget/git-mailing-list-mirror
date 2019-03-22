Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEAC020248
	for <e@80x24.org>; Fri, 22 Mar 2019 14:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfCVOTc (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 10:19:32 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:48108 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfCVOTc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 10:19:32 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1h7L13-0002h2-T6; Fri, 22 Mar 2019 23:19:25 +0900
Date:   Fri, 22 Mar 2019 23:19:25 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: How to properly find git config in a libgit.a-using executable?
Message-ID: <20190322141925.olzzfjm5ytp2gwv7@glandium.org>
References: <20190320101941.2xjsjx3zfnnp33a2@glandium.org>
 <20190322073311.GA839@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903221436590.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903221436590.41@tvgsbejvaqbjf.bet>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 02:39:43PM +0100, Johannes Schindelin wrote:
> Hi Peff & Mike,
> 
> On Fri, 22 Mar 2019, Jeff King wrote:
> 
> > On Wed, Mar 20, 2019 at 07:19:41PM +0900, Mike Hommey wrote:
> >
> > > I thought of a few options (it's worth noting the helper is invoked in a
> > > way that makes $GIT_EXEC_PATH set, which can help a little):
> > > - spawn `$GIT_EXEC_PATH/git-config -l -z`, parse its output, and set the
> > >   internal config from that. That's the barbarian option.
> > > - build the helper with RUNTIME_PREFIX, and modify the RUNTIME_PREFIX
> > >   code to use $GIT_EXEC_PATH if it's set, rather than the path the
> > >   executable is in. That actually sounds reasonable enough that I'd send
> > >   a patch for git itself. But that doesn't quite address the nitpick case
> > >   where ETC_GITCONFIG could be either `/etc/gitconfig` or
> > >   `etc/gitconfig` depending how git was compiled, and there's no way to
> > >   know which is the right one.
> >
> > I'm not entirely sure I understand the problem, but it sounds like you
> > want to know the baked-in ETC_GITCONFIG for a built version of git (that
> > isn't necessarily the one that shares your build of libgit.a).
> >
> > There's no direct way to have Git print that out. It would be reasonable
> > to add one to rev-parse, I think.
> >
> > Barring that, here's a hack:
> >
> >   git config --system --show-origin --list -z |
> >   perl -lne '/^file:(.*?)\0/ and print $1 and exit 0'
> >
> > If the file is empty, it won't print anything, of course. But then,
> > you'd know that it also has no config in it. :)
> 
> How about
> 
> 	GIT_EDITOR=echo git config --system -e 2>/dev/null
> 
> It will error out if the directory does not exist, for some reason, e.g.
> when you installed Git in your home directory via `make install` from a
> fresh clone. So you'll have to cope with that contingency.

Thank you both, I can probably work with this, although I might have to
alter the git init sequence. I'm not sure my usecase needs git to cater
for it more generally, though. Who else uses libgit.a?

Mike
