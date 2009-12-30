From: Phil Miller <mille121@illinois.edu>
Subject: Re: [PATCH/resend] CVS Server: Support reading base and roots from 
	environment
Date: Wed, 30 Dec 2009 14:12:55 -0600
Message-ID: <81f018ac0912301212l68ebd7y91004acc93d36779@mail.gmail.com>
References: <81f018ac0911200805g55bd1607u651334c1ed7f1303@mail.gmail.com> 
	<7vocmwvmvr.fsf@alter.siamese.dyndns.org> <20091230224108.6117@nanako3.lavabit.com> 
	<81f018ac0912300912g25887523g1bdf29fd6e31d011@mail.gmail.com> 
	<7vpr5wz1hb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 21:13:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ4v5-00028f-NU
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 21:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbZL3UNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 15:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753489AbZL3UNS
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 15:13:18 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:55008 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbZL3UNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 15:13:16 -0500
Received: by ewy19 with SMTP id 19so4035154ewy.21
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 12:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=w0ztcL1kHPv/Bpq5kFjwOS0s2ULQNndEOlhKg3Zef6w=;
        b=s2tF86b8uUPFNsQ3z6RV7T3iYoOukZfvNDgFA0SYdiBuXX5eaNnQlwgPtT7bWYqocE
         SyBHOGnNCdKjyeIfqIRs1bqrtDeXX+MJFQ7EkufWKo04rjrNiv2tOQExeXNc33HVxCcY
         S0o5SwduQXkglwoF2ur+Lj3B81Rhuf+hdj5V8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=ekbrmac+u0OH/DKswsR4cc2Bwe5GVHbFly6fIvpOfz8DHIFospUXXBCWysszPEPd85
         BtmVL72dYcjLX+qQsBW/RtD0pA7oLnmWIhtg4IXjlNCC73UuAgJtChjFeRgpdTMmRAUj
         QduxHlO3/clfYC8hlN3LJzVJU98bamojVg29Q=
Received: by 10.216.93.77 with SMTP id k55mr7043459wef.196.1262203995160; Wed, 
	30 Dec 2009 12:13:15 -0800 (PST)
In-Reply-To: <7vpr5wz1hb.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 984baeffe3c79107
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135923>

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
@@ -277,6 +277,21 @@ In `dbdriver` and `dbuser` you can use the
following variables:
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
@@ -148,6 +150,24 @@ if ($state->{'export-all'} &&
!@{$state->{allowed_roots}}) {
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
