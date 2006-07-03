From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] send-email: Use setlocale in addition to $ENV{LC_ALL} to set locale
Date: Sun, 02 Jul 2006 19:49:50 -0700
Message-ID: <7vd5cnv1v5.fsf@assigned-by-dhcp.cox.net>
References: <7v3bdy5178.fsf@assigned-by-dhcp.cox.net>
	<11508811631669-git-send-email-jnareb@gmail.com>
	<e7b796$lj$1@sea.gmane.org> <20060621104941.GB15748@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 03 04:50:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxEVY-0001uo-L1
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 04:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWGCCtw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 22:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWGCCtw
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 22:49:52 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:51199 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751039AbWGCCtv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 22:49:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703024951.QKRX22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 22:49:51 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23152>

I was reviewing old log and noticed this topic has never been
resolved.  Your proposal was to use POSIX::setlocale(), and
Eric's counter-proposal was to mimic what 822-date script does,
doing it by hand without mucking with locales, and the
discussion seemed to have died there.  Does this still need to
be addressed?

My gut feeling is that it would probably be less problematic if
we do not muck with locales at all (so drop POSIX::strftime as
well).

So maybe something like this (totally untested)?

-- >8 --
[PATCH] do not use locale specific strftime when preparing 2822 date

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/git-send-email.perl b/git-send-email.perl
index c5d9e73..bc42761 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -23,8 +23,43 @@ use Getopt::Long;
 use Data::Dumper;
 
 # most mail servers generate the Date: header, but not all...
-$ENV{LC_ALL} = 'C';
-use POSIX qw/strftime/;
+sub format_2822_time {
+	my ($time) = @_;
+	my @localtm = localtime($time);
+	my @gmttm = gmtime($time);
+	my $localmin = $localtm[1] + $localtm[2] * 60;
+	my $gmtmin = $gmttm[1] + $gmttm[2] * 60;
+	if ($localtm[0] != $gmttm[0]) {
+		die "local zone differs from GMT by a non-minute interval\n";
+	}
+	if ((($gmttm[6] + 1) % 7) == $localtm[6]) {
+		$localmin += 1440;
+	} elsif ((($gmttm[6] - 1) % 7) == $localtm[6]) {
+		$localmin -= 1440;
+	} elsif ($gmttm[6] != $localtm[6]) {
+		die "local time offset greater than or equal to 24 hours\n";
+	}
+	my $offset = $localmin - $gmtmin;
+	my $offhour = $offset / 60;
+	my $offmin = abs($offset % 60);
+	if (abs($offhour) >= 24) {
+		die ("local time offset greater than or equal to 24 hours\n");
+	}
+
+	return sprintf("%s, %2d %s %d %02d:%02d:%02d %s%02d%02d",
+		       qw(Sun Mon Tue Wed Thu Fri Sat)[$localtm[6]],
+		       $localtm[3],
+		       qw(Jan Feb Mar Apr May Jun
+			  Jul Aug Sep Oct Nov Dec)[$localtm[4]],
+		       $localtm[5]+1900,
+		       $localtm[2],
+		       $localtm[1],
+		       $localtm[0],
+		       ($offset >= 0) ? '+' : '-',
+		       abs($offhour),
+		       $offmin,
+		       );
+}
 
 my $have_email_valid = eval { require Email::Valid; 1 };
 my $smtp;
@@ -371,7 +405,7 @@ sub send_message
 	my @recipients = unique_email_list(@to);
 	my $to = join (",\n\t", @recipients);
 	@recipients = unique_email_list(@recipients,@cc,@bcclist);
-	my $date = strftime('%a, %d %b %Y %H:%M:%S %z', localtime($time++));
+	my $date = format_2822_time($time++);
 	my $gitversion = '@@GIT_VERSION@@';
 	if ($gitversion =~ m/..GIT_VERSION../) {
 	    $gitversion = `git --version`;
