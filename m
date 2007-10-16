From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: use "no warnings 'once'" to disable false-positives
Date: Tue, 16 Oct 2007 00:43:18 -0700
Message-ID: <20071016074318.GA32348@soma>
References: <20071015071912.GG984@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Tue Oct 16 09:44:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihh5b-0006PL-L8
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 09:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760977AbXJPHnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 03:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759809AbXJPHnU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 03:43:20 -0400
Received: from hand.yhbt.net ([66.150.188.102]:46382 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760266AbXJPHnT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 03:43:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id D6A0D7DC0FE;
	Tue, 16 Oct 2007 00:43:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071015071912.GG984@void.codelabs.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61105>

Thanks, minor nit regarding fixed in the patch below.

	"{ no warnings 'once';"

on the same line as the "{"

From: Eygene Ryabinkin <rea-git@codelabs.ru>
Date: Mon, 15 Oct 2007 11:19:12 +0400
Subject: [PATCH] git-svn: use "no warnings 'once'" to disable false-positives

Some variables coming from the Subversion's Perl bindings are used
in our code only once, so the interpreter warns us about it.  These
warnings are false-positives, because the variables themselves are
initialized in the binding's guts, that are made by SWIG.

Credits to Sam Vilain for his note about "no warnings 'once'".

[ew: minor formatting change]

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   87 ++++++++++++++++++++++++++++-----------------------------
 1 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 2c8a158..1130a09 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2303,23 +2303,31 @@ sub ssl_server_trust {
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
+	{
+		no warnings 'once';
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
@@ -2403,20 +2411,6 @@ sub _read_password {
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
@@ -2833,16 +2827,21 @@ sub open_or_add_dir {
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
+	{
+		no warnings 'once';
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
 
@@ -3068,11 +3067,11 @@ sub new {
 	my $dont_store_passwords = 1;
 	my $conf_t = ${$config}{'config'};
 	{
+		no warnings 'once';
 		# The usage of $SVN::_Core::SVN_CONFIG_* variables
 		# produces warnings that variables are used only once.
 		# I had not found the better way to shut them up, so
-		# warnings are disabled in this block.
-		no warnings;
+		# the warnings of type 'once' are disabled in this block.
 		if (SVN::_Core::svn_config_get_bool($conf_t,
 		    $SVN::_Core::SVN_CONFIG_SECTION_AUTH,
 		    $SVN::_Core::SVN_CONFIG_OPTION_STORE_PASSWORDS,
@@ -3087,7 +3086,7 @@ sub new {
 		    1) == 0) {
 			$Git::SVN::Prompt::_no_auth_cache = 1;
 		}
-	}
+	} # no warnings 'once'
 	my $self = SVN::Ra->new(url => $url, auth => $baton,
 	                      config => $config,
 			      pool => SVN::Pool->new,
-- 
1.5.3.4.1173.gcfeee

-- 
Eric Wong
