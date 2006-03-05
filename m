From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] blame and annotate: show localtime with timezone.
Date: Sun, 05 Mar 2006 14:48:01 -0800
Message-ID: <7vbqwkecf2.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060305110351.GA23448@c165.ib.student.liu.se>
	<7vbqwlgkhk.fsf@assigned-by-dhcp.cox.net>
	<20060305123800.GD23448@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Mar 05 23:48:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG21H-0004sJ-3Z
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 23:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWCEWsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 17:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWCEWsE
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 17:48:04 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:54227 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932191AbWCEWsD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 17:48:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305224441.VOWI17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 17:44:41 -0500
To: git@vger.kernel.org
In-Reply-To: <20060305123800.GD23448@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sun, 5 Mar 2006 13:38:01 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17248>

Earlier they showed gmtime and timezone, which was inconsistent
with the way our commits and tags are pretty-printed.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 blame.c           |   15 ++++++++++++---
 git-annotate.perl |    8 +++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

e29f298a17ee898fd0d191d448ba4fc202175896
diff --git a/blame.c b/blame.c
index 59146fa..a3a8ddc 100644
--- a/blame.c
+++ b/blame.c
@@ -550,13 +550,22 @@ static void get_commit_info(struct commi
 	*tmp = 0;
 }
 
-char* format_time(unsigned long time, const char* tz)
+static const char* format_time(unsigned long time, const char* tz_str)
 {
 	static char time_buf[128];
 	time_t t = time;
+	int minutes, tz;
+	struct tm *tm;
 
-	strftime(time_buf, sizeof(time_buf), "%Y-%m-%d %H:%M:%S ", gmtime(&t));
-	strcat(time_buf, tz);
+	tz = atoi(tz_str);
+	minutes = tz < 0 ? -tz : tz;
+	minutes = (minutes / 100)*60 + (minutes % 100);
+	minutes = tz < 0 ? -minutes : minutes;
+	t = time + minutes * 60;
+	tm = gmtime(&t);
+
+	strftime(time_buf, sizeof(time_buf), "%Y-%m-%d %H:%M:%S ", tm);
+	strcat(time_buf, tz_str);
 	return time_buf;
 }
 
diff --git a/git-annotate.perl b/git-annotate.perl
index d93ee19..b113def 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -418,7 +418,13 @@ sub format_date {
 		return $_[0];
 	}
 	my ($timestamp, $timezone) = split(' ', $_[0]);
-	return strftime("%Y-%m-%d %H:%M:%S " . $timezone, gmtime($timestamp));
+	my $minutes = abs($timezone);
+	$minutes = int($minutes / 100) * 60 + ($minutes % 100);
+	if ($timezone < 0) {
+	    $minutes = -$minutes;
+	}
+	my $t = $timestamp + $minutes * 60;
+	return strftime("%Y-%m-%d %H:%M:%S " . $timezone, gmtime($t));
 }
 
 # Copied from git-send-email.perl - We need a Git.pm module..
-- 
1.2.4.gee5c7
