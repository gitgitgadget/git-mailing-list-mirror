From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: bail out on incorrect command-line options
Date: Tue, 3 Apr 2007 01:57:08 -0700
Message-ID: <20070403085708.GA16051@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 10:57:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYepR-0003JR-AN
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 10:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933463AbXDCI5L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 04:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933464AbXDCI5L
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 04:57:11 -0400
Received: from hand.yhbt.net ([66.150.188.102]:48031 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933463AbXDCI5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 04:57:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id B6BD87DC091;
	Tue,  3 Apr 2007 01:57:08 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43620>

"git svn log" is the only command that needs the pass-through
option in Getopt::Long; otherwise we will bail out and let the
user know something is wrong.

Also, avoid printing out unaccepted mixed-case options (that
are reserved for the command-line) such as --useSvmProps
in the usage() function.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Sam: Cc-ing you because I saw you using use --useSvmProps in
 a tutorial you wrote, however this was disabled in:
 97ae091169b233ecd80eb5ef2da80145f8c724f7
 and only enabled in lower-case form for the "init" and "clone"
 commands in:
 0dfaf0a4e1905a9137d3f2f691620529aeb3b4fa

 git-svn.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d307d43..6216cad 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -33,7 +33,7 @@ use Carp qw/croak/;
 use IO::File qw//;
 use File::Basename qw/dirname basename/;
 use File::Path qw/mkpath/;
-use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev pass_through/;
+use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 use IPC::Open3;
 use Git;
 
@@ -168,6 +168,7 @@ for (my $i = 0; $i < @ARGV; $i++) {
 my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
 
 read_repo_config(\%opts);
+Getopt::Long::Configure('pass_through') if $cmd eq 'log';
 my $rv = GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version,
                     'minimize-connections' => \$Git::SVN::Migration::_minimize,
                     'id|i=s' => \$Git::SVN::default_ref_id,
@@ -229,6 +230,8 @@ Usage: $0 <command> [options] [arguments]\n
 		next if /^multi-/; # don't show deprecated commands
 		print $fd '  ',pack('A17',$_),$cmd{$_}->[1],"\n";
 		foreach (keys %{$cmd{$_}->[2]}) {
+			# mixed-case options are for .git/config only
+			next if /[A-Z]/ && /^[a-z]+$/i;
 			# prints out arguments as they should be passed:
 			my $x = s#[:=]s$## ? '<arg>' : s#[:=]i$## ? '<num>' : '';
 			print $fd ' ' x 21, join(', ', map { length $_ > 1 ?
-- 
Eric Wong
