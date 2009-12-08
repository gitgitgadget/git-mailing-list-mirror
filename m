From: Jeff King <peff@peff.net>
Subject: Re: git-apply fails on creating a new file, with both -p and
 --directory specified
Date: Tue, 8 Dec 2009 02:49:35 -0500
Message-ID: <20091208074935.GB12049@coredump.intra.peff.net>
References: <20091123194523.GZ15966@cl.cam.ac.uk>
 <7vws1e3ma1.fsf@alter.siamese.dyndns.org>
 <loom.20091207T222449-752@post.gmane.org>
 <7vk4wyqigf.fsf@alter.siamese.dyndns.org>
 <7v3a3mqhhd.fsf@alter.siamese.dyndns.org>
 <20091208054724.GA21347@coredump.intra.peff.net>
 <20091208060109.GB9951@coredump.intra.peff.net>
 <7v3a3lorge.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Vega <vega.james@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 08:49:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHupM-0004hS-G4
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 08:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbZLHHtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 02:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbZLHHtd
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 02:49:33 -0500
Received: from peff.net ([208.65.91.99]:56269 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbZLHHtc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 02:49:32 -0500
Received: (qmail 9207 invoked by uid 107); 8 Dec 2009 07:54:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 08 Dec 2009 02:54:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Dec 2009 02:49:35 -0500
Content-Disposition: inline
In-Reply-To: <7v3a3lorge.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134832>

On Mon, Dec 07, 2009 at 11:28:01PM -0800, Junio C Hamano wrote:

> That might be something we may want to fix someday, when we find ourselves
> needing to add a feature to turn deletion into non-deletion or vice versa
> during "add -p" [e]dit, as I suspect that the "hunk editing" codepath does
> not keep track of what the user's patch is doing, to the point that it
> does not even know how many lines there are supposed to be in the
> resulting hunk that it asks "git apply" to recount.  There is no way to
> add/delete "deleted file" line if the logic does not know what the patch
> is doing.
> 
> But someday is not today.  I think this six-liner is preferable.

OK, here it is with the test and an amended commit message. You could
almost do an [e]dit on this and delete the "deleted" line, but you have
no way of fixing up the "+++ /dev/null" line. For now, we have
disabled [e]dit entirely for non-content hunks, so at least you cannot
get yourself into trouble creating a broken patch. :)

-- >8 --
Subject: [PATCH] add-interactive: fix deletion of non-empty files

Commit 24ab81a fixed the deletion of empty files, but broke
deletion of non-empty files. The approach it took was to
factor out the "deleted" line from the patch header into its
own hunk, the same way we do for mode changes. However,
unlike mode changes, we only showed the special "delete this
file" hunk if there were no other hunks. Otherwise, the user
would annoyingly be presented with _two_ hunks: one for
deleting the file and one for deleting the content.

This meant that in the non-empty case, we forgot about the
deleted line entirely, and we submitted a bogus patch to
git-apply (with "/dev/null" as the destination file, but not
marked as a deletion).

Instead, this patch combines the file deletion hunk and the
content deletion hunk (if there is one) into a single
deletion hunk which is either staged or not.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl  |    6 +++++-
 t/t3701-add-interactive.sh |   20 ++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 35f4ef1..02e97b9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1217,7 +1217,11 @@ sub patch_update_file {
 	if (@{$mode->{TEXT}}) {
 		unshift @hunk, $mode;
 	}
-	if (@{$deletion->{TEXT}} && !@hunk) {
+	if (@{$deletion->{TEXT}}) {
+		foreach my $hunk (@hunk) {
+			push @{$deletion->{TEXT}}, @{$hunk->{TEXT}};
+			push @{$deletion->{DISPLAY}}, @{$hunk->{DISPLAY}};
+		}
 		@hunk = ($deletion);
 	}
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index aa5909b..0926b91 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -215,6 +215,26 @@ test_expect_success 'add first line works' '
 '
 
 cat >expected <<EOF
+diff --git a/non-empty b/non-empty
+deleted file mode 100644
+index d95f3ad..0000000
+--- a/non-empty
++++ /dev/null
+@@ -1 +0,0 @@
+-content
+EOF
+test_expect_success 'deleting a non-empty file' '
+	git reset --hard &&
+	echo content >non-empty &&
+	git add non-empty &&
+	git commit -m non-empty &&
+	rm non-empty &&
+	echo y | git add -p non-empty &&
+	git diff --cached >diff &&
+	test_cmp expected diff
+'
+
+cat >expected <<EOF
 diff --git a/empty b/empty
 deleted file mode 100644
 index e69de29..0000000
-- 
1.6.5.1.g24ab.dirty
