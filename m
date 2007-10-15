From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH] git-svn: use "no warnings 'once'" to disable false-positives
Date: Mon, 15 Oct 2007 11:19:12 +0400
Message-ID: <20071015071912.GG984@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 09:19:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhKEa-0007Ku-PC
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 09:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447AbXJOHTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 03:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754646AbXJOHTS
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 03:19:18 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:54048 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378AbXJOHTS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 03:19:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:Content-Disposition:Sender:X-Spam-Status:Subject;
	b=W9y0eRPZE7WXfYYCFX7qRd9lsQJkyVzIJ8z+CzEGULuY4HL1CXd6v0lgLfvdSRZwRQX9ojQ6669l+iG6yhBMzTIKUEgv/BRCNPhSFSOh2K7M1xxm14D7TcFNLHA0Mjc8X7FkEzC9sUjJxvLygtlrUz4SoH2WDuZYfaTC53Wk1Bw=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1IhKEO-00056E-FP; Mon, 15 Oct 2007 11:19:16 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-2.0 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60956>

Some variables coming from the Subversion's Perl bindings are used
in our code only once, so the interpreter warns us about it.  These
warnings are false-positives, because the variables themselves are
initialized in the binding's guts, that are made by SWIG.

Credits to Sam Vilain for his note about "no warnings 'once'".

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 git-svn.perl |   86 +++++++++++++++++++++++++++------------------------------
 1 files changed, 41 insertions(+), 45 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index f7ef421..39a70bf 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2293,23 +2293,30 @@ sub ssl_server_trust {
 	my ($cred, $realm, $failures, $cert_info, $may_save, $pool) = @_;
 	$may_save = undef if $_no_auth_cache;
 	print STDERR "Error validating server certificate for '$realm':\n";
-	if ($failures & $SVN::Auth::SSL::UNKNOWNCA) {
-		print STDERR " - The certificate is not issued by a trusted ",
-		      "authority. Use the\n",
-	              "   fingerprint to validate the certificate manually!\n";
-	}
-	if ($failures & $SVN::Auth::SSL::CNMISMATCH) {
-		print STDERR " - The certificate hostname does not match.\n";
-	}
-	if ($failures & $SVN::Auth::SSL::NOTYETVALID) {
-		print STDERR " - The certificate is not yet valid.\n";
-	}
-	if ($failures & $SVN::Auth::SSL::EXPIRED) {
-		print STDERR " - The certificate has expired.\n";
-	}
-	if ($failures & $SVN::Auth::SSL::OTHER) {
-		print STDERR " - The certificate has an unknown error.\n";
-	}
+	{ no warnings 'once';
+		# All variables SVN::Auth::SSL::* are used only once,
+		# so we're shutting up Perl warnings about this.
+		if ($failures & $SVN::Auth::SSL::UNKNOWNCA) {
+			print STDERR " - The certificate is not issued ",
+			    "by a trusted authority. Use the\n",
+			    "   fingerprint to validate ",
+			    "the certificate manually!\n";
+		}
+		if ($failures & $SVN::Auth::SSL::CNMISMATCH) {
+			print STDERR " - The certificate hostname ",
+			    "does not match.\n";
+		}
+		if ($failures & $SVN::Auth::SSL::NOTYETVALID) {
+			print STDERR " - The certificate is not yet valid.\n";
+		}
+		if ($failures & $SVN::Auth::SSL::EXPIRED) {
+			print STDERR " - The certificate has expired.\n";
+		}
+		if ($failures & $SVN::Auth::SSL::OTHER) {
+			print STDERR " - The certificate has ",
+			    "an unknown error.\n";
+		}
+	} # no warnings 'once'
 	printf STDERR
 	        "Certificate information:\n".
 	        " - Hostname: %s\n".
@@ -2393,20 +2400,6 @@ sub _read_password {
 	$password;
 }
 
-package main;
-
-{
-	my $kill_stupid_warnings = $SVN::Node::none.$SVN::Node::file.
-				$SVN::Node::dir.$SVN::Node::unknown.
-				$SVN::Node::none.$SVN::Node::file.
-				$SVN::Node::dir.$SVN::Node::unknown.
-				$SVN::Auth::SSL::CNMISMATCH.
-				$SVN::Auth::SSL::NOTYETVALID.
-				$SVN::Auth::SSL::EXPIRED.
-				$SVN::Auth::SSL::UNKNOWNCA.
-				$SVN::Auth::SSL::OTHER;
-}
-
 package SVN::Git::Fetcher;
 use vars qw/@ISA/;
 use strict;
@@ -2823,16 +2816,20 @@ sub open_or_add_dir {
 	if (!defined $t) {
 		die "$full_path not known in r$self->{r} or we have a bug!\n";
 	}
-	if ($t == $SVN::Node::none) {
-		return $self->add_directory($full_path, $baton,
-						undef, -1, $self->{pool});
-	} elsif ($t == $SVN::Node::dir) {
-		return $self->open_directory($full_path, $baton,
-						$self->{r}, $self->{pool});
-	}
-	print STDERR "$full_path already exists in repository at ",
-		"r$self->{r} and it is not a directory (",
-		($t == $SVN::Node::file ? 'file' : 'unknown'),"/$t)\n";
+	{ no warnings 'once';
+		# SVN::Node::none and SVN::Node::file are used only once,
+		# so we're shutting up Perl's warnings about them.
+		if ($t == $SVN::Node::none) {
+			return $self->add_directory($full_path, $baton,
+			    undef, -1, $self->{pool});
+		} elsif ($t == $SVN::Node::dir) {
+			return $self->open_directory($full_path, $baton,
+			    $self->{r}, $self->{pool});
+		} # no warnings 'once'
+		print STDERR "$full_path already exists in repository at ",
+		    "r$self->{r} and it is not a directory (",
+		    ($t == $SVN::Node::file ? 'file' : 'unknown'),"/$t)\n";
+	} # no warnings 'once'
 	exit 1;
 }
 
@@ -3053,12 +3050,11 @@ sub new {
 	$RA = undef;
 	my $dont_store_passwords = 1;
 	my $conf_t = ${$config}{'config'};
-	{
+	{ no warnings 'once';
 		# The usage of $SVN::_Core::SVN_CONFIG_* variables
 		# produces warnings that variables are used only once.
 		# I had not found the better way to shut them up, so
-		# warnings are disabled in this block.
-		no warnings;
+		# the warnings of type 'once' are disabled in this block.
 		if (SVN::_Core::svn_config_get_bool($conf_t,
 		    $SVN::_Core::SVN_CONFIG_SECTION_AUTH,
 		    $SVN::_Core::SVN_CONFIG_OPTION_STORE_PASSWORDS,
@@ -3073,7 +3069,7 @@ sub new {
 		    1) == 0) {
 			$Git::SVN::Prompt::_no_auth_cache = 1;
 		}
-	}
+	} # no warnings 'once'
 	my $self = SVN::Ra->new(url => $url, auth => $baton,
 	                      config => $config,
 			      pool => SVN::Pool->new,
-- 
1.5.3.2
