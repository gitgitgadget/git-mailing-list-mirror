From: Allen Hubbe <allenbh@gmail.com>
Subject: [PATCH v6] send-email: Add sendmail email aliases format
Date: Tue, 26 May 2015 17:32:03 -0400
Message-ID: <950e3a77f09d62f77c9a40c843284b3686bdb7b0.1432675817.git.allenbh@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Allen Hubbe <allenbh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 23:32:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMSe-000552-Nb
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 23:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbbEZVcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 17:32:17 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:33731 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbbEZVcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 17:32:16 -0400
Received: by yhcb70 with SMTP id b70so34549512yhc.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 14:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2ZhhyAtnL1cVjnzk0QrcjVCNsmwLMulA8BUdON13csU=;
        b=syPqyyBZPfWcqKH9fgxV/ijf8HBKCMc3iSaEQITAjRJjjCw0tEYg8TLL78MyppUyTV
         Ggo2faBc0j83Lr355k3heq2ah59bpv+mjI7W1RfXeQOZZhrwVy2FyHM5EpgLMqDpS6jv
         2diTAlHXV+odb5N62bnSLTJllzzUpGZJFS62kyrkAAaeKowj5XnKmNYY02FpDSgqZACc
         MOAO2yGMsxuKRcJ2PfM/H1/SKN+VSwv4RNk09gG2o6m1CN5w1KzVGPPbmlBU7KTiogbm
         fAe41v6d+QoMl/xZSxKP9V6HO/R8x7Q6r0hLEdbp7QxNg9dEC5jFYTganwbWRl4oYGUp
         oYKg==
X-Received: by 10.236.220.197 with SMTP id o65mr25662021yhp.196.1432675936062;
        Tue, 26 May 2015 14:32:16 -0700 (PDT)
Received: from localhost.localdomain (cpe-65-190-128-155.nc.res.rr.com. [65.190.128.155])
        by mx.google.com with ESMTPSA id f75sm12410256yha.7.2015.05.26.14.32.13
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 26 May 2015 14:32:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.218.g49e9a95.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269977>

Add support for the sendmail email aliases format.

Synopsis:

	<alias>: <address|alias>[, <address|alias>...]

Example:

	alice: Alice W Land <awol@example.com>
	bob: Robert Bobbyton <bob@example.com>
	# this is a comment
	   # this is also a comment
	chloe: chloe@example.com
	abgroup: alice, bob
	bcgrp: bob, chloe, Other <o@example.com>

Quoted aliases and quoted addresses are not supported.

Line continuations are not supported.

Warnings are printed for explicitly unsupported constructs, and any
other lines that are not matched by the parser.

Signed-off-by: Allen Hubbe <allenbh@gmail.com>
---

Notes:
    This v6 makes the following changes from v5:
    
    * In the documentation:
    ** Move 'sendmail' to the end of the list of formats.
    ** Remove the description, synopsis, and example of sendmail aliases.
    ** Specify exceptions to the sendmail format as a sub-definition.
    ** Note: A general 'where to find documentation' paragraph will be added
       by Junio, appearing either before or after this patch in the series.
    * Changes to the parser:
    ** Reword a comment to mention blank lines and comment lines.
    ** Resolve inconsistent use of the keyword `next` by not using it.
    ** Use non-greedy quantifier in the capture group for the alias name.
    ** Use greedy quantifier in the capture group for email addresses.
    * Changes to the test case:
    ** Test alias input is written to the current dir, not the home dir.
    ** Note: A fix to other tests to eliminate the use of tilde for the home
       dir will be added by Junio, appearing either before or after this
       patch in the series.

 Documentation/git-send-email.txt | 13 ++++++++++++-
 git-send-email.perl              | 25 +++++++++++++++++++++++++
 t/t9001-send-email.sh            | 27 +++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 804554609def..36fd0b86353c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -383,7 +383,18 @@ sendemail.aliasesFile::
 
 sendemail.aliasFileType::
 	Format of the file(s) specified in sendemail.aliasesFile. Must be
-	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
+	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus', or 'sendmail'.
++
+--
+sendmail;;
+*	Quoted aliases and quoted addresses are not supported: lines that
+	contain a `"` symbol are ignored.
+*	Line continuations are not supported: lines that start with
+	whitespace characters, or end with a `\` symbol are ignored.
+*	Warnings are printed on the standard error output for any
+	explicitly unsupported constructs, and any other lines that are not
+	recognized by the parser.
+--
 
 sendemail.multiEdit::
 	If true (default), a single editor instance will be spawned to edit
diff --git a/git-send-email.perl b/git-send-email.perl
index e1e9b1460ced..6bedf745e72d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -516,6 +516,31 @@ my %parse_alias = (
 			  }
 		      } },
 
+	sendmail => sub { my $fh = shift; while (<$fh>) {
+		# ignore blank lines and comment lines
+		if (/^\s*(?:#.*)?$/) { }
+
+		# warn on lines that contain quotes
+		elsif (/"/) {
+			print STDERR "sendmail alias with quotes is not supported: $_\n";
+		}
+
+		# warn on lines that continue
+		elsif (/^\s|\\$/) {
+			print STDERR "sendmail continuation line is not supported: $_\n";
+		}
+
+		# recognize lines that look like an alias
+		elsif (/^(\S+?)\s*:\s*(.+)$/) {
+			my ($alias, $addr) = ($1, $2);
+			$aliases{$alias} = [ split_addrs($addr) ];
+		}
+
+		# warn on lines that are not recognized
+		else {
+			print STDERR "sendmail line is not recognized: $_\n";
+		}}},
+
 	gnus => sub { my $fh = shift; while (<$fh>) {
 		if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
 			$aliases{$1} = [ $2 ];
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 7be14a4e37f7..01c7ef4d9b67 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1549,6 +1549,33 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
 	grep "^!someone@example\.org!$" commandline1
 '
 
+test_expect_success $PREREQ 'sendemail.aliasfiletype=sendmail' '
+	clean_fake_sendmail && rm -fr outdir &&
+	git format-patch -1 -o outdir &&
+	cat >>.tmp-email-aliases <<-\EOF &&
+	alice: Alice W Land <awol@example.com>
+	bob: Robert Bobbyton <bob@example.com>
+	# this is a comment
+	   # this is also a comment
+	chloe: chloe@example.com
+	abgroup: alice, bob
+	bcgrp: bob, chloe, Other <o@example.com>
+	EOF
+	git config --replace-all sendemail.aliasesfile \
+		"$(pwd)/.tmp-email-aliases" &&
+	git config sendemail.aliasfiletype sendmail &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=alice --to=bcgrp \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		outdir/0001-*.patch \
+		2>errors >out &&
+	grep "^!awol@example\.com!$" commandline1 &&
+	grep "^!bob@example\.com!$" commandline1 &&
+	grep "^!chloe@example\.com!$" commandline1 &&
+	grep "^!o@example\.com!$" commandline1
+'
+
 do_xmailer_test () {
 	expected=$1 params=$2 &&
 	git format-patch -1 &&
-- 
2.3.4
