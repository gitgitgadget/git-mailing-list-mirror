From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Option to chop at beginning and in the middle in
	chop_str
Date: Sat, 23 Feb 2008 22:44:24 +0100
Message-ID: <20080223214226.16470.29333.stgit@localhost.localdomain>
References: <200802222014.13205.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jean-Baptiste Quenot <jbq@caraldi.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 22:45:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT2BB-0000sd-29
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 22:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422AbYBWVob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 16:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756245AbYBWVob
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 16:44:31 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:35328 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106AbYBWVo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 16:44:29 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1305678fkz.5
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 13:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        bh=K5Cn87RPDDPs/h/IIJOhq9Vyqz5E9L/beESCWQtDUfI=;
        b=VHtL3e2mmpVJEvcWLeU2R1KL544tneo4OOGs+17KnVwG63RpTBdZaMgQFBf37N7DcXwMfPpwjDAVW/JRxNvHzpH89ZnZVZKYW6RzBXb/hUbPCopXmbsBXoR7peT7ACs2QilBn8EP8BWxgvNzfgW9ysBbynNNedNnGD3iTvdtEdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=F+nUPKViOXvLqLvw6EqV4JkZFdnRzvGRUlYbO1JG5nReadSE7ZgGiKIxZRMuQyIRR/VX1txmrGoAZneCIuxajP3IODLecWvV8uzz8+y1FfqgR59ZvAudAyftdJIcpn0iNvsFrxVC9khbp3vRh5AQeqpOM2YtgZrGYXD9vmpY/uA=
Received: by 10.82.161.19 with SMTP id j19mr1670759bue.0.1203803067401;
        Sat, 23 Feb 2008 13:44:27 -0800 (PST)
Received: from localhost.localdomain ( [83.8.255.83])
        by mx.google.com with ESMTPS id z37sm5215733ikz.1.2008.02.23.13.44.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Feb 2008 13:44:26 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1NLiOVH016507;
	Sat, 23 Feb 2008 22:44:25 +0100
In-Reply-To: <200802222014.13205.jnareb@gmail.com>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74859>


Add support for '-cut' option to chop_str subroutine, to cut at the
beginning (from the left side of the string), in the middle (center of
the string), or at the end (from the right side of the string) which
is the default:
  chop_str(somestring, len, slop, -pos=>'left')    ->  ... string
  chop_str(somestring, len, slop, -pos=>'center')  ->  som ... ing
  chop_str(somestring, len, slop, -pos=>'right')   ->  somestr ...

Simplify passing all arguments to chop_str in chop_and_escape_str
subroutine. This was needed to pass additional options to chop_str.


Make use of new feature of chop_str to better cut matched string and
its context in match info for searching commit messages (commit
search), as proposed by Junio C Hamano.  For example, if you are
looking for "very long ... and how" in the first paragraph of message
(if it were all on a single line), you would now see:

    ...st this with <<very long ... and how>> the actual out...

instead of:

    Could som... <<very long search stri...>> the actual out...

(where <<something>> denotes emphasized / colored fragment).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
And here it is as a patch to gitweb to play with. I agree with Junio
that the output is better, but I'm not sure if it is worth the
complication in code; perhaps is.

 gitweb/gitweb.perl |   74 +++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e8226b1..59d44b3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -848,32 +848,74 @@ sub project_in_list {
 ## ----------------------------------------------------------------------
 ## HTML aware string manipulation
 
+# cut (chop) string to given length, with additional slop,
+# optionally from left and in the middle.
 sub chop_str {
 	my $str = shift;
 	my $len = shift;
 	my $add_len = shift || 10;
+	# supported opts:
+	# * -cut => 'left' | 'center' | 'right', defaults to 'right'
+	#   denotes where (which part) to chop
+	my %opts = @_;
 
 	# allow only $len chars, but don't cut a word if it would fit in $add_len
 	# if it doesn't fit, cut it if it's still longer than the dots we would add
-	$str =~ m/^(.{0,$len}[^ \/\-_:\.@]{0,$add_len})(.*)/;
-	my $body = $1;
-	my $tail = $2;
-	if (length($tail) > 4) {
-		$tail = " ...";
-		$body =~ s/&[^;]*$//; # remove chopped character entities
+	# remove chopped character entities entirely
+
+	# when chopping in the middle, distribute $len into left and right part
+	if (defined $opts{'-cut'} && $opts{'-cut'} eq 'center') {
+		$len = int($len/2);
+	}
+
+	# regexps: ending and beginning with word part up to $add_len
+	my $endre = qr/.{0,$len}[^ \/\-_:\.@]{0,$add_len}/;
+	my $begre = qr/[^ \/\-_:\.@]{0,$add_len}.{0,$len}/;
+
+	if (defined $opts{'-cut'} && $opts{'-cut'} eq 'left') {
+		$str =~ m/^(.*?)($begre)$/;
+		my ($lead, $body) = ($1, $2);
+		if (length($lead) > 4) {
+			if ($lead =~ m/&[^;]*$/) {
+				$body =~ s/^[^;]*;//;
+			}
+			$lead = "... ";
+		}
+		return "$lead$body";
+
+	} elsif (defined $opts{'-cut'} && $opts{'-cut'} eq 'center') {
+		$str =~ m/^($endre)(.*)$/;
+		my ($left, $str)  = ($1, $2);
+		$str =~ m/^(.*?)($begre)$/;
+		my ($mid, $right) = ($1, $2);
+		if (length($mid) > 5) {
+			$left =~ s/&[^;]*$//;
+			if ($mid =~ m/&[^;]*$/) {
+				$right =~ s/^[^;]*;//;
+			}
+			$mid = " ... ";
+		}
+		return "$left$mid$right";
+
+	} else {
+		$str =~ m/^($endre)(.*)$/;
+		my $body = $1;
+		my $tail = $2;
+		if (length($tail) > 4) {
+			$body =~ s/&[^;]*$//;
+			$tail = " ...";
+		}
+		return "$body$tail";
 	}
-	return "$body$tail";
 }
 
 # takes the same arguments as chop_str, but also wraps a <span> around the
 # result with a title attribute if it does get chopped. Additionally, the
 # string is HTML-escaped.
 sub chop_and_escape_str {
-	my $str = shift;
-	my $len = shift;
-	my $add_len = shift || 10;
+	my ($str) = @_;
 
-	my $chopped = chop_str($str, $len, $add_len);
+	my $chopped = chop_str(@_);
 	if ($chopped eq $str) {
 		return esc_html($chopped);
 	} else {
@@ -3791,11 +3833,11 @@ sub git_search_grep_body {
 		foreach my $line (@$comment) {
 			if ($line =~ m/^(.*)($search_regexp)(.*)$/i) {
 				my ($lead, $match, $trail) = ($1, $2, $3);
-				$match = chop_str($match, 70, 5);       # in case match is very long
-				my $contextlen = int((80 - length($match))/2); # for the remainder
-				$contextlen = 30 if ($contextlen > 30); # but not too much
-				$lead  = chop_str($lead,  $contextlen, 10);
-				$trail = chop_str($trail, $contextlen, 10);
+				$match = chop_str($match, 70, 5, -cut=>'center');
+				my $contextlen = int((80 - length($match))/2);
+				$contextlen = 30 if ($contextlen > 30);
+				$lead  = chop_str($lead,  $contextlen, 10, -cut=>'left');
+				$trail = chop_str($trail, $contextlen, 10, -cut=>'right');
 
 				$lead  = esc_html($lead);
 				$match = esc_html($match);
