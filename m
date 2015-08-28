From: Lyubomyr Shaydariv <dev.konsole@gmail.com>
Subject: [PATCH] git-remote-mediawiki: support subpages as subdirectories
Date: Fri, 28 Aug 2015 09:14:46 +0300
Message-ID: <1440742486-4356-1-git-send-email-lyubomyr-shaydariv@users.noreply.github.com>
Cc: Lyubomyr Shaydariv <lyubomyr-shaydariv@users.noreply.github.com>,
	Matthieu.Moy@imag.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 08:15:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVCwe-0003Cs-Nx
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 08:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbbH1GOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 02:14:55 -0400
Received: from mail-wi0-f196.google.com ([209.85.212.196]:34394 "EHLO
	mail-wi0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbH1GOy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 02:14:54 -0400
Received: by wibcx1 with SMTP id cx1so1784082wib.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 23:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RBgKGAgwzSmGw4RQqjAMB4BNkTPR7TWoDcTHe+h1m0s=;
        b=lLvFDK+KBpd0Jbtkzr6avpfYEQeCCCwKQ5nJMiEVidOeGmkavFSZoFlGzbv1uKqN6n
         7oFBKMZ+HNH/bAuxNuH7AnxlGRS/w7yH0S0DY34UrAVgnbl4n41TyosIhshF0/WmIyEG
         0I4Fihb+ELlFM6ZzVtKICTutD7ReK2Qx5IDiMWweQZx9lFBajuNcfKGkl8tVC3z4+9BC
         bDttB4aO7f/T6fCxGfa0QkVLWRXXKCbBHVDkm7MtFYOZqrzLJo6VQ985IYuuy9jpMVRQ
         0s3i3w0OAdCv7nQoJRsO+cUFH+0hfzKJ/HT5Vzn98bzWAafL+nuHySlXQGJTB5OWHIed
         Kw7g==
X-Received: by 10.194.59.20 with SMTP id v20mr8539231wjq.61.1440742493159;
        Thu, 27 Aug 2015 23:14:53 -0700 (PDT)
Received: from localhost ([194.44.30.25])
        by smtp.gmail.com with ESMTPSA id c3sm6402645wja.3.2015.08.27.23.14.52
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 27 Aug 2015 23:14:52 -0700 (PDT)
X-Google-Original-From: Lyubomyr Shaydariv <lyubomyr-shaydariv@users.noreply.github.com>
X-Mailer: git-send-email 1.8.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276706>

This is a fix for https://github.com/moy/Git-Mediawiki/issues/22
The subdirectories option is enabled using -c remote.origin.subpageDirs=true
during the cloning and it is not recommended to be modified in or
removed from .git/config after the cloning.

Signed-off-by: Lyubomyr Shaydariv <lyubomyr-shaydariv@users.noreply.github.com>
Reported-by: David Garcia Garzon
Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 8dd74a9..f3624be 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -63,6 +63,11 @@ chomp(@tracked_pages);
 my @tracked_categories = split(/[ \n]/, run_git("config --get-all remote.${remotename}.categories"));
 chomp(@tracked_categories);
 
+# Use subdirectories for subpages
+my $use_subpage_dirs = run_git("config --get --bool remote.${remotename}.subpageDirs");
+chomp($use_subpage_dirs);
+$use_subpage_dirs = ($use_subpage_dirs eq 'true');
+
 # Import media files on pull
 my $import_media = run_git("config --get --bool remote.${remotename}.mediaimport");
 chomp($import_media);
@@ -689,6 +694,9 @@ sub fe_escape_path {
     $path =~ s/\\/\\\\/g;
     $path =~ s/"/\\"/g;
     $path =~ s/\n/\\n/g;
+    if ($use_subpage_dirs) {
+        $path =~ s/%2F/\//g;
+    }
     return qq("${path}");
 }
 
@@ -927,7 +935,7 @@ sub mw_import_revids {
 		# If this is a revision of the media page for new version
 		# of a file do one common commit for both file and media page.
 		# Else do commit only for that page.
-		print {*STDERR} "${n}/", scalar(@{$revision_ids}), ": Revision #$rev->{revid} of $commit{title}\n";
+		print {*STDERR} "${n}/", scalar(@{$revision_ids}), ": Revision #$rev->{revid} of ", fe_escape_path($commit{title}), "\n";
 		import_file_revision(\%commit, ($fetch_from == 1), $n_actual, \%mediafile);
 	}
 
-- 
1.9.1
