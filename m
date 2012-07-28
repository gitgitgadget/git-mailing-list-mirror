From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 7/7] Make Git::SVN and Git::SVN::Ra canonicalize paths and urls.
Date: Sat, 28 Jul 2012 02:38:32 -0700
Message-ID: <1343468312-72024-8-git-send-email-schwern@pobox.com>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:39:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3V0-0007ho-2C
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab2G1Jji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:39:38 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50635 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab2G1JjC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:39:02 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6493452pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=gHbPmX4xKdAzZqRKaJYABi+JM+kJPsSaOIVyeqSl6uc=;
        b=RbXVT2Ylim+lg6foW7dX0//w7nkcddinwZKqtHAN4zskejaBEu5uDAapaiAGLNYnV6
         AhpjjAU+/1MyKWptIS0JtGJ54fmJNa0XUkr8zZ4Y/KGRO263278FV81gM+DUvCWJ05PK
         ofxRuC6Qeq96kvQrUFi66594XowsQXsfETjuDgPu+SgZ/NHxo/e5Bmoz3pkNDwTlhU8E
         iAqCdp79ADrA4pbXhBmmIzMoDtsPeH88moXHsHO2eEnLmnKZkXLJU4iz1B6Kf0dDFQcN
         FO8m9kcTj6VaQAWy58Y+RT9ci3V4usqlSf/zqTG/7zQimLNqS2ICgpPyYP3jvc8jPS8N
         C3xw==
Received: by 10.68.194.6 with SMTP id hs6mr20294566pbc.133.1343468342117;
        Sat, 28 Jul 2012 02:39:02 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id rs4sm3689907pbc.0.2012.07.28.02.39.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:39:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468312-72024-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202413>

From: "Michael G. Schwern" <schwern@pobox.com>

This canonicalizes paths and urls as early as possible so we don't
have to remember to do it at the point of use.  It will fix a swath
of SVN 1.7 problems in one go.

Its ok to double canonicalize things.

SVN 1.7 still fails, still not worrying about that.
---
 perl/Git/SVN.pm    | 6 ++++--
 perl/Git/SVN/Ra.pm | 6 +++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index b0ed3ea..798f6c4 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -27,6 +27,8 @@ use Git::SVN::Utils qw(
 	fatal
 	can_compress
 	join_paths
+	canonicalize_path
+	canonicalize_url
 );
 
 my $can_use_yaml;
@@ -2305,7 +2307,7 @@ sub path {
 
     if( @_ ) {
         my $path = shift;
-        $self->{path} = $path;
+        $self->{path} = canonicalize_path($path);
         return;
     }
 
@@ -2318,7 +2320,7 @@ sub url {
 
     if( @_ ) {
         my $url = shift;
-        $self->{url} = $url;
+        $self->{url} = canonicalize_url($url);
         return;
     }
 
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 27dcdd5..ef7b3dd 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -3,6 +3,10 @@ use vars qw/@ISA $config_dir $_ignore_refs_regex $_log_window_size/;
 use strict;
 use warnings;
 use SVN::Client;
+use Git::SVN::Utils qw(
+	canonicalize_url
+);
+
 use SVN::Ra;
 BEGIN {
 	@ISA = qw(SVN::Ra);
@@ -138,7 +142,7 @@ sub url {
 
     if( @_ ) {
         my $url = shift;
-        $self->{url} = $url;
+        $self->{url} = canonicalize_url($url);
         return;
     }
 
-- 
1.7.11.3
