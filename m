Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5D21F6C1
	for <e@80x24.org>; Tue, 23 Aug 2016 06:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756741AbcHWG4b (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 02:56:31 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59394 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbcHWGy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 02:54:56 -0400
Received: from mfilter13-d.gandi.net (mfilter13-d.gandi.net [217.70.178.141])
        by relay2-d.mail.gandi.net (Postfix) with ESMTP id 95BF7C5A4F;
        Tue, 23 Aug 2016 08:54:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter13-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
        by mfilter13-d.gandi.net (mfilter13-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id mCVjBGOybygy; Tue, 23 Aug 2016 08:54:02 +0200 (CEST)
X-Originating-IP: 207.236.147.202
Received: from x (unknown [207.236.147.202])
        (Authenticated sender: josh@joshtriplett.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 32B44C5A4E;
        Tue, 23 Aug 2016 08:54:00 +0200 (CEST)
Date:   Tue, 23 Aug 2016 02:53:59 -0400
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Extending "extended SHA1" syntax to traverse through gitlinks?
Message-ID: <20160823065359.34cirqig56fugnwy@x>
References: <9bad3d13-3257-2077-a734-f985c375b8d3@gmail.com>
 <20160821142634.dorgzldjvc3qiaby@x>
 <ab6e29c1-ea6d-c1c5-e69f-867c16cc736a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab6e29c1-ea6d-c1c5-e69f-867c16cc736a@gmail.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2016 at 08:39:19PM +0200, Jakub Narębski wrote:
> W dniu 21.08.2016 o 16:26, Josh Triplett pisze:
> > On Sun, Aug 21, 2016 at 03:46:36PM +0200, Jakub Narębski wrote:
> >> W dniu 21.08.2016 o 00:50, Josh Triplett pisze:
> >>> Currently, if you have a branch "somebranch" that contains a gitlink
> >>> "somecommit", you can write "somebranch:somecommit" to refer to the
> >>> commit, just like a tree or blob.  ("man git-rev-parse" defines this
> >>> syntax in the "SPECIFYING REVISIONS" section.)  You can use this
> >>> anywhere you can use a committish, including "git show
> >>> somebranch:somecommit", "git log somebranch:somecommit..anotherbranch",
> >>> or even "git format-patch -1 somebranch:somecommit".
> >>>
> >>> However, you cannot traverse *through* the gitlink to look at files
> >>> inside its own tree, or to look at other commits relative to that
> >>> commit.  For instance, "somebranch:somecommit:somefile" and
> >>> "somebranch:somecommit~3" do not work.
> >>
> >> Note that there is the same problem traversing through trees:
> >> while 'git cat-file -p HEAD:subdir/file' works, the 'HEAD:subdir:file'
> >> doesn't:
> >>
> >>   $ git cat-file -p HEAD:subdir:file
> >>   fatal: Not a valid object name HEAD:subdir:file
> > 
> > Interesting point; if extending this syntax anyway, any treeish ought to
> > work, not just a committish.
> 
> Actually, because you can use simply "HEAD:subdir/file" I'd rather
> it didn't work (no two ways of access), unless we can get it for free.

Agreed.  I suspect we'd get it for free if we introduced a syntax for
traversing through commits (by allowing that syntax to work with any
treeish), but if not, I certainly don't see any value in adding a second
syntax for accessing tree contents.

> >>> I'd love to have a syntax that allows traversing through the gitlink to
> >>> other files or commits.  Ideally, I'd suggest the syntax above, as a
> >>> natural extension of the existing extended syntax.
> >>
> >> And with the above manual resolving, you can see the problem with
> >> implementing it: the git-cat-file (in submodule) and git-rev-parse
> >> (in supermodule) are across repository boundary.
> > 
> > Only if the gitlink points to a commit that doesn't exist in the same
> > repository.  A gitlink can point to a commit you already have.
> 
> The idea of submodules is that tree object in superproject includes
> link to commit of subproject (so called gitlink).  Tree object is
> in superproject repository, while gitlinked commit is in submodule
> repository.
> 
> True, with modern Git the submodule repository is embedded in .git
> area of superproject, with '.git' in submodule being gitling file,
> but by design those objects are in different repositories, in different
> object databases.

git-submodule handles them that way by default, yes.  But a gitlink
doesn't inherently have to point to a separate repository, and even a
submodule could point to an object available in the same repository
(perhaps via another ref).

git-series creates such gitlinks, for instance.

> >> Also the problem with proposed syntax is that is not very visible.
> >> But perhaps it is all right.  Maybe :/ as separator would be better,
> >> or using parentheses or braces?
> > 
> > It seems as visible as the standard commit:path syntax; the second colon
> > seems just as visible as the first.  :/ already has a different meaning
> > (text search), so that would introduce inconsistency.
> 
> Actually ":/" has a special meaning only if it is at beginning:

True, but it seems inconsistent to have :/ mean search if at the
beginning, or traversal if not.

> But perhaps '//' would be better.

That does seem unambiguous, and it can't conflict with an existing file.
Does it seem reasonable to allow that for the initial commit as well
('committish//file', as well as 'commit//gitlink//file')?

Also, while that handles traversal into the tree contained in the
gitlinked commit, what about navigating by commit (using '~' and '^',
for instance)?  Does it seem reasonable to allow those as well, perhaps
only if you use // to reach the gitlink?  For instance,
'commit//gitlink~3', or 'commit//gitlink^{tree}'?
