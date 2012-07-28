From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 1/7] Move the canonicalization functions to Git::SVN::Utils
Date: Sat, 28 Jul 2012 02:38:26 -0700
Message-ID: <1343468312-72024-2-git-send-email-schwern@pobox.com>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:40:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3VC-0007qw-Bl
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab2G1Jje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:39:34 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50635 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab2G1Ji4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:38:56 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6493452pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=jLKldBMyoo4y+y5KnELg2uQWGj+AK05y6ZSrKj9KE6A=;
        b=df1m0UT1v34rPfxzf9/fSXiTaWI1bQS72djiUd7gPgBotGhnwVNwaryG9jD+Ix9KeV
         OSLG65f4/8/J3Aw3HegTsm/2xS/6k3GumSAaUfckgrU8UhhEHI/MiPqAygruk8Y8kL/s
         Xsh7uk+TPNaq8pHVjsn2yd6mVB2U4vUkPRTX8RBL/uUAf/8FkUIwHUb7hvv5PEQefYFI
         BsEa6aYzX2Yk+dmk0Kswpvlpa92PRdRzf8fZ9GDZBa1DEegY/BPza0cVdtHrfb4hcCPY
         ew5GuW+bE5NYEuHgtGGC3qwldHoNCqZ34OPLjgBspkW74MSlmR5gkMhYNYZUF3dCAxDo
         T4LQ==
Received: by 10.68.222.40 with SMTP id qj8mr19935669pbc.139.1343468335951;
        Sat, 28 Jul 2012 02:38:55 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id rs4sm3689907pbc.0.2012.07.28.02.38.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:38:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468312-72024-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202417>

From: "Michael G. Schwern" <schwern@pobox.com>

So they can be used by others.

I'd like to test them, but they're going to become SVN API wrappers shortly
and those aren't predictable.

No functional change.
---
 git-svn.perl          | 33 +++++++-------------------------
 perl/Git/SVN/Utils.pm | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 27 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index de1ddd1..a857484 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -29,7 +29,13 @@ use Git::SVN::Prompt;
 use Git::SVN::Log;
 use Git::SVN::Migration;
 
-use Git::SVN::Utils qw(fatal can_compress);
+use Git::SVN::Utils qw(
+	fatal
+	can_compress
+	canonicalize_path
+	canonicalize_url
+);
+
 use Git qw(
 	git_cmd_try
 	command
@@ -1256,31 +1262,6 @@ sub cmd_mkdirs {
 	$gs->mkemptydirs($_revision);
 }
 
-sub canonicalize_path {
-	my ($path) = @_;
-	my $dot_slash_added = 0;
-	if (substr($path, 0, 1) ne "/") {
-		$path = "./" . $path;
-		$dot_slash_added = 1;
-	}
-	# File::Spec->canonpath doesn't collapse x/../y into y (for a
-	# good reason), so let's do this manually.
-	$path =~ s#/+#/#g;
-	$path =~ s#/\.(?:/|$)#/#g;
-	$path =~ s#/[^/]+/\.\.##g;
-	$path =~ s#/$##g;
-	$path =~ s#^\./## if $dot_slash_added;
-	$path =~ s#^/##;
-	$path =~ s#^\.$##;
-	return $path;
-}
-
-sub canonicalize_url {
-	my ($url) = @_;
-	$url =~ s#^([^:]+://[^/]*/)(.*)$#$1 . canonicalize_path($2)#e;
-	return $url;
-}
-
 # get_svnprops(PATH)
 # ------------------
 # Helper for cmd_propget and cmd_proplist below.
diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
index 3d0bfa4..c842d00 100644
--- a/perl/Git/SVN/Utils.pm
+++ b/perl/Git/SVN/Utils.pm
@@ -5,7 +5,12 @@ use warnings;
 
 use base qw(Exporter);
 
-our @EXPORT_OK = qw(fatal can_compress);
+our @EXPORT_OK = qw(
+	fatal
+	can_compress
+	canonicalize_path
+	canonicalize_url
+);
 
 
 =head1 NAME
@@ -56,4 +61,49 @@ sub can_compress {
 }
 
 
+=head3 canonicalize_path
+
+    my $canoncalized_path = canonicalize_path($path);
+
+Converts $path into a canonical form which is safe to pass to the SVN
+API as a file path.
+
+=cut
+
+sub canonicalize_path {
+	my ($path) = @_;
+	my $dot_slash_added = 0;
+	if (substr($path, 0, 1) ne "/") {
+		$path = "./" . $path;
+		$dot_slash_added = 1;
+	}
+	# File::Spec->canonpath doesn't collapse x/../y into y (for a
+	# good reason), so let's do this manually.
+	$path =~ s#/+#/#g;
+	$path =~ s#/\.(?:/|$)#/#g;
+	$path =~ s#/[^/]+/\.\.##g;
+	$path =~ s#/$##g;
+	$path =~ s#^\./## if $dot_slash_added;
+	$path =~ s#^/##;
+	$path =~ s#^\.$##;
+	return $path;
+}
+
+
+=head3 canonicalize_url
+
+    my $canonicalized_url = canonicalize_url($url);
+
+Converts $url into a canonical form which is safe to pass to the SVN
+API as a URL.
+
+=cut
+
+sub canonicalize_url {
+	my ($url) = @_;
+	$url =~ s#^([^:]+://[^/]*/)(.*)$#$1 . canonicalize_path($2)#e;
+	return $url;
+}
+
+
 1;
-- 
1.7.11.3
