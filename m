From: Jeff King <peff@peff.net>
Subject: Re: textconv not invoked when viewing merge commit
Date: Thu, 14 Apr 2011 15:09:01 -0400
Message-ID: <20110414190901.GA1184@sigill.intra.peff.net>
References: <201104111912.47547.kumbayo84@arcor.de>
 <4DA415AB.9020008@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:09:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QARuo-00026v-Ly
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 21:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933415Ab1DNTJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 15:09:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57687
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932485Ab1DNTJF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 15:09:05 -0400
Received: (qmail 2061 invoked by uid 107); 14 Apr 2011 19:09:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 15:09:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 15:09:01 -0400
Content-Disposition: inline
In-Reply-To: <4DA415AB.9020008@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171534>

On Tue, Apr 12, 2011 at 11:04:43AM +0200, Michael J Gruber wrote:

> > This works fine, except for merge commits.
> > For merge commits i see the diff of the binary contents of the file.
> > 
> > Is this intentional?
> > git help gitattributes mentions no such limitation.
> > Anywhere else(gitk(on non merge commit), git gui blame) i see the the filtered textual representation of the file.
> > 
> > I tried 1.7.4 msysgit and current master
> > 
> > Greetings Peter
> 
> textconv is applied for "diff -m" but not for combined diffs (-c, --cc)
> at the moment. They go through a completely different codepath, so it is
> expected code-wise (not a bug per se) but not ui-wise.
> 
> Looking at the code and trying to dig something up atm...

Ick. I started with this test:

diff --git a/t/t4046-diff-textconv-merge.sh b/t/t4046-diff-textconv-merge.sh
new file mode 100755
index 0000000..8643330
--- /dev/null
+++ b/t/t4046-diff-textconv-merge.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description='combined diff uses textconv'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit one file &&
+	test_commit two file &&
+	git checkout -b other HEAD^ &&
+	test_commit three file &&
+	test_must_fail git merge master &&
+	echo resolved >file &&
+	git commit -a &&
+	echo "file diff=upcase" >.gitattributes &&
+	git config diff.upcase.textconv "tr a-z A-Z <"
+'
+
+cat >expect <<'EOF'
+Merge branch 'master' into other
+
+diff --combined file
+index 2bdf67a,f719efd..2ab19ae
+--- a/file
++++ b/file
+@@@ -1,1 -1,1 +1,1 @@@
+- THREE
+ -TWO
+++RESOLVED
+EOF
+test_expect_success 'diff -c uses textconv' '
+	git show --format=%s -c >actual &&
+	test_cmp expect actual
+'
+
+test_done

but after looking at the codepath, it is must worse than just textconv.
Try this:

  git init repo &&
  cd repo &&
  openssl rand 64 >file.bin &&
  git add file.bin &&
  git commit -m one &&
  openssl rand 64 >file.bin &&
  git commit -a -m two &&
  git checkout -b other HEAD^
  openssl rand 64 >file.bin &&
  git commit -a -m three &&
  (git merge master || true) &&
  openssl rand 64 >file.bin &&
  git commit -a -m resolved &&
  git show

We just dump the binary goo all over the terminal. So I think the whole
combined-diff code path needs to learn how to handle binaries properly.

Unfortunately, it seems to be totally distinct from the regular diff
code path. It doesn't even use diff_filespecs, so our usual is_binary
and textconv code won't work. So the best way forward may involve
significant refactoring.

And of course we have to figure out sane semantics. The textconv case is
easy; just use the textconv blobs instead of the regular ones. But what
should the true binary case (as in the rand example above) show?

-Peff
