From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jun 2013, #04; Tue, 11)
Date: Wed, 12 Jun 2013 15:49:56 -0400
Message-ID: <20130612194956.GC4898@sigill.intra.peff.net>
References: <7vwqq05laf.fsf@alter.siamese.dyndns.org>
 <loom.20130612T154959-145@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 21:50:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umr3X-0006id-Jg
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 21:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab3FLTuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 15:50:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:39446 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755924Ab3FLTuA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 15:50:00 -0400
Received: (qmail 9077 invoked by uid 102); 12 Jun 2013 19:50:52 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Jun 2013 14:50:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jun 2013 15:49:56 -0400
Content-Disposition: inline
In-Reply-To: <loom.20130612T154959-145@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227669>

On Wed, Jun 12, 2013 at 01:56:20PM +0000, Jakub Narebski wrote:

> Junio C Hamano <gitster <at> pobox.com> writes:
> 
> > * rr/remove-contrib-some (2013-06-02) 1 commit
> >   (merged to 'next' on 2013-06-05 at fc15705)
> >  + contrib: remove continuous/ and patches/
> > 
> >  Remove stale contrib/ material.
> > 
> >  Will merge to 'master'.
> 
> What about contrib/blameview by Aneesh Kumar K.V <aneesh.kumar@gmail.com>
> and Jeff King <peff@peff.net>?

Yeah, I mentioned it earlier in the thread as something that I consider
clutter at this point (but somehow the thread drifted away from contrib/
and into other topics, and I forgot).

Here is a patch.

-- >8 --
Subject: [PATCH] contrib: drop blameview/ directory

Blameview was a quick-and-dirty demonstration of how blame's
incremental output could be used in an interface. These days
one can find much better (and less ugly!) demonstrations in
"git gui blame" and "tig blame".

The only advantage blameview has is that its code is perhaps
simpler to read. However, that is balanced by the fact that
it probably has bugs, as nobody uses it nor has touched the
code in 6 years. An implementor is probably better off just
reading the "incremental output" section of "man git-blame".

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/blameview/README         |   9 ---
 contrib/blameview/blameview.perl | 155 ---------------------------------------
 2 files changed, 164 deletions(-)
 delete mode 100644 contrib/blameview/README
 delete mode 100755 contrib/blameview/blameview.perl

