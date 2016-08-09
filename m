Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4AC41FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 06:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbcHIGi6 (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 02:38:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:51766 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751020AbcHIGi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 02:38:57 -0400
Received: (qmail 4851 invoked by uid 109); 9 Aug 2016 06:38:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 06:38:55 +0000
Received: (qmail 17829 invoked by uid 1000); 9 Aug 2016 06:38:55 -0000
Date:	Tue, 9 Aug 2016 02:38:55 -0400
From:	Jeff King <peff@peff.net>
To:	Paul Hammant <paul@hammant.org>
Cc:	git@vger.kernel.org
Subject: Re: [bug] git-check-ignore and file names with unicode chars in name
 - sys-out filename is corrupted
Message-ID: <20160809063854.GA17777@peff.net>
References: <CA+298UiKf6heNPy-NZSfdx47jyS_aK+C8UX3vh6OB3_XE+pn=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+298UiKf6heNPy-NZSfdx47jyS_aK+C8UX3vh6OB3_XE+pn=g@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 01:47:18AM -0400, Paul Hammant wrote:

> Reproduction:
> 
>   $ echo "*.ignoreme" >> .gitignore
>   # (and commit)
>   $ touch "fooo-€.ignoreme"
>   $ find . -print | grep fooo | xargs git check-ignore
>   "./fooo-\342\202\254.ignoreme"
> 
> You could view that git-check-ignore isn't corrupting anything, it is
> just outputting another form for the file name (octal escaped), but it
> doesn't need to change it at all, and its causing downstream problems
> in bash scripting.

It's not corrupted; like all git commands, check-ignore by default
prints paths with a reversible quoting mechanism, so that odd filenames
are not syntactically ambiguous (e.g., consider a filename with a
newline in it), and so that you don't get binary spew on your terminal.

For robust scripting, you can either:

  - unquote the filenames in the receiving script (detect the presence
    of quoting by the double-quote in the first character, and then
    normal C-style dequoting).

or

  - use "-z" to get NUL-delimited filenames with no quoting. Your
    example above has problems in the find, grep, and xargs
    commands, too. A more careful version is:

      find . -print0 | grep -z fooo | git check-ignore --stdin -z

For human readability, you can do:

  git config core.quotepath false

to avoid quoting binary characters (here and in other tools like "git
diff"), which is convenient if you use UTF8 filenames. It also will
"unbreak" your scripts in the sense that it will avoid quoting in more
situations. The scripts would still choke on more weird filenames
(e.g., ones with embedded tabs or newlines), but in practice you'd
probably never notice.

-Peff
