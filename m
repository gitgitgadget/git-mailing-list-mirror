From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 3/3 v2] send-email: --suppress-cc improvements
Date: Sat, 14 Feb 2009 00:37:03 -0500
Message-ID: <1234589823-67610-1-git-send-email-jaysoffian@gmail.com>
References: <1234583491-61260-4-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, gitster@pobox.com,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 06:38:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYDEg-0002at-UW
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 06:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbZBNFhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 00:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbZBNFhK
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 00:37:10 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:23046 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbZBNFhI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 00:37:08 -0500
Received: by yx-out-2324.google.com with SMTP id 8so740217yxm.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 21:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Aklk8hO3nDrDPCYFbh90t5cJ0koPSOx8/vXLBGzed/g=;
        b=P42H8uUd8s5/jrgB28a5mJSsUCpquhG7r77AxcK/ryyppdVi+6VxmLqx5J8GeDDZNt
         hdh0sI5DxfiVaozoY+OnpUg4Hx4m6bdQsZm0iYDdColn4+eTAUpzXS6OscuhcGGygf34
         1TMvpw9emPAf+EAINggGcNYJS09vgmh9V3Ejc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=snMFtrdw1/DEfKbjXwkTWygndQDnzZSbr0gpxU1Mjkm15gwU3k6TojmZbXejqJckyJ
         AkmJvuRoZVllgMWAhX1STn3gxbPiRlHSahmRmzjjx+uDVGLuOpJ1F9JgFi3qeiNQquHw
         osRCptqIRrLqqSck1yGF0OmMl4BCbo46WK87s=
Received: by 10.151.9.1 with SMTP id m1mr250302ybi.59.1234589826315;
        Fri, 13 Feb 2009 21:37:06 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id z26sm5251080ele.0.2009.02.13.21.37.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 21:37:05 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.239.gfa9f6
In-Reply-To: <1234583491-61260-4-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109821>

From: Jay Soffian <jaysoffian@gmail.com>

Commit 656482830ddc4a4e2af132fabb118a25190439c2 added the --suppress-cc
option. However, it made --suppress-cc=sob suppress both SOB lines and
body Cc lines (but not header Cc lines), which seems contrary to how
it is named.

After this commit, 'sob' suppresses only SOB lines and --suppress-cc
takes two additional values:

 * 'body' suppresses both SOB and body Cc lines (i.e. what 'sob'
    used to do).

 * 'bodycc' suppresses body Cc lines, but not header Cc lines.

For backwards compatibility, --no-signed-off-by-cc, acts like 'body'.

Also update the documentation and add a few tests.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Sorry, please ignore the previous 3/3, it had an obvious breakage;
--suppress-cc=body was causing then entire message body not to be read
in at all.

 Documentation/git-send-email.txt |   14 ++++++++------
 git-send-email.perl              |   23 ++++++++++++++++-------
 t/t9001-send-email.sh            |   38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ff4aeff..d6af035 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -166,12 +166,14 @@ Automating
 	Specify an additional category of recipients to suppress the
 	auto-cc of.  'self' will avoid including the sender, 'author' will
 	avoid including the patch author, 'cc' will avoid including anyone
-	mentioned in Cc lines in the patch, 'sob' will avoid including
-	anyone mentioned in Signed-off-by lines, and 'cccmd' will avoid
-	running the --cc-cmd.  'all' will suppress all auto cc values.
-	Default is the value of 'sendemail.suppresscc' configuration value;
-	if that is unspecified, default to 'self' if --suppress-from is
-	specified, as well as 'sob' if --no-signed-off-cc is specified.
+	mentioned in Cc lines in the patch header, 'ccbody' will avoid
+	including anyone mentioned in Cc lines in the patch body (commit
+	message), 'sob' will avoid including anyone mentioned in Signed-off-by
+	lines, and 'cccmd' will avoid running the --cc-cmd. 'body' is
+	equivalent to 'sob' + 'ccbody'. 'all' will suppress all auto cc
+	values.  Default is the value of 'sendemail.suppresscc' configuration
+	value; if that is unspecified, default to 'self' if --suppress-from is
+	specified, as well as 'body' if --no-signed-off-cc is specified.
 
 --[no-]suppress-from::
 	If this is set, do not add the From: address to the cc: list.
diff --git a/git-send-email.perl b/git-send-email.perl
index 2a3e3e8..23a55e2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -68,7 +68,7 @@ git send-email [options] <file | directory | rev-list options >
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
-    --suppress-cc           <str>  * author, self, sob, cccmd, all.
+    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
     --[no-]signed-off-by-cc        * Send to Cc: and Signed-off-by:
                                      addresses. Default on.
     --[no-]suppress-from           * Send to self. Default off.
