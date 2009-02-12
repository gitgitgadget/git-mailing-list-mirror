From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: fix wrong base URL when non-root DirectoryIndex
Date: Thu, 12 Feb 2009 22:11:12 +0100
Message-ID: <1234473072-9901-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <oblomov@rbot.ratry.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 22:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXir5-0002k7-Tb
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbZBLVKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbZBLVKw
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:10:52 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:34307 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZBLVKv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:10:51 -0500
Received: by fxm13 with SMTP id 13so2700094fxm.13
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 13:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=plyZABIUG4uX50ngaDTaHVLhmAEDe9GMYhn4Oa8x+O4=;
        b=WIxTe/uzZjHELFS5qL/qsHXVchSE89Wa7/RNYNG6/S77tY31Xf6Y9xofTyNoz/HpOh
         dIq64kFf1Ad4IUI1iiK2crZz/DzTkkCMNFHjZBblGC/vONikwnY9vQwPTCg235whqP41
         mLq+0pZJ41q8B2SjLsMhUK6ny6I1CjM3Xfxrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=cDENrHNJPVj0TBM6ofpbHg08QxK7jcDOrCo7gJm3pyPeDrtFN753/x0+LBqroyzg/0
         8gh2EgT5NWD748q4p3pVtjxvQS/IL+BKkYWXIcGODmOTWLntdVAykSIeZHUCzuT5opHn
         6zLQwW7ztv5vxpJK+SxvlTe/FndfMgS4Wxqgk=
Received: by 10.103.93.18 with SMTP id v18mr665980mul.43.1234473049611;
        Thu, 12 Feb 2009 13:10:49 -0800 (PST)
Received: from localhost (host-78-13-54-17.cust-adsl.tiscali.it [78.13.54.17])
        by mx.google.com with ESMTPS id j10sm844932muh.1.2009.02.12.13.10.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Feb 2009 13:10:49 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109655>

From: Giuseppe Bilotta <oblomov@rbot.ratry.ru>

CGI::url() has some issues when rebuilding the script URL if the script
is a DirectoryIndex.

One of these issue is the inability to strip PATH_INFO, which is why we
had to do it ourselves.

Another issue is that the resulting URL cannot be used for the <base>
tag: it works if we're the DirectoryIndex at the root level, but not
otherwise.

We fix this by building the proper base URL ourselves, and improve the
documentation about the need to strip PATH_INFO manually while we're at
it.
---
 gitweb/gitweb.perl |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c2c8080..48cfd5f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -27,15 +27,23 @@ our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 
-# if we're called with PATH_INFO, we have to strip that
-# from the URL to find our real URL
-# we make $path_info global because it's also used later on
+# When the script is used as DirectoryIndex, the URL does not contain the name
+# of the script file itself, and $cgi->url() fails to strip PATH_INFO, so we
+# have to do it ourselves. We make $path_info global because it's also used
+# later on
 our $path_info = $ENV{"PATH_INFO"};
 if ($path_info) {
 	$my_url =~ s,\Q$path_info\E$,,;
 	$my_uri =~ s,\Q$path_info\E$,,;
 }
 
+# Another issue with the script being the DirectoryIndex is that the resulting
+# $my_url data is not the full script URL: this is good, because we want
+# generated links to keep implying the script name if it wasn't explicitly
+# indicated in the URL we're handling, but it means that $my_url cannot be used
+# as base URL. Therefore, we have to build the base URL ourselves:
+our $base_url = $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};
+
 # core git executable to use
 # this can just be "git" if your webserver has a sensible PATH
 our $GIT = "++GIT_BINDIR++/git";
@@ -2908,7 +2916,7 @@ EOF
 	# the stylesheet, favicon etc urls won't work correctly with path_info
 	# unless we set the appropriate base URL
 	if ($ENV{'PATH_INFO'}) {
-		print "<base href=\"".esc_url($my_url)."\" />\n";
+		print "<base href=\"".esc_url($base_url)."\" />\n";
 	}
 	# print out each stylesheet that exist, providing backwards capability
 	# for those people who defined $stylesheet in a config file
-- 
1.5.6.4
