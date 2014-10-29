From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: prepare SVN::Ra config pieces once
Date: Wed, 29 Oct 2014 19:55:02 +0000
Message-ID: <20141029195502.GA5729@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 20:55:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjZKq-0002NP-5W
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 20:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756861AbaJ2TzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 15:55:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49155 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756185AbaJ2TzD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 15:55:03 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 079461F7C9;
	Wed, 29 Oct 2014 19:55:03 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Memoizing these initialization functions saves some memory for
long fetches which require scanning many unwanted revisions
before any wanted revisions happen.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN/Ra.pm | 63 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 5bc5b4e..75cdac9 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -2,6 +2,7 @@ package Git::SVN::Ra;
 use vars qw/@ISA $config_dir $_ignore_refs_regex $_log_window_size/;
 use strict;
 use warnings;
+use Memoize;
 use SVN::Client;
 use Git::SVN::Utils qw(
 	canonicalize_url
@@ -76,6 +77,40 @@ sub _auth_providers () {
 	\@rv;
 }
 
+sub prepare_config_once {
+	SVN::_Core::svn_config_ensure($config_dir, undef);
+	my ($baton, $callbacks) = SVN::Core::auth_open_helper(_auth_providers);
+	my $config = SVN::Core::config_get_config($config_dir);
+	my $dont_store_passwords = 1;
+	my $conf_t = $config->{'config'};
+
+	no warnings 'once';
+	# The usage of $SVN::_Core::SVN_CONFIG_* variables
+	# produces warnings that variables are used only once.
+	# I had not found the better way to shut them up, so
+	# the warnings of type 'once' are disabled in this block.
+	if (SVN::_Core::svn_config_get_bool($conf_t,
+	    $SVN::_Core::SVN_CONFIG_SECTION_AUTH,
+	    $SVN::_Core::SVN_CONFIG_OPTION_STORE_PASSWORDS,
+	    1) == 0) {
+		SVN::_Core::svn_auth_set_parameter($baton,
+		    $SVN::_Core::SVN_AUTH_PARAM_DONT_STORE_PASSWORDS,
+		    bless (\$dont_store_passwords, "_p_void"));
+	}
+	if (SVN::_Core::svn_config_get_bool($conf_t,
+	    $SVN::_Core::SVN_CONFIG_SECTION_AUTH,
+	    $SVN::_Core::SVN_CONFIG_OPTION_STORE_AUTH_CREDS,
+	    1) == 0) {
+		$Git::SVN::Prompt::_no_auth_cache = 1;
+	}
+
+	return ($config, $baton, $callbacks);
+} # no warnings 'once'
+
+INIT {
+	Memoize::memoize '_auth_providers';
+	Memoize::memoize 'prepare_config_once';
+}
 
 sub new {
 	my ($class, $url) = @_;
@@ -84,34 +119,8 @@ sub new {
 
 	::_req_svn();
 
-	SVN::_Core::svn_config_ensure($config_dir, undef);
-	my ($baton, $callbacks) = SVN::Core::auth_open_helper(_auth_providers);
-	my $config = SVN::Core::config_get_config($config_dir);
 	$RA = undef;
-	my $dont_store_passwords = 1;
-	my $conf_t = ${$config}{'config'};
-	{
-		no warnings 'once';
-		# The usage of $SVN::_Core::SVN_CONFIG_* variables
-		# produces warnings that variables are used only once.
-		# I had not found the better way to shut them up, so
-		# the warnings of type 'once' are disabled in this block.
-		if (SVN::_Core::svn_config_get_bool($conf_t,
-		    $SVN::_Core::SVN_CONFIG_SECTION_AUTH,
-		    $SVN::_Core::SVN_CONFIG_OPTION_STORE_PASSWORDS,
-		    1) == 0) {
-			SVN::_Core::svn_auth_set_parameter($baton,
-			    $SVN::_Core::SVN_AUTH_PARAM_DONT_STORE_PASSWORDS,
-			    bless (\$dont_store_passwords, "_p_void"));
-		}
-		if (SVN::_Core::svn_config_get_bool($conf_t,
-		    $SVN::_Core::SVN_CONFIG_SECTION_AUTH,
-		    $SVN::_Core::SVN_CONFIG_OPTION_STORE_AUTH_CREDS,
-		    1) == 0) {
-			$Git::SVN::Prompt::_no_auth_cache = 1;
-		}
-	} # no warnings 'once'
-
+	my ($config, $baton, $callbacks) = prepare_config_once();
 	my $self = SVN::Ra->new(url => $url, auth => $baton,
 	                      config => $config,
 			      pool => SVN::Pool->new,
-- 
EW