@@ -319,21 +319,28 @@ my(%suppress_cc);
 if (@suppress_cc) {
 	foreach my $entry (@suppress_cc) {
 		die "Unknown --suppress-cc field: '$entry'\n"
-			unless $entry =~ /^(all|cccmd|cc|author|self|sob)$/;
+			unless $entry =~ /^(all|cccmd|cc|author|self|sob|body|bodycc)$/;
 		$suppress_cc{$entry} = 1;
 	}
 }
 
 if ($suppress_cc{'all'}) {
-	foreach my $entry (qw (ccmd cc author self sob)) {
+	foreach my $entry (qw (ccmd cc author self sob body bodycc)) {
 		$suppress_cc{$entry} = 1;
 	}
 	delete $suppress_cc{'all'};
 }
 
+if ($suppress_cc{'sob'} && $suppress_cc{'bodycc'}) {
+	$suppress_cc{'body'} = 1;
+}
+
 # If explicit old-style ones are specified, they trump --suppress-cc.
 $suppress_cc{'self'} = $suppress_from if defined $suppress_from;
-$suppress_cc{'sob'} = !$signed_off_by_cc if defined $signed_off_by_cc;
+# For backwards compatibility, old-style --signed-off-by-cc suppresses
+# SOB and body Cc lines, whereas --supress-cc=sob suppresses just the SOB
+# line, but not the body Cc.
+$suppress_cc{'body'} = !$signed_off_by_cc if defined $signed_off_by_cc;
 
 # Debugging, print out the suppressions.
 if (0) {
@@ -1007,14 +1014,16 @@ foreach my $t (@files) {
 	# Now parse the message body
 	while(<F>) {
 		$message .=  $_;
+		next if $suppress_cc{'body'};
 		if (/^(Signed-off-by|Cc): (.*)$/i) {
-			next if ($suppress_cc{'sob'});
 			chomp;
-			my $c = $2;
+			my ($what, $c) = ($1, $2);
 			chomp $c;
+			next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
+			next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
 			next if ($c eq $sender and $suppress_cc{'self'});
 			push @cc, $c;
-			printf("(sob) Adding cc: %s from line '%s'\n",
+			printf("(body) Adding cc: %s from line '%s'\n",
 				$c, $_) unless $quiet;
 		}
 	}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index da54835..d7766f9 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -32,11 +32,11 @@ clean_fake_sendmail() {
 }
 
 test_expect_success 'Extract patches' '
-    patches=`git format-patch --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1`
+    patches=`git format-patch -s --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1`
 '
 
 test_expect_success 'Send patches' '
-     git send-email --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
+     git send-email --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
 '
 
 cat >expected <<\EOF
@@ -74,6 +74,7 @@ EOF
 test_expect_success 'Show all headers' '
 	git send-email \
 		--dry-run \
+		--suppress-cc=sob \
 		--from="Example <from@example.com>" \
 		--to=to@example.com \
 		--cc=cc@example.com \
@@ -195,6 +196,7 @@ test_expect_success 'sendemail.cc set' '
 	git config sendemail.cc cc@example.com &&
 	git send-email \
 		--dry-run \
+		--suppress-cc=sob \
 		--from="Example <from@example.com>" \
 		--to=to@example.com \
 		--smtp-server relay.example.com \
@@ -230,6 +232,38 @@ test_expect_success 'sendemail.cc unset' '
 	git config --unset sendemail.cc &&
 	git send-email \
 		--dry-run \
+		--suppress-cc=sob \
+		--from="Example <from@example.com>" \
+		--to=to@example.com \
+		--smtp-server relay.example.com \
+		$patches |
+	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
+		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
+		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
+		>actual-show-all-headers &&
+	test_cmp expected-show-all-headers actual-show-all-headers
+'
+
+cat >expected-show-all-headers <<\EOF
+0001-Second.patch
+Dry-OK. Log says:
+Server: relay.example.com
+MAIL FROM:<from@example.com>
+RCPT TO:<to@example.com>
+From: Example <from@example.com>
+To: to@example.com
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+
+Result: OK
+EOF
+
+test_expect_success '--suppress-cc=all' '
+	git send-email \
+		--dry-run \
+		--suppress-cc=all \
 		--from="Example <from@example.com>" \
 		--to=to@example.com \
 		--smtp-server relay.example.com \
-- 
1.6.2.rc0.238.g0c1fe
