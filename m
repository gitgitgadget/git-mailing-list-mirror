From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix auth parameter handling on SVN 1.9.0+
Date: Sat, 16 Jan 2016 10:17:19 +0000
Message-ID: <20160116101719.GA21147@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 797705@bugs.debian.org,
	Dair Grant <dair@feralinteractive.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 11:18:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKNvm-0004Gn-A0
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 11:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbcAPKRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2016 05:17:23 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42551 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbcAPKRU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2016 05:17:20 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 448FB2007D;
	Sat, 16 Jan 2016 10:17:19 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284239>

For users with "store-passwords = no" set in the "[auth]" section of
their ~/.subversion/config, SVN 1.9.0+ would fail with the
following message when attempting to call svn_auth_set_parameter:

  Value is not a string (or undef) at Git/SVN/Ra.pm

Ironically, this breakage was caused by r1553823 in subversion:

  "Make svn_auth_set_parameter() usable from Perl bindings."

Since 2007 (602015e0e6ec), git-svn has used a workaround to make
svn_auth_set_parameter usable internally.  However this workaround
breaks under SVN 1.9+, which deals properly with the type mapping
and fails to recognize our workaround.

For pre-1.9.0 SVN, we continue to use the existing workaround for
the lack of proper type mapping in the bindings.

Tested under subversion 1.6.17 and 1.9.3.

I've also verified r1553823 was not backported to SVN 1.8.x:

  BRANCH=http://svn.apache.org/repos/asf/subversion/branches/1.8.x
  svn log -v $BRANCH/subversion/bindings/swig/core.i

ref: https://bugs.debian.org/797705
Cc: 797705@bugs.debian.org
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Thanks to the reporter (Bcc:-ed to protect their privacy) who
 notified Dair and I of this bug.

 Junio: this should also head to maint, thanks.

 perl/Git/SVN/Ra.pm | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 4a499fc..e764696 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -81,7 +81,6 @@ sub prepare_config_once {
 	SVN::_Core::svn_config_ensure($config_dir, undef);
 	my ($baton, $callbacks) = SVN::Core::auth_open_helper(_auth_providers);
 	my $config = SVN::Core::config_get_config($config_dir);
-	my $dont_store_passwords = 1;
 	my $conf_t = $config->{'config'};
 
 	no warnings 'once';
@@ -93,9 +92,14 @@ sub prepare_config_once {
 	    $SVN::_Core::SVN_CONFIG_SECTION_AUTH,
 	    $SVN::_Core::SVN_CONFIG_OPTION_STORE_PASSWORDS,
 	    1) == 0) {
+		my $val = '1';
+		if (::compare_svn_version('1.9.0') < 0) { # pre-SVN r1553823
+			my $dont_store_passwords = 1;
+			$val = bless \$dont_store_passwords, "_p_void";
+		}
 		SVN::_Core::svn_auth_set_parameter($baton,
 		    $SVN::_Core::SVN_AUTH_PARAM_DONT_STORE_PASSWORDS,
-		    bless (\$dont_store_passwords, "_p_void"));
+		    $val);
 	}
 	if (SVN::_Core::svn_config_get_bool($conf_t,
 	    $SVN::_Core::SVN_CONFIG_SECTION_AUTH,
-- 
EW
