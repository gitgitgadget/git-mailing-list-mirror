From: Michael G Schwern <schwern@pobox.com>
Subject: Extract Git classes from git-svn (9/10) (was Re: Fix git-svn tests
 for SVN 1.7.5.)
Date: Tue, 17 Jul 2012 16:17:30 -0700
Message-ID: <5005F28A.6070905@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 01:17:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrH1N-0000GP-E6
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 01:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881Ab2GQXRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 19:17:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49007 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068Ab2GQXRc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 19:17:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94CF18648;
	Tue, 17 Jul 2012 19:17:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=zCGKCf1btmXU
	O5HVQWiu3UVuLns=; b=M22xhF09rpXpm09VdoH0MnHeTvM3WJK/D710oh+2h5F4
	W+Bh8S9o+pWCnRdNP+r4lC+blikzUktTzQxh+WQ7N2qNw3f0LwQMsdWkNtyoQfw9
	ZQnFGRXTVH/G2MQKmGF2c0ZXRoh7GI+oHiT2KXojkgPFKzADeNeeMFJ80WLHin4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=w6duY0
	Hf7NQN1M1gLQ9JMYFNWR8c4s5n8R/i8M9I4XmVrOKnHBiVfWYGkSaG7twdI4f2E9
	HjifJUEq0diILEv3WNF6tXR1gQsaB6IXeZV5MxP7ZdDXQVOhR3K79/7yYerYMtK+
	Axc2I7thdBHr/V5f/jzZOuxAJv5jJEJWMj1v8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 823AB8647;
	Tue, 17 Jul 2012 19:17:31 -0400 (EDT)
Received: from windhund.local (unknown [67.23.204.5]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97A3C8646; Tue, 17 Jul
 2012 19:17:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0)
 Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <20120717174446.GA14244@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 9540672C-D065-11E1-93B1-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201634>

>From 368d6c7883080d85f82b1eae1815834e3d59ef5e Mon Sep 17 00:00:00 2001
From: "Michael G. Schwern" <schwern@pobox.com>
Date: Tue, 17 Jul 2012 15:54:33 -0700
Subject: [PATCH 10/11] Cut & paste Git::SVN::GlobSpec into its own file.

Fixes to make it work come next commit.
---
 git-svn.perl             | 58 -----------------------------------------------
 perl/Git/SVN/GlobSpec.pm | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 58 deletions(-)
 create mode 100644 perl/Git/SVN/GlobSpec.pm

diff --git a/git-svn.perl b/git-svn.perl
index 6632cfb..7b54f43 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2045,64 +2045,6 @@ sub gc_directory {
 }


-package Git::SVN::GlobSpec;
-use strict;
-use warnings;
-
-sub new {
-	my ($class, $glob, $pattern_ok) = @_;
-	my $re = $glob;
-	$re =~ s!/+$!!g; # no need for trailing slashes
-	my (@left, @right, @patterns);
-	my $state = "left";
-	my $die_msg = "Only one set of wildcard directories " .
-				"(e.g. '*' or '*/*/*') is supported: '$glob'\n";
-	for my $part (split(m|/|, $glob)) {
-		if ($part =~ /\*/ && $part ne "*") {
-			die "Invalid pattern in '$glob': $part\n";
-		} elsif ($pattern_ok && $part =~ /[{}]/ &&
-			 $part !~ /^\{[^{}]+\}/) {
-			die "Invalid pattern in '$glob': $part\n";
-		}
-		if ($part eq "*") {
-			die $die_msg if $state eq "right";
-			$state = "pattern";
-			push(@patterns, "[^/]*");
-		} elsif ($pattern_ok && $part =~ /^\{(.*)\}$/) {
-			die $die_msg if $state eq "right";
-			$state = "pattern";
-			my $p = quotemeta($1);
-			$p =~ s/\\,/|/g;
-			push(@patterns, "(?:$p)");
-		} else {
-			if ($state eq "left") {
-				push(@left, $part);
-			} else {
-				push(@right, $part);
-				$state = "right";
-			}
-		}
-	}
-	my $depth = @patterns;
-	if ($depth == 0) {
-		die "One '*' is needed in glob: '$glob'\n";
-	}
-	my $left = join('/', @left);
-	my $right = join('/', @right);
-	$re = join('/', @patterns);
-	$re = join('\/',
-		   grep(length, quotemeta($left), "($re)", quotemeta($right)));
-	my $left_re = qr/^\/\Q$left\E(\/|$)/;
-	bless { left => $left, right => $right, left_regex => $left_re,
-	        regex => qr/$re/, glob => $glob, depth => $depth }, $class;
-}
-
-sub full_path {
-	my ($self, $path) = @_;
-	return (length $self->{left} ? "$self->{left}/" : '') .
-	       $path . (length $self->{right} ? "/$self->{right}" : '');
-}
-
 __END__

 Data structures:
diff --git a/perl/Git/SVN/GlobSpec.pm b/perl/Git/SVN/GlobSpec.pm
new file mode 100644
index 0000000..96cfd98
--- /dev/null
+++ b/perl/Git/SVN/GlobSpec.pm
@@ -0,0 +1,59 @@
+package Git::SVN::GlobSpec;
+use strict;
+use warnings;
+
+sub new {
+	my ($class, $glob, $pattern_ok) = @_;
+	my $re = $glob;
+	$re =~ s!/+$!!g; # no need for trailing slashes
+	my (@left, @right, @patterns);
+	my $state = "left";
+	my $die_msg = "Only one set of wildcard directories " .
+				"(e.g. '*' or '*/*/*') is supported: '$glob'\n";
+	for my $part (split(m|/|, $glob)) {
+		if ($part =~ /\*/ && $part ne "*") {
+			die "Invalid pattern in '$glob': $part\n";
+		} elsif ($pattern_ok && $part =~ /[{}]/ &&
+			 $part !~ /^\{[^{}]+\}/) {
+			die "Invalid pattern in '$glob': $part\n";
+		}
+		if ($part eq "*") {
+			die $die_msg if $state eq "right";
+			$state = "pattern";
+			push(@patterns, "[^/]*");
+		} elsif ($pattern_ok && $part =~ /^\{(.*)\}$/) {
+			die $die_msg if $state eq "right";
+			$state = "pattern";
+			my $p = quotemeta($1);
+			$p =~ s/\\,/|/g;
+			push(@patterns, "(?:$p)");
+		} else {
+			if ($state eq "left") {
+				push(@left, $part);
+			} else {
+				push(@right, $part);
+				$state = "right";
+			}
+		}
+	}
+	my $depth = @patterns;
+	if ($depth == 0) {
+		die "One '*' is needed in glob: '$glob'\n";
+	}
+	my $left = join('/', @left);
+	my $right = join('/', @right);
+	$re = join('/', @patterns);
+	$re = join('\/',
+		   grep(length, quotemeta($left), "($re)", quotemeta($right)));
+	my $left_re = qr/^\/\Q$left\E(\/|$)/;
+	bless { left => $left, right => $right, left_regex => $left_re,
+	        regex => qr/$re/, glob => $glob, depth => $depth }, $class;
+}
+
+sub full_path {
+	my ($self, $path) = @_;
+	return (length $self->{left} ? "$self->{left}/" : '') .
+	       $path . (length $self->{right} ? "/$self->{right}" : '');
+}
+
+1;
-- 
1.7.11.1
