From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH] git-svn: respect Subversion's [auth] section configuration values
Date: Sat, 6 Oct 2007 22:57:19 +0400
Message-ID: <20071006185719.GA3943@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 20:57:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeEqI-00014X-G3
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 20:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761944AbXJFS52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 14:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761260AbXJFS52
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 14:57:28 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:59897 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761014AbXJFS51 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 14:57:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:Content-Disposition:Sender:X-Spam-Status:Subject;
	b=oPEs7pmQpD5Vcs9I8XKYESSx2ZNNioWReVLn2ypGSRKx5jr+ohY+b/JFjy40ZjgmUPrSxbA5s1GpJpryT6EqP82O+AdcnbpA5FLEk5kuUoj+c+T+SYoi2onoS1kjXK7YNfQX9QJPWVTc2X88zYhjpC3HYab6S6aXT4W6+eysIW4=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1IeEq4-0007F9-6V; Sat, 06 Oct 2007 22:57:24 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60153>

Parameters 'store-passwords' and 'store-auth-creds' from Subversion's
configuration (~/.subversion/config) were not respected.  This was
fixed: the default values for these parameters are set to 'yes' to
follow Subversion behaviour.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 git-svn.perl |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 484b057..f7ef421 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3051,6 +3051,29 @@ sub new {
 	  ]);
 	my $config = SVN::Core::config_get_config($config_dir);
 	$RA = undef;
+	my $dont_store_passwords = 1;
+	my $conf_t = ${$config}{'config'};
+	{
+		# The usage of $SVN::_Core::SVN_CONFIG_* variables
+		# produces warnings that variables are used only once.
+		# I had not found the better way to shut them up, so
+		# warnings are disabled in this block.
+		no warnings;
+		if (SVN::_Core::svn_config_get_bool($conf_t,
+		    $SVN::_Core::SVN_CONFIG_SECTION_AUTH,
+		    $SVN::_Core::SVN_CONFIG_OPTION_STORE_PASSWORDS,
+		    1) == 0) {
+			SVN::_Core::svn_auth_set_parameter($baton,
+			    $SVN::_Core::SVN_AUTH_PARAM_DONT_STORE_PASSWORDS,
+			    bless (\$dont_store_passwords, "_p_void"));
+		}
+		if (SVN::_Core::svn_config_get_bool($conf_t,
+		    $SVN::_Core::SVN_CONFIG_SECTION_AUTH,
+		    $SVN::_Core::SVN_CONFIG_OPTION_STORE_AUTH_CREDS,
+		    1) == 0) {
+			$Git::SVN::Prompt::_no_auth_cache = 1;
+		}
+	}
 	my $self = SVN::Ra->new(url => $url, auth => $baton,
 	                      config => $config,
 			      pool => SVN::Pool->new,
-- 
1.5.3.2


-- 
Eygene
