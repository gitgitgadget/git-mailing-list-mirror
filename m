Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F5A1F6C1
	for <e@80x24.org>; Sun, 21 Aug 2016 14:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbcHUO1E (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 10:27:04 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:55262 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbcHUO1D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 10:27:03 -0400
Received: from mfilter35-d.gandi.net (mfilter35-d.gandi.net [217.70.178.166])
        by relay5-d.mail.gandi.net (Postfix) with ESMTP id B451941C087;
        Sun, 21 Aug 2016 16:27:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter35-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
        by mfilter35-d.gandi.net (mfilter35-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id Lp1yKwKEFbgP; Sun, 21 Aug 2016 16:26:59 +0200 (CEST)
X-Originating-IP: 65.158.186.241
Received: from x (unknown [65.158.186.241])
        (Authenticated sender: josh@joshtriplett.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 02DCC41C080;
        Sun, 21 Aug 2016 16:26:56 +0200 (CEST)
Date:   Sun, 21 Aug 2016 07:26:54 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Extending "extended SHA1" syntax to traverse through gitlinks?
Message-ID: <20160821142634.dorgzldjvc3qiaby@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bad3d13-3257-2077-a734-f985c375b8d3@gmail.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 21, 2016 at 03:46:36PM +0200, Jakub Narębski wrote:
> W dniu 21.08.2016 o 00:50, Josh Triplett pisze:
> > Currently, if you have a branch "somebranch" that contains a gitlink
> > "somecommit", you can write "somebranch:somecommit" to refer to the
> > commit, just like a tree or blob.  ("man git-rev-parse" defines this
> > syntax in the "SPECIFYING REVISIONS" section.)  You can use this
> > anywhere you can use a committish, including "git show
> > somebranch:somecommit", "git log somebranch:somecommit..anotherbranch",
> > or even "git format-patch -1 somebranch:somecommit".
> > 
> > However, you cannot traverse *through* the gitlink to look at files
> > inside its own tree, or to look at other commits relative to that
> > commit.  For instance, "somebranch:somecommit:somefile" and
> > "somebranch:somecommit~3" do not work.
> 
> Note that there is the same problem traversing through trees:
> while 'git cat-file -p HEAD:subdir/file' works, the 'HEAD:subdir:file'
> doesn't:
> 
>   $ git cat-file -p HEAD:subdir:file
>   fatal: Not a valid object name HEAD:subdir:file

Interesting point; if extending this syntax anyway, any treeish ought to
work, not just a committish.

> Though you can do resolve step manually
> 
>   $ git cat-file -p $(git rev-parse HEAD:subdir):file
> 
> This works.

True, but that seems quite inconvenient.

> > I'd love to have a syntax that allows traversing through the gitlink to
> > other files or commits.  Ideally, I'd suggest the syntax above, as a
> > natural extension of the existing extended syntax.
> 
> And with the above manual resolving, you can see the problem with
> implementing it: the git-cat-file (in submodule) and git-rev-parse
> (in supermodule) are across repository boundary.

Only if the gitlink points to a commit that doesn't exist in the same
repository.  A gitlink can point to a commit you already have.

> Also the problem with proposed syntax is that is not very visible.
> But perhaps it is all right.  Maybe :/ as separator would be better,
> or using parentheses or braces?

It seems as visible as the standard commit:path syntax; the second colon
seems just as visible as the first.  :/ already has a different meaning
(text search), so that would introduce inconsistency.

> > (That syntax would potentially introduce ambiguity if you had a file
> > named "somecommit:somefile" or "somecommit~3".  That doesn't seem like a
> > problem, though; the existing syntax already doesn't support accessing a
> > file named "x..y" or "x...y", so scripts already can't expect to access
> > arbitrary filenames with that syntax without some kind of quoting, which
> > we also don't have.)
> 
> Errr... what?
> 
>   $ echo A..B >A..B
>   $ git add A..B
>   $ git commit -m 'A..B added'
>   [master 2d69af9] A..B added
>    1 file changed, 1 insertion(+), 1 deletion(-)
>    create mode 100644 A..B
>   $ git show HEAD:A..B
>   A..B

I stand corrected; I didn't find that.  I thought rev parsing worked
independently from the repository, and didn't have any automagic
detection based on the contents of the repository?

This seems ambiguous, and (AFAICT) not documented.  If HEAD:A and B both
refer to a commit, in addition to the blob A..B, which will HEAD:A..B
refer to?  I did test the HEAD:gitlink..anotherbranch case, and it does
parse as a range.
