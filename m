From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v3 0/2] Make git-svn work with gitdir links
Date: Wed, 23 Jan 2013 02:32:35 +0000
Message-ID: <20130123023235.GA24135@dcvr.yhbt.net>
References: <20120308005103.GA27398@dcvr.yhbt.net>
 <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Barry Wardell <barry.wardell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:32:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txq94-0004Wi-1f
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 03:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab3AWCch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 21:32:37 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:52909 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819Ab3AWCcg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 21:32:36 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026111F6E1;
	Wed, 23 Jan 2013 02:32:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214271>

Barry Wardell <barry.wardell@gmail.com> wrote:
> These patches fix a bug which prevented git-svn from working with repositories
> which use gitdir links.
> 
> Changes since v2:
>  - Rebased onto latest master.
>  - Added test case which verifies that the problem has been fixed.
>  - Fixed problems with git svn (init|clone|multi-init).
>  - All git-svn test cases now pass (except two in t9101 which also failed
>    before these patches).

t9101 did not fail for me before your patches.  However I have a
patch on top of your 2/2 which should fix things.

`git rev-parse --show-cdup` outputs nothing if GIT_DIR is set,
so I unset GIT_DIR temporarily.

I'm not sure why --show-cdup behaves like this, though..

Does squashing this on top of your changes fix all your failures?
I plan on squashing both your changes together with the below:

diff --git a/git-svn.perl b/git-svn.perl
index c232798..e5bd292 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -332,11 +332,13 @@ if ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 		$ENV{GIT_DIR} = command_oneline([qw/rev-parse --git-dir/]);
 	} "Unable to find .git directory\n";
 	my $cdup = undef;
+	my $git_dir = delete $ENV{GIT_DIR};
 	git_cmd_try {
 		$cdup = command_oneline(qw/rev-parse --show-cdup/);
 		chomp $cdup if ($cdup);
 		$cdup = "." unless ($cdup && length $cdup);
-	} "Already at toplevel, but $ENV{GIT_DIR} not found\n";
+	} "Already at toplevel, but $git_dir not found\n";
+	$ENV{GIT_DIR} = $git_dir;
 	chdir $cdup or die "Unable to chdir up to '$cdup'\n";
 	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
 }
