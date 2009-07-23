From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git-add -p: be able to undo a given hunk
Date: Thu, 23 Jul 2009 09:41:04 +0200
Message-ID: <20090723074104.GI4750@laphroaig.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 23 09:41:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTsvV-0003sa-N7
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 09:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbZGWHlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 03:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbZGWHlJ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 03:41:09 -0400
Received: from pan.madism.org ([88.191.52.104]:57034 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbZGWHlI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 03:41:08 -0400
Received: from laphroaig.corp (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by hermes.madism.org (Postfix) with ESMTPSA id B4D4841D9B;
	Thu, 23 Jul 2009 09:41:06 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123854>

One of my most frequent use case for git-add -p is when I had an intense
debug session with quite a lot of debug() traces added. I then want only
to select the hunks corresponding to the bugfixes and throw away the debug
ones.

With this new operation, instead of not staging hunks I don't want and
will eventually undo, I can just undo them.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

    I reckon this is a tad late given we're already at -rc2, but that's
    an itch that has scratched me for quite some time already, and I had
    to scratch it today...

    the change looks pretty safe to me though.

    The only think that looks odd in the patch is the removal of the
    if ($_->{USE}) clause from the TEXT copying loops, but
    coalesce_overlapping_hunks already ensures that only ->{USE}d hunks
    remain. I just have modified it to deal with ->{UNDO}ed hunks the
    same way.

 Documentation/git-add.txt |    1 +
 git-add--interactive.perl |   38 ++++++++++++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ab1943c..7b173dc 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -254,6 +254,7 @@ patch::
 
        y - stage this hunk
        n - do not stage this hunk
+       u - do not stage this hunk and revert it
        q - quit, do not stage this hunk nor any of the remaining ones
        a - stage this and all the remaining hunks in the file
        d - do not stage this hunk nor any of the remaining hunks in the file
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index df9f231..945de9d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -693,6 +693,7 @@ sub split_hunk {
 			ADDDEL => 0,
 			POSTCTX => 0,
 			USE => undef,
+			UNDO => undef,
 		};
 
 		while (++$i < @$text) {
@@ -835,12 +836,13 @@ sub merge_hunk {
 }
 
 sub coalesce_overlapping_hunks {
+	my $field = shift;
 	my (@in) = @_;
 	my @out = ();
 
 	my ($last_o_ctx, $last_was_dirty);
 
-	for (grep { $_->{USE} } @in) {
+	for (grep { $_->{$field} } @in) {
 		my $text = $_->{TEXT};
 		my ($o_ofs) = parse_hunk_header($text->[0]);
 		if (defined $last_o_ctx &&
@@ -991,6 +993,7 @@ sub help_patch_cmd {
 	print colored $help_color, <<\EOF ;
 y - stage this hunk
 n - do not stage this hunk
+u - do not stage this hunk and revert it
 q - quit, do not stage this hunk nor any of the remaining ones
 a - stage this and all the remaining hunks in the file
 d - do not stage this hunk nor any of the remaining hunks in the file
@@ -1140,7 +1143,7 @@ sub patch_update_file {
 		}
 		print colored $prompt_color, 'Stage ',
 		  ($hunk[$ix]{TYPE} eq 'mode' ? 'mode change' : 'this hunk'),
-		  " [y,n,q,a,d,/$other,?]? ";
+		  " [y,n,u,q,a,d,/$other,?]? ";
 		my $line = prompt_single_character;
 		if ($line) {
 			if ($line =~ /^y/i) {
@@ -1149,6 +1152,10 @@ sub patch_update_file {
 			elsif ($line =~ /^n/i) {
 				$hunk[$ix]{USE} = 0;
 			}
+			elsif ($line =~ /^u/) {
+				$hunk[$ix]{USE} = 0;
+				$hunk[$ix]{UNDO} = 1;
+			}
 			elsif ($line =~ /^a/i) {
 				while ($ix < $num) {
 					if (!defined $hunk[$ix]{USE}) {
@@ -1301,14 +1308,14 @@ sub patch_update_file {
 		}
 	}
 
-	@hunk = coalesce_overlapping_hunks(@hunk);
-
 	my $n_lofs = 0;
 	my @result = ();
-	for (@hunk) {
-		if ($_->{USE}) {
-			push @result, @{$_->{TEXT}};
-		}
+	my @undo = ();
+	for (coalesce_overlapping_hunks("USE", @hunk)) {
+		push @result, @{$_->{TEXT}};
+	}
+	for (coalesce_overlapping_hunks("UNDO", @hunk)) {
+		push @undo, @{$_->{TEXT}};
 	}
 
 	if (@result) {
@@ -1326,6 +1333,21 @@ sub patch_update_file {
 		refresh();
 	}
 
+	if (@undo) {
+		my $fh;
+
+		open $fh, '| git apply -R';
+		for (@{$head->{TEXT}}, @undo) {
+			print $fh $_;
+		}
+		if (!close $fh) {
+			for (@{$head->{TEXT}}, @undo) {
+				print STDERR $_;
+			}
+		}
+		refresh();
+	}
+
 	print "\n";
 	return $quit;
 }
-- 
1.6.4.rc1.189.g9f628.dirty
