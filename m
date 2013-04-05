From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] t3600: test rm of path with changed leading symlinks
Date: Thu, 4 Apr 2013 20:00:09 -0400
Message-ID: <20130405000009.GA27775@sigill.intra.peff.net>
References: <20130404190211.GA15912@sigill.intra.peff.net>
 <20130404190621.GA7484@sigill.intra.peff.net>
 <7v6202hykh.fsf@alter.siamese.dyndns.org>
 <20130404195554.GA20823@sigill.intra.peff.net>
 <7v1uaqhwb4.fsf@alter.siamese.dyndns.org>
 <20130404210304.GA25811@sigill.intra.peff.net>
 <7vhajlgabi.fsf@alter.siamese.dyndns.org>
 <20130404232903.GA27128@sigill.intra.peff.net>
 <7vd2u9g9bg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 02:00:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNu5I-0003ik-TP
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 02:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765613Ab3DEAAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 20:00:16 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56545 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765426Ab3DEAAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 20:00:16 -0400
Received: (qmail 8493 invoked by uid 107); 5 Apr 2013 00:02:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 20:02:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 20:00:09 -0400
Content-Disposition: inline
In-Reply-To: <7vd2u9g9bg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220127>

On Thu, Apr 04, 2013 at 04:33:39PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So let's drop patch 3. Do we want instead to have an expect_failure
> > documenting the correct behavior?
> 
> I think that is very much preferred.

Here's a replacement for patch 3, then. I wasn't sure if the
editorializing in the last 2 paragraphs should go in the commit message
or the cover letter; feel free to tweak as you see fit.

-- >8 --
Subject: [PATCH] t3600: document failure of rm across symbolic links

If we have a symlink "d" that points to a directory, we
should not be able to remove "d/f". In the normal case,
where "d/f" does not exist in the index, we already disallow
this, as we only remove things that git knows about in the
index. So for something like:

  ln -s /outside/repo foo
  git add foo
  git rm foo/bar

we will properly produce an error (as there is no index
entry for foo/bar). However, if there is an index entry for
the path (e.g., because the movement is due to working tree
changes that have not yet been reflected in the index), we
will happily delete it, even though the path we delete from the
filesystem is not the same as the path in the index.

This patch documents that failure with a test.

While this is a bug, it should not be possible to cause
serious data loss with it. For any path that does not have
an index entry, we will complain and bail. For a path which
does have an index entry, we will do the usual up-to-date
content check. So even if the deleted path in the filesystem
is not the same as the one we are removing from the index,
we do know that they at least have the same content, and
that the content is included in HEAD.

That means the worst case is not the accidental loss of
content, but rather confusion by the user when a copy of a
file another part of the tree is removed. Which makes this
bug a minor and hard-to-trigger annoyance rather than a
data-loss bug (and hence the fix can be saved for a rainy
day when somebody feels like working on it).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3600-rm.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index a2e1a03..0c44e9f 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -659,4 +659,32 @@ test_expect_success 'rm of file when it has become a directory' '
 	test_path_is_file d/f
 '
 
+test_expect_success SYMLINKS 'rm across a symlinked leading path (no index)' '
+	rm -rf d e &&
+	mkdir e &&
+	echo content >e/f &&
+	ln -s e d &&
+	git add -A e d &&
+	git commit -m "symlink d to e, e/f exists" &&
+	test_must_fail git rm d/f &&
+	git rev-parse --verify :d &&
+	git rev-parse --verify :e/f &&
+	test -h d &&
+	test_path_is_file e/f
+'
+
+test_expect_failure SYMLINKS 'rm across a symlinked leading path (w/ index)' '
+	rm -rf d e &&
+	mkdir d &&
+	echo content >d/f &&
+	git add -A e d &&
+	git commit -m "d/f exists" &&
+	mv d e &&
+	ln -s e d &&
+	test_must_fail git rm d/f &&
+	git rev-parse --verify :d/f &&
+	test -h d &&
+	test_path_is_file e/f
+'
+
 test_done
-- 
1.8.2.rc0.33.gd915649
