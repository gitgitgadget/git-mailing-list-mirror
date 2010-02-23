From: Jeff King <peff@peff.net>
Subject: [PATCH v2] add-interactive: fix bogus diff header line ordering
Date: Mon, 22 Feb 2010 20:05:44 -0500
Message-ID: <20100223010544.GC3254@coredump.intra.peff.net>
References: <20100222103256.GA10557@coredump.intra.peff.net>
 <7vbpfg6h80.fsf@alter.siamese.dyndns.org>
 <20100223005645.GB3254@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 02:06:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjjED-0000ia-SS
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 02:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab0BWBFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 20:05:45 -0500
Received: from peff.net ([208.65.91.99]:50364 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275Ab0BWBFo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 20:05:44 -0500
Received: (qmail 4051 invoked by uid 107); 23 Feb 2010 01:05:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 22 Feb 2010 20:05:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2010 20:05:44 -0500
Content-Disposition: inline
In-Reply-To: <20100223005645.GB3254@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140761>

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
On Mon, Feb 22, 2010 at 07:56:45PM -0500, Jeff King wrote:

> Nope, good catch. Maybe this should specifically be hoisting known git
> header lines back into the header? Or perhaps a better logic would be to
> treat each hunk individually, but just take all lines before the "@@"
> hunk header? Hmm. I am not sure we would even need to treat hunks
> individually...the misplaced header lines should always be part of the
> _first_ hunk.

Like this.

 git-add--interactive.perl |   24 +++++++++++++++++++++++-
 t/t2016-checkout-patch.sh |    8 ++++++++
 2 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index cd43c34..21f1330 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -957,6 +957,28 @@ sub coalesce_overlapping_hunks {
 	return @out;
 }
 
+sub reassemble_patch {
+	my $head = shift;
+	my @patch;
+
+	# Include everything in the header except the beginning of the diff.
+	push @patch, (grep { !/^[-+]{3}/ } @$head);
+
+	# Then include any headers from the hunk lines, which must
+	# come before any actual hunk.
+	while (@_ && $_[0] !~ /^@/) {
+		push @patch, shift;
+	}
+
+	# Then begin the diff.
+	push @patch, grep { /^[-+]{3}/ } @$head;
+
+	# And then the actual hunks.
+	push @patch, @_;
+
+	return @patch;
+}
+
 sub color_diff {
 	return map {
 		colored((/^@/  ? $fraginfo_color :
@@ -1453,7 +1475,7 @@ sub patch_update_file {
 
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
1.7.0.207.g88f1
