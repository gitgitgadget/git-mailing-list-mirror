From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 3/5] engine.pl: ignore invalidcontinue.obj which is known to MSVC
Date: Wed, 24 Dec 2014 10:47:12 +0000
Message-ID: <1419418034-6276-4-git-send-email-philipoakley@iee.org>
References: <1419418034-6276-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Msysgit <msysgit@googlegroups.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 11:47:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3jTX-0004aY-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 11:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbaLXKrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 05:47:23 -0500
Received: from b216.a.smtp2go.com ([216.22.18.216]:52960 "EHLO
	b216.a.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbaLXKrV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 05:47:21 -0500
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1419418034-6276-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261804>

Commit 4b623d8 (MSVC: link in invalidcontinue.obj for better
POSIX compatibility, 2014-03-29) is not processed correctly
by the buildsystem. Ignore it.

Also split the .o and .obj processing; 'make' does not produce .obj
files. Only substitute filenames ending with .o when generating the
source .c filename.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 7f45b80..e913280 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -289,7 +289,7 @@ sub handleLibLine
 #    exit(1);
     foreach (@objfiles) {
         my $sourcefile = $_;
-        $sourcefile =~ s/\.o/.c/;
+        $sourcefile =~ s/\.o$/.c/;
         push(@sources, $sourcefile);
         push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
         push(@defines, @{$compile_options{"${sourcefile}_DEFINES"}});
@@ -333,8 +333,12 @@ sub handleLinkLine
         } elsif ($part =~ /\.(a|lib)$/) {
             $part =~ s/\.a$/.lib/;
             push(@libs, $part);
-        } elsif ($part =~ /\.(o|obj)$/) {
+        } elsif ($part eq 'invalidcontinue.obj') {
+            # ignore - known to MSVC
+        } elsif ($part =~ /\.o$/) {
             push(@objfiles, $part);
+        } elsif ($part =~ /\.obj$/) {
+            # do nothing, 'make' should not be producing .obj, only .o files
         } else {
             die "Unhandled lib option @ line $lineno: $part";
         }
@@ -343,7 +347,7 @@ sub handleLinkLine
 #    exit(1);
     foreach (@objfiles) {
         my $sourcefile = $_;
-        $sourcefile =~ s/\.o/.c/;
+        $sourcefile =~ s/\.o$/.c/;
         push(@sources, $sourcefile);
         push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
         push(@defines, @{$compile_options{"${sourcefile}_DEFINES"}});
-- 
2.1.0
