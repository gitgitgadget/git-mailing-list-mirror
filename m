From: "James Bowes" <jbowes@dangerouslyinc.com>
Subject: [PATCH] Read cvsimport options from repo-config
Date: Mon, 5 Feb 2007 20:22:25 -0500
Message-ID: <3f80363f0702051722x1812228fp1cd7a41dd32b31f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 06 02:22:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEF2U-0006i1-MG
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 02:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965435AbXBFBW1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 20:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965439AbXBFBW1
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 20:22:27 -0500
Received: from nz-out-0506.google.com ([64.233.162.236]:2906 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965435AbXBFBW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 20:22:26 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1772003nze
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 17:22:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=LZfOXZ0Z3VzqLLNNY+ysZBNIeFJoGnvsKnituFhFmvUJfaBlHG9g0kgS/rRDYMY0aHwwArncGj+Hmn6A2AWvJl2LQRX+MZ6kPHDsTcSqCNCl07zLuPxiS48JVW6F2hx++uqzMPOAzrQV08RkJk44nxh+huibVnT4mrBEtafPcpU=
Received: by 10.65.232.19 with SMTP id j19mr11802890qbr.1170724945341;
        Mon, 05 Feb 2007 17:22:25 -0800 (PST)
Received: by 10.65.97.13 with HTTP; Mon, 5 Feb 2007 17:22:25 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: c2dfd630ca37ea8a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38800>

Default values for command line options can be saved in .git/config (or the
global ~/.gitconfig). Config option names match the command line option names,
so cvsimport.d corresponds to git-cvsimport -d. One may also set
cvsimport.module to specify a default cvs module name.

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---

I found myself always forgetting the specific options I needed to sync a given
project from CVS, so I wrote up this patch which lets me set the options with
repo-config and then forget about them; 'git cvsimport' is then enough to sync
from CVS.

This is my first patch, so please be gentle :)

 git-cvsimport.perl |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 6c9fbfe..604e636 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -85,7 +85,33 @@ sub write_author_info($) {
 	close ($f);
 }

-getopts("haivmkuo:d:p:C:z:s:M:P:A:S:L:") or usage();
+# convert getopts specs for use by git-repo-config
+sub read_repo_config {
+	my @opts = split(/ *(?!:)/, shift);
+	foreach my $o (@opts) {
+		my $key = $o;
+		$key =~ s/://g;
+		my $arg = 'git-repo-config';
+		$arg .= ' --bool' if ($o !~ /:$/);
+
+        chomp(my $tmp = `$arg --get cvsimport.$key`);
+		if ($tmp && !($arg =~ / --bool / && $tmp eq 'false')) {
+            no strict 'refs';
+            my $opt_name = "opt_" . $key;
+            if (!$$opt_name) {
+                $$opt_name = $tmp;
+            }
+		}
+	}
+    if (@ARGV == 0) {
+        chomp(my $module = `git-repo-config --get cvsimport.module`);
+        push(@ARGV, $module);
+    }
+}
+
+my $opts = "haivmkuo:d:p:C:z:s:M:P:A:S:L:";
+read_repo_config($opts);
+getopts($opts) or usage();
 usage if $opt_h;

 @ARGV <= 1 or usage();
-- 
1.4.4.2
