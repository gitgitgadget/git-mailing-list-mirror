From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add--interactive: never skip files included in
 index
Date: Mon, 12 Oct 2009 01:11:57 -0400
Message-ID: <20091012051157.GA23007@coredump.intra.peff.net>
References: <1255189906-16049-1-git-send-email-pav@iki.fi>
 <7viqelwyp1.fsf@alter.siamese.dyndns.org>
 <20091011191440.GA2532@coredump.intra.peff.net>
 <7vpr8tr2pe.fsf@alter.siamese.dyndns.org>
 <20091012014007.GA7674@coredump.intra.peff.net>
 <7v63alpbwx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pauli Virtanen <pav@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 07:14:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxDF0-0004fB-Be
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 07:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbZJLFMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 01:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbZJLFMe
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 01:12:34 -0400
Received: from peff.net ([208.65.91.99]:58850 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196AbZJLFMd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 01:12:33 -0400
Received: (qmail 1175 invoked by uid 107); 12 Oct 2009 05:15:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 12 Oct 2009 01:15:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Oct 2009 01:11:57 -0400
Content-Disposition: inline
In-Reply-To: <7v63alpbwx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129976>

On Sun, Oct 11, 2009 at 07:46:06PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So now I am doubly confused. Did this feature exist, and was broken, and
> > you actually fixed it in 63d285c, creating what looked like a regression
> > but was actually intentional?
> 
> I do not think it was an intentional change.  I _think_ the comment at the
> beginning of show_files() tells us quite a bit---we don't do read-dir when
> showing the indexed files, and I suspect that we used to rely on the fact
> that not doing the read-dir made exclusion mechanism a no-op.  After the
> lazy .gitignore reading, I suspect that excluded() call started to
> initialize the exclude mechanism lazily, and that is how the bug was
> introduced, isn't it?

I did a bit more looking, and the situation is a bit more complex than
that. Hopefully the commit message below explains it.

-- >8 --
Subject: [PATCH] ls-files: excludes should not impact tracked files

In all parts of git, .gitignore and other exclude files
impact only how we treat untracked files; they should have
no effect on files listed in the index.

This behavior was originally implemented very early on in
9ff768e, but only for --exclude-from. Later, commit 63d285c
accidentally caused us to trigger the behavior for
--exclude-per-directory.

This patch totally ignores excludes for files found in the
index. This means we are reversing the original intent of
9ff768e, while at the same time fixing the accidental
behavior of 63d285c. This is a good thing, though, as the
way that 9ff768e behaved does not really make sense with the
way exclusions are used in modern git.

Signed-off-by: Jeff King <peff@peff.net>
---
One other option would be to retain the --exclude-from behavior but
eliminate the --exclude-per-directory behavior. I don't think this is
very easy, though, as it involves separating out which excludes came
from which file. And I think expecting excludes to impact the list of
index files is crazy, anyway, since no other part of git does so. But we
should recognize that we are changing existing behavior; I consider it a
bug fix, though.

I also still think that Pauli's patch makes sense; there is no point in
passing --exclude-standard there. It should be a no-op.

 builtin-ls-files.c          |    8 --------
 t/t3003-ls-files-exclude.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 8 deletions(-)
 create mode 100755 t/t3003-ls-files-exclude.sh

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 2c95ca6..c5c0407 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -170,10 +170,6 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 	if (show_cached | show_stage) {
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
-			int dtype = ce_to_dtype(ce);
-			if (excluded(dir, ce->name, &dtype) !=
-					!!(dir->flags & DIR_SHOW_IGNORED))
-				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
@@ -186,10 +182,6 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 			struct cache_entry *ce = active_cache[i];
 			struct stat st;
 			int err;
-			int dtype = ce_to_dtype(ce);
-			if (excluded(dir, ce->name, &dtype) !=
-					!!(dir->flags & DIR_SHOW_IGNORED))
-				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
 			err = lstat(ce->name, &st);
diff --git a/t/t3003-ls-files-exclude.sh b/t/t3003-ls-files-exclude.sh
new file mode 100755
index 0000000..fc1e379
--- /dev/null
+++ b/t/t3003-ls-files-exclude.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='ls-files --exclude does not affect index files'
+. ./test-lib.sh
+
+test_expect_success 'create repo with file' '
+	echo content >file &&
+	git add file &&
+	git commit -m file &&
+	echo modification >file
+'
+
+check_output() {
+test_expect_success "ls-files output contains file ($1)" "
+	echo '$2' >expect &&
+	git ls-files --exclude-standard --$1 >output &&
+	test_cmp expect output
+"
+}
+
+check_all_output() {
+	check_output 'cached' 'file'
+	check_output 'modified' 'file'
+}
+
+check_all_output
+test_expect_success 'add file to gitignore' '
+	echo file >.gitignore
+'
+check_all_output
+
+test_done
-- 
1.6.5.rc3.240.g77692
