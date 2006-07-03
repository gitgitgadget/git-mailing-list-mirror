From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/6] Git.pm: Add config() method
Date: Mon, 03 Jul 2006 22:47:55 +0200
Message-ID: <20060703204755.28541.48666.stgit@machine.or.cz>
References: <20060703204415.28541.47920.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 03 22:48:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxVLJ-0007pa-TI
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 22:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWGCUsB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 16:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWGCUsA
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 16:48:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31411 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751288AbWGCUr7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 16:47:59 -0400
Received: (qmail 29190 invoked from network); 3 Jul 2006 22:47:56 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 3 Jul 2006 22:47:56 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060703204415.28541.47920.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23205>

This accessor will retrieve value(s) of the given configuration variable.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-repo-config.txt |    3 ++-
 perl/Git.pm                       |   37 ++++++++++++++++++++++++++++++++++++-
 repo-config.c                     |    2 +-
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index 803c0d5..cc72fa9 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -54,7 +54,8 @@ OPTIONS
 
 --get::
 	Get the value for a given key (optionally filtered by a regex
-	matching the value).
+	matching the value). Returns error code 1 if the key was not
+	found and error code 2 if multiple key values were found.
 
 --get-all::
 	Like get, but does not fail if the number of values for the key
diff --git a/perl/Git.pm b/perl/Git.pm
index b4ee88b..24fd7ce 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -473,7 +473,6 @@ and the directory must exist.
 
 sub wc_chdir {
 	my ($self, $subdir) = @_;
-
 	$self->wc_path()
 		or throw Error::Simple("bare repository");
 
@@ -486,6 +485,42 @@ sub wc_chdir {
 }
 
 
+=item config ( VARIABLE )
+
+Retrieve the configuration C<VARIABLE> in the same manner as C<repo-config>
+does. In scalar context requires the variable to be set only one time
+(exception is thrown otherwise), in array context returns allows the
+variable to be set multiple times and returns all the values.
+
+Must be called on a repository instance.
+
+This currently wraps command('repo-config') so it is not so fast.
+
+=cut
+
+sub config {
+	my ($self, $var) = @_;
+	$self->repo_path()
+		or throw Error::Simple("not a repository");
+
+	try {
+		if (wantarray) {
+			return $self->command('repo-config', '--get-all', $var);
+		} else {
+			return $self->command_oneline('repo-config', '--get', $var);
+		}
+	} catch Git::Error::Command with {
+		my $E = shift;
+		if ($E->value() == 1) {
+			# Key not found.
+			return undef;
+		} else {
+			throw $E;
+		}
+	};
+}
+
+
 =item hash_object ( TYPE, FILENAME )
 
 =item hash_object ( TYPE, FILEHANDLE )
diff --git a/repo-config.c b/repo-config.c
index 743f02b..c7ed0ac 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -118,7 +118,7 @@ static int get_value(const char* key_, c
 	if (do_all)
 		ret = !seen;
 	else
-		ret =  (seen == 1) ? 0 : 1;
+		ret = (seen == 1) ? 0 : seen > 1 ? 2 : 1;
 
 free_strings:
 	if (repo_config)
