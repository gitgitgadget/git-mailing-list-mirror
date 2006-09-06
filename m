From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/7] gitweb: Use @hist_opts as git-rev-list parameters in git_history
Date: Wed,  6 Sep 2006 15:08:07 +0200
Message-ID: <11575480922090-git-send-email-jnareb@gmail.com>
References: <200609061504.40725.jnareb@gmail.com> <1157548091229-git-send-email-jnareb@gmail.com> <11575480912922-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 06 15:08:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKx8m-0005m3-Et
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 15:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWIFNI0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 09:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWIFNIZ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 09:08:25 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:45803 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750892AbWIFNIV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 09:08:21 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k86D6qso031855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Sep 2006 15:06:52 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k86D8CO6008407;
	Wed, 6 Sep 2006 15:08:12 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k86D8C86008406;
	Wed, 6 Sep 2006 15:08:12 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11575480912922-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26525>

Add new global configuration variable @hist_opts, which holds
additional, history specific options (parameters) to git-rev-list
called in git_history subroutine.  Default value is '--full-history',
as it was.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4c76032..2191853 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -176,9 +176,23 @@ # - more costly is '-C' (or '-C', '-M'),
 #   (number of changed files + number of removed files) * (number of new files)
 # - even more costly is '-C', '--find-copies-harder' with cost
 #   (number of files in the original tree) * (number of new files)
-# - one might want to include '-B' option, e.g. '-B', '-M'
+# - one might want to include '-B' option, e.g. have it ('-B', '-M'),
+#   or for example '-l<num>' together with '-M' and perhaps '-C'
 our @diff_opts = ('-M'); # taken from git_commit
 
+# options fo git-rev-list used in git_history
+# - default is '--full-history', which is slowest but works with merges,
+#   and was done to not change the output from previous version when
+#   path limiting was done by piping revisions to git-diff-tree --stdin
+# - less costly is (), i.e. without '--full-history', which of course
+#   changes output and provides _simplified_ history of a file
+# - for files which appeared late in the history less costly is
+#   --full-history, --remove-empty, although it changes output in
+#   the rare case when name vanished the appeared thorough the history;
+#   it improves performance of course only the last page of history
+# - least costly, but changing output, is having --remove-mepty only
+our @hist_opts = ('--full-history');
+
 our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
 do $GITWEB_CONFIG if -e $GITWEB_CONFIG;
 
@@ -3137,7 +3151,7 @@ sub git_history {
 	}
 
 	open my $fd, "-|",
-		git_cmd(), "rev-list", $limit, "--full-history", $hash_base, "--", $file_name
+		git_cmd(), "rev-list", $limit, @hist_opts, $hash_base, "--", $file_name
 			or die_error(undef, "Open git-rev-list-failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd
-- 
1.4.2
