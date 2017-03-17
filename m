Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A7C20951
	for <e@80x24.org>; Fri, 17 Mar 2017 14:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbdCQOPb (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 10:15:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:45910 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751185AbdCQOOc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 10:14:32 -0400
Received: (qmail 824 invoked by uid 109); 17 Mar 2017 14:14:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 14:14:20 +0000
Received: (qmail 3231 invoked by uid 111); 17 Mar 2017 14:14:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 10:14:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 10:14:17 -0400
Date:   Fri, 17 Mar 2017 10:14:17 -0400
From:   Jeff King <peff@peff.net>
To:     Okash Khawaja <okash.khawaja@gmail.com>
Cc:     stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
Subject: Re: Viewing untracked+stashed files in git stash show
Message-ID: <20170317141417.g2oenl67k74nlqrq@sigill.intra.peff.net>
References: <CAOtcWM3mrQEqDnjMipzea7Kp+VueBFsZDL2zcJ=y0wgj9N4Vjw@mail.gmail.com>
 <295db01e-6252-6acc-88d8-d2f366397ea0@atlas-elektronik.com>
 <CAOtcWM1jExsj_L4HRm194F57bt9LPuf8fFSpyuGWiPG7U_4v8A@mail.gmail.com>
 <20170317135144.scnbtyug2cqbg77p@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170317135144.scnbtyug2cqbg77p@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 09:51:44AM -0400, Jeff King wrote:

> > Okay that's fine as long as you know. But the first thing that comes
> > to your mind is that you've lost those untracked files. Is there a
> > reason why git stash show doesn't show those files?
> 
> No, I don't think there is a good reason. The "untracked" option was
> added to git-stash much later, and nobody considered how it interacted
> with "stash show".
> 
> Changes from the index have the same problem. Probably "stash show"
> should have options "--index" and "--untracked" to show:
> 
>   # index
>   git diff $stash^1 $stash^2
> 
>   # untracked
>   git diff $stash^1 $stash^3
> 
> Possibly it should even show those by default when they are non-empty.

Actually, $stash^1 is already the parent of the other commits, so we can
just show them as-is. Doing this:

diff --git a/git-stash.sh b/git-stash.sh
index 9c70662cc..868d9027b 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -388,7 +388,16 @@ show_stash () {
 		fi
 	fi
 
-	git diff ${FLAGS} $b_commit $w_commit
+	{
+		# use --pretty=format instead of tformat, because it omits the
+		# blank line between the subject and the diff; use "."
+		# to enable history simplification and drop empty commits.
+		git show --first-parent -m --pretty=format:'==> %s <==' \
+			${FLAGS} $w_commit -- .
+		git show --pretty=format:'%n==> %s <==' ${FLAGS} $i_commit -- .
+		test -n "$u_commit" &&
+			git show --pretty=format:'%n==> %s <==' ${FLAGS} $u_commit -- .
+	} | git_pager
 }
 
 show_help () {
actually looks OK to me, though I don't know if people really like the
existing format. With a setup like:

  git init
  echo base >file
  git add file
  git commit -m base
  echo index >file
  git add file
  echo working tree >file
  echo untracked >other
  git stash -u

it looks like:

  $ git stash show
  ==> WIP on master: 8aa1ec9 base <==
   file | 2 +-
   1 file changed, 1 insertion(+), 1 deletion(-)
  
  ==> index on master: 8aa1ec9 base <==
   file | 2 +-
   1 file changed, 1 insertion(+), 1 deletion(-)
  
  ==> untracked files on master: 8aa1ec9 base <==
   other | 1 +
   1 file changed, 1 insertion(+)

or:

  $ git stash show -p
  ==> WIP on master: 8aa1ec9 base <==
  diff --git a/file b/file
  index df967b9..ace4bb6 100644
  --- a/file
  +++ b/file
  @@ -1 +1 @@
  -base
  +working tree
  
  ==> index on master: 8aa1ec9 base <==
  diff --git a/file b/file
  index df967b9..9015a7a 100644
  --- a/file
  +++ b/file
  @@ -1 +1 @@
  -base
  +index
  
  ==> untracked files on master: 8aa1ec9 base <==
  diff --git a/other b/other
  new file mode 100644
  index 0000000..5a72eb2
  --- /dev/null
  +++ b/other
  @@ -0,0 +1 @@
  +untracked

And if you have only a single change, it omits the others:

  $ echo working tree >file
  $ git stash
  $ git stash show
  ==> WIP on master: 8aa1ec9 base <==
   file | 2 +-
   1 file changed, 1 insertion(+), 1 deletion(-)


If I were designing "stash show" from scratch today, I'd probably do
something like that. But like I said, I don't know if people are
invested in the current output (which _can_ be piped to "git apply" if
need be, though my output could, too, if you do not have index or
untracked files).

-Peff
