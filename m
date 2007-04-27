From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/4] Git.pm: config_boolean() -> config_bool()
Date: Fri, 27 Apr 2007 04:06:01 +0200
Message-ID: <20070427020601.22991.13792.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 04:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhGAa-0005sB-5p
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 04:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417AbXD0C0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 22:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755425AbXD0C0f
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 22:26:35 -0400
Received: from rover.dkm.cz ([62.24.64.27]:50260 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755417AbXD0C0e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 22:26:34 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id B1E4E8BE63;
	Fri, 27 Apr 2007 04:06:01 +0200 (CEST)
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45671>

This patch renames config_boolean() to config_bool() for consistency with
the commandline interface and because it is shorter but still obvious. ;-)
It also changes the return value from some obscure string to real Perl
boolean, allowing for clean user code.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 git-remote.perl |    4 ++--
 perl/Git.pm     |   12 ++++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index 52013fe..5763799 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -297,9 +297,9 @@ sub update_remote {
 	} elsif ($name eq 'default') {
 		undef @remotes;
 		for (sort keys %$remote) {
-			my $do_fetch = $git->config_boolean("remote." . $_ .
+			my $do_fetch = $git->config_bool("remote." . $_ .
 						    ".skipDefaultUpdate");
-			if (!defined($do_fetch) || $do_fetch ne "true") {
+			unless ($do_fetch) {
 				push @remotes, $_;
 			}
 		}
diff --git a/perl/Git.pm b/perl/Git.pm
index b5b1cf5..50c2993 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -516,9 +516,11 @@ sub config {
 }
 
 
-=item config_boolean ( VARIABLE )
+=item config_bool ( VARIABLE )
 
-Retrieve the boolean configuration C<VARIABLE>.
+Retrieve the bool configuration C<VARIABLE>. The return value
+is usable as a boolean in perl (and C<undef> if it's not defined,
+of course).
 
 Must be called on a repository instance.
 
@@ -526,14 +528,16 @@ This currently wraps command('config') s
 
 =cut
 
-sub config_boolean {
+sub config_bool {
 	my ($self, $var) = @_;
 	$self->repo_path()
 		or throw Error::Simple("not a repository");
 
 	try {
-		return $self->command_oneline('config', '--bool', '--get',
+		my $var = $self->command_oneline('config', '--bool', '--get',
 					      $var);
+		return undef unless defined $var;
+		return $var eq 'true';
 	} catch Git::Error::Command with {
 		my $E = shift;
 		if ($E->value() == 1) {
