From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH 2/3] Fix get_tz_offset to properly handle DST boundary cases
Date: Sat,  9 Feb 2013 21:46:57 +0000
Message-ID: <1360446418-12280-3-git-send-email-bdwalton@gmail.com>
References: <1360446418-12280-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 09 22:47:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4IGx-0000KT-N3
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 22:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633Ab3BIVrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 16:47:10 -0500
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:58081 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932584Ab3BIVrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 16:47:08 -0500
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:52486 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1U4IGI-0001ME-SN ; Sat, 09 Feb 2013 16:47:06 -0500
Received: from 86-42-148-161-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.148.161]:39736 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1U4IGF-0007ja-Qu ; Sat, 09 Feb 2013 16:47:04 -0500
Received: from bwalton by neilyoung with local (Exim 4.80)
	(envelope-from <bwalton@benandwen.net>)
	id 1U4IGL-0003D7-Uc; Sat, 09 Feb 2013 21:47:10 +0000
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360446418-12280-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215875>

When passed a local time that was on the boundary of a DST change,
get_tz_offset returned a GMT offset that was incorrect (off by one
hour).  This is because the time was converted to GMT and then back to
a time stamp via timelocal() which cannot disambiguate boundary cases
as noted in its documentation.

Modify this algorithm, using an approach suggested by Junio C Hamano
that obtains the GMT time stamp by using timegm(localtime()) instead
of timelocal(gmtime()).  This avoids the ambigious conversion and
allows a correct time to be returned on every occassion.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 perl/Git.pm |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 5649bcc..a56d1e7 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -103,7 +103,7 @@ use Error qw(:try);
 use Cwd qw(abs_path cwd);
 use IPC::Open2 qw(open2);
 use Fcntl qw(SEEK_SET SEEK_CUR);
-use Time::Local qw(timelocal);
+use Time::Local qw(timegm);
 }
 
 
@@ -528,8 +528,8 @@ If TIME is not supplied, the current local time is used.
 sub get_tz_offset {
 	# some systmes don't handle or mishandle %z, so be creative.
 	my $t = shift || time;
-	my $gm = timelocal(gmtime($t));
-	my $sign = qw( + + - )[ $t <=> $gm ];
+	my $gm = timegm(localtime($t));
+	my $sign = qw( + + - )[ $gm <=> $t ];
 	return sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
 }
 
-- 
1.7.10.4
