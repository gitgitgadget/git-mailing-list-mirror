From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 2/7] Change canonicalize_url() to use the SVN 1.7 API when available.
Date: Sat, 28 Jul 2012 02:38:27 -0700
Message-ID: <1343468312-72024-3-git-send-email-schwern@pobox.com>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:40:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3VD-0007qw-0H
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab2G1Jjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:39:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50635 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab2G1Ji5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:38:57 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6493452pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=JCqfql+U3oeFo1qcV7TZQKzDB1WXoPCet+ONwNV38Dw=;
        b=QrbSDaCiHnBySEqPIorcM+rocpFGD1nkWmLcKnHOV1OVG3UauN9LkDwdQ706odsCyG
         wnybeprzmnYRva29gEI09g9xpg+Qj5KPBdTT0kipmRjqSk4M7RJs58TOf2tiOkpItxXK
         2jA6+2kL8eL5I7iTmCmyuQyHzQe7MNsunXa/as4rJVA8yWLXXvLyC6qG2sdwkwUy/H9S
         C7572oekffNHqM8lBSwZoie8AWPDUOtD64ypijdZQjWSANhpJw4iBgQ+t5RUopZKbRsu
         IntOwR3d9YXC8i8bUmc2ybsWIYrpqHTX042QKnSyq6rTGGLi6AqTq5LivbTVEA4TO+kk
         tqBg==
Received: by 10.66.84.202 with SMTP id b10mr10712095paz.72.1343468336901;
        Sat, 28 Jul 2012 02:38:56 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id rs4sm3689907pbc.0.2012.07.28.02.38.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:38:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468312-72024-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202418>

From: "Michael G. Schwern" <schwern@pobox.com>

No change on SVN 1.6.  The tests all pass with SVN 1.6 if
canonicalize_url() does nothing, so tests passing doesn't have
much meaning.

The tests are so messed up right now with SVN 1.7 it isn't really
useful to check.  They will be useful later.
---
 perl/Git/SVN/Utils.pm | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
index c842d00..9d5d3c5 100644
--- a/perl/Git/SVN/Utils.pm
+++ b/perl/Git/SVN/Utils.pm
@@ -3,6 +3,8 @@ package Git::SVN::Utils;
 use strict;
 use warnings;
 
+use SVN::Core;
+
 use base qw(Exporter);
 
 our @EXPORT_OK = qw(
@@ -100,6 +102,20 @@ API as a URL.
 =cut
 
 sub canonicalize_url {
+	my $url = shift;
+
+	# The 1.7 way to do it
+	if ( defined &SVN::_Core::svn_uri_canonicalize ) {
+		return SVN::_Core::svn_uri_canonicalize($url);
+	}
+	# There wasn't a 1.6 way to do it, so we do it ourself.
+	else {
+		return _canonicalize_url_ourselves($url);
+	}
+}
+
+
+sub _canonicalize_url_ourselves {
 	my ($url) = @_;
 	$url =~ s#^([^:]+://[^/]*/)(.*)$#$1 . canonicalize_path($2)#e;
 	return $url;
-- 
1.7.11.3
