From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 03/12] Git.pm: Call external commands using execv_git_cmd()
Date: Sat, 24 Jun 2006 04:34:34 +0200
Message-ID: <20060624023433.32751.68321.stgit@machine.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 04:35:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtxzN-0006gs-0h
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 04:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933191AbWFXCfE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 22:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933194AbWFXCfE
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 22:35:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60311 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S933191AbWFXCfB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 22:35:01 -0400
Received: (qmail 310 invoked from network); 24 Jun 2006 04:34:34 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 24 Jun 2006 04:34:34 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060624023429.32751.80619.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22469>

Instead of explicitly using the git wrapper to call external commands,
use the execv_git_cmd() function which will directly call whatever
needs to be called. GitBin option becomes useless so drop it.

This actually means the exec_path() thing I planned to use worthless
internally, but Jakub wants it in anyway and I don't mind, so...

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.pm |   12 ++++++------
 perl/Git.xs |   22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 5c5ae12..212337e 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -122,9 +122,6 @@ to the subdirectory and the directory is
 If the directory does not have the subdirectory, C<WorkingCopy> is left
 undefined and C<Repository> is pointed to the directory itself.
 
-B<GitPath> - Path to the C<git> binary executable. By default the C<$PATH>
-is searched for it.
-
 You should not use both C<Directory> and either of C<Repository> and
 C<WorkingCopy> - the results of that are undefined.
 
@@ -363,11 +360,14 @@ sub _cmd_exec {
 		$self->{opts}->{Repository} and $ENV{'GIT_DIR'} = $self->{opts}->{Repository};
 		$self->{opts}->{WorkingCopy} and chdir($self->{opts}->{WorkingCopy});
 	}
-	my $git = $self->{opts}->{GitPath};
-	$git ||= 'git';
-	exec ($git, @args) or croak "exec failed: $!";
+	xs__execv_git_cmd(@args);
+	croak "exec failed: $!";
 }
 
+# Execute the given Git command ($_[0]) with arguments ($_[1..])
+# by searching for it at proper places.
+# _execv_git_cmd(), implemented in Git.xs.
+
 # Close pipe to a subprocess.
 sub _cmd_close {
 	my ($fh) = @_;
diff --git a/perl/Git.xs b/perl/Git.xs
index b6f6d13..c8220e2 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -33,6 +33,28 @@ OUTPUT:
 	RETVAL
 
 
+void
+xs__execv_git_cmd(...)
+CODE:
+{
+	const char **argv;
+	int i;
+
+	argv = malloc(sizeof(const char *) * (items + 1));
+	if (!argv)
+		croak("malloc failed");
+	for (i = 0; i < items; i++)
+		argv[i] = strdup(SvPV_nolen(ST(i)));
+	argv[i] = NULL;
+
+	execv_git_cmd(argv);
+
+	for (i = 0; i < items; i++)
+		if (argv[i])
+			free((char *) argv[i]);
+	free((char **) argv);
+}
+
 char *
 xs_hash_object(file, type = "blob")
 	SV *file;
