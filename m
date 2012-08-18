From: "James R. McKaskill" <james@foobar.co.nz>
Subject: [RFC 0/2] svn-fetch|push - an alternate approach
Date: Sat, 18 Aug 2012 13:39:14 -0400
Message-ID: <1345311556-70767-1-git-send-email-james@foobar.co.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 18 19:39:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2n08-0003tR-92
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 19:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab2HRRju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 13:39:50 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35793 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848Ab2HRRjj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 13:39:39 -0400
Received: by yenl14 with SMTP id l14so4624844yen.19
        for <git@vger.kernel.org>; Sat, 18 Aug 2012 10:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=6wAXY871vgwfvult6lvahsy4kpkVvbDgYdZjpQVQCHc=;
        b=pNVFBukKHLbMwp5b79xeFLXLwmLj2WmKsTY9g5O3u871gEHEuCBG5A2enN2BMRvVwl
         bYSXMIM+uini8k3dKKylxlQ/W+Ek9ED545OCaLcJoQ/SjDlLsKn1keOaoZReWFPgwufn
         QlxkNOlbQMhzrlHUiXwva/w0/oJaZdHNhk206tOIJ6JzBN8RfwKjqH11gzzRlozgJ21g
         0vDuf46EjyjDXL452WQkpfb4o0+FOJoFMJsWsmUqa7gix+FBnobxKorlm54cn8uC1ovK
         LrrB/P1kcvkhfQ3d10E2q+mkeEynOUitUxx9yzL2389tT1jDXCdXs+/T8/zSwYSzXRMB
         34yw==
Received: by 10.50.160.130 with SMTP id xk2mr5272543igb.66.1345311576187;
        Sat, 18 Aug 2012 10:39:36 -0700 (PDT)
Received: from aeir.local.net ([155.63.0.254])
        by mx.google.com with ESMTPS id gy9sm8037271igc.1.2012.08.18.10.39.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Aug 2012 10:39:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
X-Gm-Message-State: ALoCoQnsYBMdQHI1xij0hlb4jxdB2feYNg17mthzUt41DjeCfKe8vMAtbI6lmrUseqjSeH5QwZb2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203685>

This is sort of an RFC/ANN. There has been a whole bunch of traffic of
late on git-svn, vcs-svn, the remote helper, etc. I would like to
present an alternate solution that I've been playing with for a couple
of weeks.

I work in a team that uses a mixture of git-svn and svn proper. Whilst
it works remarkably well and I largely don't have to deal with svn on a
day to day basis, git-svn is still quite limiting compared to git
proper. Namely any merges created by myself or another either can't be
pushed into svn or information is lost when done so. Switching wholesale
to git is problematic due to the disruption this causes. There are also
numerous non-core users who want a really simple update and occasionally
checkin a single file/folder UI. Tortoise SVN fits their needs perfectly
and even with a proper git-svn bridge in place I have no plan on
dropping svn support.

Possible Solutions
------------------

In general there are a couple of ways of attacking this:

1. Have git-svn push extraneous git context into subversion and pull it
   back down on the other side.
2. Create a dummy svn server ala git-cvsserver
3. Use both a git server and svn server and have the git server push to
   the svn server.
4. Same as #3 but have the svn server push to the git server.

#1 is frought with issues due to how exacting git is wrt to recreating
commits. The recreated commits would have to have the same hash to be
able to use git's distributed nature.

#2 is possible but a lot of work. SVN clients expect a substantial
amount of metadata. This introduces considerable complexity of where to
store the metadata and what metadata to generate on the fly. Not all can
be generated on the fly as SVN presents a general purpose key value
store to clients, which many use and expect to work.

#3 and #4 have divergence issues in that you have two servers through
which commits can be pushed. If conflicting commits are pushed into both
servers at the same time, there has to be some method for conflict
resolution. Requiring that an admin go in and fix things manually is
unpalatable. The easiest way around this is to delegate one of the two
servers as the master and require that commits pushed to the other
update the master before suceeding. In this mode #3 has the SVN server
as master, and #4 has the git server.

