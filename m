Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288752082F
	for <e@80x24.org>; Sat, 15 Jul 2017 16:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751142AbdGOQFn (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 12:05:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:41536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751066AbdGOQFn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 12:05:43 -0400
Received: (qmail 30685 invoked by uid 109); 15 Jul 2017 16:05:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 15 Jul 2017 16:05:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21085 invoked by uid 111); 15 Jul 2017 16:05:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 15 Jul 2017 12:05:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Jul 2017 12:05:40 -0400
Date:   Sat, 15 Jul 2017 12:05:40 -0400
From:   Jeff King <peff@peff.net>
To:     John J Foerch <jjfoerch@earthlink.net>
Cc:     git@vger.kernel.org
Subject: Re: [FEATURE] git-commit option to prepend filename to commit message
Message-ID: <20170715160540.f2g5opqlr5z3r4aa@sigill.intra.peff.net>
References: <18894679.1800.1500128374439@elwamui-karabash.atl.sa.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18894679.1800.1500128374439@elwamui-karabash.atl.sa.earthlink.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 15, 2017 at 10:19:34AM -0400, John J Foerch wrote:

> The feature would be a command line option for git commit that would
> automatically prepend the "<filename>: " to the commit message.  The
> different cases of its behavior could be:
> 
>  - commit affecting a single file, with commit message given by -m:
> 
>    : prepend "<filename>: " to the message given by -m
> 
>  - commit affecting a single file, with commit message from editor:
> 
>    : pre-fill commit message template with "<filename>: "
> 
>  - commit affecting multiple files:
> 
>    : use common base directory of all affected files for <filename>, behaviors as above for use with -m or editor.
> 
> Anybody think that this or something like it would be a good convenience?

Johannes already pointed you to the prepare-commit-msg hook, which I
think is the right solution. I wrote a rough sketch for fun (note that
you could write it in whatever language you like if the mix of
perl/shell isn't to your liking):

-- >8 --
#!/bin/sh

# only kick in for vanilla commit, or "-m"
case "$2" in
""|message) ;;
*) exit 0
esac

# common prefix of all changed files
prefix=$(
        git diff-index --name-only HEAD |
        perl -lne '
                if (!defined $prefix) {
                        $prefix = $_;
                } else {
                        chop $prefix while !/^\Q$prefix\E/;
                }
                END {
                        # trim trailing slash if present
                        $prefix =~ s{/$}{};
                        print $prefix
                }
        '
)

# now stick the prefix at the start of the message-in-progress
{
        printf '%s' "$prefix: "
        cat "$1"
} >"$1".tmp &&
mv "$1".tmp "$1"
