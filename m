From: Simon Sasburg <simon.sasburg@gmail.com>
Subject: [PATCH 3/3] Make git-svn rebase --dirty pass along --dirty to git-rebase.
Date: Thu,  1 Nov 2007 22:30:24 +0100
Message-ID: <1193952624-608-4-git-send-email-Simon.Sasburg@gmail.com>
References: <1193952624-608-1-git-send-email-Simon.Sasburg@gmail.com>
 <1193952624-608-2-git-send-email-Simon.Sasburg@gmail.com>
 <1193952624-608-3-git-send-email-Simon.Sasburg@gmail.com>
Cc: git@vger.kernel.org, Simon Sasburg <Simon.Sasburg@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 01 22:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InhfB-0001oX-An
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbXKAVcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754302AbXKAVcr
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:32:47 -0400
Received: from hu-out-0506.google.com ([72.14.214.236]:16289 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220AbXKAVcq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:32:46 -0400
Received: by hu-out-0506.google.com with SMTP id 19so265852hue
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 14:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        bh=MCaR3x4NIeypa/wshA/mxeykG9YYyJ4lKrOfYMKVvuE=;
        b=nBwZ9dzgXuxT9Izn3qe++cZ24BRVS5p89IVB4O6SyoyJRJ8FHPYGNC6lcMgSDWpryIYFgwLrvKP03eeJnuCu6BoN2fvb7xDrPRU64/dT3H9N3LC459fFYiqvESzItVXRfx3XC3efTPk75dj9+o8wt2BohuiBrnYk9Q0q0kVP8lk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=ak0hOK3Oc58k4sZODJ7IIu5Hg156S5Ac2nS02DGlkbg6y5WQPKEBwWEvuLTuouxNckhlFf/gCtH9yUhdkKpyzvPfvVAvlTdrEqoVzdRRCZX1Rt5DebWhwjUjczmdcYGknokw0rLaFP+3R/o9M1xr4S6ty9NEXWN7JpYIECpiQqc=
Received: by 10.78.204.7 with SMTP id b7mr849241hug.1193952765218;
        Thu, 01 Nov 2007 14:32:45 -0700 (PDT)
Received: from localhost ( [86.85.232.104])
        by mx.google.com with ESMTPS id f3sm2302439nfh.2007.11.01.14.32.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 14:32:44 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.503.gbcee6f4
In-Reply-To: <1193952624-608-3-git-send-email-Simon.Sasburg@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63010>

Signed-off-by: Simon Sasburg <Simon.Sasburg@gmail.com>
---
 git-svn.perl |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 22bb47b..5898a26 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -63,7 +63,7 @@ my ($_stdin, $_help, $_edit,
 	$_message, $_file,
 	$_template, $_shared,
 	$_version, $_fetch_all, $_no_rebase,
-	$_merge, $_strategy, $_dry_run, $_local,
+	$_merge, $_strategy, $_dry_run, $_local, $_dirty,
 	$_prefix, $_no_checkout, $_verbose);
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
@@ -169,6 +169,7 @@ my %cmd = (
 			  'verbose|v' => \$_verbose,
 			  'strategy|s=s' => \$_strategy,
 			  'local|l' => \$_local,
+			  'dirty|d' => \$_dirty,
 			  'fetch-all|all' => \$_fetch_all,
 			  %fc_opts } ],
 	'commit-diff' => [ \&cmd_commit_diff,
@@ -482,16 +483,20 @@ sub cmd_find_rev {
 }
 
 sub cmd_rebase {
-	command_noisy(qw/update-index --refresh/);
+	unless ($_dirty) {
+		command_noisy(qw/update-index --refresh/);
+	}
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	unless ($gs) {
 		die "Unable to determine upstream SVN information from ",
 		    "working tree history\n";
 	}
 	if (command(qw/diff-index HEAD --/)) {
-		print STDERR "Cannot rebase with uncommited changes:\n";
-		command_noisy('status');
-		exit 1;
+		unless ($_dirty) {
+			print STDERR "Cannot rebase with uncommited changes:\n";
+			command_noisy('status');
+			exit 1;
+		}
 	}
 	unless ($_local) {
 		$_fetch_all ? $gs->fetch_all : $gs->fetch;
@@ -697,6 +702,7 @@ sub rebase_cmd {
 	push @cmd, '-v' if $_verbose;
 	push @cmd, qw/--merge/ if $_merge;
 	push @cmd, "--strategy=$_strategy" if $_strategy;
+	push @cmd, "--dirty" if $_dirty;
 	@cmd;
 }
 
-- 
1.5.3.4.502.g37c97
