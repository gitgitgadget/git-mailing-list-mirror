X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Handling of branches in stgit
Date: Thu, 30 Nov 2006 01:00:38 +0100
Message-ID: <20061130000038.GA13324@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 00:01:24 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32681>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpZMY-0005o1-OT for gcvg-git@gmane.org; Thu, 30 Nov
 2006 01:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967678AbWK3ABM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 19:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936117AbWK3ABM
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 19:01:12 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:54712 "EHLO
 smtp5-g19.free.fr") by vger.kernel.org with ESMTP id S936113AbWK3ABK (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 19:01:10 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp5-g19.free.fr (Postfix) with ESMTP id D725627728;
 Thu, 30 Nov 2006 01:01:06 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id A47792010;
 Thu, 30 Nov 2006 01:00:38 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

I have started to work on recording parent information for stgit
branches, so we don't need to give the same info on every "git pull".

I'm facing a problem, in that we have several kind of stgit branches:

* those created against a cogito branch (eg. by "cg clone" and "stg
  init").  They work pretty much intuitively (and it happens I mostly
  used this flavour before those tests).  All we need is the name of
  the local branch, and "stg pull <branch>" relies on "git fetch" to
  find the repository information in .git/branches/<branch>.

  In this case, it is easy to request pulling from any branch, but
  usually only one of them is what you want, and the results of using
  another one (or forgetting to specify the one you want) can be
  annoying [ISSUE 1].  Hence this work of mine: being able to store
  this info in .git/patches/<stack>/parent (my initial implementation)
  was sufficient in theory.

  But "stg pull" allows for a refspec argument.  Since the branch
  mapping is already defined in a file, and I canno think of any
  useful way to override it, maybe we could make sure noone uses it in
  such a case ?

  
* but those created against a local branch are typically different,
  and updated by "stg pull . <branch>".  In that case, we have to
  specify the repository (".") explicitely, in addition to the branch,
  and the way to use the use them is different.


* and it gets better with those branches created against a git remote
  branch (eg. by "stg clone" or "stg branch -c" against an existing
  remote branch), typically updated via "stg pull <remote>", where the
  repo information is extracted by "git fetch" from
  .git/remotes/<remote>.  That is, we do not specify a branch or a
  repository URL, but an alias that may cover several branches from
  another repo.

  Here the branch information from the remotes file appears not to be
  used at all (in fact all branches are fetched - not sure that it's
  always what we want, but I'll wait to find myself limited by this
  behaviour before complaining ;)

  Also, "stgit pull <remote>" using "git pull" by default, it is the
  1st branch listed in the remotes file that gets taken as parent
  [ISSUE 2].  We should probably instead run "git fetch <remote>" and
  then then "git pull . <branch>", but that surely requires some
  changes to the "stg pull" internals.

  Thus (modulo that issue), we need 2 infos: "remote" and branch.
  Storing the latter should help to solve issue 2.

  Note: whereas "stg pull origin", while pulling a "foo" branch, cannot
  know current "foo2" branch should be rebased to "foo", (after renaming
  remotes/origin to foo) "stg pull foo", not only fetches "origin" as
  expected, but also (seemingly correctly but hell how does it know
  [ISSUE 3]) rebases current "master" to "origin" - is "master"
  special in any way here ?  I did not find anything about this in the
  source, although I found a handful of occurences of "master" in
  commands/branch.py, which seem to imply "master" is so special it
  cannot be deleted, which would look like abuse to me [ISSUE 4].


Now what do we do next ?

We could implement an ad-hoc solution acknowledging there are 3
different ways to work with a branch, keeping the current "stg pull"
syntaxes (they are already a pain for users IMHO) and storing
paremeters as ad-hoc values, or we could try to rework the "stg pull"
command line.

Some of my ideas for the latter include:

- store a "parent branch" with the name of the parent branch in the
local repository

- store a "parent repository" (ie. "." for local branches, "AUTO" for
cogito branches, and <remote> for git branches)

- rejecting non-default arguments and adding new options to allow to
specify/store alternative values

- we'll need to make sure there are no remote branches of one type
shadowed by one of the other type with same name, and do some sanity
checks that specified branch in a given remote really exists.


How does that sound ?
-- 
