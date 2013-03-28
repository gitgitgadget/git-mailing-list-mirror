From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] git-send-email.perl: implement suggestions made by perlcritic
Date: Thu, 28 Mar 2013 18:17:15 +0530
Message-ID: <1364474835-23416-1-git-send-email-artagnon@gmail.com>
References: <7vfvzgn3ob.fsf@alter.siamese.dyndns.org>
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 13:46:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULCDu-0007gW-6G
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 13:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368Ab3C1MqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 08:46:02 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:44676 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291Ab3C1MqA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 08:46:00 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so4517342dan.33
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=gj7HHYbp135BRJTrVSpqxaSzcvhEQyQt5g3k+3Cp9E4=;
        b=Ds5MuqvWU940n9hXRmqTuudW7KJ4busBHh1ek6WVBG8m12/ah/TuAKtzAGFVOKRRbp
         UP75XGJ+v9i247xnX4KI+jfuAZIL0JKhMejWQVQMPn36WFyY7d4nwamuabzBq2xCZLQ0
         iQwSkqnECyR5BHHQcTlzb1D3BolbsHoQRVZ8WZy5K0R/jvU5sdbcj7qRG3gjTNnakGAR
         xpV17VC8GkKtEp1Anr+9Mfxc1aYYhs65kwEir5fCJ3R5Wz100kNx633uMAT8bWBh8P8B
         BGP/hjB1ldWON7H8rT9oSrs4NNm0U22ntNxsu2qMMxYWlR9qYvapsu/EsnVTUEOrNbCO
         CIsw==
X-Received: by 10.66.52.76 with SMTP id r12mr11161464pao.217.1364474760136;
        Thu, 28 Mar 2013 05:46:00 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id vd4sm25443079pbc.35.2013.03.28.05.45.57
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 05:45:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.g07926c6
In-Reply-To: <7vfvzgn3ob.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219383>

Running perlcritic with gentle severity reports six problems.  The
following lists the line numbers on which the problems occur, along
with a description of the problem.  This patch fixes them all, after
carefully considering the consequences.

516: Contrary to common belief, subroutine prototypes do not enable
compile-time checks for proper arguments.  They serve the singular
purpose of defining functions that behave like built-in functions, but
check_file_rev_conflict was never intended to behave like one.  We
have verified that the callers of the subroutines are alright with the
change.

714, 836, 855, 1487: Returning `undef' upon failure from a subroutine
is pretty common. But if the subroutine is called in list context, an
explicit `return undef;' statement will return a one-element list
containing `(undef)'. Now if that list is subsequently put in a
boolean context to test for failure, then it evaluates to true. But
you probably wanted it to be false.  The solution is to just use a
bare `return' statement whenever you want to return failure. In list
context, Perl will then give you an empty list (which is false), and
`undef' in scalar context (which is also false).

1441: The three-argument form of `open' (introduced in Perl 5.6)
prevents subtle bugs that occur when the filename starts with funny
characters like '>' or '<'.  It's also more explicitly clear to define
the input mode of the file.  This policy will not complain if the file
explicitly states that it is compatible with a version of Perl prior
to 5.6 via an include statement (see 'use 5.008' near the top of the
file).

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Junio: In future, please tell me explicitly that you're expecting a
 re-roll with an updated commit message.  It wasn't obvious to me at
 all.

 git-send-email.perl | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index c3501d9..633f447 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -513,7 +513,7 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 ($sender) = expand_aliases($sender) if defined $sender;
 
 # returns 1 if the conflict must be solved using it as a format-patch argument
-sub check_file_rev_conflict($) {
+sub check_file_rev_conflict {
 	return unless $repo;
 	my $f = shift;
 	try {
@@ -711,7 +711,7 @@ sub ask {
 			}
 		}
 	}
-	return undef;
+	return;
 }
 
 my %broken_encoding;
@@ -833,7 +833,7 @@ sub extract_valid_address {
 	# less robust/correct than the monster regexp in Email::Valid,
 	# but still does a 99% job, and one less dependency
 	return $1 if $address =~ /($local_part_regexp\@$domain_regexp)/;
-	return undef;
+	return;
 }
 
 sub extract_valid_address_or_die {
@@ -852,7 +852,7 @@ sub validate_address {
 			valid_re => qr/^(?:quit|q|drop|d|edit|e)/i,
 			default => 'q');
 		if (/^d/i) {
-			return undef;
+			return;
 		} elsif (/^q/i) {
 			cleanup_compose_files();
 			exit(0);
@@ -1453,7 +1453,7 @@ sub recipients_cmd {
 
 	my $sanitized_sender = sanitize_address($sender);
 	my @addresses = ();
-	open my $fh, "$cmd \Q$file\E |"
+	open my $fh, q{-|}, "$cmd \Q$file\E"
 	    or die "($prefix) Could not execute '$cmd'";
 	while (my $address = <$fh>) {
 		$address =~ s/^\s*//g;
@@ -1499,7 +1499,7 @@ sub validate_patch {
 			return "$.: patch contains a line longer than 998 characters";
 		}
 	}
-	return undef;
+	return;
 }
 
 sub file_has_nonascii {
-- 
1.8.2.141.g07926c6
