From: Jeff King <peff@peff.net>
Subject: [PATCH] add-interactive: fix bogus diff header line ordering
Date: Mon, 22 Feb 2010 05:32:56 -0500
Message-ID: <20100222103256.GA10557@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 12:31:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjVb9-0000nK-Kw
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 11:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab0BVKdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 05:33:00 -0500
Received: from peff.net ([208.65.91.99]:51271 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881Ab0BVKc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 05:32:59 -0500
Received: (qmail 24655 invoked by uid 107); 22 Feb 2010 10:33:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 22 Feb 2010 05:33:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2010 05:32:56 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140662>

When we look at a patch for adding hunks interactively, we
first split it into a header and a list of hunks. Some of
the header lines, such as mode changes and deletion, however,
become their own selectable hunks. Later when we reassemble
the patch, we simply concatenate the header and the selected
hunks. This leads to patches like this:

  diff --git a/file b/file
  index d95f3ad..0000000
  --- a/file
  +++ /dev/null
  deleted file mode 100644
  @@ -1 +0,0 @@
  -content

Notice how the deletion comes _after_ the ---/+++ lines,
when it should come before.

In many cases, we can get away with this as git-apply
accepts the slightly bogus input. However, in the specific
case of a deletion line that is being applied via "apply
-R", this malformed patch triggers an assert in git-apply.
This comes up when discarding a deletion via "git checkout
-p".

Rather than try to make git-apply accept our odd input,
let's just reassemble the patch in the correct order.

Signed-off-by: Jeff King <peff@peff.net>
---
We talked about this bogosity a few months ago:

http://article.gmane.org/gmane.comp.version-control.git/134815

(see my "slightly different approach" section). And your response was:

  That might be something we may want to fix someday [...] but someday
  is not today.

But since it is triggering a real problem, I think someday is today. :)

The reassembly feels a little hack-ish to me, but it should work fine in
all cases I can imagine (and of course passes all tests).  The
alternatives would be:

  - making git-apply more liberal in accepting this bogus input. I don't
    see much of a point, as the input is clearly malformed (we just
    happened to accept it in some cases).

  - refactoring the whole hunk selection loop to be more clueful about
    magic like mode changes and deletion, and keep the patch in the
    "right" order. I just don't think it's worth the effort.

I've cc'd Thomas because the bug was found through his "checkout -p". It
is not your bug at all, Thomas, but I thought you would be a good person
to sanity check the fix.

 git-add--interactive.perl |   17 ++++++++++++++++-
 t/t2016-checkout-patch.sh |    8 ++++++++
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index bfd1003..4173200 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -979,6 +979,21 @@ sub coalesce_overlapping_hunks {
 	return @out;
 }
 
+sub reassemble_patch {
+	my $head = shift;
+	return (
+		# Include everything in the header except the beginning of the
+		# diff.
+		(grep { !/^[-+]{3}/ } @$head),
+		# Then include any other non-diff header lines from the hunks.
+		(grep { !/^[@ +-]/ } @_),
+		# Then begin the diff.
+		(grep { /^[-+]{3}/ } @$head),
+		# And then the hunk diff lines.
+		(grep { /^[@ +-]/ } @_)
+	);
+}
+
 sub color_diff {
 	return map {
 		colored((/^@/  ? $fraginfo_color :
@@ -1475,7 +1490,7 @@ sub patch_update_file {
 
 	if (@result) {
 		my $fh;
-		my @patch = (@{$head->{TEXT}}, @result);
+		my @patch = reassemble_patch($head->{TEXT}, @result);
 		my $apply_routine = $patch_mode_flavour{APPLY};
 		&$apply_routine(@patch);
 		refresh();
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 4d1c2e9..2144184 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -66,6 +66,14 @@ test_expect_success 'git checkout -p HEAD^' '
 	verify_state dir/foo parent parent
 '
 
+test_expect_success 'git checkout -p handles deletion' '
+	set_state dir/foo work index &&
+	rm dir/foo &&
+	(echo n; echo y) | git checkout -p &&
+	verify_saved_state bar &&
+	verify_state dir/foo index index
+'
+
 # The idea in the rest is that bar sorts first, so we always say 'y'
 # first and if the path limiter fails it'll apply to bar instead of
 # dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
-- 
1.7.0.206.g3f950.dirty
