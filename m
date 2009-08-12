From: Jeff King <peff@peff.net>
Subject: Re: fatal: bad revision 'HEAD'
Date: Tue, 11 Aug 2009 23:27:40 -0400
Message-ID: <20090812032740.GA26089@coredump.intra.peff.net>
References: <06DCECD0-45F0-4695-86D4-7C54EFE4E640@gmail.com>
 <20090810011803.GA435@coredump.intra.peff.net>
 <09EE2E57-626B-4686-A6DD-3B8DF1BC3FE2@gmail.com>
 <20090811015615.GA8383@coredump.intra.peff.net>
 <C44788EB-02BA-4D69-8091-9E97827223A0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Joel Mahoney <joelmahoney@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 05:27:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb4VF-00072Z-Ns
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 05:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755835AbZHLD1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 23:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755833AbZHLD1k
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 23:27:40 -0400
Received: from peff.net ([208.65.91.99]:52100 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755831AbZHLD1j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 23:27:39 -0400
Received: (qmail 8514 invoked by uid 107); 12 Aug 2009 03:27:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 11 Aug 2009 23:27:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Aug 2009 23:27:40 -0400
Content-Disposition: inline
In-Reply-To: <C44788EB-02BA-4D69-8091-9E97827223A0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125653>

[re-adding git@vger, since this discussion really belongs on the list]

On Tue, Aug 11, 2009 at 10:30:49AM -0600, Joel Mahoney wrote:

> here's what I get now:
> 
> trace: built-in: git 'init'
> Initialized empty Git repository in /path/to/project/vendor/plugins/
> paperclip/.git/
> trace: exec: 'git-pull' '--depth' '1' 'git://github.com/thoughtbot/
> paperclip.git'
> trace: built-in: git 'rev-parse' '--git-dir'
> trace: built-in: git 'rev-parse' '--is-inside-work-tree'
> trace: built-in: git 'rev-parse' '--show-cdup'
> trace: built-in: git 'ls-files' '-u'
> trace: built-in: git 'symbolic-ref' '-q' 'HEAD'
> trace: built-in: git 'config' '--bool' 'branch.master.rebase'
> trace: built-in: git 'update-index' '--ignore-submodules' '--refresh'
> trace: built-in: git 'diff-files' '--ignore-submodules' '--quiet'
> trace: built-in: git 'diff-index' '--ignore-submodules' '--cached'
> '--quiet' 'HEAD' '--'
> fatal: bad revision 'HEAD'
> refusing to pull with rebase: your working tree is not up-to-date

I was able to replicate your problem, but only if I set
branch.master.rebase to "true" in my user-wide git config (i.e.,
~/.gitconfig). It looks like "git pull" is not capable of handling a
rebase when you have no commits yet.

I'm slightly dubious that such a configuration is sane, but probably
"git pull" should handle this case anyway, as you can easily replicate
it without config by doing:

  git init && git pull --rebase /any/git/repo

Patch is below.

-- >8 --
Subject: [PATCH] allow pull --rebase on branch yet to be born

When doing a "pull --rebase", we check to make sure that the
index and working tree are clean. The index-clean check
compares the index against HEAD. The test erroneously
reports dirtiness if we don't have a HEAD yet.

In the case that we don't have a HEAD, we should just check
if the index has anything in it, which we can do by
comparing to the empty tree.

Signed-off-by: Jeff King <peff@peff.net>
---
Actually, this test is slightly more strict than the "index dirty" check
in git-rebase.sh itself. That test does "git diff-index HEAD", but
doesn't check the return code. It actually looks at whether it generates
output. So it would consider an index with something in it on a branch
yet-to-be-born to be clean, which is perhaps wrong.

Such a thing seems pretty unlikely in practice, though. I don't know if
it is worth making the two tests the same (maybe it is worth refactoring
into an index_is_clean function in git-sh-setup).

 git-pull.sh     |    8 +++++++-
 t/t5520-pull.sh |   11 +++++++++++
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 0f24182..427b5c6 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -119,9 +119,15 @@ error_on_no_merge_candidates () {
 }
 
 test true = "$rebase" && {
+	if git rev-parse -q --verify HEAD >/dev/null; then
+		parent_tree=HEAD
+	else # empty tree
+		parent_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+	fi
+
 	git update-index --ignore-submodules --refresh &&
 	git diff-files --ignore-submodules --quiet &&
-	git diff-index --ignore-submodules --cached --quiet HEAD -- ||
+	git diff-index --ignore-submodules --cached --quiet $parent_tree -- ||
 	die "refusing to pull with rebase: your working tree is not up-to-date"
 
 	oldremoteref= &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index e78d402..dd2ee84 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -149,4 +149,15 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 
 '
 
+test_expect_success 'pull --rebase works on branch yet to be born' '
+	git rev-parse master >expect &&
+	mkdir empty_repo &&
+	(cd empty_repo &&
+	 git init &&
+	 git pull --rebase .. master &&
+	 git rev-parse HEAD >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.6.4.228.g9ab2.dirty
