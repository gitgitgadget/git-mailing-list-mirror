Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3961F51C
	for <e@80x24.org>; Tue, 22 May 2018 20:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeEVUTR (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 16:19:17 -0400
Received: from continuum.iocl.org ([217.140.74.2]:47462 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752365AbeEVUTR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 16:19:17 -0400
X-Greylist: delayed 1817 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 May 2018 16:19:16 EDT
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id w4MJmsB29639;
        Tue, 22 May 2018 21:48:54 +0200
Date:   Tue, 22 May 2018 21:48:54 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     git <git@vger.kernel.org>
Subject: bug: --shallow-since misbehaves on old branch heads
Message-ID: <20180522194854.GA29564@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everybody,

I think I have discovered a problem with clone/fetch --shallow-since:
When a ref that is fetches has a head that is already older than
the 'since' time, then the entire branch is fetched, instead of
just the current commit.

Repro:

  rm -rf tmp out deep
  git init tmp
  for i in `seq 10 31`; do
      d="2017-05-${i}T12:00"
      GIT_AUTOR_DATE="$d" GIT_COMMITTER_DATE="$d" git -C tmp commit -m nix$i --allow-empty
  done
  git -C tmp checkout -b test HEAD^^^
  for i in `seq 10 14`; do
      d="2017-06-${i}T12:00"
      GIT_AUTHOR_DATE="$d" GIT_COMMITTER_DATE="$d" git -C tmp commit -m nax$i --allow-empty
  done
  for i in `seq 1 4`; do
      git -C tmp commit -m new$i --allow-empty
  done

  echo "** This is fine:"

  git clone --shallow-since '1 month ago' file://`pwd`/tmp out --branch test
  git -C out log --oneline

  echo "** This should show one commit but shows all:"

  git clone --shallow-since '1 month ago' file://`pwd`/tmp deep --branch master
  git -C deep log --oneline

Do I expect the wrong thing?

- Andreas


-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
