From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Git.pm: Add remote_refs() git-ls-remote frontend
Date: Tue, 08 Jul 2008 19:48:04 +0200
Message-ID: <20080708173523.7359.63945.stgit@rover.dkm.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 08 19:50:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGHKL-0007eL-62
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 19:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbYGHRtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 13:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbYGHRtL
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 13:49:11 -0400
Received: from rover.dkm.cz ([62.24.64.27]:47111 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546AbYGHRtK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 13:49:10 -0400
Received: from rover.dkm.cz (localhost [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id EBAE1166741;
	Tue,  8 Jul 2008 19:48:04 +0200 (CEST)
User-Agent: StGIT/0.14.3.171.ge0e6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87780>

This patch also converts the good ole' git-remote.perl to use it.
It is otherwise used in the repo.or.cz machinery and I guess other
scripts might find it useful too.

Unfortunately,

	git-ls-remote --heads .
	
is subtly different from

	git-ls-remote . refs/heads/

(since the second matches anywhere in the string, not just at the
beginning) so we have to provide interface for both.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

  This is resend after another year. ;-)

 contrib/examples/git-remote.perl |    5 +--
 perl/Git.pm                      |   56 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 5 deletions(-)


diff --git a/contrib/examples/git-remote.perl b/contrib/examples/git-remote.perl
index b30ed73..36bd54c 100755
--- a/contrib/examples/git-remote.perl
+++ b/contrib/examples/git-remote.perl
@@ -129,10 +129,7 @@ sub update_ls_remote {
 	return if (($harder == 0) ||
 		   (($harder == 1) && exists $info->{'LS_REMOTE'}));
 
-	my @ref = map {
-		s|^[0-9a-f]{40}\s+refs/heads/||;
-		$_;
-	} $git->command(qw(ls-remote --heads), $info->{'URL'});
+	my @ref = map { s|refs/heads/||; $_; } keys %{$git->remote_refs($info->{'URL'}, [ 'heads' ])};
 	$info->{'LS_REMOTE'} = \@ref;
 }
 
diff --git a/perl/Git.pm b/perl/Git.pm
index 97e61ef..d99e778 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -56,7 +56,8 @@ require Exporter;
 @EXPORT_OK = qw(command command_oneline command_noisy
                 command_output_pipe command_input_pipe command_close_pipe
                 command_bidi_pipe command_close_bidi_pipe
-                version exec_path hash_object git_cmd_try);
+                version exec_path hash_object git_cmd_try
+                remote_refs);
 
 
 =head1 DESCRIPTION
@@ -668,6 +669,59 @@ sub get_color {
 	return $color;
 }
 
+=item remote_refs ( REPOSITORY [, GROUPS [, REFGLOBS ] ] )
+
+This function returns a hashref of refs stored in a given remote repository.
+The hash is in the format C<refname =\> hash>. For tags, the C<refname> entry
+contains the tag object while a C<refname^{}> entry gives the tagged objects.
+
+C<REPOSITORY> has the same meaning as the appropriate C<git-ls-remote>
+argument; either an URL or a remote name (if called on a repository instance).
+C<GROUPS> is an optional arrayref that can contain 'tags' to return all the
+tags and/or 'heads' to return all the heads. C<REFGLOB> is an optional array
+of strings containing a shell-like glob to further limit the refs returned in
+the hash; the meaning is again the same as the appropriate C<git-ls-remote>
+argument.
+
+This function may or may not be called on a repository instance. In the former
+case, remote names as defined in the repository are recognized as repository
+specifiers.
+
+=cut
+
+sub remote_refs {
+	my ($self, $repo, $groups, $refglobs) = _maybe_self(@_);
+	my @args;
+	if (ref $groups eq 'ARRAY') {
+		foreach (@$groups) {
+			if ($_ eq 'heads') {
+				push (@args, '--heads');
+			} elsif ($_ eq 'tags') {
+				push (@args, '--tags');
+			} else {
+				# Ignore unknown groups for future
+				# compatibility
+			}
+		}
+	}
+	push (@args, $repo);
+	if (ref $refglobs eq 'ARRAY') {
+		push (@args, @$refglobs);
+	}
+
+	my @self = $self ? ($self) : (); # Ultra trickery
+	my ($fh, $ctx) = Git::command_output_pipe(@self, 'ls-remote', @args);
+	my %refs;
+	while (<$fh>) {
+		chomp;
+		my ($hash, $ref) = split(/\t/, $_, 2);
+		$refs{$ref} = $hash;
+	}
+	Git::command_close_pipe(@self, $fh, $ctx);
+	return \%refs;
+}
+
+
 =item ident ( TYPE | IDENTSTR )
 
 =item ident_person ( TYPE | IDENTSTR | IDENTARRAY )
