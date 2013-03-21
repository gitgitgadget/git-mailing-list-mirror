From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] git-send-email.perl: implement suggestions made by perlcritic
Date: Thu, 21 Mar 2013 18:09:47 +0530
Message-ID: <1363869587-10462-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 21 13:39:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIelt-0003tA-5X
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 13:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758084Ab3CUMii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 08:38:38 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:55156 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756086Ab3CUMih (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 08:38:37 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so1630215dan.19
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 05:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:x-mailer;
        bh=SpQrwQch1zKGO7iO4IZxnKHgi+DprqRKIAzMiBBblIw=;
        b=dHgNcY2G7dyArHbX/zjv+k+yULwdG4onqMDoEGXhW6xNlmuDXTeBM2R7l9PMnFTh/4
         lBnIOM+eniAKGBqkeuWcCEKikasEXsFkcAcRI3mC7FZqSyU1beJY1DQtYrM4eqUJjnl3
         YXyR/1te5xAX04mI2Loxpc5shAaRkwgnC8KEU/uBt3GD1HljUqK2na2Mvj38wHORITpK
         gONUzoX3vTLlCcS9L6uR95rSzot5oQe74imj3lDUdVk3/W5beAh5PuKfmu6LuJV2IPgP
         AymRkgLT3ojj+rmwGNzaz8GBRXA9/JCBEYCMB4vHkNKp4inRCf4G5qPzIqj8mO+nlWYl
         GZNQ==
X-Received: by 10.68.134.133 with SMTP id pk5mr14365147pbb.209.1363869516703;
        Thu, 21 Mar 2013 05:38:36 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id ri1sm5997404pbc.16.2013.03.21.05.38.34
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 05:38:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.62.ga35d936.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218719>

Running perlcritic with gentle severity reports six problems.  The
following lists the line numbers on which the problems occur, along
with a description of the problem.  This patch fixes them all.

516: Contrary to common belief, subroutine prototypes do not enable
compile-time checks for proper arguments.  They serve the singular
purpose of defining functions that behave like built-in functions, but
check_file_rev_conflict was never intended to behave like one.

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
 I was looking at git-send-email.perl after I posted that bug report
 about SSL_verify.  What better way to get started than Perl Best
 Practices?  Here's a nice patch to fix some obvious style issues.  I
 didn't run perlcritic on a higher severity, because I don't know
 enough Perl to have a well-formed opinion of my own; I'm just fixing
 the glaringly obvious problems.

 git-send-email.perl | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index be809e5..e974b11 100755
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
@@ -1438,7 +1438,7 @@ sub recipients_cmd {
 
 	my $sanitized_sender = sanitize_address($sender);
 	my @addresses = ();
-	open my $fh, "$cmd \Q$file\E |"
+	open my $fh, q{-|}, "$cmd \Q$file\E"
 	    or die "($prefix) Could not execute '$cmd'";
 	while (my $address = <$fh>) {
 		$address =~ s/^\s*//g;
@@ -1484,7 +1484,7 @@ sub validate_patch {
 			return "$.: patch contains a line longer than 998 characters";
 		}
 	}
-	return undef;
+	return;
 }
 
 sub file_has_nonascii {
-- 
1.8.2.62.ga35d936.dirty
