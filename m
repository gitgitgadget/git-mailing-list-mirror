From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: gitifyhg vs. git-remote-hg
Date: Wed, 10 Apr 2013 21:49:53 -0500
Message-ID: <516624d13a6ea_66fcc5de1023665@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: gitifyhg@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 04:56:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ7gm-0000bR-Dd
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 04:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937077Ab3DKC4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 22:56:36 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:35432 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936130Ab3DKC4f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 22:56:35 -0400
Received: by mail-qc0-f175.google.com with SMTP id j3so503919qcs.6
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 19:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=HVMb1Lq6DQaCOO22jU3k23i2WTbf5qjPYmZWVhHqSVQ=;
        b=S/vJ1ZczKXgfRnIuttm+CD5hepwItMWCY9b0IHa+zTwBio+jNvhOktyu6SCxJe2hSK
         Obopf0FdHl3c/akS81YgBvKCFNLDHX6yZG3KkvoZM2DRM22KHdPDNDTT0UtnGQD1PmPp
         H2wmP692oYDtawOVop8bffZFh4dP7IQrfK+OuHkF66LQCCoWsRFaShXX9DSqp2pPgnnE
         JZAq+JwWokwuQ5pw7JxLQi76qDBfUrimYKVQnkFBbP7HEOq3s1xIKkehJSzeboWYMv+H
         qgSn+FcBnn0LFUeKX0Qz4U+dClWfy2pEgCs2oxwRHJSaQtonvK4T/o9VBinEA8dEh9dB
         NuDQ==
X-Received: by 10.229.58.65 with SMTP id f1mr1776933qch.134.1365648994305;
        Wed, 10 Apr 2013 19:56:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id c2sm4222101qeg.6.2013.04.10.19.56.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 19:56:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220807>

Hi,

In a recent e-mail[1] it was suggested that gitifyhg and git-remote-hg had many
differences, and that some users might be best served by using gitifyhg. While
that e-mail was answered properly, I would like to point out what are the
actual differences that affect users, not the ones that are particular to the
state of the code this week, but rather the ones that are inherent due to the
design and/or development process.

First of all, it's worth mentioning that much of the code of gitifyhg was
simply copied from git-remote-hg. One example is the get_filechanges() function
which was introduced in v6 of the initial patch series[2], after extensive
profiling. The gitifyhg developers simply copied the function without
mentioning where it came from. And like this one, there are numerous examples.

== Code changes ==

In terms of design, they are vastly similar (not surprising since gitifyhg is
based on remote-hg), however remote-hg tries to have a minimal code-base, 
avoid hacks, and tries to minimize and isolate changes to avoid regressions -- as
is typical for git.git code --, whereas gitifyhg tries to introduce features as
soon as possible, and fix the possible issues later on.

A succint example is the introduction of a custom function to write tags:

https://github.com/buchuki/gitifyhg/commit/9a89296

Then the inevitable fixes come (some after a major version was released):

https://github.com/buchuki/gitifyhg/commit/8cd638b
https://github.com/buchuki/gitifyhg/commit/1ce980a
https://github.com/buchuki/gitifyhg/commit/885dd84

Contrast with the single commit in remote-hg, which is simpler, cleaner, passes
the same tests, and still, it's not merged, nor on the queue (it's on the
'next' branch):

https://github.com/felipec/git/commit/b565809

== Development practices ==

Each patch of remote-hg is reviewed in the git.git mailing list before being
merged to the mainline, the stages are: fc/remote/hg-next -> fc/master
(patch review) -> pu -> next -> master. On the other hand, gitifyhg doesn't
have patch review through a mailing list[4], nor different development branches;
everything is committed to 'master'.


Features are important for users, but more important than features is that what
used to work continues to work, and in the same way, and remote-hg's practices
help to achieve that.

== Testing ==

It's impossible to test all Mercurial repositories, or even a significant chunk
of them, which is why it's a good idea to rely on the testing and gathered
tricks of other conversion projects. By far the most widely used tool is
hg-git, which already has a decent test cases, it makes sense then to use these
tests cases and make sure that the output of a conversion tool matches the one
of hg-git, and that's exactly what remote-hg does.

gitifyhg has continuous testing, but it's more important to have the right tests.

== Features ==

All the features of gitifyhg have been implemented in remote-hg, with the
exception of push rollback. However, this feature is not needed if only certain
commits are pushed; this way there's no need to rollback the previous commits
that failed; they would be simply ignored for the next push.

Here are the commits that implement them:

Notes:
https://github.com/felipec/git/commit/e7234dc

Noteids (SHA-1):
https://github.com/felipec/git/commit/663704d

Changing alias:
https://github.com/felipec/git/commit/316c330

The first two will be merged, but the last one won't; we can choose either the
alias or the URL as a unique identifier, and choosing the alias makes more
sense.

This means as a user, there's no reason to use gitifyhg, since the same
features are available in remote-hg. And as a developer, one can simply pick
these missing patches (one?) and maintain a friendly fork.

To make sure that remote-hg can indeed act like gitifyhg for all intents and
purposes I created a branch to do so:

https://github.com/felipec/git/tree/fc/remote/hg-gitifyhg-compat

The changes are minimal:

  contrib/remote-helpers/git-remote-hg | 57 ++++++++++++++++++++++++++++++++++-----------------------
   1 file changed, 34 insertions(+), 23 deletions(-)

After these patches, gitifyhg's test suite passes **all** the tests (except a
trivial one).

== Minor differences ==

What follows are some tedious comparisons between both test suites, and an
explanation about the difference.


= remote-hg =

== cloning with branches ==

  -next
  -refs/heads/next
  +zero
  +refs/heads/master

