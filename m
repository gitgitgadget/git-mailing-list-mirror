From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] git svn: canonicalize_url(): use svn_path_canonicalize
 when available
Date: Sun, 14 Oct 2012 04:48:57 -0700
Message-ID: <20121014114857.GB21106@elie.Belkin>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-3-git-send-email-schwern@pobox.com>
 <20120728135018.GB9715@burratino>
 <50143700.80900@pobox.com>
 <20121014114234.GA18127@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Oct 14 13:49:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNMh6-0006Zy-41
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 13:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab2JNLtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 07:49:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50034 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab2JNLtG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 07:49:06 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4135302pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 04:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZGelBE/MNC5OUvzrVGZO6nM4D8BTV0JtMY9/OEP7TJg=;
        b=fVfaD6ijy66Pei773iaxnj1to3HAc6FIeAmSEq6UFmt0MOkiSID7oOsOYyv0oW2cWM
         OtlaBVwzVfi6NiWAY4W3CGCze78fEifby1MM6phjKjX9FBogzbX1+m2hjih3cD0m6TbK
         20GKlnDdUV4Ls2y6nOzmWcCq2+CL+6Go7dRKrUXxsoWFYv3IlM7N+51DYZlX+29TMMJl
         ws3G9nqQte3LwQDNNiMN94xzQT28JdcOTa8X0QGDiilf0gaZRydOdVK4PeBOVnKeciIX
         x3g2Op2AH94KOL2Z4e4al5r89bq0/ibC8TIASh5n2A9QGCH+gFluCLpcbM5ZbWrzrf9w
         kRaw==
Received: by 10.68.138.163 with SMTP id qr3mr28556884pbb.161.1350215345396;
        Sun, 14 Oct 2012 04:49:05 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id ho7sm7394953pbc.3.2012.10.14.04.49.04
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 04:49:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121014114234.GA18127@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207655>

Until Subversion 1.7 (more precisely r873487), the standard way to
canonicalize a URI was to call svn_path_canonicalize().  Use it.

This saves "git svn" from having to rely on our imperfect
reimplementation of the same.  If the function doesn't exist or
returns undef, though, it can use the fallback code, which we keep to
be conservative.  Since svn_path_canonicalize() was added before
Subversion 1.1, hopefully that doesn't happen often.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 perl/Git/SVN/Utils.pm | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
index 3d1a0933..40f7c799 100644
--- a/perl/Git/SVN/Utils.pm
+++ b/perl/Git/SVN/Utils.pm
@@ -138,15 +138,19 @@ API as a URL.
 
 sub canonicalize_url {
 	my $url = shift;
+	my $rv;
 
 	# The 1.7 way to do it
 	if ( defined &SVN::_Core::svn_uri_canonicalize ) {
-		return SVN::_Core::svn_uri_canonicalize($url);
+		$rv = SVN::_Core::svn_uri_canonicalize($url);
 	}
-	# There wasn't a 1.6 way to do it, so we do it ourself.
-	else {
-		return _canonicalize_url_ourselves($url);
+	# The 1.6 way to do it
+	elsif ( defined &SVN::_Core::svn_path_canonicalize ) {
+		$rv = SVN::_Core::svn_path_canonicalize($url);
 	}
+	return $rv if defined $rv;
+
+	return _canonicalize_url_ourselves($url);
 }
 
 
-- 
1.8.0.rc2
