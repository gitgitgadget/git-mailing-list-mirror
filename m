From: Aleksey Vasenev <margtu-fivt@ya.ru>
Subject: [PATCH] git-svn: Support svn:global-ignores property
Date: Thu, 21 Nov 2013 14:41:24 +0400
Message-ID: <528DE354.1050804@ya.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 11:48:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjRoZ-0005m9-IF
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 11:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab3KUKsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 05:48:42 -0500
Received: from forward14.mail.yandex.net ([95.108.130.92]:60447 "EHLO
	forward14.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab3KUKsl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 05:48:41 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Nov 2013 05:48:41 EST
Received: from smtp13.mail.yandex.net (smtp13.mail.yandex.net [95.108.130.68])
	by forward14.mail.yandex.net (Yandex) with ESMTP id 552E31982BF3;
	Thu, 21 Nov 2013 14:41:25 +0400 (MSK)
Received: from smtp13.mail.yandex.net (localhost [127.0.0.1])
	by smtp13.mail.yandex.net (Yandex) with ESMTP id 10CF1E40A66;
	Thu, 21 Nov 2013 14:41:24 +0400 (MSK)
Received: from atlas252-147.me12.ru (atlas252-147.me12.ru [91.210.252.147])
	by smtp13.mail.yandex.net (nwsmtp/Yandex) with ESMTP id jTI3WqHjK4-fOmC2BWb;
	Thu, 21 Nov 2013 14:41:24 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1385030484;
	bh=MRig1QiaV6lX5HzQw5f8tIcdfv/JrgR9vH3lJqLrMWc=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:
	 Content-Type:Content-Transfer-Encoding;
	b=m5jwvE+T0GHcVS8QYuQEvRpv76jypap7uTkbfVkbxMjFD92b2L8clsRe2UG4I34MJ
	 yOzvXMIO/xRJodqC/2Xlo93efJFflxFTLln5hXQXr/fW8t8ikmLwNYTh/FH+/s/XY2
	 9ZJiDVWuahtvQaqdZQXFvoSgKnVEhhWM/R4X7mks=
Authentication-Results: smtp13.mail.yandex.net; dkim=pass header.i=@ya.ru
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238116>

---
  Documentation/git-svn.txt | 12 ++++++------
  git-svn.perl              | 46 
++++++++++++++++++++++++++++++++--------------
  2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 30c5ee2..0c1cd46 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -405,14 +405,14 @@ Any other arguments are passed directly to 'git log'
      independently of 'git svn' functions.

  'create-ignore'::
-    Recursively finds the svn:ignore property on directories and
-    creates matching .gitignore files. The resulting files are staged to
-    be committed, but are not committed. Use -r/--revision to refer to a
-    specific revision.
+    Recursively finds svn:ignore and svn:global-ignores properties on
+    directories and creates matching .gitignore files. The resulting
+    files are staged to be committed, but are not committed.
+    Use -r/--revision to refer to a specific revision.

  'show-ignore'::
-    Recursively finds and lists the svn:ignore property on
-    directories.  The output is suitable for appending to
+    Recursively finds and lists svn:ignore and svn:global-ignores
+    properties on directories. The output is suitable for appending to
      the $GIT_DIR/info/exclude file.

  'mkdirs'::
diff --git a/git-svn.perl b/git-svn.perl
index 7349ffe..a2565e1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1261,6 +1261,15 @@ sub cmd_rebase {
      }
  }

+sub get_svn_ignore {
+    my ($props, $prop) = @_;
+    my $s = $props->{$prop} or return;
+    $s =~ s/[\r\n]+/\n/g;
+    $s =~ s/^\n+//;
+    chomp $s;
+    return $s;
+}
+
  sub cmd_show_ignore {
      my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
      $gs ||= Git::SVN->new;
@@ -1268,12 +1277,17 @@ sub cmd_show_ignore {
      $gs->prop_walk($gs->path, $r, sub {
          my ($gs, $path, $props) = @_;
          print STDOUT "\n# $path\n";
-        my $s = $props->{'svn:ignore'} or return;
-        $s =~ s/[\r\n]+/\n/g;
-        $s =~ s/^\n+//;
-        chomp $s;
-        $s =~ s#^#$path#gm;
-        print STDOUT "$s\n";
+        my $s = &get_svn_ignore($props, 'svn:ignore');
+        my $s_global = &get_svn_ignore($props, 'svn:global-ignores');
+        $s or $s_global or return;
+        if ($s) {
+            $s =~ s#^#$path#gm;
+            print STDOUT "$s\n";
+        }
+        if ($s_global) {
+            $s_global =~ s#^#$path**/#gm;
+            print STDOUT "$s_global\n";
+        }
      });
  }

@@ -1304,16 +1318,20 @@ sub cmd_create_ignore {
          # which git won't track
          mkpath([$path]) unless -d $path;
          my $ignore = $path . '.gitignore';
-        my $s = $props->{'svn:ignore'} or return;
+        my $s = &get_svn_ignore($props, 'svn:ignore');
+        my $s_global = &get_svn_ignore($props, 'svn:global-ignores');
+        $s or $s_global or return;
          open(GITIGNORE, '>', $ignore)
            or fatal("Failed to open `$ignore' for writing: $!");
-        $s =~ s/[\r\n]+/\n/g;
-        $s =~ s/^\n+//;
-        chomp $s;
-        # Prefix all patterns so that the ignore doesn't apply
-        # to sub-directories.
-        $s =~ s#^#/#gm;
-        print GITIGNORE "$s\n";
+        if ($s) {
+            # Prefix all patterns so that the ignore doesn't apply
+            # to sub-directories.
+            $s =~ s#^#/#gm;
+            print GITIGNORE "$s\n";
+        }
+        if ($s_global) {
+            print GITIGNORE "$s_global\n";
+        }
          close(GITIGNORE)
            or fatal("Failed to close `$ignore': $!");
          command_noisy('add', '-f', $ignore);
-- 
1.8.3.msysgit.0
