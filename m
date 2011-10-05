From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] git-svn: On MSYS, escape and quote SVN_SSH also if set by
 the user
Date: Wed, 05 Oct 2011 11:14:38 +0200
Message-ID: <4E8C1FFE.3010605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 11:16:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBNaT-00035l-8D
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 11:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933949Ab1JEJQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 05:16:19 -0400
Received: from lo.gmane.org ([80.91.229.12]:43517 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933575Ab1JEJQT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 05:16:19 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RBNaM-00032q-25
	for git@vger.kernel.org; Wed, 05 Oct 2011 11:16:18 +0200
Received: from jambul.zib.de ([130.73.68.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 11:16:18 +0200
Received: from sschuberth by jambul.zib.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 11:16:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: jambul.zib.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182839>

While GIT_SSH does not require any escaping / quoting (e.g. for paths
containing spaces), SVN_SSH requires it due to its use in a Perl script.

Previously, SVN_SSH has only been escaped and quoted automatically if it
was unset and thus derived from GIT_SSH. For user convenience, do the
escaping and quoting also for a SVN_SSH set by the user. This way, the
user is able to use the same unescaped and unquoted syntax for GIT_SSH
and SVN_SSH.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-svn.perl |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 89f83fd..c3b4b58 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -22,14 +22,13 @@ $Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 'git-svn';
 $Git::SVN::Ra::_log_window_size = 100;
 $Git::SVN::_minimize_url = 'unset';
 
-if (! exists $ENV{SVN_SSH}) {
-	if (exists $ENV{GIT_SSH}) {
-		$ENV{SVN_SSH} = $ENV{GIT_SSH};
-		if ($^O eq 'msys') {
-			$ENV{SVN_SSH} =~ s/\\/\\\\/g;
-			$ENV{SVN_SSH} =~ s/(.*)/"$1"/;
-		}
-	}
+if (! exists $ENV{SVN_SSH} && exists $ENV{GIT_SSH}) {
+	$ENV{SVN_SSH} = $ENV{GIT_SSH};
+}
+
+if (exists $ENV{SVN_SSH} && $^O eq 'msys') {
+	$ENV{SVN_SSH} =~ s/\\/\\\\/g;
+	$ENV{SVN_SSH} =~ s/(.*)/"$1"/;
 }
 
 $Git::SVN::Log::TZ = $ENV{TZ};
-- 
1.7.6.GIT
