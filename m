From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/7] gitweb: Add parse_rev_list for later use
Date: Wed,  6 Sep 2006 15:08:08 +0200
Message-ID: <11575480922634-git-send-email-jnareb@gmail.com>
References: <200609061504.40725.jnareb@gmail.com> <1157548091229-git-send-email-jnareb@gmail.com> <11575480912922-git-send-email-jnareb@gmail.com> <11575480922090-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 06 15:08:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKx8k-0005m3-BH
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 15:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWIFNIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 09:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWIFNIV
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 09:08:21 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:42475 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750862AbWIFNIS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 09:08:18 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k86D6qPI031858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Sep 2006 15:06:52 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k86D8CMT008413;
	Wed, 6 Sep 2006 15:08:12 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k86D8C9v008412;
	Wed, 6 Sep 2006 15:08:12 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11575480922090-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26526>

Add parse_rev_list to generate _parsed_ list of revisions, combining
getting the list of revisions, and parsing of individual revisions
into one subroutine.  It is to avoid code like below

	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash
		or die_error(undef, "Open git-rev-list failed");
	my @revlist = map { chomp; $_ } <$fd>;

	...

	foreach my $commit (@revlist) {
		my %co = parse_commit($commit);

where parse_commit subroutine calls git-rev-list with '--max-count=1'
to parse individual commit.  Using parse_rev_list will avoid
unnecessary forks.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2191853..8aeca52 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1125,6 +1125,35 @@ sub git_get_refs_list {
 	return \@reflist;
 }
 
+# To use only one invocation of git-rev-list, instead of getting
+# the list of revisions and then using git-rev-list per revision
+# to parse individual commits.
+#
+# parse_rev_list parameters are passed to git-rev-list, so they should
+# include at least starting revision; just in case we default to HEAD
+sub parse_rev_list {
+	my @rev_opts = @_;
+	my @revlist;
+
+	@rev_opts = ("HEAD") unless @rev_opts;
+
+	local $/ = "\0";
+	open my $fd, "-|", git_cmd(), "rev-list", "--header", "--parents", @rev_opts
+		or return \@revlist;
+
+	while (my $revinfo = <$fd>) {
+		chomp $revinfo;
+		my @commit_lines = split '\n', $revinfo;
+		my %co = parse_commit(undef, \@commit_lines);
+
+		push @revlist, \%co;
+	}
+
+	close $fd;
+
+	return wantarray ? @revlist : \@revlist;
+}
+
 ## ----------------------------------------------------------------------
 ## filesystem-related functions
 
-- 
1.4.2
