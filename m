From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Git.pm: Call external commands using execv_git_cmd()
Date: Fri, 23 Jun 2006 01:37:52 +0200
Message-ID: <20060622233752.29122.78856.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 23 01:38:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtYkK-0001xC-JB
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 01:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbWFVXh4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 19:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWFVXh4
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 19:37:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4282 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932706AbWFVXhz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 19:37:55 -0400
Received: (qmail 29132 invoked from network); 23 Jun 2006 01:37:52 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 23 Jun 2006 01:37:52 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22384>

Instead of explicitly using the git wrapper to call external commands,
use the execv_git_cmd() function which will directly call whatever
needs to be called. GitBin option becomes useless so drop it.

This actually means the exec_path() thing I planned to use worthless
internally, but Jakub wants it in anyway and I don't mind, so...

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.pm |   12 ++++++------
 perl/Git.xs |   20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 516c065..5b233ed 100644
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
index d1f94a4..f94ee95 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -29,6 +29,26 @@ OUTPUT:
 	RETVAL
 
 
+void
+xs__execv_git_cmd(...)
+CODE:
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
+			free(argv[i]);
+	free(argv);
+
 char *
 xs_hash_object(file, type = "blob")
 	SV *file;