diff --git a/contrib/blameview/README b/contrib/blameview/README
deleted file mode 100644
index fada5ce..0000000
--- a/contrib/blameview/README
+++ /dev/null
@@ -1,9 +0,0 @@
-This is a sample program to use 'git-blame --incremental', based
-on this message.
-
-From: Jeff King <peff@peff.net>
-Subject: Re: More precise tag following
-To: Linus Torvalds <torvalds@linux-foundation.org>
-Cc: git@vger.kernel.org
-Date: Sat, 27 Jan 2007 18:52:38 -0500
-Message-ID: <20070127235238.GA28706@coredump.intra.peff.net>
diff --git a/contrib/blameview/blameview.perl b/contrib/blameview/blameview.perl
deleted file mode 100755
index 1dec001..0000000
--- a/contrib/blameview/blameview.perl
+++ /dev/null
@@ -1,155 +0,0 @@
-#!/usr/bin/perl
-
-use Gtk2 -init;
-use Gtk2::SimpleList;
-
-my $hash;
-my $fn;
-if ( @ARGV == 1 ) {
-	$hash = "HEAD";
-	$fn = shift;
-} elsif ( @ARGV == 2 ) {
-	$hash = shift;
-	$fn = shift;
-} else {
-	die "Usage blameview [<rev>] <filename>";
-}
-
-Gtk2::Rc->parse_string(<<'EOS');
-style "treeview_style"
-{
-  GtkTreeView::vertical-separator = 0
-}
-class "GtkTreeView" style "treeview_style"
-EOS
-
-my $window = Gtk2::Window->new('toplevel');
-$window->signal_connect(destroy => sub { Gtk2->main_quit });
-my $vpan = Gtk2::VPaned->new();
-$window->add($vpan);
-my $scrolled_window = Gtk2::ScrolledWindow->new;
-$vpan->pack1($scrolled_window, 1, 1);
-my $fileview = Gtk2::SimpleList->new(
-    'Commit' => 'text',
-    'FileLine' => 'text',
-    'Data' => 'text'
-);
-$scrolled_window->add($fileview);
-$fileview->get_column(0)->set_spacing(0);
-$fileview->set_size_request(1024, 768);
-$fileview->set_rules_hint(1);
-$fileview->signal_connect (row_activated => sub {
-		my ($sl, $path, $column) = @_;
-		my $row_ref = $sl->get_row_data_from_path ($path);
-		system("blameview @$row_ref[0]~1 $fn &");
-		});
-
-my $commitwindow = Gtk2::ScrolledWindow->new();
-$commitwindow->set_policy ('GTK_POLICY_AUTOMATIC','GTK_POLICY_AUTOMATIC');
-$vpan->pack2($commitwindow, 1, 1);
-my $commit_text = Gtk2::TextView->new();
-my $commit_buffer = Gtk2::TextBuffer->new();
-$commit_text->set_buffer($commit_buffer);
-$commitwindow->add($commit_text);
-
-$fileview->signal_connect (cursor_changed => sub {
-		my ($sl) = @_;
-		my ($path, $focus_column) = $sl->get_cursor();
-		my $row_ref = $sl->get_row_data_from_path ($path);
-		my $c_fh;
-		open($c_fh,  '-|', "git cat-file commit @$row_ref[0]")
-					or die "unable to find commit @$row_ref[0]";
-		my @buffer = <$c_fh>;
-		$commit_buffer->set_text("@buffer");
-		close($c_fh);
-		});
-
-my $fh;
-open($fh, '-|', "git cat-file blob $hash:$fn")
-  or die "unable to open $fn: $!";
-
-while(<$fh>) {
-  chomp;
-  $fileview->{data}->[$.] = ['HEAD', "$fn:$.", $_];
-}
-
-my $blame;
-open($blame, '-|', qw(git blame --incremental --), $fn, $hash)
-    or die "cannot start git-blame $fn";
-
-Glib::IO->add_watch(fileno($blame), 'in', \&read_blame_line);
-
-$window->show_all;
-Gtk2->main;
-exit 0;
-
-my %commitinfo = ();
-
-sub flush_blame_line {
-	my ($attr) = @_;
-
-	return unless defined $attr;
-
-	my ($commit, $s_lno, $lno, $cnt) =
-	    @{$attr}{qw(COMMIT S_LNO LNO CNT)};
-
-	my ($filename, $author, $author_time, $author_tz) =
-	    @{$commitinfo{$commit}}{qw(FILENAME AUTHOR AUTHOR-TIME AUTHOR-TZ)};
-	my $info = $author . ' ' . format_time($author_time, $author_tz);
-
-	for(my $i = 0; $i < $cnt; $i++) {
-		@{$fileview->{data}->[$lno+$i-1]}[0,1,2] =
-		(substr($commit, 0, 8), $filename . ':' . ($s_lno+$i));
-	}
-}
-
-my $buf;
-my $current;
-sub read_blame_line {
-
-	my $r = sysread($blame, $buf, 1024, length($buf));
-	die "I/O error" unless defined $r;
-
-	if ($r == 0) {
-		flush_blame_line($current);
-		$current = undef;
-		return 0;
-	}
-
-	while ($buf =~ s/([^\n]*)\n//) {
-		my $line = $1;
-
-		if (($commit, $s_lno, $lno, $cnt) =
-		    ($line =~ /^([0-9a-f]{40}) (\d+) (\d+) (\d+)$/)) {
-			flush_blame_line($current);
-			$current = +{
-				COMMIT => $1,
-				S_LNO => $2,
-				LNO => $3,
-				CNT => $4,
-			};
-			next;
-		}
-
-		# extended attribute values
-		if ($line =~ /^(author|author-mail|author-time|author-tz|committer|committer-mail|committer-time|committer-tz|summary|filename) (.*)$/) {
-			my $commit = $current->{COMMIT};
-			$commitinfo{$commit}{uc($1)} = $2;
-			next;
-		}
-	}
-	return 1;
-}
-
-sub format_time {
-  my $time = shift;
-  my $tz = shift;
-
-  my $minutes = $tz < 0 ? 0-$tz : $tz;
-  $minutes = ($minutes / 100)*60 + ($minutes % 100);
-  $minutes = $tz < 0 ? 0-$minutes : $minutes;
-  $time += $minutes * 60;
-  my @t = gmtime($time);
-  return sprintf('%04d-%02d-%02d %02d:%02d:%02d %s',
-		 $t[5] + 1900, @t[4,3,2,1,0], $tz);
-}
-- 
1.8.3.rc2.14.g7eee6b3
