From: Jeff King <peff@peff.net>
Subject: Re: git-apply fails on creating a new file, with both -p and
 --directory specified
Date: Tue, 8 Dec 2009 00:47:24 -0500
Message-ID: <20091208054724.GA21347@coredump.intra.peff.net>
References: <20091123194523.GZ15966@cl.cam.ac.uk>
 <7vws1e3ma1.fsf@alter.siamese.dyndns.org>
 <loom.20091207T222449-752@post.gmane.org>
 <7vk4wyqigf.fsf@alter.siamese.dyndns.org>
 <7v3a3mqhhd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Vega <vega.james@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 06:47:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHsvH-0007WS-DO
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 06:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbZLHFrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 00:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbZLHFrW
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 00:47:22 -0500
Received: from peff.net ([208.65.91.99]:56569 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbZLHFrV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 00:47:21 -0500
Received: (qmail 7812 invoked by uid 107); 8 Dec 2009 05:51:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 08 Dec 2009 00:51:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Dec 2009 00:47:24 -0500
Content-Disposition: inline
In-Reply-To: <7v3a3mqhhd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134815>

On Mon, Dec 07, 2009 at 07:20:30PM -0800, Junio C Hamano wrote:

> An update.  I tried your reproduction recipe with 1.6.5.2 and it doesn't
> reproduce, but with 1.6.5.3 it does.

Thanks, both, for a very helpful bug report.  24ab81a was totally bogus,
but we lacked a test for deleting a non-empty file. That test and a fix
for the problem are in the patch below.

I am still slightly concerned that James's

  git diff | sed '/^deleted file/d' | git apply --cached

behaves as it does. What should git-apply do with a patch like:

  diff --git a/foo b/foo
  index 257cc56..0000000
  --- a/foo
  +++ /dev/null
  @@ -1 +0,0 @@
  -foo

? I can see either turning it into a deletion patch (because /dev/null
is special) or barfing (because /dev/null as a special case should have
appeared in the "diff" line). But creating a dev/null file seems very
wrong.

But maybe it is not worth worrying about too much. That patch format is
not generated intentionally by any known software.

Here is the fix directly on top of 24ab81a.

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

Instead, this patch takes a separate approach. We leave the
deletion line in the header, so it will be used as usual by
non-empty files if their deletion hunk is staged. For empty
files, we create a deletion hunk with no content; it doesn't
add anything to the patch, but by staging it we trigger the
application of the header, which does contain the deletion.

Signed-off-by: Jeff King <peff@peff.net>
---
There is a slightly different approach we could take, too: keep the
"deletion" hunk as a first-class hunk, and just meld the content hunk's
output into it. Then both cases would get the "Stage deletion" question
instead of the "Stage this hunk" you get now for non-empty files (which
just happens to trigger a deletion due to the headers).

That would take some refactoring, though, as pulling the deletion hunk
out means we are re-ordering the headers. So right now if you did that
your ($head, @hunk) output would be something like:

       diff --git a/foo b/foo
       index 257cc56..0000000
       --- a/foo
       +++ /dev/null
       deleted file mode 100644
       @@ -1 +0,0 @@
       -foo

which is pretty weird. On the other hand, we already do that funny
ordering for mode hunks, and git-apply is just fine with it. A mode hunk
with content change looks like this:

       diff --git a/foo b/foo
       index 257cc56..19c6cc1
       --- a/foo
       +++ b/foo
       old mode 100644
       new mode 100755

And it also opens the door to editing the hunk to stop the deletion, but
still tweak the content change. Right now if you edit a deletion patch,
you can't remove the 'deleted' bit, and if your edit result keeps any
content in the file, apply will complain. I'm not sure that particular
feature would be useful though (I have certainly never wanted it).

 git-add--interactive.perl  |   18 +++++++++++-------
 t/t3701-add-interactive.sh |   20 ++++++++++++++++++++
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 35f4ef1..f4b95b1 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -731,17 +731,19 @@ sub parse_diff_header {
 
 	my $head = { TEXT => [], DISPLAY => [], TYPE => 'header' };
 	my $mode = { TEXT => [], DISPLAY => [], TYPE => 'mode' };
-	my $deletion = { TEXT => [], DISPLAY => [], TYPE => 'deletion' };
+	my $is_deletion;
 
 	for (my $i = 0; $i < @{$src->{TEXT}}; $i++) {
 		my $dest =
 		   $src->{TEXT}->[$i] =~ /^(old|new) mode (\d+)$/ ? $mode :
-		   $src->{TEXT}->[$i] =~ /^deleted file/ ? $deletion :
 		   $head;
 		push @{$dest->{TEXT}}, $src->{TEXT}->[$i];
 		push @{$dest->{DISPLAY}}, $src->{DISPLAY}->[$i];
+		if ($src->{TEXT}->[$i] =~ /^deleted file/) {
+			$is_deletion = 1;
+		}
 	}
-	return ($head, $mode, $deletion);
+	return ($head, $mode, $is_deletion);
 }
 
 sub hunk_splittable {
@@ -1209,7 +1211,7 @@ sub patch_update_file {
 	my ($ix, $num);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
-	($head, my $mode, my $deletion) = parse_diff_header($head);
+	($head, my $mode, my $is_deletion) = parse_diff_header($head);
 	for (@{$head->{DISPLAY}}) {
 		print;
 	}
@@ -1217,8 +1219,8 @@ sub patch_update_file {
 	if (@{$mode->{TEXT}}) {
 		unshift @hunk, $mode;
 	}
-	if (@{$deletion->{TEXT}} && !@hunk) {
-		@hunk = ($deletion);
+	if ($is_deletion && !@hunk) {
+		@hunk = ({TEXT => [], DISPLAY => [], TYPE => 'deletion'});
 	}
 
 	$num = scalar @hunk;
@@ -1441,14 +1443,16 @@ sub patch_update_file {
 	@hunk = coalesce_overlapping_hunks(@hunk);
 
 	my $n_lofs = 0;
+	my $hunks_used = 0;
 	my @result = ();
 	for (@hunk) {
 		if ($_->{USE}) {
 			push @result, @{$_->{TEXT}};
+			$hunks_used++;
 		}
 	}
 
-	if (@result) {
+	if ($hunks_used) {
 		my $fh;
 		my @patch = (@{$head->{TEXT}}, @result);
 		my $apply_routine = $patch_mode_flavour{APPLY};
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
