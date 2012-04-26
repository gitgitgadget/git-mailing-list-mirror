From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH 2/2] git-svn: Configure a prompt callback for gnome_keyring.
Date: Thu, 26 Apr 2012 21:34:03 +0200
Message-ID: <1335468843-24653-2-git-send-email-matthijs@stdin.nl>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl>
 <1335468843-24653-1-git-send-email-matthijs@stdin.nl>
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
	id 1SNV35-0000Ko-CQ
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 22:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758381Ab2DZUMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 16:12:13 -0400
Received: from 84-245-11-97.dsl.cambrium.nl ([84.245.11.97]:49354 "EHLO
	grubby.stderr.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758046Ab2DZUML (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 16:12:11 -0400
Received: from matthijs by grubby.stderr.nl with local (Exim 4.77)
	(envelope-from <matthijs@stdin.nl>)
	id 1SNUSR-0006QB-BQ; Thu, 26 Apr 2012 21:34:27 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335468843-24653-1-git-send-email-matthijs@stdin.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196404>

This allows git-svn to prompt for a keyring unlock password, when a
the needed gnome keyring is locked.

This requires changes in the subversion perl bindings which have been
committed to trunk (1241554 and some followup commits) and should be
available with the (as of yet unreleased) 1.8.0 release.
---
 git-svn.perl |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/git-svn.perl b/git-svn.perl
index 1790d10..6565f4a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4420,6 +4420,11 @@ sub username {
 	$SVN::_Core::SVN_NO_ERROR;
 }
 
+sub gnome_keyring_unlock {
+	my ($keyring, $pool) = @_;
+	_read_password("Password for '$keyring' GNOME keyring: ", undef);
+}
+
 sub _read_password {
 	my ($prompt, $realm) = @_;
 	my $password = '';
@@ -5524,6 +5529,21 @@ sub new {
 			$Git::SVN::Prompt::_no_auth_cache = 1;
 		}
 	} # no warnings 'once'
+
+
+	# Allow git-svn to show a prompt for opening up a gnome-keyring, if needed.
+	if (defined(&SVN::Core::auth_set_gnome_keyring_unlock_prompt_func)) {
+		my $keyring_callback = SVN::Core::auth_set_gnome_keyring_unlock_prompt_func(
+			$baton,
+			\&Git::SVN::Prompt::gnome_keyring_unlock
+		);
+		# Keep a reference to this callback, to prevent the function
+		# (reference) from being garbage collected.  We just add it to
+		# the callbacks value, which are also used only to prevent the
+		# garbage collector from eating stuff.
+		$callbacks = [$callbacks, $keyring_callback]
+	}
+
 	my $self = SVN::Ra->new(url => escape_url($url), auth => $baton,
 	                      config => $config,
 			      pool => SVN::Pool->new,
-- 
1.7.10
