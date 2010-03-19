From: Thomas Rast <trast@student.ethz.ch>
Subject: [BUG] merge-recursive call in git-am -3 chokes, autocrlf issue?
Date: Fri, 19 Mar 2010 01:49:02 +0100
Message-ID: <201003190149.03025.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <scottg.wp-hackers@mhg2.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 01:49:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsQP8-00079h-PR
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 01:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab0CSAt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 20:49:28 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:30001 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251Ab0CSAt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 20:49:28 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 19 Mar
 2010 01:49:24 +0100
Received: from thomas.localnet (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 19 Mar
 2010 01:49:05 +0100
User-Agent: KMail/1.13.1 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.1; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142548>

Hi everyone,

I helped Scott R. "WebDragon" Godin on IRC[1] with a bug internal to
git-rebase.  It manifests like this:

  $ git rebase --stat develop
  First, rewinding head to replay your work on top of it...
   .gitmeta                                           |    2 +-
   Products/index.php                                 |    1 +
   index.php                                          |   11 -----
   res/includes/featured/featured-TEMPLATE.php        |    6 +-
   res/includes/featured/featured-aerotube.php        |    2 +-
   res/includes/featured/featured-beltfeederclock.php |    2 +-
   res/includes/featured/featured-fiberglasstanks.php |    2 +-
   res/includes/featured/featured-handypolaris2.php   |    2 +-
   res/includes/featured/featured-hydrotech.php       |    2 +-
   .../featured/featured-uv_sterilization.php         |    2 +-
   res/includes/inc_meta.php                          |    1 +
   res/includes/inc_nav.php                           |   42 ++++++++++++++++---
   res/java/featurebox.js                             |    2 +-
   13 files changed, 48 insertions(+), 29 deletions(-)
  Applying: Begin restyling/content work on new footer
  Using index info to reconstruct a base tree...
  Falling back to patching base and 3-way merge...
  error: Your local changes to 'res/css/stylehome.css' would be overwritten by merge.  Aborting.
  Please, commit your changes or stash them before you can merge.
  Failed to merge in the changes.
  [...]

I don't know much about the merging machinery, but I figured I could
help him poke around, so here's what we gathered:

* He uses 1.7.0.1 on Fedora [2]

* The repo is fairly ordinary except for[3]: setgitperms.perl contrib
  hooks, core.autocrlf = true

* Editing git-am to use git-merge-resolve instead fixes the issue.

* With GIT_MERGE_VERBOSITY=5 it says [I don't think there's anything
  useful in there, but who knows]:

    $ git rebase develop
    First, rewinding head to replay your work on top of it...
    Applying: Begin restyling/content work on new footer
    Using index info to reconstruct a base tree...
    Falling back to patching base and 3-way merge...
    Merging HEAD with Begin restyling/content work on new footer
    Merging:
    9e2793f remove innerbox sizing js, as no longer necessary: matching bg color obviates need for equal sized boxes
    virtual Begin restyling/content work on new footer
    found 1 common ancestor(s):
    virtual cef31479147bd3ba2922c3506ec1c70ee5b22729
    error: Your local changes to 'res/css/stylehome.css' would be overwritten by merge.  Aborting.
    Please, commit your changes or stash them before you can merge.
    fatal: merging of trees fe2928d5311cfcf5e668b13cd85608589928f848 and b2ad8208510f713acf1be1c9e62856c51175c6d0 failed
    Failed to merge in the changes.

* Immediately before the git-merge-{recursive,resolve} call, the
  following outputs may be relevant:

-- 8< -- git diff-files --patch-with-raw
:100644 100644 c1ff94058b86004de4dc1693b6dcd2fccfb28d52 0000000000000000000000000000000000000000 M     res/css/stylehome.css
:100644 100644 b653183cc466262996c319ce21fbc29d1164b942 0000000000000000000000000000000000000000 M res/includes/inc_footerhome.php
:100644 100644 29182f14b8e54525649685cdfe718a9a4204ab0e 0000000000000000000000000000000000000000 M       res/includes/inc_meta.php
:100644 100644 5910568e733b631d3e3cc73b74ee89a71e4140a2 0000000000000000000000000000000000000000 M     res/includes/inc_validate.php
 
diff --git a/res/css/stylehome.css b/res/css/stylehome.css
diff --git a/res/includes/inc_footerhome.php b/res/includes/inc_footerhome.php
diff --git a/res/includes/inc_meta.php b/res/includes/inc_meta.php
diff --git a/res/includes/inc_validate.php b/res/includes/inc_validate.php
-- >8 --

-- 8< -- git diff-index --patch-with-raw HEAD
:100644 100644 c1ff94058b86004de4dc1693b6dcd2fccfb28d52 0000000000000000000000000000000000000000 M    res/css/stylehome.css
:100644 100644 b653183cc466262996c319ce21fbc29d1164b942 0000000000000000000000000000000000000000 M res/includes/inc_footerhome.php
:100644 100644 29182f14b8e54525649685cdfe718a9a4204ab0e 0000000000000000000000000000000000000000 M       res/includes/inc_meta.php
:100644 100644 5910568e733b631d3e3cc73b74ee89a71e4140a2 0000000000000000000000000000000000000000 M     res/includes/inc_validate.php
 
diff --git a/res/css/stylehome.css b/res/css/stylehome.css
diff --git a/res/includes/inc_footerhome.php b/res/includes/inc_footerhome.php
diff --git a/res/includes/inc_meta.php b/res/includes/inc_meta.php
diff --git a/res/includes/inc_validate.php b/res/includes/inc_validate.php
-- >8 --

Not sure if it's relevant, but the differences shown here and in the
diffstat for the rebased patch above both list
'res/includes/inc_meta.php'.

[I only just noticed that we probably should have used diff-index
--cached for the second snippet; I hope that this doesn't make the
data worthless...]

We tried the differences between $base_tree and {$his_tree,HEAD} too,
but they were too large to be practical.


Since there is some difference between files and index, but neither
the modes nor the contents actually show any, my best guess is that
it's autocrlf's fault.  Then again, who knows.

I did try a theory, but it worked well[4] so that's not it:

  * base has a file foo
  * side..master recodes foo to crlf and changes bar
  * master..side changes bar differently to trigger the 3-way logic
  Then rebase side on master.

In code:

  git init foo
  cd foo
  seq 1 20 > foo
  git add foo
  git commit -m initial
  seq 100 120 > bar
  git add bar
  git commit -m bar
  seq 1 20 | sed 's/$/\r/' > foo
  git add foo
  git commit -m crlf
  sed -i 's/101/a/;s/102/b/;s/103/c/' bar
  git add bar
  git commit -m 'change bar'
  git checkout -b side HEAD~2
  sed -i 's/105/d/;s/106/e/;s/107/f/' bar
  git add bar
  git commit -m 'change bar differently'
  git config core.autocrlf true
  git rebase master


[1] http://colabti.org/irclogger/irclogger_log/git?date=2010-03-18#l3682
[2] http://colabti.org/irclogger/irclogger_log/git?date=2010-03-18#l3818
[3] http://colabti.org/irclogger/irclogger_log/git?date=2010-03-18#l3898
[4] modulo the slight problem that I can't get rid of the false dirty
    state of foo after that, but if I understood autocrlf right that's
    expected?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
