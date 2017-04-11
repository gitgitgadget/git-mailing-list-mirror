Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F20120960
	for <e@80x24.org>; Tue, 11 Apr 2017 01:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753282AbdDKBPB (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 21:15:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:59589 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbdDKBPB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 21:15:01 -0400
Received: (qmail 9174 invoked by uid 109); 11 Apr 2017 01:14:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 01:14:57 +0000
Received: (qmail 30576 invoked by uid 111); 11 Apr 2017 01:15:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 21:15:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 21:14:54 -0400
Date:   Mon, 10 Apr 2017 21:14:54 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] test-lib: exhaustively insert non-alnum ASCII into
 the TRASH_DIRECTORY name
Message-ID: <20170411011454.oteysryg4t44gebj@sigill.intra.peff.net>
References: <20170409191117.25175-1-avarab@gmail.com>
 <20170409191117.25175-3-avarab@gmail.com>
 <CACBZZX7OfM-zivJAQMXdNarHDjAhzQhqGNZNs2QqDUyOo3AA0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7OfM-zivJAQMXdNarHDjAhzQhqGNZNs2QqDUyOo3AA0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 01:23:32AM +0200, Ævar Arnfjörð Bjarmason wrote:

> * Most of the tests fail because git clone can't deal with cloning a
> repo with a \r in the path. The error we produce when we try is quite
> bad and doesn't indicate what went wrong:
> 
> $ rm -rf /tmp/git.*; mkdir /tmp/git.$(perl -e 'print chr 13') && cd
> /tmp/git.* && git init --bare b && file b && git clone b c
> /b/tialized empty Git repository in /tmp/git.
> b: directory
> Cloning into 'c'...
> fatal: '/tmp/git. /b' does not appear to be a git repository
> fatal: Could not read from remote repository.
> 
> Please make sure you have the correct access rights
> and the repository exists.
> 
> So file(1) shows it exists, a strace shows that git knows it exists at
> some point, but something gets lost along the way.

It's the round-trip through the config. It writes:

  [remote "origin"]
  url = /tmp/git.^M/b

into the config (where ^M is a literal CR). And then on reading it back,
unquoted whitespace in config values is converted to spaces, which is
why you see "git. /b" in the error message (the other ones are ugly
because it's writing the raw CR in via printf, and your terminal
respects it. Try "2>&1 | cat -A" when debugging this sort of thing (our
error and warning messages clean up cruft like this already, but
informational messages don't always go through vreportf()).

Anyway, something like this would fix it (it actually adds "\r" to the
config format, which is how we handle \n and \t; we could do it without
touching the parsing side if we taught store_write_pair() to recognize
that \r needs to go in double-quotes).

diff --git a/config.c b/config.c
index 1a4d85537..4a36a37ba 100644
--- a/config.c
+++ b/config.c
@@ -526,6 +526,9 @@ static char *parse_value(void)
 			case 'n':
 				c = '\n';
 				break;
+			case 'r':
+				c = '\r';
+				break;
 			/* Some characters escape as themselves */
 			case '\\': case '"':
 				break;
@@ -2172,6 +2175,9 @@ static int store_write_pair(int fd, const char *key, const char *value)
 		case '\t':
 			strbuf_addstr(&sb, "\\t");
 			break;
+		case '\r':
+			strbuf_addstr(&sb, "\\r");
+			break;
 		case '"':
 		case '\\':
 			strbuf_addch(&sb, '\\');

-Peff
