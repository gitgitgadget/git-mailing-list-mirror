Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA8AC33C9B
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 10:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556742073A
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 10:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgAHKkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:40:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:60144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727145AbgAHKkK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 05:40:10 -0500
Received: (qmail 21284 invoked by uid 109); 8 Jan 2020 10:40:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Jan 2020 10:40:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8695 invoked by uid 111); 8 Jan 2020 10:45:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jan 2020 05:45:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jan 2020 05:40:08 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten Krah <krah.tm@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Broken branch after git commit - tracked files in staging area
 can't be removed with restore --staged, or commit or stash
Message-ID: <20200108104008.GA2207365@coredump.intra.peff.net>
References: <07c84224bb0b093ab3770be9b5ab2ec23ce2d31a.camel@gmail.com>
 <234df85965f8a685be5e563fe795ed477f359d7c.camel@gmail.com>
 <f0638fc0d09c213b661d2b244d3457f362daebe0.camel@gmail.com>
 <20200108091119.GB87523@coredump.intra.peff.net>
 <2423f8c0b91578c0faf7527b7d97b0e1e9666261.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2423f8c0b91578c0faf7527b7d97b0e1e9666261.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 08, 2020 at 11:02:41AM +0100, Torsten Krah wrote:

> Hi Jeff, I have a poc you can try:

Thanks, I can see the problem now.

> cd /tmp
> mkdir testrepo
> cd testrepo
> touch TEST1 TEST2
> git add -A
> git commit -m First
> touch TEST3 TEST4
> git add -A
> git commit -m Second
> git reset --soft HEAD~1

OK, so we'd expect to still see TEST3 and TEST4 in the index. And we do:

> git status
> 
>    Auf Branch master
>    Zum Commit vorgemerkte Änderungen:
>      (benutzen Sie "git restore --staged <Datei>..." zum Entfernen aus
>    der Staging-Area)
>    	neue Datei:     TEST3
>    	neue Datei:     TEST4

And then if we try to unstage one of them, we should see that:

> git restore --staged TEST3
> 
>    [10:57:26][tkrah@torstenknbl:/tmp/testrepo]  (master) $ LC_ALL=C git
>    status
>    On branch master
>    Changes to be committed:
>      (use "git restore --staged <file>..." to unstage)
>    	new file:   TEST4
> 
>    Untracked files:
>      (use "git add <file>..." to include in what will be committed)
>    	TEST3

So far so good. But I think there is a lurking problem in the index,
because...

> git commit -m Second
> 
>    [master 5b62331] Second
>     2 files changed, 0 insertions(+), 0
>    deletions(-)
>     create mode 100644 TEST3
>     create mode 100644 TEST4

This is very wrong (and is a bug, not a problem with what you're doing).
We wrote a commit with TEST3 in it, even though it wasn't in the index.
Why would we do that? Almost certainly it's because of a cache-tree
extension in the index. Presumably "git restore --staged" is not
properly invalidating the cache-tree entry. And that would explain what
you see next:

> And now TEST3 is in the commit and what is even more "interesting" is
> the next one:
> 
>    [10:59:16][tkrah@torstenknbl:/tmp/testrepo]  (master) $ LC_ALL=C git
> status
>    On branch master
>    Changes to be committed:
>      (use "git restore --staged <file>..." to unstage)
>    	deleted:    TEST3
> 
>    Untracked files:
>      (use "git add <file>..." to include in what will be committed)
>    	TEST3
> 
> TEST3 is unstaged and deleted now.

That happens because we wrote out a commit with TEST3, but it's still
not in the index! So it appears as if a deletion was staged (remember
that what is "staged" is really just the diff between the index and
HEAD).

We can repeat the same process, substituting "git reset -- TEST3" for
git-restore, and it works fine. So the problem is in git-restore itself.

Here's another observation. If we do:

  git restore --staged TEST3 TEST4

then running "git commit" won't do anything, since there's nothing
staged (and this is why I had trouble reproducing the problem earlier).
If we add a new file, like:

  echo whatever >new
  git add new

then the problem won't exhibit, because that will also invalidate the
cache-tree (because it has to account for "new"). But we could put those
files in their own subdirectory and do:

  $ git restore --staged subdir/TEST3
  $ git status
  On branch master
  Changes to be committed:
  	new file:   subdir/TEST4
  
  Untracked files:
  	subdir/TEST3

and if I commit that, I see the bug again:

  $ git commit -m second
  [master 5c3b8c1] second
   2 files changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 subdir/TEST3
   create mode 100644 subdir/TEST4

Now here's even more fun. I wanted to do another test, so I tried to
reset back to the original "second" commit, but it segfaults! Yikes.

  $ git reset --hard HEAD@{2}
  Segmentation fault

Running it under valgrind shows we're indeed seeing a bogus cache-tree:

  ==2214443== Invalid read of size 4
  ==2214443==    at 0x362DFF: traverse_by_cache_tree (unpack-trees.c:734)
  ==2214443==    by 0x3630A3: traverse_trees_recursive (unpack-trees.c:799)
  ==2214443==    by 0x364209: unpack_callback (unpack-trees.c:1258)
  ==2214443==    by 0x35F925: traverse_trees (tree-walk.c:497)
  ==2214443==    by 0x364DDD: unpack_trees (unpack-trees.c:1589)
  ==2214443==    by 0x1BE6CF: reset_index (reset.c:95)
  ==2214443==    by 0x1BF894: cmd_reset (reset.c:421)
  ==2214443==    by 0x124868: run_builtin (git.c:444)
  ==2214443==    by 0x124BAE: handle_builtin (git.c:674)
  ==2214443==    by 0x124E24: run_argv (git.c:741)
  ==2214443==    by 0x1252AB: cmd_main (git.c:872)
  ==2214443==    by 0x1E811A: main (common-main.c:52)
  ==2214443==  Address 0x40 is not stack'd, malloc'd or (recently) free'd
  ==2214443== 
  ==2214443== Process terminating with default action of signal 11 (SIGSEGV)

This isn't the same spot that Emily fixed earlier today in [1], but it
seems like a very similar problem. Weird.

So instead I blew away the index and then did hard reset:

  $ rm .git/index
  $ git reset --hard
  HEAD is now at 5c3b8c1 second

And now we can see what happens if both files are unstaged, and then we
add a new file, and then commit:

  $ git reset --soft HEAD^
  $ git restore --staged subdir/TEST3 subdir/TEST4
  $ echo whatever >new
  $ git add new
  $ git commit -m again
  [master 119d9e4] again
   1 file changed, 1 insertion(+)
   create mode 100644 new

So that _doesn't_ exhibit the problem. I guess because adding the new
file causes git-add to reexamine the whole cache-tree and clean it up.

So there seem to be at least two bugs:

 - git-restore doesn't properly invalidate the cache-tree

 - the index-reading code is not careful enough about bogus cache-trees,
   and may segfault

-Peff

[1] https://lore.kernel.org/git/20200108023127.219429-1-emilyshaffer@google.com/
