From: "Bryan Larsen" <bryan@larsen.st>
Subject: [PATCH] Remove non-POSIX alternation in sed script in instaweb
Date: Fri, 14 Sep 2007 17:41:07 -0400
Message-ID: <256f7ba80709141441l3bd2d3ecu9ce53809c686cec4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 23:41:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWIvC-00063C-E2
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 23:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbXINVlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 17:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbXINVlJ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 17:41:09 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:6279 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbXINVlI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 17:41:08 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1112900wah
        for <git@vger.kernel.org>; Fri, 14 Sep 2007 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=ivp+F3ldN+hVDBSHcx5js+YywfEms6IzR6BkOlYTxeM=;
        b=hOWEGNCSsX6wrwLDABRmrGR2ByR4Xehl75x5lH8Wd1uCCpxiLhKZyqDXOESJIM1R5QvkVW/3Qnm4wPkNP1AsUkTZg4bs4OrDeGnsVu/f5vs4ypWqfbXHFv90xurOFwrM5sGzm/SDs5sJ02yCluVvt9XJKMNdFFEhrnTm4V/o/s4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=D2cS+K/nGBiSH+mmSF7ZQLi8wBhUWvM09ygQSAs8L9F3p+75YCUdsCDlDE2WxQprapk/7EW6k+3ezvFJ75uMmOPerVfCfLNWqVhzjhVFCD0paGyIESPDt6EV2QY4Xl+Ekzp9LXsEpfImk0pIGYEndV7+aYFftmUcgU6UFKG4k7I=
Received: by 10.114.194.1 with SMTP id r1mr495345waf.1189806067956;
        Fri, 14 Sep 2007 14:41:07 -0700 (PDT)
Received: by 10.114.81.11 with HTTP; Fri, 14 Sep 2007 14:41:07 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 68e0300f35e8768b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58186>

git-instaweb.sh uses alternation in a sed script.  Unfortunately,
this is not POSIX compliant and does not work on some BSD's.  This
patch removes the alternation via the simple expedient of doubling
the number of lines in the sed script.

Signed-off-by: Bryan Larsen <bryan@larsen.st>
---
 git-instaweb.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index b79c6b6..ce631a0 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -207,10 +207,14 @@ EOF
 }

 script='
-s#^\(my\|our\) $projectroot =.*#\1 $projectroot = "'`dirname $fqgitdir`'";#
-s#\(my\|our\) $gitbin =.*#\1 $gitbin = "'$GIT_EXEC_PATH'";#
-s#\(my\|our\) $projects_list =.*#\1 $projects_list = $projectroot;#
-s#\(my\|our\) $git_temp =.*#\1 $git_temp = "'$fqgitdir/gitweb/tmp'";#'
+s#^my $projectroot =.*#my $projectroot = "'`dirname $fqgitdir`'";#
+s#^our $projectroot =.*#our $projectroot = "'`dirname $fqgitdir`'";#
+s#my $gitbin =.*#my $gitbin = "'$GIT_EXEC_PATH'";#
+s#our $gitbin =.*#our $gitbin = "'$GIT_EXEC_PATH'";#
+s#my $projects_list =.*#my $projects_list = $projectroot;#
+s#our $projects_list =.*#our $projects_list = $projectroot;#
+s#my $git_temp =.*#my $git_temp = "'$fqgitdir/gitweb/tmp'";#
+s#our $git_temp =.*#our $git_temp = "'$fqgitdir/gitweb/tmp'";#'

 gitweb_cgi () {
        cat > "$1.tmp" <<\EOFGITWEB
-- 
1.5.3.1
