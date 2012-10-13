From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 1/2] git-cvsimport: use localtime for converting timestamps
Date: Fri, 12 Oct 2012 23:11:54 -0500
Message-ID: <35710ee78133792f4c79b0afeb56804d745c1de5.1350100320.git.chris@rorvick.com>
References: <cover.1350100320.git.chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 06:12:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMt5E-0002zM-Lg
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 06:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898Ab2JMEL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 00:11:58 -0400
Received: from [38.98.186.242] ([38.98.186.242]:11675 "HELO burner.cogcap.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
	id S1750832Ab2JMEL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 00:11:56 -0400
Received: by burner.cogcap.com (Postfix, from userid 10028)
	id E5F932B0966; Fri, 12 Oct 2012 23:11:55 -0500 (CDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1350100320.git.chris@rorvick.com>
In-Reply-To: <cover.1350100320.git.chris@rorvick.com>
References: <cover.1350100320.git.chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207569>

cvsps formats timestamps for the local timezone in its output.
Using timegm() to convert to epoch-relative only works because
cvsimport overrides TZ to "UTC".  Using timelocal() does not change
the behavior of the script as is, but it does ensure cvsimport
behaves sanely if run with another TZ value.

Also, use localtime() for generating the commit timestamp instead of
gmtime().  Again, this has no affect on the script as is since TZ
is hard-wired to "UTC".  But using localtime() would allow someone
to change the value of TZ with what is likely the desired effect
(i.e., timestamps are written to the Git commit with local timezone
offset.)

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 git-cvsimport.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 8032f23..2f5da9e 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -582,7 +582,7 @@ sub pdate($) {
 	m#(\d{2,4})/(\d\d)/(\d\d)\s(\d\d):(\d\d)(?::(\d\d))?#
 		or die "Unparseable date: $d\n";
 	my $y=$1; $y-=1900 if $y>1900;
-	return timegm($6||0,$5,$4,$3,$2-1,$y);
+	return timelocal($6||0,$5,$4,$3,$2-1,$y);
 }
 
 sub pmode($) {
@@ -844,7 +844,7 @@ sub commit {
 		}
 	}
 
-	my $commit_date = strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date));
+	my $commit_date = strftime("%z %Y-%m-%d %H:%M:%S",localtime($date));
 	$ENV{GIT_AUTHOR_NAME} = $author_name;
 	$ENV{GIT_AUTHOR_EMAIL} = $author_email;
 	$ENV{GIT_AUTHOR_DATE} = $commit_date;
-- 
1.7.1
