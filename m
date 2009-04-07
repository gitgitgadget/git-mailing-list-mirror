From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC 3/6] send-email: Handle "GIT:" rather than "GIT: " during --compose
Date: Tue,  7 Apr 2009 16:25:19 -0500
Message-ID: <1239139522-24118-3-git-send-email-mfwitten@gmail.com>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 23:28:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrIpv-0002qz-F0
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 23:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760909AbZDGV0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 17:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756418AbZDGV0D
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 17:26:03 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:61365 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619AbZDGV0B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 17:26:01 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2931737rvb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OyyKjnJi5meetxCG7gmu8CUIeMlc2fIa/AGbCnwFyXg=;
        b=ZVsaI5NiklbhsWlMxhq5Oweeoop1op0DPgcPUe3W8uE1yhpZGVR8GjroIkuvhj4bIU
         EUOCaNknQKQy/oO1OfokE+SAwfw62F/upyE9GMHOywDQGuSMCq2Yn1FILD8dqgkOshqU
         ufhCX201KJpWNes5+hAaI6N0Zxp9gI6QdMoGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PGBZV/1aQzL+T/WR4JHDuGWIJlttXob66lXNn2YBevkpZUxI/2I0aKGwjaMfUkNZRm
         eXf5gpSxB3seMZja9gA/GdQESgcEE2Dp0w9nvjC7hQkfnZjapVm3qGQa5C2yphGgRb+t
         utaKqrHSayesC1waU1oKMJWyhbhe91+DMhmGk=
Received: by 10.115.110.1 with SMTP id n1mr298558wam.99.1239139560881;
        Tue, 07 Apr 2009 14:26:00 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-21.mpls.qwest.net [97.116.125.21])
        by mx.google.com with ESMTPS id j39sm7381340waf.28.2009.04.07.14.25.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 14:26:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.448.g61445.dirty
In-Reply-To: <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115991>

This should make things a little more robust in terms of user input;
before, even the program got it wrong by outputting a line with only
"GIT:", which was left in place as a header, because there would be
no following space character.

Also, I cleaned up get_patch_subject().

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 63d6063..098c620 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -505,15 +505,16 @@ if (@files) {
 }
 
 sub get_patch_subject($) {
-	my $fn = shift;
-	open (my $fh, '<', $fn);
-	while (my $line = <$fh>) {
-		next unless ($line =~ /^Subject: (.*)$/);
-		close $fh;
-		return "GIT: $1\n";
+
+	my $patch = shift;
+	open (my $fh, '<', $patch);
+
+	while (<$fh>) {
+		next unless (/^Subject: (.*)$/);
+		return $1;
 	}
-	close $fh;
-	die "No subject line in $fn ?";
+
+	die "'Subject:' line expected in '$patch'";
 }
 
 if ($compose) {
@@ -532,7 +533,7 @@ if ($compose) {
 
 	print C <<EOT;
 From $tpl_sender # This line is ignored.
-GIT: Lines beginning in "GIT: " will be removed.
+GIT: Lines beginning in "GIT:" will be removed.
 GIT: Consider including an overall diffstat or table of contents
 GIT: for the patch you are writing.
 GIT:
@@ -543,7 +544,7 @@ In-Reply-To: $tpl_reply_to
 
 EOT
 	for my $f (@files) {
-		print C get_patch_subject($f);
+		print C "GIT: ", get_patch_subject($f), "\n";
 	}
 	close(C);
 
@@ -565,7 +566,7 @@ EOT
 	my $in_body = 0;
 	my $summary_empty = 1;
 	while(<C>) {
-		next if m/^GIT: /;
+		next if m/^GIT:/;
 		if ($in_body) {
 			$summary_empty = 0 unless (/^\n$/);
 		} elsif (/^\n$/) {
-- 
1.6.2.2.448.g61445.dirty