There is an existing commercial system that came up a couple of weeks
ago that transfers commits asynchronously. I am unsure of how this
avoids conflicts if at all.

I've been working on a solution using approach #3. The code follows
(hopefully) and is currently running an internal beta with 3 or 4 users
using it and works very well.

In my setup, the SVN server is the master node. The git server has a
pre-receive hook which pushes commits onto the SVN server. The hook
checks for any SVN errors (SVN hooks, file conflicts, etc), and that no
SVN commits are intermingled with the pushed git commits (either before
or interspersed). If this fails at all, the pre-receive hook fails,
which fails the git push. The git user then pulls or rebases and tries
to push again.

Kerberos Auth (Off-Topic)
-------------------------

I am also using a kerberos auth http frontend
(http://github.com/jmckaskill/krb-httpd). This checks authentication
against active directory and uses the remote user for the --user
argument of git svn-push. Most clients are windows users. In this case I
have built a replacement version of libcurl-4.dll which enables kerberos
negotiate (as an aside the msysgit build should enable this by default).
I've then added the following to users' global git config:

credential.http://domain.name.username=dummy
credential.http://domain.name.helper=!echo password=dummy

With this in place, git uses the user's domain login and never asks for
a password. There is also some equivalent tweaks to get domain logins
working in browsers for cgit.

How it Works
------------

The attached patch adds two commands to git: svn-fetch and svn-push. The
names are temporary. My plan is to refactor these into git-remote-svn so
that git push/pull/fetch work as expected. svn-fetch fetches svn commits
for all branches and creates git commits, branches, tags, etc as it goes
along. svn-push takes the remote ref name, from and to sha1 (or a list
of these on stdin for use as a pre-receive hook) and pushes the changes
to svn, creating/deleting branches/tags as neccessary and failing if
there are any intermingled svn commits in the pushed to folders.

Metadata is tracked by creating an extra git commit for each svn commit
in each branch/tag that is stored in refs/svn/heads|tags as well as
refs/svn/latest for the latest fetched commit. These commits look
like the following:

tree <svn tree>
parent <underlying git commit>
parent <previous svn commit for this svn folder>
author <svn author + time>
committer <svn author + time>
revision <svn revision>
path <svn path relative to svn.url>

Using commits to track the SVN metadata has proven really really handy.
The code gets to use all the built-in locking primitives, packing, etc.
git push --mirror nicely mirrors all of the metadata as well as the
git commits. As an anecdote I had a bug the other day where my
check_for_svn_commits wasn't working and so had missed a svn commit.
After fixing the bug, I needed to rerun the fetch to grab the missing
commit. This was a simple matter of: ran git log --pretty=raw
refs/svn/heads/trunk to get the svn/git commit sha1s, updated the refs,
and reran git svn-fetch.

As a twist the code does not use the svn library, but rather talks the
svn protocol directly. I actually found it much easier to go this route
then trying to bend everything to how the svn library understands
things. It also has the advantage of not depending on libsvn. A number
of distributions currently distribute the svn specific parts of git
seperately to avoid this dependency.

Trees
-----

For each commit I track the svn and git trees seperately. The svn tree
tracks exactly what SVN returns byte for byte. This is required so that
fetched SVN diffs can be processed correctly. I can then have slight
tweaks between the two trees. Currently I have three differences between
the two trees.

If svn.eol is set then eol conversion is done between the two trees
(controlled by info/attributes). This way all of my imported git trees
have unix line endings, whilst the svn trees have a mixture. In my case
they should be windows line endings, but some third party libraries we
imported as unix line endings. Files updated in git are renormalized to
the eol given as svn.eol.

The second tweak is that changes to .git* pushed from the git side are
not pushed through to svn. This way git users can manage .gitattributes
and .gitignore without pushing these through to svn.

The third change is that svn-fetch creates a .gitempty file in any
empty directory on the svn side. This forces git to create the directory
and gives the git user a clean way of removing the directory.

Branches
--------

Branch names in SVN are a bit more leniant then ref names in git. For
example SVN allows spaces whilst git does not. Thus svn-fetch converts
all disallowed characters to '_'. The svn commit stores the original
branch name so it can be pushed back to. svn-fetch does not currently
handle conflicts where two different SVN branches collide with a single
git name.

When updating a branch svn-push tries to find a path from the previous
commit to the target. When another branch has been merged into the svn
branch, then the pushed commits look very similar to the svn equivalent.
Namely just the merge commit with a large diff. In the case that pushed
commits branch and merge back together, then svn-push simply tries to
find any path that gets it from the previous commit to the target. For
new branches it creates an svn copy from the newest svn commit that is a
ancestor of the target. In the case a forced push it will do an svn
replace with the newest ancestor in svn. The code for this is in
find_copy_source and if (!has_parent) check in do_push.

Tags
----

Tags are pushed to SVN as SVN tags (ie folder copies). Both annonated
and simple tags can be used. For annontated tags, the messages is used
for the commit message. For simple tags a hard-coded commit message of
Create <tag folder relative to svn.url> is used. svn-fetch creates
annotated tags for tags created/updated in SVN. If a tag is updated in
SVN, svn-fetch will create a git commit for the change, a new annotated
tag and overwrite the existing tag. Standard SVN practise is not to
commit to tag folders, but it does occasionally happen. This is thus
treated in the same way as the need in git to occasionally overwrite a
tag.

SVN Auth
--------

The current authentication is temporary. Currently I'm using a git-svn
style authors file hard-coded to <git-dir>/svn-authors. svn-push then
requires the user be of the form user:pass. As you push commits it will
then switch to that user by killing the connection and reopening. There
are also a couple of operations which require an svn user but don't have
a git commit to look the email up from. For these both svn-fetch and
svn-push require a --user argument. These operations are: all of
svn-fetch and get-latest-rev, log, and deleting branch/tags for
svn-push.

Pipelining
----------

svn-fetch has a -c option which lets you increase the number of
connections used to download commits. The svn protocol is annoying in
that it doesn't let you pipeline requests. svnserve will let you send
some content out of order, but once you overflow its rx buffer it will
kill the connection. So instead svn-fetch opens n+1 connections, sends
the requests ahead of time and then cycle back round to process the
reply. When initially importing one of my work projects setting this to
15 increased the fetch speed by a factor of 10.

Tests
-----

I've also added some tests for svn-fetch, svn-push. These currently
require svn 1.7 or newer. svn 1.6 doesn't understand branch
replacement and I haven't gotten around to disabling those tests.

Config
------

svn-fetch and svn-push use a number of config items:

- svn.trunk - path under svn.url of the trunk branch

- svn.branches - path under svn.url of the branches folder, branches are
    then folders inside this folder

- svn.tags - path under svn.url of the tags folders, tags are then
    folders inside this folder

- svn.user - default svn user for fetch, push without a git commit

- svn.remote - remote name to use for fetch tags/branches

- svn.trunkref - name to use for the git trunk ref (defaults to master)

- svn.eol - eol to convert to for files pushed to svn

Most of these are temporary.

TODO
----

There is a whole bunch more work to be done. My big ticket items are:

- svn over HTTP support. I've had an initial look into this and looks
    fairly straight forward. svn over HTTP is largely the same svn
commands converted to XML. Is there any recomendation on what XML
library to use or should I write my own limited version?

- fixing up auth to use credentials

- refactor svn-fetch svn-push into git-remote-svn

- adding a cfg item for the authors file and using svn-user@repo UUID if
    none is provided like git-svn

- documentation - for the moment the documentation is this email

- svn:externals - none of the repos have to deal with have this and I'm
    not sure yet how to deal with it

- style cleanup

Code
----

The code is also available at https://github.com/jmckaskill/git, which I
will keep uptodate as I flush out the todo list.
