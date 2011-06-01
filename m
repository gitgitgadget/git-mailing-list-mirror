From: Jeff King <peff@peff.net>
Subject: Re: git clone (ssh://) skips detached HEAD
Date: Wed, 1 Jun 2011 18:47:54 -0400
Message-ID: <20110601224754.GA16820@sigill.intra.peff.net>
References: <BANLkTi=xK+hmvGTLnKREScABU=7v_SKqPQ@mail.gmail.com>
 <20110601220518.GA32681@sigill.intra.peff.net>
 <7vipspfazy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:48:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRuCo-0002Bb-Vg
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 00:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757508Ab1FAWr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 18:47:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53950
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233Ab1FAWr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 18:47:57 -0400
Received: (qmail 18789 invoked by uid 107); 1 Jun 2011 22:48:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jun 2011 18:48:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2011 18:47:54 -0400
Content-Disposition: inline
In-Reply-To: <7vipspfazy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174914>

On Wed, Jun 01, 2011 at 03:22:09PM -0700, Junio C Hamano wrote:

> > We basically have two choices:
> >
> >   1. Fetch objects for HEAD on clone.
> >
> >   2. Don't checkout a detached HEAD if we don't have the object (or
> >      possibly, don't checkout a detached HEAD at all; we already do
> >      something similar for the case of a HEAD that points to a bogus
> >      branch).
> >
> > I think (2) is more consistent with the refspec we set up, but (1) is
> > probably more convenient to users (and better matches the case where the
> > remote is on a detached HEAD that _does_ point to something we have).
> 
> Probably. As HEAD is usually visible via ls-remote exchange, the usual
> security concern would not come into the picture even if we do (1), even
> though it feels somewhat wrong to do.

Yeah, one can always just do:

  git fetch origin HEAD && git checkout FETCH_HEAD

immediately afterwards. But I think given that we make some effort to
propagate detached-ness across a clone in cases where we can, we should
just do the fetch.

I wrote some tests that document what I think _should_ happen. In
addition to this bug, there's one other (the second in my list below).

I'm done for the day, but may take a look at actually fixing these
tomorrow.

-- >8 --
Subject: [PATCH] t: add tests for cloning remotes with detached HEAD

We didn't test this setup at all, and doing so reveals a few
bugs:

  1. Cloning a repository with an orphaned detached HEAD
     (i.e., one that points to history that is not
     referenced by any ref) will fail.

  2. Cloning a repository with a detached HEAD that points
     to a tag will cause us to write a bogus "refs/tags/..."
     ref into the HEAD symbolic ref. We should probably
     detach instead.

  3. Cloning a repository with a detached HEAD that points
     to a branch will cause us to checkout that branch. This
     is a known limitation of the git protocol (we have to
     guess at HEAD's destination, since the symref contents
     aren't shown to us). This test serves to document the
     desired behavior, which can only be achieved once the
     git protocol learns to share symref information.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5707-clone-detached.sh |   76 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100755 t/t5707-clone-detached.sh

diff --git a/t/t5707-clone-detached.sh b/t/t5707-clone-detached.sh
new file mode 100755
index 0000000..fca8609
--- /dev/null
+++ b/t/t5707-clone-detached.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+
+test_description='test cloning a repository with detached HEAD'
+. ./test-lib.sh
+
+head_is_detached() {
+	git --git-dir=$1/.git rev-parse --verify HEAD &&
+	test_must_fail git --git-dir=$1/.git symbolic-ref HEAD
+}
+
+test_expect_success 'setup' '
+	echo one >file &&
+	git add file &&
+	git commit -m one &&
+	echo two >file &&
+	git commit -a -m two &&
+	git tag two &&
+	echo three >file &&
+	git commit -a -m three
+'
+
+test_expect_success 'clone repo (detached HEAD points to branch)' '
+	git checkout --detach master &&
+	git clone "file://$PWD" detached-branch
+'
+test_expect_success 'cloned HEAD matches' '
+	echo three >expect &&
+	git --git-dir=detached-branch/.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+test_expect_failure 'cloned HEAD is detached' '
+	head_is_detached detached-branch
+'
+
+test_expect_success 'clone repo (detached HEAD points to tag)' '
+	git checkout --detach two &&
+	git clone "file://$PWD" detached-tag
+'
+test_expect_success 'cloned HEAD matches' '
+	echo two >expect &&
+	git --git-dir=detached-tag/.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+test_expect_failure 'cloned HEAD is detached' '
+	head_is_detached detached-tag
+'
+
+test_expect_success 'clone repo (detached HEAD points to history)' '
+	git checkout --detach two^ &&
+	git clone "file://$PWD" detached-history
+'
+test_expect_success 'cloned HEAD matches' '
+	echo one >expect &&
+	git --git-dir=detached-history/.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+test_expect_success 'cloned HEAD is detached' '
+	head_is_detached detached-history
+'
+
+test_expect_failure 'clone repo (orphan detached HEAD)' '
+	git checkout --detach master &&
+	echo four >file &&
+	git commit -a -m four &&
+	git clone "file://$PWD" detached-orphan
+'
+test_expect_failure 'cloned HEAD matches' '
+	echo four >expect &&
+	git --git-dir=detached-orphan/.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+test_expect_failure 'cloned HEAD is detached' '
+	head_is_detached detached-orphan
+'
+
+test_done
-- 
1.7.4.4.23.g5df3c
