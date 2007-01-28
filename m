From: Junio C Hamano <junkio@cox.net>
Subject: Re: More precise tag following
Date: Sun, 28 Jan 2007 11:58:26 -0800
Message-ID: <7vlkjmexel.fsf@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701281107050.25027@woody.linux-foundation.org>
	<7vveirdkpb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 20:59:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBGBJ-0001Ok-NE
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 20:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813AbXA1T63 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 14:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbXA1T63
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 14:58:29 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:53600 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932813AbXA1T62 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 14:58:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128195827.OKIK25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 14:58:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GjxU1W00a1kojtg0000000; Sun, 28 Jan 2007 14:57:29 -0500
In-Reply-To: <7vveirdkpb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 28 Jan 2007 11:18:08 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38044>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Sun, 28 Jan 2007, Junio C Hamano wrote:
>>> 
>>> I think it is sensible to do the attached on top of your patch.
>>
>> Ack.
>>
>> I see you committed this, which is nice, but now Shawn's butt-ugly thing 
>> doesn't work any more, and my mad perl skillz are sadly lacking.
>
> Do you mean the perl-Gtk one by Jeff King?

This on top of the "final" by Jeff should minimally restore it,
in addition to fixing a few problems.

 * filename/linenumber is updated from the blame.
 * gmtime output is relative to year 1900.

I've annotated revision.c with -C and it was fun to watch;-).

---
diff --git a/jk.perl b/jk.perl
index 6a4ac9f..c4d9d57 100644
--- a/jk.perl
+++ b/jk.perl
@@ -41,32 +41,63 @@ $window->show_all;
 Gtk2->main;
 exit 0;
 
+my %commitinfo = ();
+
+sub flush_blame_line {
+	my ($attr) = @_;
+
+	return unless defined $attr;
+
+	my ($commit, $s_lno, $lno, $cnt) =
+	    @{$attr}{qw(COMMIT S_LNO LNO CNT)};
+
+	my ($filename, $author, $author_time, $author_tz) =
+	    @{$commitinfo{$commit}}{qw(FILENAME AUTHOR AUTHOR-TIME AUTHOR-TZ)};
+	my $info = $author . ' ' . format_time($author_time, $author_tz);
+
+	for(my $i = 0; $i < $cnt; $i++) {
+		@{$fileview->{data}->[$lno+$i-1]}[0,1,2] =
+		    (substr($commit, 0, 8), $info,
+		     $filename . ':' . ($s_lno+$i));
+	}
+}
+
 my $buf;
+my $current;
 sub read_blame_line {
-  my $r = sysread(STDIN, $buf, 1024, length($buf));
-  return 0 unless $r;
-  while($buf =~ s/([^\n]*)\n//) {
-    my $line = $1;
-    $line =~ /^(\d+) (\d+) ([0-9a-f]+):(.*):(\d+)$/
-      or die "bad blame output: $line";
-    my $info = commitinfo($3);
-    for(my $i = 0; $i < $2; $i++) {
-      @{$fileview->{data}->[$1+$i]}[0,1] =
-        (substr($3, 0, 8), $info, $4 . ':' . ($5+$i+1));
-    }
-  }
-  return 1;
-}
 
-sub commitinfo {
-  my $hash = shift;
-  open(my $fh, '-|', qw(git rev-list -1 --pretty=raw), $hash)
-    or die "unable to open git-rev-list: $!";
-  while(<$fh>) {
-    chomp;
-    next unless /^author (.*) <.*> (\d+) ([+-]\d+)/;
-    return $1 . ' ' . format_time($2, $3);
-  }
+	my $r = sysread(STDIN, $buf, 1024, length($buf));
+	die "I/O error" unless defined $r;
+
+	if ($r == 0) {
+		flush_blame_line($current);
+		$current = undef;
+		return 0;
+	}
+
+	while ($buf =~ s/([^\n]*)\n//) {
+		my $line = $1;
+
+		if (($commit, $s_lno, $lno, $cnt) =
+		    ($line =~ /^([0-9a-f]{40}) (\d+) (\d+) (\d+)$/)) {
+			flush_blame_line($current);
+			$current = +{
+				COMMIT => $1,
+				S_LNO => $2,
+				LNO => $3,
+				CNT => $4,
+			};
+			next;
+		}
+
+		# extended attribute values
+		if ($line =~ /^(author|author-mail|author-time|author-tz|committer|committer-mail|committer-time|committer-tz|summary|filename) (.*)$/) {
+			my $commit = $current->{COMMIT};
+			$commitinfo{$commit}{uc($1)} = $2;
+			next;
+		}
+	}
+	return 1;
 }
 
 sub format_time {
@@ -78,5 +109,6 @@ sub format_time {
   $minutes = $tz < 0 ? 0-$minutes : $minutes;
   $time += $minutes * 60;
   my @t = gmtime($time);
-  return sprintf('%04d-%02d-%02d %02d:%02d:%02d %s', @t[5,4,3,2,1,0], $tz);
+  return sprintf('%04d-%02d-%02d %02d:%02d:%02d %s',
+		 $t[5] + 1900, @t[4,3,2,1,0], $tz);
 }
