From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH v2] gitweb: Option to chop at beginning and in the middle
	in chop_str
Date: Sun, 24 Feb 2008 14:01:17 +0100
Message-ID: <20080224125920.24448.2179.stgit@localhost.localdomain>
References: <200802222014.13205.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jean-Baptiste Quenot <jbq@caraldi.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 14:02:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTGUn-0002Kh-AP
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 14:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbYBXNB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 08:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752310AbYBXNB3
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 08:01:29 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:27935 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbYBXNB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 08:01:28 -0500
Received: by py-out-1112.google.com with SMTP id u52so1909670pyb.10
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 05:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        bh=oGshCrJkhsGaGarGopiNuoRnboNOwtu47pgn90uOP8o=;
        b=SYZTDevWUxHMmoIeAU40QTXAHUREg2YyuYHjHE1qbQlXh9jLBsiyGrv5mwFQd5ox5jhIOPGQ0OWii2Q1wxirPl6+cEW0l411424PM4Kiil9uvJS0qFKbmPKNVDfm9bsChamUULYAr+hIqOdzTIYP4/OY9R7NGPF4Pvv6HG0dc2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=GmHxkV11T3yebgWDs+cRLSH1+vBDgAlh67CTlyy6qxVlNBJpVRGX7IPGVfx793XPvfa386C6m6g3xRH5NRcJ0g/pGGQWYAEM1kMaevvwiBBJzk3Oc0zKJ+EmPQ4dcmqmTmrjvmtrbwOV7c431hkYfBuDiFZr/fdBlRlGpzD4I5g=
Received: by 10.65.249.11 with SMTP id b11mr3601599qbs.2.1203858087145;
        Sun, 24 Feb 2008 05:01:27 -0800 (PST)
Received: from localhost.localdomain ( [83.8.255.46])
        by mx.google.com with ESMTPS id y34sm6345471iky.6.2008.02.24.05.01.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 05:01:24 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1OD1H0R024489;
	Sun, 24 Feb 2008 14:01:17 +0100
In-Reply-To: <200802222014.13205.jnareb@gmail.com>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74928>

Add support for '-cut' option to chop_str subroutine, to cut at the
beginning (from the left side of the string), in the middle (center of
the string), or at the end (from the right side of the string) which
is the default:
  chop_str(somestring, len, slop, -cut=>'left')    ->  ' ...string'
  chop_str(somestring, len, slop, -cut=>'center')  ->  'som ... ing'
  chop_str(somestring, len, slop, -cut=>'right')   ->  'somestr... '

While at it return from chop_str early if given string is so short
that chop_str couldn't shorten it, and simplify regexp used. Make
ellipsis (ots) stick to shorthened fragment for cutting at ends.

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
This is second version of the patch, with regexp simplified,
and early return. Rudimentarly tested.

 gitweb/gitweb.perl |   77 +++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e8226b1..9a8e0a6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -848,32 +848,77 @@ sub project_in_list {
 ## ----------------------------------------------------------------------
 ## HTML aware string manipulation
 
+# Try to chop given string on a word boundary between position
+# $len and $len+$add_len. If there is no word boundary there,
+# chop at $len+$add_len. Do not chop if chopped part plus ellipsis
+# (marking chopped part) would be longer than given string.
 sub chop_str {
 	my $str = shift;
 	my $len = shift;
 	my $add_len = shift || 10;
+	my $where = shift || 'right' # 'left' | 'center' | 'right'
 
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
+	# return early if chupping wouldn't make string shorter
+	if ($where eq 'center') {
+		return $str if ($len + 5 >= length($str)); # filler is length 5
+		$len = int($len/2);
+	} else {
+		return $str if ($len + 4 >= length($str)); # filler is length 4
+	}
+
+	# regexps: ending and beginning with word part up to $add_len
+	my $endre = qr/.{$len}\w{0,$add_len}/;
+	my $begre = qr/\w{0,$add_len}.{$len}/;
+
+	if ($where eq 'left') {
+		$str =~ m/^(.*?)($begre)$/;
+		my ($lead, $body) = ($1, $2);
+		if (length($lead) > 4) {
+			if ($lead =~ m/&[^;]*$/) {
+				$body =~ s/^[^;]*;//;
+			}
+			$lead = " ...";
+		}
+		return "$lead$body";
+
+	} elsif ($where eq 'center') {
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
+			$tail = "... ";
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
@@ -3791,11 +3836,11 @@ sub git_search_grep_body {
 		foreach my $line (@$comment) {
 			if ($line =~ m/^(.*)($search_regexp)(.*)$/i) {
 				my ($lead, $match, $trail) = ($1, $2, $3);
-				$match = chop_str($match, 70, 5);       # in case match is very long
-				my $contextlen = int((80 - length($match))/2); # for the remainder
-				$contextlen = 30 if ($contextlen > 30); # but not too much
-				$lead  = chop_str($lead,  $contextlen, 10);
-				$trail = chop_str($trail, $contextlen, 10);
+				$match = chop_str($match, 70, 5, 'center');
+				my $contextlen = int((80 - length($match))/2);
+				$contextlen = 30 if ($contextlen > 30);
+				$lead  = chop_str($lead,  $contextlen, 10, 'left');
+				$trail = chop_str($trail, $contextlen, 10, 'right');
 
 				$lead  = esc_html($lead);
 				$match = esc_html($match);


-- 
Stacked GIT 0.14.1
git version 1.5.4.2
