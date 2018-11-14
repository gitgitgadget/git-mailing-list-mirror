Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB941F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 21:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeKOHnt (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 02:43:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:39854 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725756AbeKOHnt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 02:43:49 -0500
Received: (qmail 16824 invoked by uid 109); 14 Nov 2018 21:38:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Nov 2018 21:38:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8031 invoked by uid 111); 14 Nov 2018 21:38:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Nov 2018 16:38:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2018 16:38:51 -0500
Date:   Wed, 14 Nov 2018 16:38:51 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] tests: respect GIT_TEST_INSTALLED when initializing
 repositories
Message-ID: <20181114213851.GA2960@sigill.intra.peff.net>
References: <pull.73.git.gitgitgadget@gmail.com>
 <948b3dc146fe353fbab6057c1376fa0e787a444f.1542030510.git.gitgitgadget@gmail.com>
 <xmqqin10p8aq.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1811141413170.39@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1811141413170.39@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 02:16:37PM +0100, Johannes Schindelin wrote:

> > Makes perfect sense.  Shouldn't we be asking where the template
> > directory of the installed version is and using it instead of the
> > freshly built one, no?
> 
> It would make sense, but we don't know how to get that information, do we?
> 
> $ git grep DEFAULT_GIT_TEMPLATE_DIR
> Makefile:       -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
> builtin/init-db.c:#ifndef DEFAULT_GIT_TEMPLATE_DIR
> builtin/init-db.c:#define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
> builtin/init-db.c:              template_dir = to_free = system_path(DEFAULT_GIT_TEMPLATE_DIR);
> contrib/vscode/init.sh: '-DDEFAULT_GIT_TEMPLATE_DIR="$(template_dir_SQ)"' \
> 
> In other words, the Makefile defines the DEFAULT_GIT_TEMPLATE_DIR, and the
> only user in the code is init-db.c which uses it in copy_templates().
> 
> And changing the code *now* to let us query Git where it thinks its
> templates should be won't work, as this patch is about using the installed
> Git (at whatever pre-compiled version that might be).

Do we actually care where the templates are? I thought the point was to
override for the built Git to use the built templates instead of the
installed one. For an installed Git, shouldn't we not be overriding the
templates at all? I.e.:

  if test -n "$GIT_TEST_INSTALLED"
  then
	"$GIT_TEST_INSTALLED/git" init
  else
	"$GIT_ExEC_PATH/git" init --template="$GIT_BUILD_DIR/templates/blt"
  fi >&3 2>&4

(That's all leaving aside the question of whether we ought to be using a
clean template dir instead of this).

-Peff
