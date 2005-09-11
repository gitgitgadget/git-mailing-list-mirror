From: martin@catalyst.net.nz
Subject: [PATCH 5/5] archimport - better handling of temp dirs
Date: Sun, 11 Sep 2005 21:26:05 +1200
Message-ID: <1126430765146-git-send-email-martin@catalyst.net.nz>
References: <1126430765745-git-send-email-martin@catalyst.net.nz>
Reply-To: martin@catalyst.net.nz
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sun Sep 11 11:26:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEO6P-0005zt-4u
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 11:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbVIKJ0T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 05:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbVIKJ0T
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 05:26:19 -0400
Received: from 202-0-36-112.cable.paradise.net.nz ([202.0.36.112]:10707 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964836AbVIKJ0S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 05:26:18 -0400
Received: from aporo-debian (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with SMTP id EA19B8A72F;
	Sun, 11 Sep 2005 21:26:05 +1200 (NZST)
In-Reply-To: <1126430765745-git-send-email-martin@catalyst.net.nz>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8281>

Switched from backwards hard-coded tmp directory creation to using
File::Temp::tempdir() to create the directory inside $TMP_PATH or
what the user has provided via the -t parameter.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-archimport.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

67d3cf04c6a2353835d52a4d1ae85c7fb91bad36
diff --git a/git-archimport.perl b/git-archimport.perl
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -23,7 +23,6 @@ See man (1) git-archimport for more deta
 
  - create tag objects instead of ref tags
  - audit shell-escaping of filenames
- - better handling of temp directories
  - hide our private tags somewhere smarter
  - find a way to make "cat *patches | patch" safe even when patchfiles are missing newlines  
 
@@ -37,7 +36,7 @@ use strict;
 use warnings;
 use Getopt::Std;
 use File::Spec;
-use File::Temp qw(tempfile);
+use File::Temp qw(tempfile tempdir);
 use File::Path qw(mkpath);
 use File::Basename qw(basename dirname);
 use String::ShellQuote;
@@ -72,9 +71,10 @@ usage if $opt_h;
 @ARGV >= 1 or usage();
 my @arch_roots = @ARGV;
 
-my $tmp = $opt_t;
-$tmp ||= '/tmp';
-$tmp .= '/git-archimport/';
+my ($tmpdir, $tmpdirname) = tempdir('git-archimport-XXXXXX', TMPDIR => 1, CLEANUP => 1);
+my $tmp = $opt_t || 1;
+$tmp = tempdir('git-archimport-XXXXXX', TMPDIR => 1, CLEANUP => 1);
+$opt_v && print "+ Using $tmp as temporary directory\n";
 
 my @psets  = ();                # the collection
 my %psets  = ();                # the collection, by name
