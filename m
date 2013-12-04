From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH 3/5] gitweb: Return plain booleans in validation methods
Date: Wed,  4 Dec 2013 14:43:01 +0100
Message-ID: <1386164583-14109-4-git-send-email-krzesimir@endocode.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 14:43:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoCjz-0007Bq-Ne
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 14:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483Ab3LDNnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 08:43:42 -0500
Received: from mail-ea0-f179.google.com ([209.85.215.179]:58347 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932462Ab3LDNne (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 08:43:34 -0500
Received: by mail-ea0-f179.google.com with SMTP id r15so10775201ead.10
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 05:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1HyyERh5BM9LFse5M3Hwz9RtfGcsqhDOy/3OXhEXfs8=;
        b=jHjaOBgJPkaL2iztL0QBuJLj8JBgl6C1+wA723uTped5T7GiFADUBr+TB1s3yW70DT
         ZcF7y8rBBNdnLiKqlJ0Mdy8G1wR03xS5s+NLZwusFa4oRwKYh1HKecfMf7rRaahJqSKj
         oV5p0FsvF77FUV5TSz04b1CbchiFcChxuJ3weRqoxWQ7xkMSF9BUHGnTHpHcn1Y3ItD7
         WfiTqXqMvuLZ+vmEkdm0lvEuMFr4tmEk2OSPnaL+YhN4cuOaeqL8qvYSaGNGfE6FyZi5
         zrfahvldDnRO3l2+2Wu6Gj4oUTu/Vyr5gbXVlzlP6auzTGPTzm1mgMgarstgookHVAEM
         4ZQg==
X-Gm-Message-State: ALoCoQlp8/fkDnMzJqz1KYNzBeJ/G5S2QBFNPjniy1wF3QMMel6bekYCPXhPNVGTE5T6X+bVzlMu
X-Received: by 10.15.56.137 with SMTP id y9mr1285408eew.111.1386164613142;
        Wed, 04 Dec 2013 05:43:33 -0800 (PST)
Received: from localhost.home (95-91-240-208-dynip.superkabel.de. [95.91.240.208])
        by mx.google.com with ESMTPSA id z42sm22327433eeo.17.2013.12.04.05.43.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2013 05:43:32 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238780>

Users of validate_* passing "0" might get failures on correct name
because of coercion of "0" to false in code like:
die_error(500, "invalid ref") unless (check_ref_format ("0"));

Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
---
 gitweb/gitweb.perl | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 67415b9..3434602 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1419,63 +1419,68 @@ sub href {
 ## validation, quoting/unquoting and escaping
 
 sub validate_action {
-	my $input = shift || return undef;
-	return undef unless exists $actions{$input};
-	return $input;
+	my $input = shift;
+
+	return 0 unless defined $input;
+	return 0 unless exists $actions{$input};
+	return 1;
 }
 
 sub validate_project {
-	my $input = shift || return undef;
+	my $input = shift;
+
+	return 0 unless defined $input;
 	if (!validate_pathname($input) ||
 		!(-d "$projectroot/$input") ||
 		!check_export_ok("$projectroot/$input") ||
 		($strict_export && !project_in_list($input))) {
-		return undef;
+		return 0;
 	} else {
-		return $input;
+		return 1;
 	}
 }
 
 sub validate_pathname {
-	my $input = shift || return undef;
+	my $input = shift;
 
+	return 0 unless defined $input;
 	# no '.' or '..' as elements of path, i.e. no '.' nor '..'
 	# at the beginning, at the end, and between slashes.
 	# also this catches doubled slashes
 	if ($input =~ m!(^|/)(|\.|\.\.)(/|$)!) {
-		return undef;
+		return 0;
 	}
 	# no null characters
 	if ($input =~ m!\0!) {
-		return undef;
+		return 0;
 	}
-	return $input;
+	return 1;
 }
 
 sub check_ref_format {
-	my $input = shift || return undef;
+	my $input = shift;
 
+	return 0 unless defined $input;
 	# restrictions on ref name according to git-check-ref-format
 	if ($input =~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
-		return undef;
+		return 0;
 	}
-	return $input;
+	return 1;
 }
 
 sub validate_refname {
-	my $input = shift || return undef;
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
+	validate_pathname($input) or return 0;
 	# check git-check-ref-format restrictions
-	check_ref_format($input)
-		or return undef;
-	return $input;
+	check_ref_format($input) or return 0;
+	return 1;
 }
 
 # decode sequences of octets in utf8 into Perl's internal form,
-- 
1.8.3.1
