From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH v7 2/4] gitweb: Return 1 on validation success instead of passed input
Date: Wed, 11 Dec 2013 12:54:42 +0100
Message-ID: <1386762884-7564-3-git-send-email-krzesimir@endocode.com>
References: <1386762884-7564-1-git-send-email-krzesimir@endocode.com>
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 12:55:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqiO4-0003A9-2s
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 12:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab3LKLz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 06:55:26 -0500
Received: from mail-ee0-f54.google.com ([74.125.83.54]:55483 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab3LKLzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 06:55:22 -0500
Received: by mail-ee0-f54.google.com with SMTP id e51so2670578eek.41
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 03:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mDeko+A7mPpK5HomUA8dtgiCVc6XtVF4FyXBuQ8Peys=;
        b=Lgfzzv5wPB7heL5KCyFGO/iCBaRNIFLyIxNk3+zOuL7zzUyaZmqVtAGuK13RBI1UQW
         ldCqXDb5HPQWIcVzvyQ7t/SHOKN2iGaRfpLEpkweTrgHTvNQZAkW+2he2PHy3vP33KdI
         f6AmyDEGBeU1AYrdcIekeHuBOZ4sqZl8eBXOzJ4C1ropG46+S9awIzCKEXHuQ0KsfzWS
         SEn6qhhLjr5szH2gb8w3N9rmwjQet93PCxDVPFpPzAD8k99A2NlVlkzVxqFkv9Mznowg
         1TzMXPhXH4x41gjOMXJ/AXxusiqJ/ltp44C9k7OYxlNk0nnI8T92Phv3/u6mVvHzgaMC
         Nn8g==
X-Gm-Message-State: ALoCoQmF1KioSmYUeMmDR460b9VCDJiuzq8hrykpcQBrJ1cwlGaNXTg9lok9A5F6dmfPQYFQmkDr
X-Received: by 10.14.37.66 with SMTP id x42mr1253618eea.83.1386762921825;
        Wed, 11 Dec 2013 03:55:21 -0800 (PST)
Received: from localhost.home (95-91-241-58-dynip.superkabel.de. [95.91.241.58])
        by mx.google.com with ESMTPSA id z42sm52742677eeo.17.2013.12.11.03.55.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2013 03:55:21 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1386762884-7564-1-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239188>

Users of validate_* passing "0" might get failures on correct name
because of coercion of "0" to false in code like:
die_error(500, "invalid ref") unless (check_ref_format ("0"));

Also, the validate_foo subs are renamed to is_valid_foo.

Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
---
 gitweb/gitweb.perl | 61 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 46bd6ac..b5a8a36 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -994,7 +994,7 @@ our ($action, $project, $file_name, $file_parent, $hash, $hash_parent, $hash_bas
 sub evaluate_and_validate_params {
 	our $action = $input_params{'action'};
 	if (defined $action) {
-		if (!validate_action($action)) {
+		if (!is_valid_action($action)) {
 			die_error(400, "Invalid action parameter");
 		}
 	}
@@ -1002,7 +1002,7 @@ sub evaluate_and_validate_params {
 	# parameters which are pathnames
 	our $project = $input_params{'project'};
 	if (defined $project) {
-		if (!validate_project($project)) {
+		if (!is_valid_project($project)) {
 			undef $project;
 			die_error(404, "No such project");
 		}
@@ -1010,21 +1010,21 @@ sub evaluate_and_validate_params {
 
 	our $project_filter = $input_params{'project_filter'};
 	if (defined $project_filter) {
-		if (!validate_pathname($project_filter)) {
+		if (!is_valid_pathname($project_filter)) {
 			die_error(404, "Invalid project_filter parameter");
 		}
 	}
 
 	our $file_name = $input_params{'file_name'};
 	if (defined $file_name) {
-		if (!validate_pathname($file_name)) {
+		if (!is_valid_pathname($file_name)) {
 			die_error(400, "Invalid file parameter");
 		}
 	}
 
 	our $file_parent = $input_params{'file_parent'};
 	if (defined $file_parent) {
-		if (!validate_pathname($file_parent)) {
+		if (!is_valid_pathname($file_parent)) {
 			die_error(400, "Invalid file parent parameter");
 		}
 	}
@@ -1032,21 +1032,21 @@ sub evaluate_and_validate_params {
 	# parameters which are refnames
 	our $hash = $input_params{'hash'};
 	if (defined $hash) {
-		if (!validate_refname($hash)) {
+		if (!is_valid_refname($hash)) {
 			die_error(400, "Invalid hash parameter");
 		}
 	}
 
 	our $hash_parent = $input_params{'hash_parent'};
 	if (defined $hash_parent) {
-		if (!validate_refname($hash_parent)) {
+		if (!is_valid_refname($hash_parent)) {
 			die_error(400, "Invalid hash parent parameter");
 		}
 	}
 
 	our $hash_base = $input_params{'hash_base'};
 	if (defined $hash_base) {
-		if (!validate_refname($hash_base)) {
+		if (!is_valid_refname($hash_base)) {
 			die_error(400, "Invalid hash base parameter");
 		}
 	}
@@ -1066,7 +1066,7 @@ sub evaluate_and_validate_params {
 
 	our $hash_parent_base = $input_params{'hash_parent_base'};
 	if (defined $hash_parent_base) {
-		if (!validate_refname($hash_parent_base)) {
+		if (!is_valid_refname($hash_parent_base)) {
 			die_error(400, "Invalid hash parent base parameter");
 		}
 	}
@@ -1418,27 +1418,30 @@ sub href {
 ## ======================================================================
 ## validation, quoting/unquoting and escaping
 
-sub validate_action {
-	my $input = shift || return undef;
+sub is_valid_action {
+	my $input = shift;
 	return undef unless exists $actions{$input};
-	return $input;
+	return 1;
 }
 
-sub validate_project {
-	my $input = shift || return undef;
-	if (!validate_pathname($input) ||
+sub is_valid_project {
+	my $input = shift;
+
+	return unless defined $input;
+	if (!is_valid_pathname($input) ||
 		!(-d "$projectroot/$input") ||
 		!check_export_ok("$projectroot/$input") ||
 		($strict_export && !project_in_list($input))) {
 		return undef;
 	} else {
-		return $input;
+		return 1;
 	}
 }
 
-sub validate_pathname {
-	my $input = shift || return undef;
+sub is_valid_pathname {
+	my $input = shift;
 
+	return undef unless defined $input;
 	# no '.' or '..' as elements of path, i.e. no '.' nor '..'
 	# at the beginning, at the end, and between slashes.
 	# also this catches doubled slashes
@@ -1449,33 +1452,33 @@ sub validate_pathname {
 	if ($input =~ m!\0!) {
 		return undef;
 	}
-	return $input;
+	return 1;
 }
 
 sub is_valid_ref_format {
-	my $input = shift || return undef;
+	my $input = shift;
 
+	return undef unless defined $input;
 	# restrictions on ref name according to git-check-ref-format
 	if ($input =~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
 		return undef;
 	}
-	return $input;
+	return 1;
 }
 
-sub validate_refname {
-	my $input = shift || return undef;
+sub is_valid_refname {
+	my $input = shift;
 
+	return undef unless defined $input;
 	# textual hashes are O.K.
 	if ($input =~ m/^[0-9a-fA-F]{40}$/) {
-		return $input;
+		return 1;
 	}
 	# it must be correct pathname
-	$input = validate_pathname($input)
-		or return undef;
+	is_valid_pathname($input) or return undef;
 	# check git-check-ref-format restrictions
-	is_valid_ref_format($input)
-		or return undef;
-	return $input;
+	is_valid_ref_format($input) or return undef;
+	return 1;
 }
 
 # decode sequences of octets in utf8 into Perl's internal form,
-- 
1.8.3.1
