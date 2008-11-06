From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH v2] git-svn: proper detection of bare repositories
Date: Thu, 6 Nov 2008 00:07:39 -0500
Message-ID: <20081106050739.GA7713@euler>
References: <20081103000903.GA1135@euler> <20081104083015.GA14405@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 06 06:10:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxx7x-0003Z3-1t
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 06:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbYKFFHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 00:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbYKFFHu
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 00:07:50 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:16971 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbYKFFHt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 00:07:49 -0500
Received: by yw-out-2324.google.com with SMTP id 9so181522ywe.1
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 21:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=/0DIsExQDwEfplllIqeWAqzhhkmiDjBZBqJH2/SjilE=;
        b=G/O5QMydn9HNqpCC44TiyqoURnx9GkJtmir3VGcqPmS9B1+M3OzYPP6l9MmV64n+mN
         Fzk83dbO69+4ZXMyBxhI8iOno/EydaSTJ397iAHEQ6IRnzCUbsj/5Y/AO3iCQgpiA7Gb
         UN8eqBGm26133kilRF24lLC2MEa2aeQnl6WQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=YZ5NdVC3tzoS7+/6KOJvx1Gn+Wsnxl6FJOOj7B7Ztx8XGwtjc/K8DdKshETSdrASYa
         l1/JtUwzCi4/L8arsWKCOEYl3Su2KGjaaGjpJHrUmx3a+dqmWWWCWe/aADYUDRkcSsE0
         fPsYLIlXyCVeee/FIJYkNEDC7ofd52U2/OSlw=
Received: by 10.64.151.14 with SMTP id y14mr1768668qbd.93.1225948067463;
        Wed, 05 Nov 2008 21:07:47 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id s35sm956015qbs.13.2008.11.05.21.07.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Nov 2008 21:07:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081104083015.GA14405@untitled>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100214>

On Tue, Nov 04, 2008 at 12:30:15AM -0800, Eric Wong wrote:
> How about using git_cmd_try instead?
> 
> The Error.pm try/catch stuff makes me a bit uncomfortable.  I realize
> it's (unfortunately) in Git.pm; but I'd rather keep it confined there so
> we can more easily remove it later if someone were inclined.

Yeah, major thinko; I read the Git(3pm) manpage, looked at git_cmd_try, and for
some reason thought that it wasn't what I want.  But it's exactly what I want.

Deskin Miller

-- 8< --

When in a bare repository (or .git, for that matter), git-svn would fail
to initialise properly, since git rev-parse --show-cdup would not output
anything.  However, git rev-parse --show-cdup actually returns an error
code if it's really not in a git directory.

Fix the issue by checking for an explicit error from git rev-parse, and
setting $git_dir appropriately if instead it just does not output.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
 git-svn.perl             |   12 +++++++-----
 t/t9100-git-svn-basic.sh |    9 +++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 56238da..829a323 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -214,11 +214,13 @@ unless ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 			    "but it is not a directory\n";
 		}
 		my $git_dir = delete $ENV{GIT_DIR};
-		chomp(my $cdup = command_oneline(qw/rev-parse --show-cdup/));
-		unless (length $cdup) {
-			die "Already at toplevel, but $git_dir ",
-			    "not found '$cdup'\n";
-		}
+		my $cdup = undef;
+		git_cmd_try {
+			$cdup = command_oneline(qw/rev-parse --show-cdup/);
+			$git_dir = '.' unless ($cdup);
+			chomp $cdup if ($cdup);
+			$cdup = "." unless ($cdup && length $cdup);
+		} "Already at toplevel, but $git_dir not found\n";
 		chdir $cdup or die "Unable to chdir up to '$cdup'\n";
 		unless (-d $git_dir) {
 			die "$git_dir still not found after going to ",
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 843a501..fdbc23a 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -265,4 +265,13 @@ test_expect_success 'able to set-tree to a subdirectory' "
 	test -z \"\`git diff refs/heads/my-bar refs/remotes/bar\`\"
 	"
 
+test_expect_success 'git-svn works in a bare repository' '
+	mkdir bare-repo &&
+	( cd bare-repo &&
+	git init --bare &&
+	GIT_DIR=. git svn init "$svnrepo" &&
+	git svn fetch ) &&
+	rm -rf bare-repo
+	'
+
 test_done
-- 
1.6.0.3.524.g47d14
