From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] filter-branch: use git-sh-setup's ident parsing
 functions
Date: Thu, 18 Oct 2012 06:22:17 -0400
Message-ID: <20121018102217.GA17332@sigill.intra.peff.net>
References: <20121018072207.GA1605@sigill.intra.peff.net>
 <20121018072535.GB9999@sigill.intra.peff.net>
 <507FB470.2060404@viscovery.net>
 <20121018075429.GD9999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 12:22:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOnFL-00064W-JW
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 12:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746Ab2JRKWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 06:22:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37692 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755737Ab2JRKWU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 06:22:20 -0400
Received: (qmail 4530 invoked by uid 107); 18 Oct 2012 10:22:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 06:22:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 06:22:17 -0400
Content-Disposition: inline
In-Reply-To: <20121018075429.GD9999@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207992>

On Thu, Oct 18, 2012 at 03:54:29AM -0400, Jeff King wrote:

> On Thu, Oct 18, 2012 at 09:49:04AM +0200, Johannes Sixt wrote:
> 
> > > -			s/.*/GIT_'$uid'_NAME='\''&'\''; export GIT_'$uid'_NAME/p
> > 
> > Didn't you lose the export GIT_$uid_{NAME,EMAIL,DATE} parts somewhere on
> > the way?
> 
> Yikes, you're right. I didn't even notice, as the test suite still
> passes. I can see how the env filter would still be able to see the
> variables, but the commit-tree call wouldn't. I guess it happens to work
> because we do not test alternate idents in our filter branch tests (IOW,
> we are silently rewriting each commit during the filter-branch, but it
> happens to have the same identities).

Hrm. We _do_ test this in t7003. Weirder, if I instrument filter-branch
like this:

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 69406ae..1b504ce 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -298,8 +298,13 @@ while read commit parents; do
 	git cat-file commit "$commit" >../commit ||
 		die "Cannot read commit $commit"
 
+	echo >&2 pre: $GIT_AUTHOR_NAME
+	sh -c 'echo >&2 pre, subshell: $GIT_AUTHOR_NAME'
+
 	eval "$(set_ident <../commit)" ||
 		die "setting author/committer failed for commit $commit"
+	echo >&2 post: $GIT_AUTHOR_NAME
+	sh -c 'echo >&2 post, subshell: $GIT_AUTHOR_NAME'
 	eval "$filter_env" < /dev/null ||
 		die "env filter failed: $filter_env"
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 4d13e10..ce57fc5 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -174,6 +174,8 @@ test_expect_success 'author information is preserved' '
 	test 1 = $(git rev-list --author="B V Uips" preserved-author | wc -l)
 '
 
+test_done
+
 test_expect_success "remove a certain author's commits" '
 	echo i > i &&
 	test_tick &&

and run t7003, it shows that the variable is properly exported to the
sub-process! But I can't seem to figure out why. Confused...

-Peff
