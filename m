From: Phil Miller <mille121@illinois.edu>
Subject: [PATCH/resend] CVS Server: Support reading base and roots from 
	environment
Date: Fri, 20 Nov 2009 10:05:44 -0600
Message-ID: <81f018ac0911200805g55bd1607u651334c1ed7f1303@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Git Maintainer <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 17:06:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBW01-0002DG-Tt
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 17:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100AbZKTQGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 11:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754086AbZKTQGD
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 11:06:03 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:25504 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbZKTQGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 11:06:00 -0500
Received: by fg-out-1718.google.com with SMTP id d23so151478fga.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 08:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=weabWXmacfK3n2hWLirQNF587lIyBp88ElqlP6XpbCE=;
        b=tGR9Xkg/+h/cqyxZGWehdlDOfRDdno0rjh1pg680laiNlNi1mDtZoCPyWUD0R5/LBt
         1xpojSYPGuSPRkXNHSraYvcJbsOtGaSZx5GgWTMW3IjOZsFKKRTZpZ+bhI8jhnlkD2FQ
         2XgRD9DuSTpjpcRXsRmUoWz43MCKmUw+Y9HLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        b=N0VKByIkgcFl0Trd5fWSb7qrwCO9XKOJzbocf6Dtd2ruMrhQ6OesTfGMjZM25i7cyh
         goKR4z+vBgiJSM0/TZui/g596by/s002cqoAS4Usrh2fOxZd/EA0Lanl1xPT8SWmd8Nx
         mlpWqH/2ZbSOocQAYeYHeAMyzzjZzOjsrvUeE=
Received: by 10.216.88.71 with SMTP id z49mr462418wee.90.1258733164739; Fri, 
	20 Nov 2009 08:06:04 -0800 (PST)
X-Google-Sender-Auth: ec6cf0adb31623f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133357>

The Gitosis single-account Git/ssh hosting system runs git commands
through git-shell after confirming that the connecting user is
authorized to access the requested repository. This works well for
upload-pack and receive-pack, which take a repository argument through
git-shell. This doesn't work so well for `cvs server', which is passed
through literally, with no arguments. Allowing arguments risks
sneaking in `--export-all', so that restriction should be maintained.

Despite that, passing a list of repository roots is necessary for
per-user access control by the hosting software, and passing a base
path improves usability without weakening security. Thus,
git-cvsserver needs to come up with these values at runtime by some
other means. Since git-shell preserves the environment for other
purposes, the environment can carry these arguments as well.

Thus, modify git-cvsserver to read $GIT_CVSSERVER_{BASE_PATH,ROOTS} in
the absence of equivalent command line arguments.

Signed-off-by: Phil Miller <mille121@illinois.edu>
---
 git-cvsserver.perl |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 6dc45f5..9e58d2a 100755
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
+    "Alternately, these directories may be specified in
GIT_CVSSERVER_ROOTS.\n";

 my @opts = ( 'help|h|H', 'version|V',
 	     'base-path=s', 'strict-paths', 'export-all' );
@@ -148,6 +150,23 @@ if ($state->{'export-all'} &&
!@{$state->{allowed_roots}}) {
     die "--export-all can only be used together with an explicit whitelist\n";
 }

+# Environment handling for running under git-shell
+if ($ENV{GIT_CVSSERVER_BASE_PATH}) {
+    if ($state->{'base-path'}) {
+	die "Cannot specify base path both ways.\n";
+    }
+    my $base_path = $ENV{GIT_CVSSERVER_BASE_PATH};
+    $state->{'base-path'} = $base_path;
+    $log->debug("Picked up base path '$base_path' from environment.\n");
+}
+if ($ENV{GIT_CVSSERVER_ROOTS}) {
+    if (@{$state->{allowed_roots}}) {
+	die "Cannot specify roots both ways: @ARGV\n";
+    }
+    my @allowed_root = split(',', $ENV{GIT_CVSSERVER_ROOTS});
+    $state->{allowed_roots} = [ @allowed_root ];
+}
+
 # if we are called with a pserver argument,
 # deal with the authentication cat before entering the
 # main loop
-- 
1.5.6.3