remote-hg closes the current branch (next), gitifyhg doesn't.

== cloning with bookmarks ==

  -feature-a
  -refs/heads/feature-a
  +zero
  +refs/heads/master

remote-hg closes the current bookmark (feature-a), gitifyhg doesn't.

== authors ==

   H G Wells <wells@example.com>
  -test <unknown>
  -test <test@example.com>
  +test <>
  +test <test@example.com (comment)>
   Unknown <test@example.com>
   name <test@example.com>
   name <test@example.com>
  -test <unknown>
  +test <>
   test <test@example.com>
   test <test@example.com>
  -test <unknown>
  +test <test at example dot com>
   Unknown <test@example.com>

remote-hg uses <unknown> when there's no e-mail, gitifyhg <>. Also, remote-hg
removes garbage after the email, gitifyhg doesn't <test@example.com (comment)>.

== strip ==

  Cloning into 'gitrepo'...
  1 files updated, 0 files merged, 0 files removed, 0 files unresolved
  saved backup bundle to /home/felipec/dev/git/t/trash directory.test-hg/tmp/hgrepo/.hg/strip-backup/06c5e5718f17-backup.hg
  WARNING: "Branch 'default' has more than one head, consider merging"
  WARNING: "Branch 'default' has more than one head, consider merging"
  warning: Not updating refs/hg/origin/bookmarks/master (new tip 7a424409fcae0c8855f3d887bf1c2c376c00f09c does not contain 796e103bcc0968ae99db18e7e612a7fb1fbb81cf)
  fatal: Error while running fast-import			

Funny how the gitifyhg people claimed SHA-1 ids were necessary, yet when the
revision ids of Mercurial change, gitifyhg fails.

= remote-hg bidi =

== git tags ==

  -@  changeset:   3:4c73577597f09b1bbd90399e85ac81bd0658e9f2
  +@  changeset:   3:5a84c01d4d40e697a879c54f6b12e516d24bbfc7
   |  tag:         tip
   |  parent:      2:9f22c99d619819e20669949f318491eb47741d5f
   |  parent:      -1:0000000000000000000000000000000000000000
   |  manifest:    3:56f3afad7f2dafcb324b2b3a2741e5750d3c9820
  -|  user:        felipec@nysa
  +|  user:        Unknown <felipec@nysa>
   |  date:        Thu Apr 11 00:57:42 2013 +0000
   |  files:       .hgtags
   |  extra:       branch=default

gitifyhg doesn't restore the original author properly.

== hg branch ==

  alpha: No such file or directory
  abort: no files to copy

Probably some issues checking out and restoring the original branch/bookmark.

== hg tags ==

  abort: not at a branch head (use -f to force)

Ditto.

= remote-hg hg-git =

All these tests fail, so it's impossible to compare to the well known hg-git.

= gitifyhg =

== test_author_no_email ==

  no email supplied <>
  no email supplied <unknown>

Trivial e-mail difference (silenced with [5]).

== test_author_abuse_quotes ==

  totally <bad  quote can be used in hg>
  totally <unknown>

Irrelevant e-mail difference.

== test_clone_relative ==

  IOError: [Errno 21] Is a directory: path(u'XXX/git_dir/hg_base/.')

remote-hg doesn't create a local clone when it's not needed
(silenced with [10]).

== test_clone_linear_branch ==
== test_clone_branch_with_spaces ==
== test_clone_bookmark ==
== test_clone_bookmark_with_spaces ==
== test_clone_divergent_bookmarks ==
== test_clone_bookmark_not_at_tip ==

All these fail because gitifyhg always checks out the 'default' branch, and
ignores the 'master' ref (silenced with [7][8]).

== test_clone_close_branch ==

Ditto. Plus gitifyhg shows closed branches (silenced with [9]).

== test_pull_rename_remote ==

remote-hg allows changing the URL without recloning, gitifyhg allows changing
the alias (silenced with [12]).

== test_simple_push_updates_notes_after_contentful_pull ==
== test_simple_push_updates_remote ==

gitifyhg always checks out 'master' (silenced by [7]).

== test_push_conflict_default ==
== test_push_conflict_default_double ==
== test_push_conflict_default_double_non_english ==
== test_push_conflict_named_branch ==

gitifyhg barfs when pushing a new head to a branch (the fix [11] might be
merged to remote-hg). Also, these tests need a proxy clone (silenced with
[10]).

== test_push_to_bookmark ==
== test_push_to_bookmark_with_spaces ==
== test_push_up_to_date ==

gitifyhg always checks out 'master' (silenced with [7]).

== test_push_tag_with_previous_commits ==
== test_push_only_new_tag ==

gitifyhg doesn't allow repeated tags (Mercurial does)(silenced with [6]).

[1] http://article.gmane.org/gmane.comp.version-control.git/219893
[2] http://article.gmane.org/gmane.comp.version-control.git/208990
[3] https://github.com/buchuki/gitifyhg/commit/a46d518e2b8df5e8339c8caa9fa113642bc7ac3a
[4] https://groups.google.com/forum/?fromgroups=#!forum/gitifyhg
[5] https://github.com/felipec/git/commit/77d12ea
[6] https://github.com/felipec/git/commit/415da9e
[7] https://github.com/felipec/git/commit/4c0f7e2
[8] https://github.com/felipec/git/commit/2fdca59
[9] https://github.com/felipec/git/commit/8dfcee1
[10] https://github.com/felipec/git/commit/4d023e5
[11] https://github.com/felipec/git/commit/006b090
[12] https://github.com/felipec/git/commit/316c330
[13] https://github.com/felipec/git/commit/9545d66

-- 
Felipe Contreras
