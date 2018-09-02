Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBAE21F404
	for <e@80x24.org>; Sun,  2 Sep 2018 05:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeIBJWe (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 05:22:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:36496 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725993AbeIBJWe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 05:22:34 -0400
Received: (qmail 6664 invoked by uid 109); 2 Sep 2018 05:08:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 02 Sep 2018 05:08:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16413 invoked by uid 111); 2 Sep 2018 05:08:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 02 Sep 2018 01:08:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Sep 2018 01:08:03 -0400
Date:   Sun, 2 Sep 2018 01:08:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: Re: [BUG] index corruption with git commit -p
Message-ID: <20180902050803.GA21324@sigill.intra.peff.net>
References: <20180901214157.hxlqmbz3fds7hsdl@ltop.local>
 <87tvn8c166.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvn8c166.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 02, 2018 at 12:17:53AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Here are the steps to reproduce it:
> >   $ git clone git://github.com/lucvoo/sparse-dev.git <somedir>
> >   $ cd <somedir>
> >   $ git co index-corruption
> >   $ git rm -r validation/ Documentation/
> >   $ git commit -m <some message> -p
> >   $ git status
> > error: index uses $?+? extension, which we do not understand
> > fatal: index file corrupt
> >
> > The 'extension' pattern '$?+?', can vary a bit, sometimes
> > it's just '????', but always seems 4 chars.
> > If the commit command doesn't use the '-p' flag, there is no
> > problem. The repository itself is not corrupted, it's only
> > the index. It happends with git 2.18.0 and 2.17.0
> 
> Yeah this is a bug, I didn't dig much but testing with this script down
> to 2.8.0:
> [...]
> I found that the first bad commit was: 680ee550d7 ("commit: skip
> discarding the index if there is no pre-commit hook", 2017-08-14)

I think it's much older than that. I set up my test repo like this:

  git clone git://github.com/lucvoo/sparse-dev.git
  cd sparse-dev
  git checkout --detach

and then bisected with this script:

  cd /path/to/sparse-dev
  rm .git/index
  git reset --hard index-corruption &&
  git rm -q -r validation/ Documentation/ &&
  git commit -qm foo -p &&
  git status

Since a33fc72fe9 (read-cache: force_verify_index_checksum, 2017-04-14),
that produces the corrupt extension error. But before that, I
consistently get:

  error: bad index file sha1 signature
  fatal: index file corrupt

from git-commit. And that bisects back to 9c4d6c0297 (cache-tree: Write
updated cache-tree after commit, 2014-07-13).

If I revert that commit (which takes some untangling, see below), then
the problem seems to go away. Here's the patch I tried on top of the
current master, though I think it is actually the first hunk that is
making the difference.

---
diff --git a/builtin/commit.c b/builtin/commit.c
index 0d9828e29e..779c5e2cb5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -359,13 +359,6 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 
 		discard_cache();
 		read_cache_from(get_lock_file_path(&index_lock));
-		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
-			if (reopen_lock_file(&index_lock) < 0)
-				die(_("unable to write index file"));
-			if (write_locked_index(&the_index, &index_lock, 0))
-				die(_("unable to update temporary index"));
-		} else
-			warning(_("Failed to update main cache tree"));
 
 		commit_style = COMMIT_NORMAL;
 		ret = get_lock_file_path(&index_lock);
@@ -408,9 +401,6 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	if (!only && !pathspec.nr) {
 		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 		refresh_cache_or_die(refresh_flags);
-		if (active_cache_changed
-		    || !cache_tree_fully_valid(active_cache_tree))
-			update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write new_index file"));
@@ -457,7 +447,6 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
-	update_main_cache_tree(WRITE_TREE_SILENT);
 	if (write_locked_index(&the_index, &index_lock, 0))
 		die(_("unable to write new_index file"));
 

-Peff
