From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] new test fails "add -p" for adds on the top line
Date: Sat, 16 May 2009 10:48:23 -0700
Message-ID: <7viqk1ndlk.fsf@alter.siamese.dyndns.org>
References: <1c5969370905152010m486a8b85s96334e99e6c54ad5@mail.gmail.com>
	<20090516192529.6117@nanako3.lavabit.com>
	<200905161612.30911.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Matt Graham <mdg149@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat May 16 19:50:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5O29-00057w-1y
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 19:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbZEPRsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 13:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbZEPRsX
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 13:48:23 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:37359 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbZEPRsW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 13:48:22 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516174822.GKKW20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Sat, 16 May 2009 13:48:22 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id sHoP1b0044aMwMQ04HoPvQ; Sat, 16 May 2009 13:48:23 -0400
X-Authority-Analysis: v=1.0 c=1 a=bKi9ceUIwy0A:10 a=8WvdOqfm3OgA:10
 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8 a=7-0bVKOXyNRYHAO9HVQA:9
 a=GGyBjSXFuxOfnMk04S4A:7 a=Dgz6NOxDxs1JGaZMjisrpxpaniUA:4 a=MSl-tDqOz04A:10
 a=qIVjreYYsbEA:10 a=qqL0AIIf40HDHo7I:21 a=x7QgBVo5Y7Aed8me:21
X-CM-Score: 0.00
In-Reply-To: <200905161612.30911.trast@student.ethz.ch> (Thomas Rast's message of "Sat\, 16 May 2009 16\:12\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119368>

Thomas Rast <trast@student.ethz.ch> writes:

> Nanako Shiraishi wrote:
>> Quoting Matt Graham <mdg149@gmail.com>:
>> 
>> > add -p doesn't work for some diffs.  diffs adding a new line at the top of
>> > the file with other adds later in the file are one way to trigger the problem.
>> >
>> > during add -p, split the diff and then answer y for all segments.  the file
>> > won't have been added to the index.
>> >
>> > Signed-off-by: Matthew Graham <mdg149@gmail.com>
>> 
>> I tried "git-add -p" from different versions and I found out that versions before the commit 0beee4c6dec15292415e3d56075c16a76a22af54 doesn't have this problem.
>> 
>> commit 0beee4c6dec15292415e3d56075c16a76a22af54
>> Author: Thomas Rast <trast@student.ethz.ch>
>> Date:   Wed Jul 2 23:59:44 2008 +0200
>> 
>>     git-add--interactive: remove hunk coalescing
>>     
>>     Current git-apply has no trouble at all applying chunks that have
>>     overlapping context, as produced by the splitting feature. So we can
>>     drop the manual coalescing.
>>     
>>     Signed-off-by: Thomas Rast <trast@student.ethz.ch>
>>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> The above commit still reverts cleanly, but AFAICS merge_hunk blindly
> trusts the hunk headers, an assumption that is no longer valid due to
> the 'edit' feature.

Heh, here is my "I told you so" moment ;-).

We could also remove that "edit" thing; I do not use nor trust it
(fundamentally you cannot trust it).

But how about doing it this way?

-- >8 --
Subject: Revert "git-add--interactive: remove hunk coalescing"

This reverts commit 0beee4c6dec15292415e3d56075c16a76a22af54 but with a
bit of twist, as we have added "edit hunk manually" hack and we cannot
rely on the original line numbers of the hunks that were manually edited.
---
 git-add--interactive.perl  |   96 +++++++++++++++++++++++++++++++++++++++++++-
 t/t3701-add-interactive.sh |    2 +-
 2 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index f6e536e..a06172c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -767,6 +767,96 @@ sub split_hunk {
 	return @split;
 }
 
