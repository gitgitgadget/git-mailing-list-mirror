From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Git.pm: Add remote_refs() git-ls-remote frontend
Date: Sun, 26 Aug 2007 00:11:44 +0200
Message-ID: <20070825221143.6514.22516.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 00:47:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP4Pi-0007D6-4z
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 00:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbXHYWqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 18:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934575AbXHYWqu
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 18:46:50 -0400
Received: from rover.dkm.cz ([62.24.64.27]:45304 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934378AbXHYWqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 18:46:48 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 4FC568B557;
	Sun, 26 Aug 2007 00:11:44 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56662>

Should support all the important features, I guess. Too bad that
	git-ls-remote --heads .
	
is subtly different from

	git-ls-remote . refs/heads/

so we have to provide the interface for specifying both.

This patch also converts git-remote.perl to use it.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 git-remote.perl |    5 +----
 perl/Git.pm     |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index 01cf480..8ce8418 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -128,10 +128,7 @@ sub update_ls_remote {
 	return if (($harder == 0) ||
 		   (($harder == 1) && exists $info->{'LS_REMOTE'}));
 
-	my @ref = map {
-		s|^[0-9a-f]{40}\s+refs/heads/||;
-		$_;
-	} $git->command(qw(ls-remote --heads), $info->{'URL'});
+	my @ref = keys %{$git->remote_refs($info->{'URL'}, [ 'heads' ])};
 	$info->{'LS_REMOTE'} = \@ref;
 }
 
diff --git a/perl/Git.pm b/perl/Git.pm
index 3f4080c..3bce733 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -51,7 +51,7 @@ require Exporter;
 # Methods which can be called as standalone functions as well:
 @EXPORT_OK = qw(command command_oneline command_noisy
                 command_output_pipe command_input_pipe command_close_pipe
-                version exec_path hash_object git_cmd_try);
+                version exec_path hash_object git_cmd_try remote_refs);
 
 
 =head1 DESCRIPTION
@@ -550,6 +550,59 @@ sub config_bool {
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
