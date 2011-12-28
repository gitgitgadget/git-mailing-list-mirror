From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH 1/2] git-svn, perl/Git.pm: add central method for prompting
 passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Wed, 28 Dec 2011 01:11:31 +0100
Message-ID: <4EFA5EB3.4000802@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 01:11:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rfh7U-0006bZ-6H
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 01:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740Ab1L1ALo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 19:11:44 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:23101 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab1L1ALm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 19:11:42 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id AF87D422118;
	Wed, 28 Dec 2011 01:11:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=iXUxVQjizLsFYbNu1qPTitZR8a8=; b=jcsFp1C1rGWJZBRCp2WAuozchR71
	B/+jfG5G9BWwJr3s+Upov6vyYZoxfdNy04lRSjYKAXtW/XLb8ze41PvdqqL/wsTm
	aATLzLKDczHGXQeq+F9XkAtTxYdmwY7ThJWMf0GVsqVcBYf1VY/Y4h5imiizDBYy
	VvdmDIpHYzIQrvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=X9Brl1TzAKDXywdorOx3EFITu6vF2sZ4KLV9jcd61+eqq612rqzrkhY
	rbT29poBzwKW1KsMpXRPZIu+ObXY0m8WF6VGcl8oWSfdRQQ61+DtulTB8tTE+ma6
	yjM72LAHvO0Z9ajvQA6DT7hhqnyZvZx+2YNPgnSd2s7uBpGJWgRY=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 5214D42210E;
	Wed, 28 Dec 2011 01:11:40 +0100 (CET)
Received: from [91.4.113.35] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25252303; Wed, 28 Dec 2011 01:11:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vty4l4rr8.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187739>

git-svn reads passwords from an interactive terminal or by using
GIT_ASKPASS helper tool. But if GIT_ASKPASS environment variable is not
set, git-svn does not try to use SSH_ASKPASS as git-core does. This
cause GUIs (w/o STDIN connected) to hang waiting forever for git-svn to
complete (http://code.google.com/p/tortoisegit/issues/detail?id=967).

Commit 56a853b62c0ae7ebaad0a7a0a704f5ef561eb795 tried to solve this
issue, but was incomplete as described above.

Instead of using hand-rolled prompt-response code that only works with
the interactive terminal, a reusable prompt() method is introduced in
this commit. This change also adds a fallback to SSH_ASKPASS.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 git-svn.perl |   20 +-------------------
 perl/Git.pm  |   51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index eeb83d3..bcee8aa 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4415,25 +4415,7 @@ sub username {

 sub _read_password {
 	my ($prompt, $realm) = @_;
-	my $password = '';
-	if (exists $ENV{GIT_ASKPASS}) {
-		open(PH, "-|", $ENV{GIT_ASKPASS}, $prompt);
-		$password = <PH>;
-		$password =~ s/[\012\015]//; # \n\r
-		close(PH);
-	} else {
-		print STDERR $prompt;
-		STDERR->flush;
-		require Term::ReadKey;
-		Term::ReadKey::ReadMode('noecho');
-		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
-			last if $key =~ /[\012\015]/; # \n\r
-			$password .= $key;
-		}
-		Term::ReadKey::ReadMode('restore');
-		print STDERR "\n";
-		STDERR->flush;
-	}
+	my $password = Git->prompt($prompt);
 	$password;
 }

diff --git a/perl/Git.pm b/perl/Git.pm
index f7ce511..b1c7c50 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -58,7 +58,7 @@ require Exporter;
                 command_output_pipe command_input_pipe command_close_pipe
                 command_bidi_pipe command_close_bidi_pipe
                 version exec_path html_path hash_object git_cmd_try
-                remote_refs
+                remote_refs prompt
                 temp_acquire temp_release temp_reset temp_path);


@@ -512,6 +512,55 @@ C<git --html-path>). Useful mostly only internally.
 sub html_path { command_oneline('--html-path') }


+=item prompt ( PROMPT )
+
+Query user C<PROMPT> and return answer from user.
+
+Check if GIT_ASKPASS or SSH_ASKPASS is set, use first matching for querying
+user and return answer. If no *_ASKPASS variable is set, the variable is
+empty or an error occoured, the terminal is tried as a fallback.
+
+=cut
+
+sub prompt {
+	my ($self, $prompt) = _maybe_self(@_);
+	my $ret;
+	if (exists $ENV{'GIT_ASKPASS'}) {
+		$ret = _prompt($ENV{'GIT_ASKPASS'}, $prompt);
+	}
+	if (!defined $ret && exists $ENV{'SSH_ASKPASS'}) {
+		$ret = _prompt($ENV{'SSH_ASKPASS'}, $prompt);
+	}
+	if (!defined $ret) {
+		print STDERR $prompt;
+		STDERR->flush;
+		require Term::ReadKey;
+		Term::ReadKey::ReadMode('noecho');
+		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
+			last if $key =~ /[\012\015]/; # \n\r
+			$ret .= $key;
+		}
+		Term::ReadKey::ReadMode('restore');
+		print STDERR "\n";
+		STDERR->flush;
+	}
+	return $ret;
+}
+
+sub _prompt {
+	my ($askpass, $prompt) = @_;
+	unless ($askpass) {
+		return undef;
+	}
+	my $ret;
+	open my $fh, "-|", $askpass, $prompt || return undef;
+	$ret = <$fh>;
+	$ret =~ s/[\012\015]//g; # strip \n\r, chomp does not work on all systems (i.e. windows) as expected
+	close ($fh);
+	return $ret;
+}
+
+
 =item repo_path ()

 Return path to the git repository. Must be called on a repository instance.
-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
