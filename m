From: Jeff King <peff@peff.net>
Subject: [PATCH] stash: default listing to working-tree diff
Date: Wed, 6 Aug 2014 14:35:25 -0400
Message-ID: <20140806183525.GA21254@peff.net>
References: <xmqqy4v7uax0.fsf@gitster.dls.corp.google.com>
 <20140806081102.GA1646@peff.net>
 <xmqq1tsto83q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 20:35:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF63g-0007ZN-7B
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 20:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756503AbaHFSf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 14:35:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:47141 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756489AbaHFSf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 14:35:28 -0400
Received: (qmail 6148 invoked by uid 102); 6 Aug 2014 18:35:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Aug 2014 13:35:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Aug 2014 14:35:25 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tsto83q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254887>

On Wed, Aug 06, 2014 at 10:12:25AM -0700, Junio C Hamano wrote:

> > I think we want to drop the "stash show" patch, based on the discussion
> > we had.  The first three patches are nominally prep for that final
> > patch, but actually are things I've often wanted over the years. I'd be
> > glad if they made it in separately, but there were some compatibility
> > questions.
> 
> I am not sure what compatibility you are worried about.  The empty
> format one looks like a pure bugfix to me, and I agree that they
> are good changes regardless of the remainder of the series.

I was mostly worried that somebody is relying on the weird current
behavior with the blank line. I'm inclined to call it a bugfix, too.

> > As clever as I find the --simplify-combined-diff patch, I think we came
> > to the conclusion that "--first-parent" is probably the reasonable
> > choice. It matches "stash show", and it's simple and obvious. Do we just
> > want a patch to specify "--first-parent" to stash-log? That would make
> > "-p" just work. The only downside is that there isn't a good way to turn
> > it off.
> 
> Perhaps we can add --no-first-parent to countermand it?

I started down that road and then realized that "--first-parent" is not
enough. It is only interesting combined with "-m". But it turns out that
using the two together does exactly what we want, and is overridden
as you would hope with just "--cc".

See the patch below, which I think could replace the top three from
jk/stash-list-p (or really, could replace the whole series, and the
bottom three could go into their own topic).

-- >8 --
Subject: stash: default listing to working-tree diff

When you list stashes, you can provide arbitrary git-log
options to change the display. However, adding just "-p"
does nothing, because each stash is actually a merge commit.

This implementation detail is easy to forget, leading to
confused users who think "-p" is not working. We can make
this easier by defaulting to "--first-parent -m", which will
show the diff against the working tree. This omits the
index portion of the stash entirely, but it's simple and it
matches what "git stash show" provides.

People who are more clueful about stash's true form can use
"--cc" to override the "-m", and the "--first-parent" will
then do nothing. For diffs, it only affects non-combined
diffs, so "--cc" overrides it. And for the traversal, we are
walking the linear reflog anyway, so we do not even care
about the parents.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-stash.sh     |  2 +-
 t/t3903-stash.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index bcc757b..9c1ba8e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -297,7 +297,7 @@ have_stash () {
 
 list_stash () {
 	have_stash || return 0
-	git log --format="%gd: %gs" -g "$@" $ref_stash --
+	git log --format="%gd: %gs" -g --first-parent -m "$@" $ref_stash --
 }
 
 show_stash () {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5b79b21..1e29962 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -685,4 +685,46 @@ test_expect_success 'handle stash specification with spaces' '
 	grep pig file
 '
 
+test_expect_success 'setup stash with index and worktree changes' '
+	git stash clear &&
+	git reset --hard &&
+	echo index >file &&
+	git add file &&
+	echo working >file &&
+	git stash
+'
+
+test_expect_success 'stash list implies --first-parent -m' '
+	cat >expect <<-\EOF &&
+	stash@{0}: WIP on master: b27a2bc subdir
+
+	diff --git a/file b/file
+	index 257cc56..d26b33d 100644
+	--- a/file
+	+++ b/file
+	@@ -1 +1 @@
+	-foo
+	+working
+	EOF
+	git stash list -p >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stash list --cc shows combined diff' '
+	cat >expect <<-\EOF &&
+	stash@{0}: WIP on master: b27a2bc subdir
+
+	diff --cc file
+	index 257cc56,9015a7a..d26b33d
+	--- a/file
+	+++ b/file
+	@@@ -1,1 -1,1 +1,1 @@@
+	- foo
+	 -index
+	++working
+	EOF
+	git stash list -p --cc >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.1.0.rc0.286.g5c67d74
