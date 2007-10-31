From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Possible bug: git-svn leaves broken tree in case of error
Date: Wed, 31 Oct 2007 01:42:57 -0700
Message-ID: <20071031084257.GA2911@mayonaise>
References: <1193729426.30755.32.camel@asl.dorms.spbu.ru> <20071031075524.GB7798@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anton Korobeynikov <asl@math.spbu.ru>
X-From: git-owner@vger.kernel.org Wed Oct 31 09:43:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In9Au-0004ib-HW
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 09:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbXJaInC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 04:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753303AbXJaInC
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 04:43:02 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44640 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbXJaInA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 04:43:00 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 54B897DC0FE;
	Wed, 31 Oct 2007 01:42:58 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 31 Oct 2007 01:42:58 -0700
Content-Disposition: inline
In-Reply-To: <20071031075524.GB7798@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Eric Wong <normalperson@yhbt.net> wrote:
> Anton Korobeynikov <asl@math.spbu.ru> wrote:
> > Hello, Everyone.
> > 
> > I noticed this bug several times. Consider the following conditions are
> > met:
> > - We're syncing from svn using git-svn :)
> > - We have authors file provided
> > - We have a changeset with author unlisted in the authors file.
> > 
> > git-svn dies due to the following code:
> > sub check_author {
> >         my ($author) = @_;
> >         if (!defined $author || length $author == 0) {
> >                 $author = '(no author)';
> >         }
> >         if (defined $::_authors && ! defined $::users{$author}) {
> >                 die "Author: $author not defined in $::_authors file\n";
> >         }
> >         $author;
> > }
> > 
> > Unfortunately it leaves repository in some middle state: git-svn itself
> > thinks, that it synced with everything, but git itself doesn't "see" any
> > changesets anymore. I found no way to repair tree after such situation,
> > so I had to repull from scratch.
> > 
> > I found myself, that this should be warning (and fix in this case is
> > trivial), not error (maybe some commandline switch to control behaviour,
> > etc). It can be even error, but breaking tree is definitely bug in this
> > case.
> 
> You should be able to change the numbers in *-maxRev back to
> an old revision in .git/svn/.metadata.  Does that fix things for you
> so you can resume synching again?
> 
> I'll have to investigate the die()-ing of check_authors since
> that should cause git-svn to quit before the maxRev numbers
> get incremented.

With the following test case, I'm not able to reproduce what you're
describing.

But yes, die-ing here and not being able to gracefully recover is a
nasty bug...

Warning instead of die-ing here is not a good option, because it can
lead to inconsistent author data inside populating history.  I believe
it's better to error out immediately so the user can fix their authors
file.

diff --git a/t/t9117-git-svn-authors-file.sh b/t/t9117-git-svn-authors-file.sh
new file mode 100755
index 0000000..4566307
--- /dev/null
+++ b/t/t9117-git-svn-authors-file.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Eric Wong
+#
+
+test_description='git-svn authors file tests'
+
+. ./lib-git-svn.sh
+
+cat > svn-authors <<EOF
+aa = AAAAAAA AAAAAAA <aa@example.com>
+bb = BBBBBBB BBBBBBB <bb@example.com>
+EOF
+
+test_expect_success 'setup svnrepo' "
+	svn mkdir -m aa --username aa $svnrepo/aa &&
+	svn mkdir -m bb --username bb $svnrepo/bb &&
+	svn mkdir -m cc --username cc $svnrepo/cc &&
+	svn mkdir -m dd --username dd $svnrepo/dd
+	"
+
+test_expect_failure 'start import with incomplete authors file' "
+	git-svn clone --authors-file=svn-authors $svnrepo x
+	"
+
+test_expect_success 'imported 2 revisions successfully' "
+	cd x &&
+		test \`git rev-list refs/remotes/git-svn | wc -l\` -eq 2 &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
+		  grep '^author BBBBBBB BBBBBBB <bb@example\.com> ' &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 | \
+		  grep '^author AAAAAAA AAAAAAA <aa@example\.com> ' &&
+		cd ..
+	"
+
+cat >> svn-authors <<EOF
+cc = CCCCCCC CCCCCCC <cc@example.com>
+dd = DDDDDDD DDDDDDD <dd@example.com>
+EOF
+
+test_expect_success 'continues to import once authors have been added' "
+	cd x &&
+		git-svn fetch --authors-file=../svn-authors &&
+		test \`git rev-list refs/remotes/git-svn | wc -l\` -eq 4 &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
+		  grep '^author DDDDDDD DDDDDDD <dd@example\.com> ' &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 | \
+		  grep '^author CCCCCCC CCCCCCC <cc@example\.com> ' &&
+		cd ..
+	"
+
+test_expect_success 'authors-file against globs' "
+	svn mkdir -m globs --username aa \
+	  $svnrepo/aa/trunk $svnrepo/aa/branches $svnrepo/aa/tags &&
+	git-svn clone --authors-file=svn-authors -s $svnrepo/aa aa-work &&
+	svn mkdir -m aa/branches/bb --username bb $svnrepo/aa/branches/bb &&
+	svn mkdir -m aa/branches/ee --username ee $svnrepo/aa/branches/ee &&
+	svn mkdir -m aa/branches/cc --username cc $svnrepo/aa/branches/cc
+	"
+
+test_expect_failure 'fetch fails on ee' "
+	cd aa-work &&
+		git-svn fetch --authors-file=../svn-authors
+	"
+
+tmp_config_get () {
+	GIT_CONFIG=.git/svn/.metadata git config --get "$1"
+}
+
+test_expect_success 'failure happened without negative side effects' "
+	test 6 -eq \"\`tmp_config_get svn-remote.svn.branches-maxRev\`\" &&
+	test 6 -eq \"\`tmp_config_get svn-remote.svn.tags-maxRev\`\"
+	"
+
+cat >> ../svn-authors <<EOF
+ee = EEEEEEE EEEEEEE <ee@example.com>
+EOF
+
+test_expect_success 'fetch continues after authors-file is fixed' "
+	git-svn fetch --authors-file=../svn-authors &&
+	test 8 -eq \"\`tmp_config_get svn-remote.svn.branches-maxRev\`\" &&
+	test 8 -eq \"\`tmp_config_get svn-remote.svn.tags-maxRev\`\"
+	"
+
+test_done

-- 
Eric Wong
