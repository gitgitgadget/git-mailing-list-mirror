From: Avishay Lavie <avishay.lavie@gmail.com>
Subject: [PATCH] git svn dcommit: avoid self-referential mergeinfo lines when
 svn.pushmergeinfo is configured
Date: Wed, 14 Mar 2012 18:09:04 +0200
Message-ID: <CAHkK2bpq1J2SW2P1tkFnjw5dWEr=uQrfrTUaS2J-swuKsP4kig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>, Bryan Jacobs <bjacobs@woti.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 17:09:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7qlX-0003j8-Bn
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 17:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053Ab2CNQJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 12:09:26 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37275 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569Ab2CNQJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 12:09:25 -0400
Received: by wibhj6 with SMTP id hj6so7410690wib.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=Pg1rQHNN+SnRmrY2/6SU6gYA/91rPilPWdnWglTY1g4=;
        b=hk8/TAhaQZ8SLjS9JQzCzAxvshl3KXmXh/HyUMdqUqyY9GniUHL6BSZMMz2wZmUT5Z
         i83KLF+usSJh6mgvyo+12GsjZhMW93AQsIl43TgWW24zoUy8UyVEwQkJqJBr9MuMJKHV
         SrTTwniZp1nLmCiwKvxmX/FqsZM/IUCATSgxmyTQrPwAa2p3vDiUyUPnFHA6plujg+TT
         oL8b0HHTctns07Sszak+p8B3jycoIxWPGrbn9cGBhj7csD13xUkbUogsDBuJs0QY5Zag
         h2c6qtTd8L+dEEJJaYJefOLZVva2Oyq3bP6VrxE95atBOvFUF/mug41mdzbbfJ7uHnrG
         Kfjg==
Received: by 10.180.103.35 with SMTP id ft3mr7710065wib.0.1331741364140; Wed,
 14 Mar 2012 09:09:24 -0700 (PDT)
Received: by 10.216.170.70 with HTTP; Wed, 14 Mar 2012 09:09:04 -0700 (PDT)
X-Google-Sender-Auth: 1shwswG6H_914HSabCa3aVUi8h0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193123>

[PATCH] git svn dcommit: avoid self-referential mergeinfo lines when
svn.pushmergeinfo flag is configured

When svn.pushmergeinfo is configured, git svn dcommit tries to
automatically populate svn:mergeinfo properties by merging the parent
branch's mergeinfo into the committed one on each merge commit. This
process can add self-referential mergeinfo lines, i.e. ones that
reference the same branch being committed into (e.g. when
reintegrating a branch to trunk after previously having merged trunk
into it), which are then mishandled by SVN and cause errors in mixed
SVN/Git environments.
For more details, see my original report on the issue at [1].

This commit adds a step to git svn dcommit that filters out any
mergeinfo lines referencing the target branch from the mergeinfo, thus
avoiding the problem.

[1] http://thread.gmane.org/gmane.comp.version-control.git/191932

Signed-off-by: Avishay Lavie <avishay.lavie@gmail.com>
---
This is my first time sending a patch to the group, so if I'm doing
something wrong, please let me know.

 git-svn.perl |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index eeb83d3..1ed409d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -752,6 +752,19 @@ sub populate_merge_info {
 	return undef;
 }

+sub remove_self_referential_merge_info {
+	return $_merge_info unless defined $_merge_info;
+
+	my ($_merge_info, $branchurl, $gs) = @_;
+	my $rooturl = $gs->repos_root;
+	
+	unless ($branchurl =~ /^\Q$rooturl\E(.*)/) {
+		fatal "URL to commit to is not under SVN root $rooturl!";
+	}
+	my $branchpath = $1;
+	return join("\n", grep { $_ !~ m/^$branchpath\:/ } split(/\n/, $_merge_info));
+}
+
 sub cmd_dcommit {
 	my $head = shift;
 	command_noisy(qw/update-index --refresh/);
@@ -902,6 +915,8 @@ sub cmd_dcommit {
 				                             $uuid,
 				                             $linear_refs,
 				                             $rewritten_parent);
+
+				$_merge_info = remove_self_referential_merge_info($_merge_info, $url, $gs);
 			}

 			my %ed_opts = ( r => $last_rev,
-- 
1.7.8.msysgit.0
