From: Deskin Miller <deskinm@umich.edu>
Subject: [RFC PATCH] git-svn: proper detection of bare repositories
Date: Sun, 2 Nov 2008 19:09:03 -0500
Message-ID: <20081103000903.GA1135@euler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 01:10:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwn1Y-0003wh-Sa
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 01:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbYKCAJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 19:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbYKCAJO
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 19:09:14 -0500
Received: from el-out-1112.google.com ([209.85.162.176]:8773 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbYKCAJN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 19:09:13 -0500
Received: by el-out-1112.google.com with SMTP id z25so1083202ele.1
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 16:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent
         :sender;
        bh=dO0dTsar67SmpFk2CPUQP2G06QNCZyz8IhiL6NG1GTY=;
        b=dcKLvSYCmMS3v8wEeg1rbkmw4GIHAuJeT9v/WMJR8VsgSyM5NjIQmsUJhTA04XHFQB
         +WDsCMW9JzaslzUX737p7il/8SB8KSjy5fqDDXbDvZCIApbtXZsXcvcVdUWNWx7vp22t
         QlHdbeUpAjL3j76f8wYo59TLqrYNc78lG0C0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:sender;
        b=nn3xkqZzTDcdtlvfgwdYqpMRju0RpUcjiELjwB/QEkPVirSlOGHry8mvNCEam4cfkQ
         iV3UF+WbUzRCHwsa+l5F5zYzhQf9/C44bvPtDk00HIy8cDdt5Vfl/Yv5IL0CTEsbdOyl
         F2I8byQrYQreY2Dyap02AbayXb/XWIiS7buuc=
Received: by 10.64.208.8 with SMTP id f8mr17225588qbg.24.1225670951020;
        Sun, 02 Nov 2008 16:09:11 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id s12sm15860159qbs.9.2008.11.02.16.09.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 16:09:09 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99892>

I keep coming across commands like this, which don't work properly in bare
repositories, and thinking that they need to be patched (see e.g. ddff8563, or
Duy's comments on the thread starting at
http://thread.gmane.org/gmane.comp.version-control.git/98849), but now I'm not
so sure.  For one, despite this patch working, it turns out that 'git --bare
svn <cmd>' also works (and presumably has) for some time.

Is git --bare the correct way to deal with this situation?  That is to say, do
we intend commands to 'just work' regardless of whether the repo is bare or
not, or should the user be thinking about the difference and including --bare
in the command invocation when necessary?  I'm a vote for the 'just work' camp,
but it seems a lot of things aren't necessarily that way.  On the other hand,
the majority of commands do just work.

I guess I'm asking for a sanity check before I write any more such patches;
certainly I find them useful, as the issues come up during my normal use of
Git, but I don't want to be pursuing things of no use to anyone else, or
(worse) things that are fundamentally wrong for some reason I don't understand
yet.

-- 8< --

When in a bare repository (or .git, for that matter), git-svn would fail
to initialise properly, since git rev-parse --show-cdup would not output
anything.  However, git rev-parse --show-cdup actually returns an error
code if it's really not in a git directory.

Fix the issue by checking for an explicit error from git rev-parse, and
setting $git_dir appropriately if instead it just does not output.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
 git-svn.perl             |   14 ++++++++++----
 t/t9100-git-svn-basic.sh |    9 +++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 56238da..d25e9be 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -42,6 +42,7 @@ use File::Path qw/mkpath/;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 use IPC::Open3;
 use Git;
+use Error qw/:try/;
 
 BEGIN {
 	# import functions from Git into our packages, en masse
@@ -214,11 +215,16 @@ unless ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 			    "but it is not a directory\n";
 		}
 		my $git_dir = delete $ENV{GIT_DIR};
-		chomp(my $cdup = command_oneline(qw/rev-parse --show-cdup/));
-		unless (length $cdup) {
-			die "Already at toplevel, but $git_dir ",
-			    "not found '$cdup'\n";
-		}
+		my $cdup = undef;
+		try {
+			$cdup = command_oneline(qw/rev-parse --show-cdup/);
+			$git_dir = '.' unless ($cdup);
+			chomp $cdup if ($cdup);
+			$cdup = "." unless ($cdup && length $cdup);
+		}
+		catch Git::Error::Command with {
+			die "Already at toplevel, but $git_dir not found\n";
+		};
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
