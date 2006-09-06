From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 8/8] gitweb: Remove --parents from call to git-rev-list in parse_rev_list
Date: Wed,  6 Sep 2006 22:56:22 +0200
Message-ID: <11575761821830-git-send-email-jnareb@gmail.com>
References: <11575480921132-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 06 22:56:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL4Rj-0004FZ-Qq
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 22:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWIFU43 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 16:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWIFU42
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 16:56:28 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:21916 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750922AbWIFU41 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 16:56:27 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k86Kt2In028539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Sep 2006 22:55:03 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k86KuMtr008843;
	Wed, 6 Sep 2006 22:56:22 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k86KuMmS008842;
	Wed, 6 Sep 2006 22:56:22 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11575480921132-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26559>

This option is removed by default, because with --full-history option
(which is by default used in git_history) --parents means full history
with parenthood, which means that we get all the connecting merges
too.  And since we asked for the _full_ history, that means EVERY
SINGLE MERGE.  Even those that do not change given file (or
directory).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Benchmarks (7 means patch before, 8 means this patch):
# 1:gitweb/new~n 2:%e 3:%U 4:%s 5:ab-n10_cgi_time[ms] 6:[+/-sd] 7:ab-n10_perl_time[ms] 8:[+/-sd]
7 2.59  1.53 0  2621.073  234.2  2742.230   96.6
8 2.89  1.80 0  3081.722  246.6  3306.196  367.2
8 2.95  1.81 0  2952.253  155.9  3175.441  128.0

 gitweb/gitweb.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index edded74..68ddbe6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1131,6 +1131,13 @@ # to parse individual commits.
 #
 # parse_rev_list parameters are passed to git-rev-list, so they should
 # include at least starting revision; just in case we default to HEAD
+#
+# if you want in parsed info to have full equivalent of first generating
+# list of interesting revisions, then calling parse_commit on each of revs,
+# i.e. if you want to have full parent info which includes grafts,
+# you have to include '--parents' in the parse_rev_list parameters;
+# it is excluded by default as it changes notion which revs are interesting
+# e.g. '--full-history' with '--parents' include EVERY SINGLE MERGE.
 sub parse_rev_list {
 	my @rev_opts = @_;
 	my @revlist;
@@ -1138,7 +1145,7 @@ sub parse_rev_list {
 	@rev_opts = ("HEAD") unless @rev_opts;
 
 	local $/ = "\0";
-	open my $fd, "-|", git_cmd(), "rev-list", "--header", "--parents", @rev_opts
+	open my $fd, "-|", git_cmd(), "rev-list", "--header", @rev_opts
 		or return \@revlist;
 
 	while (my $revinfo = <$fd>) {
-- 
1.4.2
