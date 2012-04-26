From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Thu, 26 Apr 2012 21:34:02 +0200
Message-ID: <1335468843-24653-1-git-send-email-matthijs@stdin.nl>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl>
Cc: Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org,
	Matthijs Kooijman <matthijs@stdin.nl>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 22:12:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNV34-0000Ko-QU
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 22:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758247Ab2DZUML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 16:12:11 -0400
Received: from 84-245-11-97.dsl.cambrium.nl ([84.245.11.97]:49353 "EHLO
	grubby.stderr.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758046Ab2DZUMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 16:12:09 -0400
X-Greylist: delayed 2254 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Apr 2012 16:12:09 EDT
Received: from matthijs by grubby.stderr.nl with local (Exim 4.77)
	(envelope-from <matthijs@stdin.nl>)
	id 1SNUSQ-0006Q9-ED; Thu, 26 Apr 2012 21:34:26 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <20120426183634.GA4023@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196403>

On Linux, this makes authentication using passwords from gnome-keyring
and kwallet work (only the former was tested). On Mac OS X, this allows
using the OS X Keychain.
---
 git-svn.perl |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4334b95..1790d10 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5436,7 +5436,7 @@ BEGIN {
 }
 
 sub _auth_providers () {
-	[
+	my @rv = (
 	  SVN::Client::get_simple_provider(),
 	  SVN::Client::get_ssl_server_trust_file_provider(),
 	  SVN::Client::get_simple_prompt_provider(
@@ -5452,7 +5452,23 @@ sub _auth_providers () {
 	    \&Git::SVN::Prompt::ssl_server_trust),
 	  SVN::Client::get_username_prompt_provider(
 	    \&Git::SVN::Prompt::username, 2)
-	]
+	);
+
+	# earlier 1.6.x versions would segfault, and <= 1.5.x didn't have
+	# this function
+	if ($SVN::Core::VERSION gt '1.6.12') {
+		my $config = SVN::Core::config_get_config($config_dir);
+		my ($p, @a);
+		# config_get_config returns all config files from
+		# ~/.subversion, auth_get_platform_specific_client_providers
+		# just wants the config "file".
+		@a = ($config->{'config'}, undef);
+		$p = SVN::Core::auth_get_platform_specific_client_providers(@a);
+		# Insert the return value from
+		# auth_get_platform_specific_providers
+		unshift @rv, @$p;
+	}
+	\@rv;
 }
 
 sub escape_uri_only {
-- 
1.7.10
