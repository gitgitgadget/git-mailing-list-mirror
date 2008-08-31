From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Feature request: git-svn dcommit should send deltas upstream
Date: Sun, 31 Aug 2008 18:14:27 +0200
Message-ID: <87y72dkvq4.fsf@mid.deneb.enyo.de>
References: <87myj0f3mb.fsf@mid.deneb.enyo.de>
	<20080829082311.GA7128@yp-box.dyndns.org>
	<87tzd4p1lt.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Aug 31 18:15:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZpaU-0000OQ-Ak
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 18:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbYHaQOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 12:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbYHaQOb
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 12:14:31 -0400
Received: from mail.enyo.de ([212.9.189.167]:35800 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792AbYHaQOa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 12:14:30 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1KZpZM-000307-8p; Sun, 31 Aug 2008 18:14:28 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1KZpZL-0003X1-SY; Sun, 31 Aug 2008 18:14:27 +0200
In-Reply-To: <87tzd4p1lt.fsf@mid.deneb.enyo.de> (Florian Weimer's message of
	"Fri, 29 Aug 2008 12:17:02 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94488>

* Florian Weimer:

>> It's been too long since I've looked at the SVN TxDelta API, but I
>> thought SVN::TxDelta::apply would take care of the delta computation for
>> us...
>
> SVN::Git::Editor::M does not seem to make use of the base text.

Here's an attempt at delta generation.  I don't know if it is entirely
correct, but it does work in the sense that it passes "make test" and
the test cases I reported eariler.

Sorry for the format.  Has anybody got some Emacs code to submit diffs
using Gnus?

commit c94c8b36b41bac20ebf952244675507d2fb927cb
Author: Florian Weimer <fw@deneb.enyo.de>
Date:   Sun Aug 31 17:05:09 2008 +0200

    git-svn: extract base blob in generate_diff
    
    We need the base blob to compute a delta to be sent to the server.
    
    Signed-off-by: Florian Weimer <fw@deneb.enyo.de>

diff --git a/git-svn.perl b/git-svn.perl
index 7a1d26d..0479f41 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3380,11 +3380,12 @@ sub generate_diff {
 	while (<$diff_fh>) {
 		chomp $_; # this gets rid of the trailing "\0"
 		if ($state eq 'meta' && /^:(\d{6})\s(\d{6})\s
-					$::sha1\s($::sha1)\s
+					($::sha1)\s($::sha1)\s
 					([MTCRAD])\d*$/xo) {
 			push @mods, {	mode_a => $1, mode_b => $2,
-					sha1_b => $3, chg => $4 };
-			if ($4 =~ /^(?:C|R)$/) {
+					sha1_a => $3, sha1_b => $4,
+					chg => $5 };
+			if ($5 =~ /^(?:C|R)$/) {
 				$state = 'file_a';
 			} else {
 				$state = 'file_b';

commit 020f941b8b606ed3dc2d323194ab11e019380b03
Author: Florian Weimer <fw@deneb.enyo.de>
Date:   Sun Aug 31 17:45:04 2008 +0200

    git-svn: Introduce SVN::Git::Editor::_chg_file_get_blob
    
    Signed-off-by: Florian Weimer <fw@deneb.enyo.de>

diff --git a/git-svn.perl b/git-svn.perl
index 0479f41..2c3e13f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3663,28 +3663,35 @@ sub change_file_prop {
 	$self->SUPER::change_file_prop($fbat, $pname, $pval, $self->{pool});
 }
 
-sub chg_file {
-	my ($self, $fbat, $m) = @_;
-	if ($m->{mode_b} =~ /755$/ && $m->{mode_a} !~ /755$/) {
-		$self->change_file_prop($fbat,'svn:executable','*');
-	} elsif ($m->{mode_b} !~ /755$/ && $m->{mode_a} =~ /755$/) {
-		$self->change_file_prop($fbat,'svn:executable',undef);
-	}
-	my $fh = Git::temp_acquire('git_blob');
-	if ($m->{mode_b} =~ /^120/) {
+sub _chg_file_get_blob ($$$$) {
+	my ($self, $fbat, $m, $which) = @_;
+	my $fh = Git::temp_acquire("git_blob_$which");
+	if ($m->{"mode_$which"} =~ /^120/) {
 		print $fh 'link ' or croak $!;
 		$self->change_file_prop($fbat,'svn:special','*');
-	} elsif ($m->{mode_a} =~ /^120/ && $m->{mode_b} !~ /^120/) {
+	} elsif ($m->{mode_a} =~ /^120/ && $m->{"mode_$which"} !~ /^120/) {
 		$self->change_file_prop($fbat,'svn:special',undef);
 	}
-	my $size = $::_repository->cat_blob($m->{sha1_b}, $fh);
-	croak "Failed to read object $m->{sha1_b}" if ($size < 0);
+	my $blob = $m->{"sha1_$which"};
+	return ($fh,) if ($blob =~ /^0{40}$/);
+	my $size = $::_repository->cat_blob($blob, $fh);
+	croak "Failed to read object $blob" if ($size < 0);
 	$fh->flush == 0 or croak $!;
 	seek $fh, 0, 0 or croak $!;
 
 	my $exp = ::md5sum($fh);
 	seek $fh, 0, 0 or croak $!;
+	return ($fh, $exp);
+}
 
+sub chg_file {
+	my ($self, $fbat, $m) = @_;
+	if ($m->{mode_b} =~ /755$/ && $m->{mode_a} !~ /755$/) {
+		$self->change_file_prop($fbat,'svn:executable','*');
+	} elsif ($m->{mode_b} !~ /755$/ && $m->{mode_a} =~ /755$/) {
+		$self->change_file_prop($fbat,'svn:executable',undef);
+	}
+	my ($fh, $exp) = _chg_file_get_blob $self, $fbat, $m, 'b';
 	my $pool = SVN::Pool->new;
 	my $atd = $self->apply_textdelta($fbat, undef, $pool);
 	my $got = SVN::TxDelta::send_stream($fh, @$atd, $pool);

commit 846d32cbe8283ffdf4ad5ddb2905dfbc30eace27
Author: Florian Weimer <fw@deneb.enyo.de>
Date:   Sun Aug 31 17:47:09 2008 +0200

    git-svn: Send deltas during commits
    
    Signed-off-by: Florian Weimer <fw@deneb.enyo.de>

diff --git a/git-svn.perl b/git-svn.perl
index 2c3e13f..fdf4e4a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3691,12 +3691,20 @@ sub chg_file {
 	} elsif ($m->{mode_b} !~ /755$/ && $m->{mode_a} =~ /755$/) {
 		$self->change_file_prop($fbat,'svn:executable',undef);
 	}
-	my ($fh, $exp) = _chg_file_get_blob $self, $fbat, $m, 'b';
+	my ($fh_a, $exp_a) = _chg_file_get_blob $self, $fbat, $m, 'a';
+	my ($fh_b, $exp_b) = _chg_file_get_blob $self, $fbat, $m, 'b';
 	my $pool = SVN::Pool->new;
-	my $atd = $self->apply_textdelta($fbat, undef, $pool);
-	my $got = SVN::TxDelta::send_stream($fh, @$atd, $pool);
-	die "Checksum mismatch\nexpected: $exp\ngot: $got\n" if ($got ne $exp);
-	Git::temp_release($fh, 1);
+	my $atd = $self->apply_textdelta($fbat, $exp_a, $pool);
+	if (-s $fh_a) {
+		my $txstream = SVN::TxDelta::new ($fh_a, $fh_b, $pool);
+		SVN::TxDelta::send_txstream($txstream, @$atd, $pool);
+	} else {
+		my $got = SVN::TxDelta::send_stream($fh_b, @$atd, $pool);
+		die "Checksum mismatch\nexpected: $exp_b\ngot: $got\n"
+		    if ($got ne $exp_b);
+	}
+	Git::temp_release($fh_b, 1);
+	Git::temp_release($fh_a, 1);
 	$pool->clear;
 }
 
