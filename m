From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH] git-svn: Configure a prompt callback for gnome_keyring.
Date: Tue, 18 Jun 2013 18:38:10 +0200
Message-ID: <1371573490-21973-1-git-send-email-matthijs@stdin.nl>
References: <20130618163609.GD10217@login.drsnuggles.stderr.nl>
Cc: Eric Wong <normalperson@yhbt.net>,
	Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>,
	Matthijs Kooijman <matthijs@stdin.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 18:38:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoyvL-0003NP-EC
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933002Ab3FRQiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 12:38:21 -0400
Received: from 84-245-11-97.dsl.cambrium.nl ([84.245.11.97]:57593 "EHLO
	grubby.stderr.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933015Ab3FRQiR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 12:38:17 -0400
Received: from matthijs by grubby.stderr.nl with local (Exim 4.80)
	(envelope-from <matthijs@stdin.nl>)
	id 1Uoyv5-0005ix-P5; Tue, 18 Jun 2013 18:38:11 +0200
X-Mailer: git-send-email 1.8.3.rc1
In-Reply-To: <20130618163609.GD10217@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228269>

This allows git-svn to prompt for a keyring unlock password, when a
the needed gnome keyring is locked.

This requires changes in the subversion perl bindings which have been
committed to svn trunk (r1241554 and some followup commits) and are
first available in the 1.8.0 release.
---
 perl/Git/SVN/Prompt.pm |  5 +++++
 perl/Git/SVN/Ra.pm     | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/perl/Git/SVN/Prompt.pm b/perl/Git/SVN/Prompt.pm
index e940b08..faeda01 100644
--- a/perl/Git/SVN/Prompt.pm
+++ b/perl/Git/SVN/Prompt.pm
@@ -23,6 +23,11 @@ sub simple {
 	$SVN::_Core::SVN_NO_ERROR;
 }
 
+sub gnome_keyring_unlock {
+	my ($keyring, $pool) = @_;
+	_read_password("Password for '$keyring' GNOME keyring: ", undef);
+}
+
 sub ssl_server_trust {
 	my ($cred, $realm, $failures, $cert_info, $may_save, $pool) = @_;
 	$may_save = undef if $_no_auth_cache;
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 75ecc42..38ed0cb 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -104,6 +104,19 @@ sub new {
 		}
 	} # no warnings 'once'
 
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
 	my $self = SVN::Ra->new(url => $url, auth => $baton,
 	                      config => $config,
 			      pool => SVN::Pool->new,
-- 
1.8.3.rc1
