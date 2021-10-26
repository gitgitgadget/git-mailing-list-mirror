Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6243C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 20:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED6C60F9B
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 20:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhJZURN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 16:17:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49056 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230413AbhJZURN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 16:17:13 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 2961C1F953;
        Tue, 26 Oct 2021 20:14:49 +0000 (UTC)
Date:   Tue, 26 Oct 2021 20:14:49 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: scripting speedups [was: [Summit topic] Crazy (and not so crazy)
 ideas]
Message-ID: <20211026201448.GA29480@dcvr>
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211144490.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2110211144490.56@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> * Test suite is slow. Shell scripts and process forking.
> 
>    * What if we had a special shell that interpreted the commands in a
>      single process?
> 
>    * Even Git commands like rev-parse and hash-object, as long as that’s
>      not the command you’re trying to test

This is something I've wanted in a very long time as a scripter.
fast-import has been great over the years, as is
"cat-file --batch(-check)", but there's gaps should be filled
(preferably without fragile linkage of shared libraries into a
script process)

>    * Dscho wants to slip in a C-based solution
> 
>    * Jonathan tan commented: going back to your custom shell for tests
>      idea, one thing we could do is have a custom command that generates
>      the repo commits that we want (and that saves process spawns and
>      might make the tests simpler too)

Perhaps a not-seriously-proposed patch from 2006 could be
modernized for our now-libified internals:

https://yhbt.net/lore/git/Pine.LNX.4.64.0602232229340.3771@g5.osdl.org/

>       * We could replace several “setup repo” steps with “git fast-import”
>         instead.
> 
>    * Dscho measured: 0.5 sec - 30 sec in setup steps. Can use fast-import,
>      or can make a new format that helps us set up the test scenario

0.5s - 30s across the whole suite or individual tests?

Having a way to disable fsync globally should further improve
things, especially for people on slower storage.  libeatmydata
is available, but perhaps not widely available/known.

>    * Elijah: test-lib-functions helpers could be built ins
