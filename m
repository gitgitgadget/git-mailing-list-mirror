From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add -p: skip conflicted paths
Date: Thu, 5 Apr 2012 08:30:08 -0400
Message-ID: <20120405123007.GA439@sigill.intra.peff.net>
References: <7vaa30tmk9.fsf@alter.siamese.dyndns.org>
 <7v62dotltk.fsf@alter.siamese.dyndns.org>
 <20120329054558.GA27604@sigill.intra.peff.net>
 <CABPQNSY8gNPZTV77AjFbHn1HA9S=fw3NC+H8bCzZOPFyLg0nHQ@mail.gmail.com>
 <7v398mgfdu.fsf@alter.siamese.dyndns.org>
 <20120404094618.GA13870@sigill.intra.peff.net>
 <7v398jbjbo.fsf@alter.siamese.dyndns.org>
 <7vty0z8i66.fsf@alter.siamese.dyndns.org>
 <20120404202527.GA1363@sigill.intra.peff.net>
 <7v62df89pv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr, hellmuth@ira.uka.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 14:30:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFlpU-0000ad-1h
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 14:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151Ab2DEMaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 08:30:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48814
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026Ab2DEMaL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 08:30:11 -0400
Received: (qmail 23019 invoked by uid 107); 5 Apr 2012 12:30:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Apr 2012 08:30:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2012 08:30:08 -0400
Content-Disposition: inline
In-Reply-To: <7v62df89pv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194768>

On Wed, Apr 04, 2012 at 02:31:56PM -0700, Junio C Hamano wrote:

> >> -	for (run_cmd_pipe(qw(git diff-files --numstat --summary --), @tracked)) {
> >> +	for (run_cmd_pipe(qw(git diff-files --numstat --summary),
> >> +			  ($note_unmerged ? ("--raw") : ()),
> >> +			  "--", @tracked)) {
> >
> > Maybe it is not worth even having $note_unmerged, and just filling in
> > the UNMERGED field unconditionally? I know other callers don't care
> > about the information, but it's so cheap, and it just makes the function
> > interface that much simpler.
> 
> Perhaps.  Care to do the honors of rolling the final version perhaps with
> a test?

Here it is. The three interesting changes are:

  1. It tweaks @all_mods properly to produce "No changes" or "Only
     binary changes" as appropriate. So you might see:

        ignoring unmerged: foo
        No changes.

     which I think is clear enough.

  2. Earlier iterations did not handle the "create a record with
     INDEX => 'unchanged' if it did not appear in diff-index" code path.
     So if we made an UNMERGED entry from something that had not
     appeared in "git diff-index", then it could end up not having an
     INDEX field at all.

     I'm not sure this can happen in normal use, as generally diff-index
     would mention any conflicted entries. You can trigger this with
     regular "git diff-index" if the path is missing in HEAD and in
     the working tree, but not with "git diff-index --cached". So maybe
     it is not possible to trigger, but it was a bit too subtle for my
     taste, so I took the more obvious approach you see below.

  3. I added a test. I used a more plausible merge conflict instead of
     tweaking the index as you showed in an earlier email.  While the
     latter would have caught the particular ill-conceived
     implementation I posted earlier, I thought it was more important to
     check a more real-world setup (where HEAD actually has real data in
     it).

-- >8 --
Subject: [PATCH] add--interactive: ignore unmerged entries in patch mode

When "add -p" sees an unmerged entry, it shows the combined
diff and then immediately skips the hunk. This can be
confusing in a variety of ways, depending on whether there
are other changes to stage (in which case you get the
superfluous combined diff output in between other hunks) or
not (in which case you get the combined diff and the program
exits immediately, rather than seeing "No changes").

The current behavior was not planned, and is just what the
implementation happens to do. Instead, let's explicitly
remove unmerged entries from our list of modified files, and
print a warning that we are ignoring them.

We can cheaply find which entries are unmerged by adding
"--raw" output to the "diff-files --numstat" we already run.
There is one non-obvious thing we must change when parsing
this combined output. Before this patch, when we saw a
numstat line for a file that did not have index changes, we
would create a new record with 'unchanged' in the 'INDEX'
field.  Because "--raw" comes before "--numstat", we must
move this special-case down to the raw-line case (and it is
sufficient to move it rather than handle it in both places,
since any file which has a --numstat will also have a --raw
entry).

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl  |   25 ++++++++++++++++++-------
 t/t3701-add-interactive.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8f0839d..d948aa8 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -268,6 +268,7 @@ sub get_empty_tree {
 # FILE:		is file different from index?
 # INDEX_ADDDEL:	is it add/delete between HEAD and index?
 # FILE_ADDDEL:	is it add/delete between index and file?
+# UNMERGED:	is the path unmerged
 
 sub list_modified {
 	my ($only) = @_;
@@ -318,16 +319,10 @@ sub list_modified {
 		}
 	}
 
-	for (run_cmd_pipe(qw(git diff-files --numstat --summary --), @tracked)) {
+	for (run_cmd_pipe(qw(git diff-files --numstat --summary --raw --), @tracked)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			$file = unquote_path($file);
-			if (!exists $data{$file}) {
-				$data{$file} = +{
-					INDEX => 'unchanged',
-					BINARY => 0,
-				};
-			}
 			my ($change, $bin);
 			if ($add eq '-' && $del eq '-') {
 				$change = 'binary';
@@ -346,6 +341,18 @@ sub list_modified {
 			$file = unquote_path($file);
 			$data{$file}{FILE_ADDDEL} = $adddel;
 		}
+		elsif (/^:[0-7]+ [0-7]+ [0-9a-f]+ [0-9a-f]+ (.)	(.*)$/) {
+			$file = unquote_path($2);
+			if (!exists $data{$file}) {
+				$data{$file} = +{
+					INDEX => 'unchanged',
+					BINARY => 0,
+				};
+			}
+			if ($1 eq 'U') {
+				$data{$file}{UNMERGED} = 1;
+			}
+		}
 	}
 
 	for (sort keys %data) {
@@ -1190,6 +1197,10 @@ sub apply_patch_for_checkout_commit {
 
 sub patch_update_cmd {
 	my @all_mods = list_modified($patch_mode_flavour{FILTER});
+	error_msg "ignoring unmerged: $_->{VALUE}\n"
+		for grep { $_->{UNMERGED} } @all_mods;
+	@all_mods = grep { !$_->{UNMERGED} } @all_mods;
+
 	my @mods = grep { !($_->{BINARY}) } @all_mods;
 	my @them;
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 9e236f9..098a6ae 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -330,4 +330,30 @@ test_expect_success PERL 'split hunk "add -p (edit)"' '
 	! grep "^+15" actual
 '
 
+test_expect_success 'patch mode ignores unmerged entries' '
+	git reset --hard &&
+	test_commit conflict &&
+	test_commit non-conflict &&
+	git checkout -b side &&
+	test_commit side conflict.t &&
+	git checkout master &&
+	test_commit master conflict.t &&
+	test_must_fail git merge side &&
+	echo changed >non-conflict.t &&
+	echo y | git add -p >output &&
+	! grep a/conflict.t output &&
+	cat >expected <<-\EOF &&
+	* Unmerged path conflict.t
+	diff --git a/non-conflict.t b/non-conflict.t
+	index f766221..5ea2ed4 100644
+	--- a/non-conflict.t
+	+++ b/non-conflict.t
+	@@ -1 +1 @@
+	-non-conflict
+	+changed
+	EOF
+	git diff --cached >diff &&
+	test_cmp expected diff
+'
+
 test_done
-- 
1.7.10.rc4.3.gb05f6