+sub find_last_o_ctx {
+	my ($it) = @_;
+	my $text = $it->{TEXT};
+	my ($o_ofs, $o_cnt) = parse_hunk_header($text->[0]);
+	my $i = @{$text};
+	my $last_o_ctx = $o_ofs + $o_cnt;
+	while (0 < --$i) {
+		my $line = $text->[$i];
+		if ($line =~ /^ /) {
+			$last_o_ctx--;
+			next;
+		}
+		last;
+	}
+	return $last_o_ctx;
+}
+
+sub merge_hunk {
+	my ($prev, $this) = @_;
+	my ($o0_ofs, $o0_cnt, $n0_ofs, $n0_cnt) =
+	    parse_hunk_header($prev->{TEXT}[0]);
+	my ($o1_ofs, $o1_cnt, $n1_ofs, $n1_cnt) =
+	    parse_hunk_header($this->{TEXT}[0]);
+
+	my (@line, $i, $ofs, $o_cnt, $n_cnt);
+	$ofs = $o0_ofs;
+	$o_cnt = $n_cnt = 0;
+	for ($i = 1; $i < @{$prev->{TEXT}}; $i++) {
+		my $line = $prev->{TEXT}[$i];
+		if ($line =~ /^\+/) {
+			$n_cnt++;
+			push @line, $line;
+			next;
+		}
+
+		last if ($o1_ofs <= $ofs);
+
+		$o_cnt++;
+		$ofs++;
+		if ($line =~ /^ /) {
+			$n_cnt++;
+		}
+		push @line, $line;
+	}
+
+	for ($i = 1; $i < @{$this->{TEXT}}; $i++) {
+		my $line = $this->{TEXT}[$i];
+		if ($line =~ /^\+/) {
+			$n_cnt++;
+			push @line, $line;
+			next;
+		}
+		$ofs++;
+		$o_cnt++;
+		if ($line =~ /^ /) {
+			$n_cnt++;
+		}
+		push @line, $line;
+	}
+	my $head = ("@@ -$o0_ofs" .
+		    (($o_cnt != 1) ? ",$o_cnt" : '') .
+		    " +$n0_ofs" .
+		    (($n_cnt != 1) ? ",$n_cnt" : '') .
+		    " @@\n");
+	@{$prev->{TEXT}} = ($head, @line);
+}
+
+sub coalesce_overlapping_hunks {
+	my (@in) = @_;
+	my @out = ();
+
+	my ($last_o_ctx, $last_was_dirty);
+
+	for (grep { $_->{USE} } @in) {
+		my $text = $_->{TEXT};
+		my ($o_ofs) = parse_hunk_header($text->[0]);
+		if (defined $last_o_ctx &&
+		    $o_ofs <= $last_o_ctx &&
+		    !$_->{DIRTY} &&
+		    !$last_was_dirty) {
+			merge_hunk($out[-1], $_);
+		}
+		else {
+			push @out, $_;
+		}
+		$last_o_ctx = find_last_o_ctx($out[-1]);
+		$last_was_dirty = $_->{DIRTY};
+	}
+	return @out;
+}
 
 sub color_diff {
 	return map {
@@ -878,7 +968,8 @@ sub edit_hunk_loop {
 		my $newhunk = {
 			TEXT => $text,
 			TYPE => $hunk->[$ix]->{TYPE},
-			USE => 1
+			USE => 1,
+			DIRTY => 1,
 		};
 		if (diff_applies($head,
 				 @{$hunk}[0..$ix-1],
@@ -1210,6 +1301,8 @@ sub patch_update_file {
 		}
 	}
 
+	@hunk = coalesce_overlapping_hunks(@hunk);
+
 	my $n_lofs = 0;
 	my @result = ();
 	for (@hunk) {
@@ -1224,6 +1317,7 @@ sub patch_update_file {
 		open $fh, '| git apply --cached --recount';
 		for (@{$head->{TEXT}}, @result) {
 			print $fh $_;
+			print STDERR $_;
 		}
 		if (!close $fh) {
 			for (@{$head->{TEXT}}, @result) {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 45da6c8..c5220a1 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -187,7 +187,7 @@ index b6f2c08..61b9053 100755
 +lastline
 EOF
 # Test splitting the first patch, then adding both
-test_expect_failure 'add first line works' '
+test_expect_success 'add first line works' '
 	git commit -am "clear local changes" &&
 	git apply patch &&
 	(echo s; echo y; echo y) | git add -p file &&
-- 
1.6.3.1.9.g95405b
