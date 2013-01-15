From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH 3/3] Avoid non-portable strftime format specifiers in git-cvsimport
Date: Tue, 15 Jan 2013 23:10:05 +0000
Message-ID: <1358291405-10173-4-git-send-email-bdwalton@gmail.com>
References: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
Cc: esr@thyrsus.com, git@vger.kernel.org,
	Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 16 00:11:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvFew-0000Dw-Dq
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 00:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934204Ab3AOXKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 18:10:44 -0500
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:44870 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758724Ab3AOXKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 18:10:11 -0500
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:57197 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1TvFdx-0005du-Qk ; Tue, 15 Jan 2013 18:10:09 -0500
Received: from 86-42-159-147-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.159.147]:55555 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1TvFdu-0005Cv-VA ; Tue, 15 Jan 2013 18:10:07 -0500
Received: from bwalton by neilyoung with local (Exim 4.80)
	(envelope-from <bwalton@benandwen.net>)
	id 1TvFe4-0002hO-Cy; Tue, 15 Jan 2013 23:10:16 +0000
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213687>

Neither %s or %z are portable strftime format specifiers.  There is no
need for %s in git-cvsimport as the supplied time is already in
seconds since the epoch.  For %z, use the function get_tz_offset
provided by Git.pm instead.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 git-cvsimport.perl |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 0a31ebd..344f120 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -26,6 +26,7 @@ use IO::Socket;
 use IO::Pipe;
 use POSIX qw(strftime tzset dup2 ENOENT);
 use IPC::Open2;
+use Git qw(get_tz_offset);
 
 $SIG{'PIPE'}="IGNORE";
 set_timezone('UTC');
@@ -864,7 +865,9 @@ sub commit {
 	}
 
 	set_timezone($author_tz);
-	my $commit_date = strftime("%s %z", localtime($date));
+	# $date is in the seconds since epoch format
+	my $tz_offset = get_tz_offset($date);
+	my $commit_date = "$date $tz_offset";
 	set_timezone('UTC');
 	$ENV{GIT_AUTHOR_NAME} = $author_name;
 	$ENV{GIT_AUTHOR_EMAIL} = $author_email;
-- 
1.7.10.4
