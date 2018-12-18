Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 194DD1F405
	for <e@80x24.org>; Tue, 18 Dec 2018 13:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeLRNOc (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 08:14:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:44800 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726419AbeLRNOb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 08:14:31 -0500
Received: (qmail 17227 invoked by uid 109); 18 Dec 2018 13:14:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Dec 2018 13:14:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12932 invoked by uid 111); 18 Dec 2018 13:14:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Dec 2018 08:14:03 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2018 08:14:29 -0500
Date:   Tue, 18 Dec 2018 08:14:29 -0500
From:   Jeff King <peff@peff.net>
To:     Mark Kharitonov <mark.kharitonov@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Can git tell me which uncommitted files clash with the incoming
 changes?
Message-ID: <20181218131429.GE30471@sigill.intra.peff.net>
References: <CAG2YSPzmN5u1uAPVbjsqC3LzVVinFR21-_6wfrkBHdPWhOfMfQ@mail.gmail.com>
 <CACsJy8ANoiWfmLkmO9ACab5H+m2c2y5uhKBJzGNwwxcs9zV0wA@mail.gmail.com>
 <CABPp-BE9+qqVfccwzofD0qFecTGo2EjighNSu0vh-rF_8F5PoA@mail.gmail.com>
 <CACsJy8BFoK4hoXrSUi+P3xB1LumevvFe6XWAM2fLUq-UGNUs8A@mail.gmail.com>
 <CAG2YSPy85YtAv6m5WR4ZrsZ4TRzgcyrC4DNZnOONtFD6MsH=YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG2YSPy85YtAv6m5WR4ZrsZ4TRzgcyrC4DNZnOONtFD6MsH=YQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 17, 2018 at 05:50:31PM -0500, Mark Kharitonov wrote:

> Guys, having git merge --dry-run would be great, but I am OK with git
> merge for real as long as its output is parseable.
> 
> However, somewhere in between git 2.18 and git 2.20 the output of
> merge changed and now I do not know how to parse it.
> it used to be something like that:
> 
> bla bla bla
> <tab>file name 1
> <tab>file name 2
> ...
> bla bla bla
> 
> But now, the files are output in one line and given that some files
> may have spaces in the name I do not see how this can be parsed. If we
> could have easily parseable output of merge, it would be enough for
> me.

Interesting. I don't see that behavior at all. E.g., running this:

-- >8 --
git init repo
cd repo

echo base >base; git add base; git commit -m base
for i in one two three; do
	echo $i >$i
done
git add .
git commit -m master

git checkout -b other HEAD^
echo other >other; git add other; git commit -m other

for i in one two three; do
	echo working-tree >$i
done

git pull . master
-- 8< --

I see:

  error: The following untracked working tree files would be overwritten by merge:
  	one
  	three
  	two
  Please move or remove them before you merge.

I wonder if it has to do with Windows.

If you can reproduce it at will, can you try bisecting between v2.18 and
v2.20 to see which commit introduced the change?

-Peff
