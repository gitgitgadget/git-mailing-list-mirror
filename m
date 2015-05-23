From: Allen Hubbe <allenbh@gmail.com>
Subject: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Sat, 23 May 2015 09:21:27 -0400
Message-ID: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Allen Hubbe <allenbh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 15:21:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yw9Mx-0001kn-2B
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 15:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757862AbbEWNVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 09:21:35 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:32792 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757812AbbEWNVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 09:21:33 -0400
Received: by qkgv12 with SMTP id v12so33034898qkg.0
        for <git@vger.kernel.org>; Sat, 23 May 2015 06:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=igKJLdKAXdS/fYOjcrp1lYjfUK+ePQxCUTDz7YntR0c=;
        b=PDuAZzvb0N188bdROvubWaaM3Yp+inS7ET7NqfTLjBS/lEqsQOWm1X/yzv63z/a8Dv
         9AN4hut83Ki19YmCxu5WV4YLDMUYLk5teHDtgJ8xBz7YjSyMXXUNdJN5588qMJwPA9+H
         09ev2V3hkY8DjZMQU2rwm0qtOcEReBRW6FEBhCnzroTuETfVoyGrsnFanyVI493NL6fv
         5kdC9zUTe6S43SNAv6Dd52DAEQ/qoIiKqum1uMRVv4Xn7ZQbxud8QL6kvk/yxPF56hUQ
         CI/UfyQlT2HRuPdhPfYqAWpF3EqrtP7HuzE/UaIhxpW4CBkdYI44IYK7pyzo8x5ItmaZ
         CYfQ==
X-Received: by 10.140.32.38 with SMTP id g35mr16801406qgg.74.1432387293045;
        Sat, 23 May 2015 06:21:33 -0700 (PDT)
Received: from localhost.localdomain (cpe-65-190-128-155.nc.res.rr.com. [65.190.128.155])
        by mx.google.com with ESMTPSA id q16sm2552651qkq.4.2015.05.23.06.21.31
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 May 2015 06:21:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.218.gca5b38c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269802>

Note that this only adds support for a limited subset of the sendmail
format.  The format is is as follows.

	<alias>: <address|alias>[, <address|alias>...]

Aliases are specified one per line, and must start on the first column of the
line.  Blank lines are ignored.  If the first non whitespace character
on a line is a '#' symbol, then the whole line is considered a comment,
and is ignored.

Example:

	alice: Alice W Land <awol@example.com>
	bob: Robert Bobbyton <bob@example.com>
	# this is a comment
	   # this is also a comment
	chloe: chloe@example.com
	abgroup: alice, bob
	bcgrp: bob, chloe, Other <o@example.com>

Unlike the standard sendmail format, this does not support quoted
aliases or quoted addresses.  Line continuations are not supported.
Warnings are printed for explicitly unsupported constructs, and any
other lines that are not recognized.

Signed-off-by: Allen Hubbe <allenbh@gmail.com>
---

Notes:
    This v5 renames the parser 'sendmail' again, from 'simple'.
    Therefore, the subject line is changed again, too.
    
    Previous subject line: send-email: Add simple email aliases format
    
    The format is restricted to a subset of sendmail.  When the subset
    diverges from sendmail, the parser warns about the line that diverges,
    and ignores the line.  The supported format is described in the
    documentation, as well as the behavior when an unsupported format
    construct is detected.
    
    A badly constructed sentence was corrected in the documentation.
    
    The test case was changed to use a here document, and the unsupported
    comment after an alias was removed from the test case alias file input.

 Documentation/git-send-email.txt | 37 ++++++++++++++++++++++++++++++++++++-
 git-send-email.perl              | 29 +++++++++++++++++++++++++++++
 t/t9001-send-email.sh            | 27 +++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 804554609def..97387fd27a8d 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -383,7 +383,42 @@ sendemail.aliasesFile::
 
 sendemail.aliasFileType::
 	Format of the file(s) specified in sendemail.aliasesFile. Must be
-	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
+	one of 'sendmail', 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
++
+If the format is 'sendmail', then the alias file format is described below.
+Descriptions of the other file formats can be found by searching the
+documentation of the email program of the same name.
++
+The 'sendmail' format is is as follows.  Note that 'git-send-email' currently
+only supports a limited subset of the sendmail format.
++
+	<alias>: <address|alias>[, <address|alias>...]
++
+Aliases are specified one per line, and must start on the first column of the
+line.  Blank lines are ignored.  If the first non whitespace character on a
+line is a `#` symbol, then the whole line is considered a comment, and is
+ignored.
++
+Example of the 'sendmail' format:
++
+	alice: Alice W Land <awol@example.com>
+	bob: Robert Bobbyton <bob@example.com>
+	# this is a comment
+	   # this is also a comment
+	chloe: chloe@example.com
+	abgroup: alice, bob
+	bcgrp: bob, chloe, Other <o@example.com>
++
+Unlike the standard sendmail format, 'git-send-email' currently diverges in the
+following ways.
++
+*	Quoted aliases and quoted addresses are not supported: lines that
+	contain a `"` symbol are ignored.
+*	Line continuations are not supported: any lines that start with
+	whitespace, or end with a `\` symbol are ignored.
+*	Warnings are printed on the standard error output for any explicitly
+	unsupported constructs, and any other lines that are not recognized
+	by the parser.
 
 sendemail.multiEdit::
 	If true (default), a single editor instance will be spawned to edit
diff --git a/git-send-email.perl b/git-send-email.perl
index e1e9b1460ced..ffea50094a48 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -487,6 +487,8 @@ sub split_addrs {
 }
 
 my %aliases;
+
+
 my %parse_alias = (
 	# multiline formats can be supported in the future
 	mutt => sub { my $fh = shift; while (<$fh>) {
@@ -516,6 +518,33 @@ my %parse_alias = (
 			  }
 		      } },
 
+	sendmail => sub { my $fh = shift; while (<$fh>) {
+		# ignore comment lines
+		if (/^\s*(?:#.*)?$/) { }
+
+		# warn on lines that contain quotes
+		elsif (/"/) {
+			print STDERR "sendmail alias with quotes is not supported: $_\n";
+			next;
+		}
+
+		# warn on lines that continue
+		elsif (/^\s|\\$/) {
+			print STDERR "sendmail continuation line is not supported: $_\n";
+			next;
+		}
+
+		# recognize lines that look like an alias
+		elsif (/^(\S+)\s*:\s*(.+?)$/) {
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
index 7be14a4e37f7..b04d26364767 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1549,6 +1549,33 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
 	grep "^!someone@example\.org!$" commandline1
 '
 
+test_expect_success $PREREQ 'sendemail.aliasfiletype=sendmail' '
+	clean_fake_sendmail && rm -fr outdir &&
+	git format-patch -1 -o outdir &&
+	cat >>~/.tmp-email-aliases <<-\EOF &&
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
