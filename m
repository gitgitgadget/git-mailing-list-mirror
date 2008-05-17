From: Chris Frey <cdfrey@foursquare.net>
Subject: [PATCH] perl/Makefile.PL: teach makefiles about possible old Error.pm files
Date: Fri, 16 May 2008 21:16:14 -0400
Message-ID: <20080517011614.GA11029@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 03:17:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxB30-0003Vx-2b
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 03:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbYEQBQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 21:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbYEQBQ1
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 21:16:27 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:54733 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbYEQBQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 21:16:26 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m4H1GE28013766
	for <git@vger.kernel.org>; Fri, 16 May 2008 21:16:14 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82328>

If a previous version of git was installed on a system without a
proper Error.pm, git will install its own.  But the next time
git is compiled on that system, that Error.pm will prevent git from
installing its own copy the second time.  This causes a broken
git install on such systems.

This patch fixes this bug by tagging git's Error.pm with an
INSTALLED_BY flag, and checking for it during the compile.

Signed-off-by: Chris Frey <cdfrey@foursquare.net>
---

	I use 'stow' to handle multiple versions of git installations.
	So when I uninstall a version of git, all those files are
	truly gone.  Including Error.pm.

	I think it is wise to mark our own copy of Error.pm in some way
	anyhow, just so people can tell the difference between
	versions on their systems.

	The drawback to this patch is that once git installs its own
	copy, it will always install its own copy, unless the user
	uninstalls the old git first.  Usually this is the desired
	behaviour, but my perl-fu isn't strong enough to make this
	check even smarter.  Ideally, if a newer version is on the
	system already, git shouldn't have to install its own.

	And on the last hand, this whole automated, secondary Error.pm
	installation method is rather suspect when it comes to creating
	binary packages.  Hopefully distro maintainers never build git
	packages on systems with a git-Error.pm, while also blindly trusting
	git's make install.

	I'd love to see this in the official git tree soon, so I don't
	run into these issues myself. :-)  Tips on how to make this
	smarter are welcome.

	- Chris


 perl/Makefile.PL      |   14 ++++++++++++--
 perl/private-Error.pm |    1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 320253e..26f7a8c 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -11,9 +11,19 @@ MAKE_FRAG
 my %pm = ('Git.pm' => '$(INST_LIBDIR)/Git.pm');
 
 # We come with our own bundled Error.pm. It's not in the set of default
-# Perl modules so install it if it's not available on the system yet.
+# Perl modules.  So, unless it was a copy we installed, install it
+# if it's not available on the system yet.
 eval { require Error };
-if ($@ || $Error::VERSION < 0.15009) {
+if ($@ || $Error::VERSION < 0.15009 || $Error::INSTALLED_BY eq 'git') {
+	if ($Error::INSTALLED_BY eq 'git') {
+		print "**************************************************\n";
+		print "WARNING: detected an Error.pm from a previous git\n";
+		print "         install, so assuming that you wish to\n";
+		print "         continue using git's version.  If this is\n";
+		print "         not the case, uninstall your old version\n";
+		print "         of git before compiling the new.\n";
+		print "**************************************************\n";
+	}
 	$pm{'private-Error.pm'} = '$(INST_LIBDIR)/Error.pm';
 }
 
diff --git a/perl/private-Error.pm b/perl/private-Error.pm
index 11e9cd9..a399983 100644
--- a/perl/private-Error.pm
+++ b/perl/private-Error.pm
@@ -16,6 +16,7 @@ use vars qw($VERSION);
 use 5.004;
 
 $VERSION = "0.15009";
+$Error::INSTALLED_BY = "git";
 
 use overload (
 	'""'	   =>	'stringify',
-- 
1.5.4.4
