From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 2/5] contrib: contacts: add ability to parse from committish
Date: Sun, 21 Jul 2013 06:52:39 -0400
Message-ID: <1374403962-48361-3-git-send-email-sunshine@sunshineco.com>
References: <1374403962-48361-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 21 12:53:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0rGq-0003Xj-Ji
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 12:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310Ab3GUKxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 06:53:31 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:56754 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076Ab3GUKxP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 06:53:15 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so12621643iec.7
        for <git@vger.kernel.org>; Sun, 21 Jul 2013 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=zviaF/93H/z+m/QWoYhbJ4FEnUQ42xNiVM7/XqMUBN0=;
        b=efLJQ6oXofjO0Nb4zrROyh85RKKoCkUx0vD6tKxO/K/wBdtHPLHcmJnM0z/X5LtRzn
         CBzVymdJZaP6uW3M3Ex2OO3kEdNw4V6L7DLH2T2MEeceTer6BZdaFsZCV1VJKxhRJDkf
         LmgKl4aaFlGrgdTAXhI9pSj+0H0Y4QyyKOvWqhiSVA/TSmDRr8KGCkphZfpX3SWhiqaF
         duEIBqqXxEommQkGv99TDt8bc3KKzruJ1nSx8VWGOys3bxqDJ2bpTt9Zq7pySqV0qOdK
         DB9SB2//3dws/Cf7Ku86evRRFfGW5a55RklRMOwleZ4m1DvUJwLw5OJaOwb5LEtNQLxn
         9Yow==
X-Received: by 10.43.84.131 with SMTP id ak3mr14668385icc.84.1374403995012;
        Sun, 21 Jul 2013 03:53:15 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id d14sm50204105igz.6.2013.07.21.03.53.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 21 Jul 2013 03:53:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.803.gd114dc6
In-Reply-To: <1374403962-48361-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230922>

For example:

  % git contacts R1..R2

Committishes and patch files can be mentioned in the same invocation:

  % git contacts R1..R2 extra/*.patch

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/contacts/git-contacts | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 3e6cce8..1686ff3 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -3,7 +3,7 @@
 # List people who might be interested in a patch.  Useful as the argument to
 # git-send-email --cc-cmd option, and in other situations.
 #
-# Usage: git contacts <file> ...
+# Usage: git contacts <file | rev-list option> ...
 
 use strict;
 use warnings;
@@ -77,8 +77,8 @@ sub get_blame {
 }
 
 sub scan_patches {
-	my ($commits, $f) = @_;
-	my ($id, $source);
+	my ($commits, $id, $f) = @_;
+	my $source;
 	while (<$f>) {
 		if (/^From ([0-9a-f]{40}) Mon Sep 17 00:00:00 2001$/) {
 			$id = $1;
@@ -98,18 +98,44 @@ sub scan_patches {
 sub scan_patch_file {
 	my ($commits, $file) = @_;
 	open my $f, '<', $file or die "read failure: $file: $!\n";
-	scan_patches($commits, $f);
+	scan_patches($commits, undef, $f);
+	close $f;
+}
+
+sub scan_rev_args {
+	my ($commits, $args) = @_;
+	open my $f, '-|', qw(git rev-list --reverse), @$args or die;
+	while (<$f>) {
+		chomp;
+		my $id = $_;
+		$seen{$id} = 1;
+		open my $g, '-|', qw(git show -C --oneline), $id or die;
+		scan_patches($commits, $id, $g);
+		close $g;
+	}
 	close $f;
 }
 
 if (!@ARGV) {
-	die "No input patch files\n";
+	die "No input revisions or patch files\n";
 }
 
-my %commits;
+my (@files, @rev_args);
 for (@ARGV) {
+	if (-e) {
+		push @files, $_;
+	} else {
+		push @rev_args, $_;
+	}
+}
+
+my %commits;
+for (@files) {
 	scan_patch_file(\%commits, $_);
 }
+if (@rev_args) {
+	scan_rev_args(\%commits, \@rev_args)
+}
 import_commits(\%commits);
 
 my $contacts = {};
-- 
1.8.3.3.803.gd114dc6
