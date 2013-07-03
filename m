From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/3] contrib: contacts: add ability to parse from committish
Date: Wed,  3 Jul 2013 16:59:41 -0400
Message-ID: <1372885182-5512-3-git-send-email-sunshine@sunshineco.com>
References: <1372885182-5512-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 23:00:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuUAT-0000M9-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 23:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933368Ab3GCVA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 17:00:29 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:49248 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933209Ab3GCVAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 17:00:25 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so723810obc.6
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 14:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=zkJEdCRP3T5NoKe2vuhXIzIjeZd0gCNrwLgvNRzDA5s=;
        b=0LsHK/sEZRo/E7o+Z1WpBHljllzctSeGlkzDbhMt8E7hJx4T6jPdahkDm5Ac/F64Ry
         oQ/H3uRbMEUwqUBJq5cWl0nIw8TAvACtg2zc/OMjHCrapzU43lmhKo/EmzNvOYoNESnu
         cQ1kwZijmbOLumw9PoZLgKLCVyGm3SekdyUViyqLDKM90W9q5kO4bpyxpwMtUJXo3kYg
         Dx+/8qrQU/etcb7HIeSIKw+Ui981pZFl8m4UmgnIJSJb72PrpOlIBTk5e046iSv+5kV9
         Rqms60DXK35M7NOXOiEmqGzQ+Jhy0gfGe/VQfQYp6jbac5koy3m98/Jc9VO8G1uXgC9H
         ydKQ==
X-Received: by 10.60.146.230 with SMTP id tf6mr2690016oeb.94.1372885224978;
        Wed, 03 Jul 2013 14:00:24 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ps5sm14400579oeb.8.2013.07.03.14.00.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 14:00:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1372885182-5512-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229532>

For example:

  % git contacts master..feature

Committishes and patch files can be mentioned in the same
invocation:

  % git contacts master..feature extra/*.patch

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/contacts/git-contacts | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 6e9ab45..42e6059 100755
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
 
 my %count_per_person;
-- 
1.8.3.2
