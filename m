From: "martin f. krafft" <madduck@madduck.net>
Subject: [PATCH/gitolite] Tell gitweb about repo owner via git-config
Date: Wed,  3 Feb 2010 21:13:47 +1300
Message-ID: <1265184827-11364-1-git-send-email-madduck@madduck.net>
Cc: "martin f. krafft" <madduck@madduck.net>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 09:14:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcaNM-0001el-SX
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 09:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550Ab0BCIOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 03:14:11 -0500
Received: from clegg.madduck.net ([193.242.105.96]:37568 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338Ab0BCIOI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 03:14:08 -0500
Received: from lapse.rw.madduck.net (lapse.nz.madduck.net [IPv6:2001:4428:234::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 6A6DE1D4097;
	Wed,  3 Feb 2010 09:13:56 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 8DF4A177; Wed,  3 Feb 2010 21:13:51 +1300 (NZDT)
X-Mailer: git-send-email 1.6.6
X-Virus-Scanned: clamav-milter 0.95.3 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138813>

Gitolite uses projects.list to set the owners for gitweb's use.
Unfortunately, this does not work for gitweb setups that set
$projectroot to a directory, thus generating the list of
repositories on the fly.

This patch changes that: gitolite now writes the gitweb.owner
configuration variable for each repository (and properly cleans up after
itself if the owner is removed).

The patch causes gitolite not to write the owner to projects.list
anymore, as this would be redundant.

The owner also needs no longer be escaped, so this patch removes the
poor man's 's/ /+/g' escaping previously in place.

Note that I am not a Perl coder. Thus there are probably better ways to
implement this, but at least it works.

Cc: Sitaram Chamarty <sitaramc@gmail.com>
Signed-off-by: martin f. krafft <madduck@madduck.net>
---
 src/gl-compile-conf |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/src/gl-compile-conf b/src/gl-compile-conf
index e88819a..7cd5d2e 100755
--- a/src/gl-compile-conf
+++ b/src/gl-compile-conf
@@ -284,7 +284,6 @@ sub parse_conf_file
             die "$WARN $fragment attempting to set description for $repo\n" if
                 $fragment ne 'master' and $fragment ne $repo and ($groups{"\@$fragment"}{$repo} || '') ne 'master';
             $desc{"$repo.git"} = $desc;
-            $owner =~ s/ /+/g if $owner;    # gitweb/INSTALL wants more, but meh...!
             $owner{"$repo.git"} = $owner || '';
         }
         else
@@ -414,16 +413,32 @@ for my $repo (sort keys %repos) {
         $projlist{"$repo.git"} = 1;
         # add the description file; no messages to user or error checking :)
         $desc{"$repo.git"} and open(DESC, ">", $desc_file) and print DESC $desc{"$repo.git"} . "\n" and close DESC;
+        if ($owner{"$repo.git"}) {
+            # set the repository owner
+            system("git --git-dir=$repo.git config gitweb.owner '" . $owner{"$repo.git"} . "'");
+        } else {
+            # remove the repository owner setting
+            system("git --git-dir=$repo.git config --unset-all gitweb.owner 2>/dev/null");
+        }
     } else {
         # delete the description file; no messages to user or error checking :)
         unlink $desc_file;
+        # remove the repository owner setting
+        system("git --git-dir=$repo.git config --unset-all gitweb.owner 2>/dev/null");
+    }
+
+    # unless there are other gitweb.* keys set, remove the section to keep the
+    # config file clean
+    my $keys = `git --git-dir=$repo.git config --get-regexp '^gitweb\\.' 2>/dev/null`;
+    if (length($keys) == 0) {
+        system("git --git-dir=$repo.git config --remove-section gitweb 2>/dev/null");
     }
 }
 
 # update the project list
 my $projlist_fh = wrap_open( ">", $PROJECTS_LIST);
 for my $proj (sort keys %projlist) {
-    print $projlist_fh "$proj" . ( $owner{$proj} ? " $owner{$proj}" : "" ) . "\n";
+    print $projlist_fh "$proj\n";
 }
 close $projlist_fh;
 
-- 
1.6.6
