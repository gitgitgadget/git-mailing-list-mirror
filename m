From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add--interactive: never skip files included in
 index
Date: Sun, 11 Oct 2009 21:40:07 -0400
Message-ID: <20091012014007.GA7674@coredump.intra.peff.net>
References: <1255189906-16049-1-git-send-email-pav@iki.fi>
 <7viqelwyp1.fsf@alter.siamese.dyndns.org>
 <20091011191440.GA2532@coredump.intra.peff.net>
 <7vpr8tr2pe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pauli Virtanen <pav@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 03:45:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx9ym-0008NM-Q9
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 03:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbZJLBkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 21:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbZJLBkp
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 21:40:45 -0400
Received: from peff.net ([208.65.91.99]:51686 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbZJLBkp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 21:40:45 -0400
Received: (qmail 32632 invoked by uid 107); 12 Oct 2009 01:43:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 11 Oct 2009 21:43:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Oct 2009 21:40:07 -0400
Content-Disposition: inline
In-Reply-To: <7vpr8tr2pe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129967>

On Sun, Oct 11, 2009 at 03:22:05PM -0700, Junio C Hamano wrote:

> > I don't know if it is worth fixing now or not. It does seem a bit
> > inconsistent to me (since everything else is very clear that .gitignore
> > is only about untracked files), but nobody seems to have been
> > complaining for the last two years (and they may have, in fact, been
> > coding to the new behavior).
> 
> This is one of those moments when I feel very blessed to have competent
> and diligent people around me ;-)

Well, I have to do _something_ to make up for all the brown paper bag
bugs. ;)

> I think you are right; that we shouldn't filter the output with gitignore
> entries when showing what is _in_ the index.

So being the diligent and competent soul that I am, I started to prepare
a patch for this, which is included below. But the plot thickens.

I bisected the change of behavior to 63d285c, as I mentioned. But when I
found the code that needed to be tweaked, it actually git-blames to a
much earlier date in "git show-files", which later became ls-files.  See
9ff768e.

So now I am doubly confused. Did this feature exist, and was broken, and
you actually fixed it in 63d285c, creating what looked like a regression
but was actually intentional?

And more importantly, what do you want to do with it now?

---
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
