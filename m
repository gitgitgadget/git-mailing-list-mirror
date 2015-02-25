From: Ryuichi Kokubo <ryu1kkb@gmail.com>
Subject: [PATCH] git-svn: fix localtime=true on non-glibc environments
Date: Thu, 26 Feb 2015 01:04:41 +0900
Message-ID: <1424880281-570-1-git-send-email-ryu1kkb@gmail.com>
Cc: Ryuichi Kokubo <ryu1kkb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 17:05:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQeSN-0001rq-AD
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 17:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbbBYQE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 11:04:58 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:41200 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbbBYQE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 11:04:57 -0500
Received: by pdno5 with SMTP id o5so5782733pdn.8
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 08:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=uBqUqDOoH+ZtQL21Q38kybsog4B0joE65XK4zT8j0/s=;
        b=XS7JILJOWFDAEhPmWNBKYFoXc+G0RqqaavIQ/xd/7G91La8Tt86KTT1g1QmL6zbKH8
         tJYQM4iKZvwNGv7Fgg8eztX4SaB5k/AZ0Vw73MUkHjXiWISZleCG775uqe7EQnxCeQqt
         x0tyS16ilYuQc9j6LC6AFJf5dbwZe480v/GrqJT/KA7eXjX4NB34b9BQRf3e3bVoYAgv
         jhbLnmt2Wt7j9xcuWTUCI/UqP5dJxV0Oqw1Dc13Ivs8tl161ifWGrd2aujAKd7k+VV4Y
         jqXowypdoCmVQacX/VzxWmgp+4RpJBxOr3rTrOc0O6aM3wUCV/jTX2adaxmYlg0bFWVq
         HU7A==
X-Received: by 10.70.44.100 with SMTP id d4mr6848658pdm.36.1424880296271;
        Wed, 25 Feb 2015 08:04:56 -0800 (PST)
Received: from lab.kkbs.net (124x34x74x180.ap124.ftth.ucom.ne.jp. [124.34.74.180])
        by mx.google.com with ESMTPSA id fl6sm2845153pdb.23.2015.02.25.08.04.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2015 08:04:55 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264396>

git svn uses POSIX::strftime('%s', $sec, $min, ...) to make unix epoch time.
But lowercase %s formatting character is a GNU extention. This causes problem
in git svn fetch --localtime on non-glibc systems, such as msys or cygwin.
Using Time::Local::timelocal($sec, $min, ...) fixes it.

Signed-off-by: Ryuichi Kokubo <ryu1kkb@gmail.com>

Notes:
    lowercase %s format character in strftime is a GNU extension and not widely supported.
    POSIX::strftime affected by underlying crt's strftime because POSIX::strftime just calls crt's one.
    Time::Local is good function to replace POSIX::strftime because it's a perl core module function.
    
    Document about Time::Local.
     http://perldoc.perl.org/Time/Local.html
    
    These are specifications of strftime.
    
    The GNU C Library Reference Manual.
     http://www.gnu.org/software/libc/manual/html_node/Formatting-Calendar-Time.html
    
    perl POSIX module's strftime document. It does not have '%s'.
     http://perldoc.perl.org/POSIX.html
    
    strftime document of Microsort Windows C Run-Time library.
     https://msdn.microsoft.com/en-us/library/fe06s4ak.aspx
    
    The Open Group's old specification does not have '%s' too.
     http://pubs.opengroup.org/onlinepubs/007908799/xsh/strftime.html
    
    On my environment, following problems happened.
    - msys   : git svn fetch does not progress at all with perl.exe consuming CPU.
    - cygwin : git svn fetch progresses but time stamp information is dropped.
       Every commits have unix epoch timestamp.
    
    I would like to thank git developer and contibutors.
    git helps me so much everyday.
    Thank you.
---
 perl/Git/SVN.pm |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 8e4af71..f243726 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -14,6 +14,7 @@ use IPC::Open3;
 use Memoize;  # core since 5.8.0, Jul 2002
 use Memoize::Storable;
 use POSIX qw(:signal_h);
+use Time::Local;
 
 use Git qw(
     command
@@ -1332,7 +1333,7 @@ sub parse_svn_date {
 		$ENV{TZ} = 'UTC';
 
 		my $epoch_in_UTC =
-		    POSIX::strftime('%s', $S, $M, $H, $d, $m - 1, $Y - 1900);
+		    Time::Local::timelocal($S, $M, $H, $d, $m - 1, $Y - 1900);
 
 		# Determine our local timezone (including DST) at the
 		# time of $epoch_in_UTC.  $Git::SVN::Log::TZ stored the
-- 
1.7.10.4
