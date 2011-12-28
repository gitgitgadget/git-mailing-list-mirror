From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt method
 for querying users
Date: Wed, 28 Dec 2011 01:12:56 +0100
Message-ID: <4EFA5F08.2060705@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 01:13:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rfh8g-0004AJ-55
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 01:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812Ab1L1AM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 19:12:59 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:64152 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752407Ab1L1AM5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Dec 2011 19:12:57 -0500
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 274A529A61D;
	Wed, 28 Dec 2011 01:12:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=q67iMnpy26rjuuB+lst6gMr4SLQ=; b=bnL9Z0W9oalARQ7uXcC/I14+fpCj
	gk0BWV7tvxyYXuARoXFIyvQCuXM6BXc6e0C2/ffiUlOCDjLal3IXOUMHs/VttjuN
	D7dr540ryl/aSImkxS4w5/3ra4N4yqi/F2ht9d+Fok+lzJvIxNwfOrfFUldi7wdf
	HRPFSLtXSngwoWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=oD1g66BgkeFxQM5BNgZEZTTcfTW7jldtpPlhSHr+RFccWhpF8hasAwn
	5QVkAYMf/AUm0oaQrB4Yh78J29zIcZ2kOPNWLsDp/VYcEn4QQt1L3Th/Gq8p/woL
	8tzoageHPnwkkoQ19tVLw83uyxDcKa+FaZqZjzyRy3bz75j8oWyk=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id DD13729A611;
	Wed, 28 Dec 2011 01:12:55 +0100 (CET)
Received: from [91.4.113.35] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25252224; Wed, 28 Dec 2011 01:12:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vty4l4rr8.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187740>

git-svn reads usernames and other user queries from an interactive
terminal. This cause GUIs (w/o STDIN connected) to hang waiting forever
for git-svn to complete (http://code.google.com/p/tortoisegit/issues/detail?id=967).

This change extends the Git->prompt method, so that it can also be used
for non password queries, and makes use of it instead of using
hand-rolled prompt-response code that only works with the interactive
terminal.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 git-svn.perl |   16 +++++-----------
 perl/Git.pm  |   25 +++++++++++++++----------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index bcee8aa..1f30dc2 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4357,11 +4357,10 @@ sub ssl_server_trust {
 	                               issuer_dname fingerprint);
 	my $choice;
 prompt:
-	print STDERR $may_save ?
+	my $options = $may_save ?
 	      "(R)eject, accept (t)emporarily or accept (p)ermanently? " :
 	      "(R)eject or accept (t)emporarily? ";
-	STDERR->flush;
-	$choice = lc(substr(<STDIN> || 'R', 0, 1));
+	$choice = substr(Git->prompt("Certificate unknown. " . $options) || 'R', 0, 1);
 	if ($choice =~ /^t$/i) {
 		$cred->may_save(undef);
 	} elsif ($choice =~ /^r$/i) {
@@ -4378,10 +4377,7 @@ prompt:
 sub ssl_client_cert {
 	my ($cred, $realm, $may_save, $pool) = @_;
 	$may_save = undef if $_no_auth_cache;
-	print STDERR "Client certificate filename: ";
-	STDERR->flush;
-	chomp(my $filename = <STDIN>);
-	$cred->cert_file($filename);
+	$cred->cert_file(Git->prompt("Client certificate filename: "));
 	$cred->may_save($may_save);
 	$SVN::_Core::SVN_NO_ERROR;
 }
@@ -4404,9 +4400,7 @@ sub username {
 	if (defined $_username) {
 		$username = $_username;
 	} else {
-		print STDERR "Username: ";
-		STDERR->flush;
-		chomp($username = <STDIN>);
+		$username = Git->prompt("Username: ");
 	}
 	$cred->username($username);
 	$cred->may_save($may_save);
@@ -4415,7 +4409,7 @@ sub username {

 sub _read_password {
 	my ($prompt, $realm) = @_;
-	my $password = Git->prompt($prompt);
+	my $password = Git->prompt($prompt, 1);
 	$password;
 }

diff --git a/perl/Git.pm b/perl/Git.pm
index b1c7c50..62b824c 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -512,18 +512,19 @@ C<git --html-path>). Useful mostly only internally.
 sub html_path { command_oneline('--html-path') }


-=item prompt ( PROMPT )
+=item prompt ( PROMPT , ISPASSWORD )

 Query user C<PROMPT> and return answer from user.

 Check if GIT_ASKPASS or SSH_ASKPASS is set, use first matching for querying
 user and return answer. If no *_ASKPASS variable is set, the variable is
 empty or an error occoured, the terminal is tried as a fallback.
+If C<ISPASSWORD> is set and true, the terminal disables echo.

 =cut

 sub prompt {
-	my ($self, $prompt) = _maybe_self(@_);
+	my ($self, $prompt, $isPassword) = _maybe_self(@_);
 	my $ret;
 	if (exists $ENV{'GIT_ASKPASS'}) {
 		$ret = _prompt($ENV{'GIT_ASKPASS'}, $prompt);
@@ -534,15 +535,19 @@ sub prompt {
 	if (!defined $ret) {
 		print STDERR $prompt;
 		STDERR->flush;
-		require Term::ReadKey;
-		Term::ReadKey::ReadMode('noecho');
-		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
-			last if $key =~ /[\012\015]/; # \n\r
-			$ret .= $key;
+		if (defined $isPassword && $isPassword) {
+			require Term::ReadKey;
+			Term::ReadKey::ReadMode('noecho');
+			while (defined(my $key = Term::ReadKey::ReadKey(0))) {
+				last if $key =~ /[\012\015]/; # \n\r
+				$ret .= $key;
+			}
+			Term::ReadKey::ReadMode('restore');
+			print STDERR "\n";
+			STDERR->flush;
+		} else {
+			chomp($ret = <STDIN>);
 		}
-		Term::ReadKey::ReadMode('restore');
-		print STDERR "\n";
-		STDERR->flush;
 	}
 	return $ret;
 }
-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
