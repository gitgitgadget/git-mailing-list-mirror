From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/3 v3] git-svn info: implement info command
Date: Wed, 21 Nov 2007 17:40:38 -0800
Message-ID: <20071122014038.GA25341@soma>
References: <1195675039-26746-1-git-send-email-ddkilzer@kilzer.net> <1195675039-26746-2-git-send-email-ddkilzer@kilzer.net> <1195675039-26746-3-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 02:40:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv13p-0002mU-9o
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 02:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbXKVBkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 20:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbXKVBkk
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 20:40:40 -0500
Received: from hand.yhbt.net ([66.150.188.102]:37038 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbXKVBkj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 20:40:39 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 0A2DC7DC0FE;
	Wed, 21 Nov 2007 17:40:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1195675039-26746-3-git-send-email-ddkilzer@kilzer.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65731>

"David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> Implement "git-svn info" for files and directories based on the
> "svn info" command.  Note that the -r/--revision argument is not
> supported yet.
> 
> Added 18 tests in t/t9119-git-svn-info.sh.

Eric Wong <normalperson@yhbt.net> wrote:
> I'm having a problem with [2/3] currently:
> 
> $file_type not being detected correctly when running "git svn info"
> on the top-level directory with no arguments.  It's opening the
> directory and trying to md5 it here:
> 
> 		} else {
> 			open FILE, "<", $path or die $!;
> 			$checksum = Git::SVN::Util::md5sum(\*FILE);
> 			close FILE or die $!;
> 		}
> 
>

When running from a top-level directory with no arguments, the first
line of git-ls-tree was being read.  This allowed the test case to pass
because ls-tree sorts the output and 'directory' just happened to
be up top; so we were getting the 040000 mode from the 'directory'
tree and not the top-level tree.

The below test should fix it for the trivial case I have.

diff --git a/git-svn.perl b/git-svn.perl
index 62801c8..7d86870 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1165,6 +1165,7 @@ sub linearize_history {
 
 sub find_file_type_and_diff_status {
 	my ($path) = @_;
+	return ('dir', '') if $path eq '.';
 
 	my $diff_output =
 	    command_oneline(qw(diff --cached --name-status --), $path) || "";
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index e81457f..439bd93 100644
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -19,6 +19,7 @@ ptouch() {
 test_expect_success 'setup repository and import' "
 	mkdir info &&
 	cd info &&
+		echo FIRST > A &&
 		echo one > file &&
 		ln -s file symlink-file &&
 		mkdir directory &&

-- 
Eric Wong
