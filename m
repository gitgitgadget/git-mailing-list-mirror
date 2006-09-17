From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: use correct mime type even if filename has multiple dots.
Date: Sun, 17 Sep 2006 01:41:40 -0700
Message-ID: <7vejua7um3.fsf@assigned-by-dhcp.cox.net>
References: <20060916210933.GX17042@admingilde.org>
	<eehr7e$5i0$1@sea.gmane.org> <20060917075157.GY17042@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 17 10:42:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOsEI-0001pq-BE
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 10:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWIQIlm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 04:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWIQIlm
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 04:41:42 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:22526 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932224AbWIQIll (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 04:41:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917084141.OFJN12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 04:41:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PLhU1V00E1kojtg0000000
	Sun, 17 Sep 2006 04:41:29 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060917075157.GY17042@admingilde.org> (Martin Waitz's message
	of "Sun, 17 Sep 2006 09:51:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27165>

Martin Waitz <tali@admingilde.org> writes:

>> > -     $filename =~ /\.(.*?)$/;
>> > -     return $mimemap{$1};
>> 
>> Actually, that is non-greedy match, so the above code insist that 
>> extension starts at the _last_ dot.
>
> hmm, but it didn't work for me.
> I had filenames like "man/program.8.html" which got served as
> "text/html" with the old code.

It based its decision on '.html' part, which is expected from
non-greedy match (if I were writing the pattern, I would have
written /\.[^.]+$/ instead, though).  Are you trying to have it
behave differently between "x.8.html" and "x.html"?

> Looking at /etc/mime.types, it only contains pcf.Z but perhaps
> it should also contain tar.gz or similiar.

Probably.  But that makes me think it might be better to:

 - read in mime.types, sort the entries with length of the
   suffixes (longer first);

 - try matching the suffixes from longer to shorter and pick the
   first match.

Without that, you would not be able to cope with a /etc/mime.types
that looks like this, no?

        application/a	a
        application/b	b.a

Perhaps something like the attached.

---
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a81c8d4..4994a33 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1140,23 +1140,42 @@ sub mimetype_guess_file {
 	my $filename = shift;
 	my $mimemap = shift;
 	-r $mimemap or return undef;
+	local($_);
 
-	my %mimemap;
-	open(MIME, $mimemap) or return undef;
+	open MIME, $mimemap
+	    or return undef;
+
+	# Under mod_perl caching this may make a lot of sense...
+	my @mime = ();
+	my $maxlen = 0;
 	while (<MIME>) {
-		next if m/^#/; # skip comments
-		my ($mime, $exts) = split(/\t+/);
-		if (defined $exts) {
-			my @exts = split(/\s+/, $exts);
-			foreach my $ext (@exts) {
-				$mimemap{$ext} = $mime;
+		next if /^#/;
+		chomp;
+		my ($mimetype, @ext) = split(/\s+/);
+		for (@ext) {
+			my $len = length;
+			my $map = $mime[$len];
+			if (!$map) {
+				$mime[$len] = $map = {};
+				$maxlen = $len if ($maxlen < $len);
 			}
+			# We could detect duplicate definition here... i.e.
+			# onetype	ext
+			# anothertype	ext
+			$map->{$_} = $mimetype;
 		}
 	}
-	close(MIME);
+	close MIME;
 
-	$filename =~ /\.(.*?)$/;
-	return $mimemap{$1};
+	for ($filename) {
+		for (my $len = $maxlen; 0 < $len; $len--) {
+			my $map = $mime[$len];
+			while (my ($ext, $type) = each %$map) {
+				return $type if (/\.\Q$ext\E$/);
+			}
+		}
+	}
+	return undef;
 }
 
 sub mimetype_guess {
