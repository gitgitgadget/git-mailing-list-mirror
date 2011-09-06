From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] send-email: add option -h
Date: Tue, 6 Sep 2011 08:32:36 +0200
Message-ID: <20110906063236.GA4923@ecki>
References: <20110903170612.GA3536@ecki>
 <7vk49mbvlk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 08:35:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0pFe-0003vi-MK
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 08:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936Ab1IFGfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 02:35:05 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:46453 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752869Ab1IFGfE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 02:35:04 -0400
Received: from localhost (p5B22CD62.dip.t-dialin.net [91.34.205.98])
	by bsmtp.bon.at (Postfix) with ESMTP id EAC72130062;
	Tue,  6 Sep 2011 08:34:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk49mbvlk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180772>

On Mon, Sep 05, 2011 at 01:08:39PM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > Most other git commands print a synopsis when passed -h. Make
> > send-email do the same.
> >
> > Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> > ...
> > +my $help;
> > +my $rc = GetOptions("help|H|h" => \$help,
> 
> I do not think what the patch aims to do is wrong per-se, but
> 
>  $ git send-email --help
> 
> already shows the full documentation, and I find it is misleading to say
> "help|H|h" here to pretend as if a long-help is triggered with this
> command. For that matter, do we have any other place that accept -H for
> help?
> 
> IOW, shouldn't this line be this instead?
> 
> > +my $rc = GetOptions("h" => \$help,

Sure. I was just copy-pasting from git-svn.perl. And in fact I
_was_ confused by the fact that it also seemed to allow --help, but
in fact did not handle that case any different.

Just found a few more places, so how about this on top?

-->8--
From: Clemens Buchacher <drizzd@aon.at>
Date: Tue, 6 Sep 2011 08:27:13 +0200
Subject: [PATCH] use -h for synopsis and --help for manpage consistently

The "git cmd --help" syntax is translated into "git help cmd" by
git.c. Do not pretend to handle such cases in any individual
commands.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 git-cvsserver.perl  |    4 ++--
 git-pull.sh         |    2 +-
 git-send-email.perl |    2 +-
 git-svn.perl        |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 1b8bff2..6c5185e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -109,14 +109,14 @@ my $usage =
     "    --strict-paths      : Don't allow recursing into subdirectories\n".
     "    --export-all        : Don't check for gitcvs.enabled in config\n".
     "    --version, -V       : Print version information and exit\n".
-    "    --help, -h, -H      : Print usage information and exit\n".
+    "    -h                  : Print usage information and exit\n".
     "\n".
     "<directory> ... is a list of allowed directories. If no directories\n".
     "are given, all are allowed. This is an additional restriction, gitcvs\n".
     "access still needs to be enabled by the gitcvs.enabled config option.\n".
     "Alternately, one directory may be specified in GIT_CVSSERVER_ROOT.\n";
 
-my @opts = ( 'help|h|H', 'version|V',
+my @opts = ( 'h', 'version|V',
 	     'base-path=s', 'strict-paths', 'export-all' );
 GetOptions( $state, @opts )
     or die $usage;
diff --git a/git-pull.sh b/git-pull.sh
index 63da37b..f08372a 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -120,7 +120,7 @@ do
 	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
 		dry_run=--dry-run
 		;;
-	-h|--h|--he|--hel|--help|--help-|--help-a|--help-al|--help-all)
+	-h)
 		usage
 		;;
 	*)
diff --git a/git-send-email.perl b/git-send-email.perl
index 4ac6931..734356a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -276,7 +276,7 @@ $SIG{INT}  = \&signal_handler;
 # needing, first, from the command line:
 
 my $help;
-my $rc = GetOptions("help|H|h" => \$help,
+my $rc = GetOptions("h" => \$help,
 		    "sender|from=s" => \$sender,
                     "in-reply-to=s" => \$initial_reply_to,
 		    "subject=s" => \$initial_subject,
diff --git a/git-svn.perl b/git-svn.perl
index 89f83fd..a019f55 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -294,7 +294,7 @@ read_git_config(\%opts);
 if ($cmd && ($cmd eq 'log' || $cmd eq 'blame')) {
 	Getopt::Long::Configure('pass_through');
 }
-my $rv = GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version,
+my $rv = GetOptions(%opts, 'h' => \$_help, 'version|V' => \$_version,
                     'minimize-connections' => \$Git::SVN::Migration::_minimize,
                     'id|i=s' => \$Git::SVN::default_ref_id,
                     'svn-remote|remote|R=s' => sub {
-- 
1.7.6.1
