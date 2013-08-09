From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/3] contacts: gather all blame sources prior to invoking git-blame
Date: Fri,  9 Aug 2013 17:39:55 -0400
Message-ID: <1376084396-53617-3-git-send-email-sunshine@sunshineco.com>
References: <1376084396-53617-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 23:40:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7uQH-0005mE-Of
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 23:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031247Ab3HIVk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 17:40:27 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:46828 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031235Ab3HIVkT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 17:40:19 -0400
Received: by mail-ie0-f170.google.com with SMTP id e14so5130883iej.15
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 14:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bukJJP+/HL75akumyU14Gub/YN6rcefvDj9VRyqoO6A=;
        b=l0ecM767Q6AxABgyIkMFBQlRScAFDjp7JW21DqFx+1rD5h7Su3/BLJW75uwMhmMFrF
         AVaRHM/SwBpaiyLK6SoR0RvT9YNRIxUilnS0c99D0Z7c/Fgb4mHAe4/bd11ytwywFJhl
         Gwu21ksfdpPRS5H+x4Z6Jv8pGMgMgUAVIC3VMYY0qKyG8P82Ua7JuaG1wYOLxiEg3sVn
         SLtASzqOUEKHfH9ClmUIpwZyrz/uNoFq+CUJV2uVb7pyEa1r9JpsQ+ZwHwWVUp9d3gqy
         ZOv2xyhEBhyf5EbdgFFpyEzm/br3cFeihQkrtlTv/sOfoxv1x0/HU11tQ0xP5eMbN8f/
         9gNA==
X-Received: by 10.42.88.1 with SMTP id a1mr5513263icm.7.1376084419153;
        Fri, 09 Aug 2013 14:40:19 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id q4sm6156131igp.6.2013.08.09.14.40.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 14:40:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2.460.ga591f4a
In-Reply-To: <1376084396-53617-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232037>

git-contacts invokes git-blame immediately upon encountering a patch
hunk. No attempt is made to consolidate invocations for multiple hunks
referencing the same file at the same revision. This can become
expensive quickly.

Any effort to reduce the number of times git-blame is run will need to
to know in advance which line ranges to blame per file per revision.
Make this information available by collecting all sources as a distinct
step from invoking git-blame.  A subsequent patch will utilize the
information to optimize git-blame invocations.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/contacts/git-contacts | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 4fbb2ef..b4d3526 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -74,8 +74,20 @@ sub get_blame {
 	close $f;
 }
 
+sub blame_sources {
+	my ($sources, $commits) = @_;
+	for my $s (keys %$sources) {
+		for my $id (keys %{$sources->{$s}}) {
+			for my $range (@{$sources->{$s}{$id}}) {
+				get_blame($commits, $s,
+					  $range->[0], $range->[1], $id);
+			}
+		}
+	}
+}
+
 sub scan_patches {
-	my ($commits, $id, $f) = @_;
+	my ($sources, $id, $f) = @_;
 	my $source;
 	while (<$f>) {
 		if (/^From ([0-9a-f]{40}) Mon Sep 17 00:00:00 2001$/) {
@@ -89,7 +101,7 @@ sub scan_patches {
 			die "Cannot parse hunk source: $_\n";
 		} elsif (/^@@ -(\d+)(?:,(\d+))?/ && $source) {
 			my $len = defined($2) ? $2 : 1;
-			get_blame($commits, $source, $1, $len, $id) if $len;
+			push @{$sources->{$source}{$id}}, [$1, $len] if $len;
 		}
 	}
 }
@@ -162,13 +174,16 @@ for (@ARGV) {
 	}
 }
 
-my %commits;
+my %sources;
 for (@files) {
-	scan_patch_file(\%commits, $_);
+	scan_patch_file(\%sources, $_);
 }
 if (@rev_args) {
-	scan_rev_args(\%commits, \@rev_args)
+	scan_rev_args(\%sources, \@rev_args)
 }
+
+my %commits;
+blame_sources(\%sources, \%commits);
 import_commits(\%commits);
 
 my $contacts = {};
-- 
1.8.4.rc2.460.ga591f4a
