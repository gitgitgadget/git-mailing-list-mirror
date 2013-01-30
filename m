From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
Subject: [PATCH 2/7] perl/Git.pm: set up command environment on Windows
Date: Wed, 30 Jan 2013 15:22:58 -0200
Message-ID: <1359566583-19654-3-git-send-email-gnustavo@cpan.org>
References: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
Cc: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 18:23:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0bNq-0006ZD-41
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 18:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915Ab3A3RXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 12:23:14 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:42372 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607Ab3A3RXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 12:23:13 -0500
Received: by mail-yh0-f43.google.com with SMTP id z6so302243yhz.30
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 09:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:x-gm-message-state;
        bh=OHpyMRtR3PS5Pv46Jc/EURcKoXnqVq4foxNvqLZWHSc=;
        b=FsMa9wqf6pkhxBR3P59Xnbw2mGwHUEQZWAtVY/LEMCf1WPlaEhcbJhzDqBMjOVj80i
         EDNm/dMeQLnU0ZvsKR0xEYJAxris5Q6jd8H9B/PPsZeXiKK6hQ1eSFScCvtSSfUCf8rm
         pVXV8ujRL3Gw2/MCKDPKCBhh6Hj/TXhTtf+eAoL3hri+8s25EcSL+6qpCFvc6tPb/Ab/
         OmQLBqGvVv41G80RyckmIIGG8Du8iwwYokwJMl5mSA2F74DsG/nGx9ZFzseyv4MVeHaf
         sDNunCqKqLE+EKuyChtKKpcMKeYGX26OBzlgpDFkVgVqffOSfWtcAAT1WptRJcAe//UM
         QcPw==
X-Received: by 10.236.120.50 with SMTP id o38mr6569379yhh.100.1359566591561;
        Wed, 30 Jan 2013 09:23:11 -0800 (PST)
Received: from gnu.cpqd.com.br (fw-cpqd.cpqd.com.br. [189.112.183.66])
        by mx.google.com with ESMTPS id q11sm1689802anp.13.2013.01.30.09.23.10
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 09:23:10 -0800 (PST)
X-Mailer: git-send-email 1.7.12.464.g83379df.dirty
In-Reply-To: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
X-Gm-Message-State: ALoCoQm7seIlBhtgOjRdYaDzhiE7MgfHzvqgxrIOm0M/489ZjuAGrzna2XQEATAP38D4JEzE/Af9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215035>

From: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>

Routine _cmd_exec invokes _setup_git_cmd_env inside the child process
before invoking an external git command to set up the environment
variables GIT_DIR and GIT_WORK_TREE and, also, to chdir to the
repository. But _cmd_exec is only used on Unix. On Windows, it's not
used and the main code path is in _command_common_pipe, which didn't
prepare the environment like _cmd_exec.

Without this environment preparation some git commands, such as "git
clone", don't work.

We can't use _setup_git_cmd_env in this case because we don't use a
forking open like _cmd_exec does and don't get a chance to make such
preparations on the child process.

So, the preparation is done on _command_common_pipe by setting up
localized environment variables and by chdir temporarily just before
invoking the external command.

Signed-off-by: Gustavo L. de M. Chaves <gnustavo@cpan.org>
---
 perl/Git.pm | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/perl/Git.pm b/perl/Git.pm
index 658b602..e14b41a 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1302,6 +1302,19 @@ sub _command_common_pipe {
 		#	warn 'ignoring STDERR option - running w/ ActiveState';
 		$direction eq '-|' or
 			die 'input pipe for ActiveState not implemented';
+
+		# Set up repo environment
+		local $ENV{GIT_DIR}       = $self->repo_path() if defined $self && $self->repo_path();
+		local $ENV{GIT_WORK_TREE} = $self->wc_path()   if defined $self && $self->repo_path() && $self->wc_path();
+
+		my $cwd = cwd;
+
+		if (defined $self) {
+			chdir $self->repo_path() if $self->repo_path();
+			chdir $self->wc_path()	 if $self->wc_path();
+			chdir $self->wc_subdir() if $self->wc_subdir();
+		}
+
 		# the strange construction with *ACPIPE is just to
 		# explain the tie below that we want to bind to
 		# a handle class, not scalar. It is not known if
@@ -1310,6 +1323,7 @@ sub _command_common_pipe {
 		tie (*ACPIPE, 'Git::activestate_pipe', $cmd, @args);
 		$fh = *ACPIPE;
 
+		chdir $cwd;
 	} else {
 		my $pid = open($fh, $direction);
 		if (not defined $pid) {
-- 
1.7.12.464.g83379df.dirty
