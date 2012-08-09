From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] gitweb: URL-decode $my_url/$my_uri when stripping PATH_INFO
Date: Wed,  8 Aug 2012 22:29:26 -0400
Message-ID: <1344479366-8957-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 04:30:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzIVm-0003rH-JD
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 04:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470Ab2HICaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 22:30:03 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52738 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab2HICaC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 22:30:02 -0400
Received: by yenl2 with SMTP id l2so1538616yen.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 19:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=rHyN1VocRuvwkZXXWFcSkykxTcZpE+nO8FLVFwWDcdg=;
        b=XL1Gt55URvzc/DtJwSwaCJxzp31I79Vf3KdJ3OGDH4oFV3JYurBr0za23ZJ/Q3kTGZ
         GyvLzA7vpXkNp7yxH7OZviQp0ddyosZjssIyZTcSpLZMNNtm9+KQU+zeP9dBlXXcfjhL
         /EomvD7CkCPeY6rq4xPT+/BVDMIJe8B54Nlj9bXaI+9slkmmSbIPuobZFl6JPDRhcegR
         DVkvT5CtpzlPEm8v9xNE6aTnIniuEqnyhNRJNA/dVHE4HfuM2+zsLM2GqVkLVZmnqYdL
         daOa/fhm7P2Om2+5LV8gjycM0RexVKWGs2yKra/QcHZBXzdDoe/JU4KuilF5Z5FgTglT
         uVaw==
Received: by 10.236.136.39 with SMTP id v27mr2599588yhi.96.1344479401403;
        Wed, 08 Aug 2012 19:30:01 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id o5sm21059424anm.17.2012.08.08.19.30.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Aug 2012 19:30:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203145>

When gitweb is used as a DirectoryIndex, it attempts to strip
PATH_INFO on its own, as $cgi->url() fails to do so.

However, it fails to account for the fact that PATH_INFO has
already been URL-decoded by the web server, but the value
returned by $cgi->url() has not been. This causes the stripping
to fail whenever the URL contains encoded characters.

To see this in action, setup gitweb as a DirectoryIndex and
then use it on a repository with a directory containing a
space in the name. Navigate to tree view, examine the gitweb
generated html and you'll see a link such as:

  <a href="/test.git/tree/HEAD:/directory with spaces">directory with spaces</a>

When clicked on, the browser will URL-encode this link, giving
a $cgi->url() of the form:

   /test.git/tree/HEAD:/directory%20with%20spaces

While PATH_INFO is:

   /test.git/tree/HEAD:/directory with spaces

Fix this by calling unescape() on both $my_url and $my_uri before
stripping PATH_INFO from them.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 gitweb/gitweb.perl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3d6a705388..7f8c1878d4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -54,6 +54,11 @@ sub evaluate_uri {
 	# to build the base URL ourselves:
 	our $path_info = decode_utf8($ENV{"PATH_INFO"});
 	if ($path_info) {
+		# $path_info has already been URL-decoded by the web server, but
+		# $my_url and $my_uri have not. URL-decode them so we can properly
+		# strip $path_info.
+		$my_url = unescape($my_url);
+		$my_uri = unescape($my_uri);
 		if ($my_url =~ s,\Q$path_info\E$,, &&
 		    $my_uri =~ s,\Q$path_info\E$,, &&
 		    defined $ENV{'SCRIPT_NAME'}) {
-- 
1.7.11.3
