From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 8b/16] engine.pl: ignore invalidcontinue.obj which is known to MSVC
Date: Mon, 20 Jul 2015 23:54:05 +0100
Message-ID: <1437432846-5796-2-git-send-email-philipoakley@iee.org>
References: <1437432846-5796-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 00:53:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHJwC-00086Q-8g
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 00:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325AbbGTWxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 18:53:19 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:8931 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756483AbbGTWxR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2015 18:53:17 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AZBgA7e61VPHMBFlxcgkFSVGmGUIFZs0QJgW2GAwQCAoEvORQBAQEBAQEBBgEBAQFAAT+EJAEBBFYjEAhJOQoGDgYTiDLJOQErkFIHhCsFlFKEb4k7ln6BCYMaPTGCSwEBAQ
X-IPAS-Result: A2AZBgA7e61VPHMBFlxcgkFSVGmGUIFZs0QJgW2GAwQCAoEvORQBAQEBAQEBBgEBAQFAAT+EJAEBBFYjEAhJOQoGDgYTiDLJOQErkFIHhCsFlFKEb4k7ln6BCYMaPTGCSwEBAQ
X-IronPort-AV: E=Sophos;i="5.15,510,1432594800"; 
   d="scan'208";a="39174026"
Received: from host-92-22-1-115.as13285.net (HELO localhost) ([92.22.1.115])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 20 Jul 2015 23:53:17 +0100
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1437432846-5796-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274358>

Commit 4b623d8 (MSVC: link in invalidcontinue.obj for better
POSIX compatibility, 2014-03-29) introduced invalidcontinue.obj
into the Makefile output, which was not parsed correctly by the
buildsystem. Ignore it, as it is known to Visual Studio and,
there is no matching source file.

Only substitute filenames ending with .o when generating the
source .c filename, otherwise a .cbj file may be expected.

Split the .o and .obj processing; 'make' does not produce .obj
files.

In the future there may be source files that produce .obj files
so keep the two issues (.obj files with & without source files)
separate.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 60c7a7d..9db3d43 100755
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
             die "Unhandled link option @ line $lineno: $part";
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
2.3.1
