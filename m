From: Phil Miller <mille121@illinois.edu>
Subject: [PATCH/resend] CVS Server: Support reading base and roots from 
 environment
Date: Wed, 30 Dec 2009 13:35:31 -0600
Message-ID: <1262201731.30213.23.camel@phil-laptop>
References: <81f018ac0911200805g55bd1607u651334c1ed7f1303@mail.gmail.com>
	 <7vocmwvmvr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 20:35:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ4Kc-0003ad-SP
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 20:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbZL3Tfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 14:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753165AbZL3Tfh
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 14:35:37 -0500
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:47043 "EHLO
	QMTA09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753128AbZL3Tfh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 14:35:37 -0500
Received: from OMTA22.emeryville.ca.mail.comcast.net ([76.96.30.89])
	by QMTA09.emeryville.ca.mail.comcast.net with comcast
	id PW9F1d0041vN32cA9Xbcfs; Wed, 30 Dec 2009 19:35:36 +0000
Received: from [192.168.1.100] ([98.212.229.232])
	by OMTA22.emeryville.ca.mail.comcast.net with comcast
	id PXd81d00851ViH68iXd9GZ; Wed, 30 Dec 2009 19:37:10 +0000
In-Reply-To: <7vocmwvmvr.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135917>

The Gitosis single-account Git/ssh hosting system runs git commands
through git-shell after confirming that the connecting user is
authorized to access the requested repository. This works well for
upload-pack and receive-pack, which take a repository argument through
git-shell. This doesn't work so well for `cvs server', which is passed
through literally, with no arguments. Allowing arguments risks
sneaking in `--export-all', so that restriction should be maintained.

Despite that, passing a repository root is necessary for per-user
access control by the hosting software, and passing a base path
improves usability without weakening security. Thus, git-cvsserver
needs to come up with these values at runtime by some other
means. Since git-shell preserves the environment for other purposes,
the environment can carry these arguments as well.

Thus, modify git-cvsserver to read $GIT_CVSSERVER_{BASE_PATH,ROOT} in
the absence of equivalent command line arguments.

Signed-off-by: Phil Miller <mille121@illinois.edu>
---
I believe this revision addresses all of your comments on the first submission.

Your comment about cramming multiple values into one environment variable made
me realize that more than one simply was unnecessary complexity, since gitosis
expects to authenticate access to a single repository anyway.

I've not documented what GIT_CVSSERVER_BASE_PATH is relative to, because it
behaves identically to the --base-path command line argument. Documenting
what that is relative to is a separate issue.

 Documentation/git-cvsserver.txt |   15 +++++++++++++++
 git-cvsserver.perl              |   22 +++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 99a7c14..fbab295 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -277,6 +277,21 @@ In `dbdriver` and `dbuser` you can use the following variables:
 	If no name can be determined, the
 	numeric uid is used.
 
+ENVIRONMENT
+-----------
+
+These variables obviate the need for command-line options in some
+circumstances, allowing easier restricted usage through git-shell.
+
+GIT_CVSSERVER_BASE_PATH takes the place of the argument to --base-path.
+
+GIT_CVSSERVER_ROOT specifies a single-directory whitelist. The
+repository must still be configured to allow access through
+git-cvsserver, as described above.
+
+When these environment variables are set, the corresponding
+command-line arguments may not be used.
+
 Eclipse CVS Client Notes
 ------------------------
 
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 6dc45f5..f5b57b9 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -104,6 +104,7 @@ $log->info("--------------- STARTING -----------------");
 my $usage =
     "Usage: git cvsserver [options] [pserver|server] [<directory> ...]\n".
     "    --base-path <path>  : Prepend to requested CVSROOT\n".
+    "                          Can be read from GIT_CVSSERVER_BASE_PATH\n".
     "    --strict-paths      : Don't allow recursing into subdirectories\n".
     "    --export-all        : Don't check for gitcvs.enabled in config\n".
     "    --version, -V       : Print version information and exit\n".
@@ -111,7 +112,8 @@ my $usage =
     "\n".
     "<directory> ... is a list of allowed directories. If no directories\n".
     "are given, all are allowed. This is an additional restriction, gitcvs\n".
-    "access still needs to be enabled by the gitcvs.enabled config option.\n";
+    "access still needs to be enabled by the gitcvs.enabled config option.\n".
+    "Alternately, one directory may be specified in GIT_CVSSERVER_ROOT.\n";
 
 my @opts = ( 'help|h|H', 'version|V',
 	     'base-path=s', 'strict-paths', 'export-all' );
@@ -148,6 +150,24 @@ if ($state->{'export-all'} && !@{$state->{allowed_roots}}) {
     die "--export-all can only be used together with an explicit whitelist\n";
 }
 
+# Environment handling for running under git-shell
+if (exists $ENV{GIT_CVSSERVER_BASE_PATH}) {
+    if ($state->{'base-path'}) {
+	die "Cannot specify base path both ways.\n";
+    }
+    my $base_path = $ENV{GIT_CVSSERVER_BASE_PATH};
+    $state->{'base-path'} = $base_path;
+    $log->debug("Picked up base path '$base_path' from environment.\n");
+}
+if (exists $ENV{GIT_CVSSERVER_ROOT}) {
+    if (@{$state->{allowed_roots}}) {
+	die "Cannot specify roots both ways: @ARGV\n";
+    }
+    my $allowed_root = $ENV{GIT_CVSSERVER_ROOT};
+    $state->{allowed_roots} = [ $allowed_root ];
+    $log->debug("Picked up allowed root '$allowed_root' from environment.\n");
+}
+
 # if we are called with a pserver argument,
 # deal with the authentication cat before entering the
 # main loop
-- 
debian.1.6.6_rc2.1.7.gc3ed7
