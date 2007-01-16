From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn - username/password
Date: Mon, 15 Jan 2007 20:20:08 -0800
Message-ID: <20070116042008.GA19873@localdomain>
References: <8664b73maf.fsf@blue.stonehenge.com> <20070116004137.GA10706@localdomain> <86sleb23vs.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 05:20:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6fo3-0005mS-6j
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 05:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbXAPEUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 23:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbXAPEUO
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 23:20:14 -0500
Received: from hand.yhbt.net ([66.150.188.102]:39274 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932197AbXAPEUM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 23:20:12 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D7C777DC094;
	Mon, 15 Jan 2007 20:20:08 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 15 Jan 2007 20:20:08 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <86sleb23vs.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36921>

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:
> 
> Eric> git-svn fetch --username <username> should work with recent-ish git-svn
> Eric> (since around Thanksgiving); and eventually prompt you for the password
> Eric> (just like svn does).
> 
> The prompts are broken... they're not being flushed properly.
> Once I knew it was talking to me, and not just stalled, I could
> type in the password at the right time.

That's odd.  I have $| = 1; at the beginning of git-svn.  Maybe
some module somewhere is unsetting $|...

Anyways, I think STDERR is more correct for prompts.

From: Eric Wong <normalperson@yhbt.net>
Date: Mon, 15 Jan 2007 20:15:55 -0800
Subject: [PATCH] git-svn: print and flush authentication prompts to STDERR

People that redirect STDOUT output should always see STDERR
prompts interactively.

STDERR should always be flushed without buffering, so
they should always show up.  If that is unset, we still
explicitly flush by calling STDERR->flush.

The svn command-line client prompts to STDERR, too.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

diff --git a/git-svn.perl b/git-svn.perl
index 9986a0c..b8ede9c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1918,7 +1918,8 @@ sub _simple_prompt {
 	$default_username = $_username if defined $_username;
 	if (defined $default_username && length $default_username) {
 		if (defined $realm && length $realm) {
-			print "Authentication realm: $realm\n";
+			print STDERR "Authentication realm: $realm\n";
+			STDERR->flush;
 		}
 		$cred->username($default_username);
 	} else {
@@ -1933,36 +1934,38 @@ sub _simple_prompt {
 sub _ssl_server_trust_prompt {
 	my ($cred, $realm, $failures, $cert_info, $may_save, $pool) = @_;
 	$may_save = undef if $_no_auth_cache;
-	print "Error validating server certificate for '$realm':\n";
+	print STDERR "Error validating server certificate for '$realm':\n";
 	if ($failures & $SVN::Auth::SSL::UNKNOWNCA) {
-		print " - The certificate is not issued by a trusted ",
+		print STDERR " - The certificate is not issued by a trusted ",
 		      "authority. Use the\n",
 	              "   fingerprint to validate the certificate manually!\n";
 	}
 	if ($failures & $SVN::Auth::SSL::CNMISMATCH) {
-		print " - The certificate hostname does not match.\n";
+		print STDERR " - The certificate hostname does not match.\n";
 	}
 	if ($failures & $SVN::Auth::SSL::NOTYETVALID) {
-		print " - The certificate is not yet valid.\n";
+		print STDERR " - The certificate is not yet valid.\n";
 	}
 	if ($failures & $SVN::Auth::SSL::EXPIRED) {
-		print " - The certificate has expired.\n";
+		print STDERR " - The certificate has expired.\n";
 	}
 	if ($failures & $SVN::Auth::SSL::OTHER) {
-		print " - The certificate has an unknown error.\n";
+		print STDERR " - The certificate has an unknown error.\n";
 	}
-	printf( "Certificate information:\n".
+	printf STDERR
+	        "Certificate information:\n".
 	        " - Hostname: %s\n".
 	        " - Valid: from %s until %s\n".
 	        " - Issuer: %s\n".
 	        " - Fingerprint: %s\n",
 	        map $cert_info->$_, qw(hostname valid_from valid_until
-	                               issuer_dname fingerprint) );
+	                               issuer_dname fingerprint);
 	my $choice;
 prompt:
-	print $may_save ?
+	print STDERR $may_save ?
 	      "(R)eject, accept (t)emporarily or accept (p)ermanently? " :
 	      "(R)eject or accept (t)emporarily? ";
+	STDERR->flush;
 	$choice = lc(substr(<STDIN> || 'R', 0, 1));
 	if ($choice =~ /^t$/i) {
 		$cred->may_save(undef);
@@ -1980,7 +1983,8 @@ prompt:
 sub _ssl_client_cert_prompt {
 	my ($cred, $realm, $may_save, $pool) = @_;
 	$may_save = undef if $_no_auth_cache;
-	print "Client certificate filename: ";
+	print STDERR "Client certificate filename: ";
+	STDERR->flush;
 	chomp(my $filename = <STDIN>);
 	$cred->cert_file($filename);
 	$cred->may_save($may_save);
@@ -1999,13 +2003,14 @@ sub _username_prompt {
 	my ($cred, $realm, $may_save, $pool) = @_;
 	$may_save = undef if $_no_auth_cache;
 	if (defined $realm && length $realm) {
-		print "Authentication realm: $realm\n";
+		print STDERR "Authentication realm: $realm\n";
 	}
 	my $username;
 	if (defined $_username) {
 		$username = $_username;
 	} else {
-		print "Username: ";
+		print STDERR "Username: ";
+		STDERR->flush;
 		chomp($username = <STDIN>);
 	}
 	$cred->username($username);
@@ -2015,7 +2020,8 @@ sub _username_prompt {
 
 sub _read_password {
 	my ($prompt, $realm) = @_;
-	print $prompt;
+	print STDERR $prompt;
+	STDERR->flush;
 	require Term::ReadKey;
 	Term::ReadKey::ReadMode('noecho');
 	my $password = '';
@@ -2024,7 +2030,8 @@ sub _read_password {
 		$password .= $key;
 	}
 	Term::ReadKey::ReadMode('restore');
-	print "\n";
+	print STDERR "\n";
+	STDERR->flush;
 	$password;
 }
 
-- 
Eric Wong
