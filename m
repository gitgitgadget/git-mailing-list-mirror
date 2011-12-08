From: Joe Perches <joe@perches.com>
Subject: [PATCH] git-send-email: Add auto-cc to all body signatures
Date: Wed, 07 Dec 2011 18:58:39 -0800
Message-ID: <1323313119.1762.58.camel@joe2Laptop>
References: <b2937bc06d1bff456b84e51d6edee0bb1afc5f31.1311902983.git.joe@perches.com>
	 <1311903782.20837.42.camel@jtkirshe-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: jeffrey.t.kirsher@intel.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 03:58:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYUC6-0004Wm-DQ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 03:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756816Ab1LHC6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 21:58:41 -0500
Received: from perches-mx.perches.com ([206.117.179.246]:34992 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756637Ab1LHC6k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 21:58:40 -0500
Received: from [173.60.85.8] (account joe@perches.com HELO [192.168.1.151])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 18504810; Wed, 07 Dec 2011 18:58:39 -0800
In-Reply-To: <1311903782.20837.42.camel@jtkirshe-mobl>
X-Mailer: Evolution 3.2.1- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186526>

Many types of signatures are used by various projects.

The most common type is formatted:
	"[some_signature_type]-by: First Last <email@domain.tld>"
e.g:
	"Reported-by: First Last <email@domain.tld>" (no quotes are used)

Make git-send-email use these signatures as "CC:" entries.

Add command line option --suppress-cc=signatures to avoid
adding these entries to the cc.

Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 Documentation/git-send-email.txt |    3 ++-
 git-send-email.perl              |   11 ++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 327233c..17ea825 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -246,8 +246,9 @@ Automating
   patch body (commit message) except for self (use 'self' for that).
 - 'sob' will avoid including anyone mentioned in Signed-off-by lines except
    for self (use 'self' for that).
+- 'signatures' will avoid including anyone mentioned in any "<foo>-by:" lines.
 - 'cccmd' will avoid running the --cc-cmd.
-- 'body' is equivalent to 'sob' + 'bodycc'
+- 'body' is equivalent to 'sob' + 'bodycc + signatures'
 - 'all' will suppress all auto cc values.
 --
 +
diff --git a/git-send-email.perl b/git-send-email.perl
index d491db9..fc5bf41 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -75,7 +75,7 @@ git send-email [options] <file | directory | rev-list options >
     --identity              <str>  * Use the sendemail.<id> options.
     --to-cmd                <str>  * Email To: via `<str> \$patch_path`
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
-    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
+    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, signatures, all.
     --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
     --[no-]suppress-from           * Send to self. Default off.
     --[no-]chain-reply-to          * Chain In-Reply-To: fields. Default off.
@@ -393,13 +393,13 @@ my(%suppress_cc);
 if (@suppress_cc) {
 	foreach my $entry (@suppress_cc) {
 		die "Unknown --suppress-cc field: '$entry'\n"
-			unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc)$/;
+			unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc|signatures)$/;
 		$suppress_cc{$entry} = 1;
 	}
 }
 
 if ($suppress_cc{'all'}) {
-	foreach my $entry (qw (cccmd cc author self sob body bodycc)) {
+	foreach my $entry (qw (cccmd cc author self sob body bodycc signatures)) {
 		$suppress_cc{$entry} = 1;
 	}
 	delete $suppress_cc{'all'};
@@ -410,7 +410,7 @@ $suppress_cc{'self'} = $suppress_from if defined $suppress_from;
 $suppress_cc{'sob'} = !$signed_off_by_cc if defined $signed_off_by_cc;
 
 if ($suppress_cc{'body'}) {
-	foreach my $entry (qw (sob bodycc)) {
+	foreach my $entry (qw (sob bodycc signatures)) {
 		$suppress_cc{$entry} = 1;
 	}
 	delete $suppress_cc{'body'};
@@ -1276,7 +1276,7 @@ foreach my $t (@files) {
 	# Now parse the message body
 	while(<$fh>) {
 		$message .=  $_;
-		if (/^(Signed-off-by|Cc): (.*)$/i) {
+		if (/^(Signed-off-by|Cc|[a-z_-]+by): (.*)$/i) {
 			chomp;
 			my ($what, $c) = ($1, $2);
 			chomp $c;
@@ -1285,6 +1285,7 @@ foreach my $t (@files) {
 			} else {
 				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
 				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
+				next if $suppress_cc{'signatures'} and $what =~ /by$/i;
 			}
 			push @cc, $c;
 			printf("(body) Adding cc: %s from line '%s'\n",
-- 
1.7.8.dirty
