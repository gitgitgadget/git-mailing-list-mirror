From: "James Bowes" <jbowes@dangerouslyinc.com>
Subject: Re: [PATCH] Read cvsimport options from repo-config
Date: Wed, 7 Feb 2007 17:57:43 -0500
Message-ID: <3f80363f0702071457g713f6f0bn41dfc0dacd7415a2@mail.gmail.com>
References: <3f80363f0702051722x1812228fp1cd7a41dd32b31f3@mail.gmail.com>
	 <7vireflxna.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 23:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvjZ-00016C-4K
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 23:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422807AbXBGW5p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 17:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422808AbXBGW5p
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 17:57:45 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:47915 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422807AbXBGW5o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 17:57:44 -0500
Received: by an-out-0708.google.com with SMTP id b33so306437ana
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 14:57:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=b2HzETEzPHM9uGAlyCWBUwQz12VJxntSY5fqkj4m109q6x4DgPzRkvKQpASS5gy0dABwclUxXH3OSS6Gp4sw6wSQJnc7L0naEeIMZ3XIeqHuEDfDeU+0rn0HcSMqVo1qENV8jEsxJxJriWZ6om/b0LTacUFKWH/Yx/HHe4C2iHc=
Received: by 10.100.119.14 with SMTP id r14mr8786514anc.1170889063359;
        Wed, 07 Feb 2007 14:57:43 -0800 (PST)
Received: by 10.65.97.13 with HTTP; Wed, 7 Feb 2007 14:57:43 -0800 (PST)
In-Reply-To: <7vireflxna.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: e71e95cb101bcb0e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38991>

Default values for command line options can be saved in .git/config (or the
global ~/.gitconfig). Config option names match the command line option names,
so cvsimport.d corresponds to git-cvsimport -d. One may also set
cvsimport.module to specify a default cvs module name.

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---

Thanks for the reply, Junio. I've added a comment explaining the
regex, and fixed the check for '--bool'; you were right, it didn't
work.

 git-cvsimport.perl |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 6c9fbfe..1a1ba7b 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -85,7 +85,35 @@ sub write_author_info($) {
 	close ($f);
 }

-getopts("haivmkuo:d:p:C:z:s:M:P:A:S:L:") or usage();
+# convert getopts specs for use by git-repo-config
+sub read_repo_config {
+    # Split the string between characters, unless there is a ':'
+    # So "abc:de" becomes ["a", "b", "c:", "d", "e"]
+	my @opts = split(/ *(?!:)/, shift);
+	foreach my $o (@opts) {
+		my $key = $o;
+		$key =~ s/://g;
+		my $arg = 'git-repo-config';
+		$arg .= ' --bool' if ($o !~ /:$/);
+
+        chomp(my $tmp = `$arg --get cvsimport.$key`);
+		if ($tmp && !($arg =~ /--bool/ && $tmp eq 'false')) {
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
