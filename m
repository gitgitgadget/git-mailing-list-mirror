From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH v2] Update test script annotate-tests.sh to handle missing/extra authors
Date: Sat, 16 Oct 2010 04:09:20 -0700
Message-ID: <1287227360-2610-1-git-send-email-kevin@sb.org>
References: <09193539-B5AD-4574-9FE4-983566A34355@sb.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 16 13:09:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P74dq-0004Ir-M7
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 13:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741Ab0JPLJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 07:09:28 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54118 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab0JPLJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 07:09:27 -0400
Received: by pwj4 with SMTP id 4so292352pwj.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 04:09:27 -0700 (PDT)
Received: by 10.142.141.12 with SMTP id o12mr1558726wfd.280.1287227367408;
        Sat, 16 Oct 2010 04:09:27 -0700 (PDT)
Received: from localhost.localdomain ([24.130.32.253])
        by mx.google.com with ESMTPS id q13sm17783377wfc.17.2010.10.16.04.09.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 04:09:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.208.g53ea2
In-Reply-To: <09193539-B5AD-4574-9FE4-983566A34355@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159160>

The current script used by annotate-tests.sh (used by t8001 and t8002) fails
to emit a warning if any of the expected authors never show up in the output
or if authors that show up in the output were never specified as expected.
Update the script to fail in both of these scenarios.

Helped-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 t/annotate-tests.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 396b965..141b60c 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -8,27 +8,27 @@ check_count () {
 	$PROG file $head >.result || return 1
 	cat .result | perl -e '
 		my %expect = (@ARGV);
-		my %count = ();
+		my %count = map { $_ => 0 } keys %expect;
 		while (<STDIN>) {
 			if (/^[0-9a-f]+\t\(([^\t]+)\t/) {
 				my $author = $1;
 				for ($author) { s/^\s*//; s/\s*$//; }
-				if (exists $expect{$author}) {
-					$count{$author}++;
-				}
+				$count{$author}++;
 			}
 		}
 		my $bad = 0;
 		while (my ($author, $count) = each %count) {
 			my $ok;
-			if ($expect{$author} != $count) {
+			my $value = 0;
+			$value = $expect{$author} if defined $expect{$author};
+			if ($value != $count) {
 				$bad = 1;
 				$ok = "bad";
 			}
 			else {
 				$ok = "good";
 			}
-			print STDERR "Author $author (expected $expect{$author}, attributed $count) $ok\n";
+			print STDERR "Author $author (expected $value, attributed $count) $ok\n";
 		}
 		exit($bad);
 	' "$@"
-- 
1.7.3.1.208.g53ea2
