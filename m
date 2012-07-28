From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 6/7] Switch path canonicalization to use the SVN API.
Date: Sat, 28 Jul 2012 02:38:31 -0700
Message-ID: <1343468312-72024-7-git-send-email-schwern@pobox.com>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:39:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3Uz-0007ho-Hg
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab2G1Jjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:39:37 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50635 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab2G1JjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:39:01 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6493452pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+8Y7UPZhiXZoKzwvbknNcF3nM2HBUNjV7dPmwGE4lkg=;
        b=Ir+nWX0PjTULCpKymv6/PtqS3oakReZGB7PB0IwQC7N9UdfPATWQLObsWskuqb6sec
         uJjj5x3R+ehvJc/jw3Dja52M99cKwG4fSBWyUqbxjlwQhGNbQ5n2EiDXCAnPwr1BoKwC
         vuEvMssujIbJ91p+qY//O4xy9BH88fdE47iORpgu7wIW0zsgVqK0pY6d0f1GyDcUgtCI
         sM/8VU94Uk9udZSyxg9B6jPY5JQpjE0qqbOe5QTs14BLMCS8WexRmjwzKhfyhYRVN/TD
         UNN/UChOqkKAnNMfZEumdZs/lYZgLeMZuLMMTndsTwDkSSp1Ywhs70mvTD9tuQKSfbOT
         AVHQ==
Received: by 10.68.221.38 with SMTP id qb6mr19915283pbc.144.1343468341148;
        Sat, 28 Jul 2012 02:39:01 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id rs4sm3689907pbc.0.2012.07.28.02.39.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:39:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468312-72024-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202412>

From: "Michael G. Schwern" <schwern@pobox.com>

All tests pass with SVN 1.6.  SVN 1.7 remains broken, not worrying
about it yet.

SVN changed its path canonicalization API between 1.6 and 1.7.
http://svnbook.red-bean.com/en/1.6/svn.developer.usingapi.html#svn.developer.usingapi.urlpath
http://svnbook.red-bean.com/en/1.7/svn.developer.usingapi.html#svn.developer.usingapi.urlpath

The SVN API does not accept foo/.. but it also doesn't canonicalize
it.  We have to do it ourselves.
---
 perl/Git/SVN/Utils.pm | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
index 6c8ae53..7ae6fac 100644
--- a/perl/Git/SVN/Utils.pm
+++ b/perl/Git/SVN/Utils.pm
@@ -86,6 +86,27 @@ sub _collapse_dotdot {
 
 
 sub canonicalize_path {
+	my $path = shift;
+
+	# The 1.7 way to do it
+	if ( defined &SVN::_Core::svn_dirent_canonicalize ) {
+		$path = _collapse_dotdot($path);
+		return SVN::_Core::svn_dirent_canonicalize($path);
+	}
+	# The 1.6 way to do it
+	elsif ( defined &SVN::_Core::svn_path_canonicalize ) {
+		$path = _collapse_dotdot($path);
+		return SVN::_Core::svn_path_canonicalize($path);
+	}
+	# No SVN API canonicalization is available, do it ourselves
+	else {
+		$path = _canonicalize_path_ourselves($path);
+		return $path;
+	}
+}
+
+
+sub _canonicalize_path_ourselves {
 	my ($path) = @_;
 	my $dot_slash_added = 0;
 	if (substr($path, 0, 1) ne "/") {
-- 
1.7.11.3
