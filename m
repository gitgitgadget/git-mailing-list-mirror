From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH 2/3] Allow Git::get_tz_offset to properly handle DST boundary times
Date: Tue, 15 Jan 2013 23:10:04 +0000
Message-ID: <1358291405-10173-3-git-send-email-bdwalton@gmail.com>
References: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
Cc: esr@thyrsus.com, git@vger.kernel.org,
	Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 16 00:11:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvFew-0000Dw-To
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 00:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934197Ab3AOXKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 18:10:44 -0500
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:44871 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758776Ab3AOXKM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 18:10:12 -0500
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:57196 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1TvFdx-0005dt-Qk ; Tue, 15 Jan 2013 18:10:09 -0500
Received: from 86-42-159-147-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.159.147]:55554 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1TvFdu-0005Cu-VO ; Tue, 15 Jan 2013 18:10:07 -0500
Received: from bwalton by neilyoung with local (Exim 4.80)
	(envelope-from <bwalton@benandwen.net>)
	id 1TvFe4-0002hJ-8U; Tue, 15 Jan 2013 23:10:16 +0000
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213688>

The Git::get_tz_offset is meant to provide a workalike replacement for
the GNU strftime %z format specifier.  The algorithm used failed to
properly handle DST boundary cases.

For example, the unix time 1162105199 in CST6CDT saw set_tz_offset
improperly return -0600 instead of -0500.

TZ=CST6CDT date -d @1162105199 +"%c %z"
Sun 29 Oct 2006 01:59:59 AM CDT -0500

$ zdump -v /usr/share/zoneinfo/CST6CDT | grep 2006
/usr/share/zoneinfo/CST6CDT  Sun Apr  2 07:59:59 2006 UTC = Sun Apr  2
01:59:59 2006 CST isdst=0 gmtoff=-21600
/usr/share/zoneinfo/CST6CDT  Sun Apr  2 08:00:00 2006 UTC = Sun Apr  2
03:00:00 2006 CDT isdst=1 gmtoff=-18000
/usr/share/zoneinfo/CST6CDT  Sun Oct 29 06:59:59 2006 UTC = Sun Oct 29
01:59:59 2006 CDT isdst=1 gmtoff=-18000
/usr/share/zoneinfo/CST6CDT  Sun Oct 29 07:00:00 2006 UTC = Sun Oct 29
01:00:00 2006 CST isdst=0 gmtoff=-21600

To determine how many hours/minutes away from GMT a particular time
was, we calculated the gmtime() of the requested time value and then
used Time::Local's timelocal() function to turn the GMT-based time
back into a scalar value representing seconds from the epoch.  Because
GMT has no daylight savings time, timelocal() cannot handle the
ambiguous times that occur at DST boundaries since there are two
possible correct results.

To work around the ambiguity at these boundaries, we must take into
account the pre and post conversion values for is_dst as provided by
both the original time value and the value that has been run through
timelocal().  If the is_dst field of the two times disagree then we
must modify the value returned from timelocal() by an hour in the
correct direction.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 perl/Git.pm |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/perl/Git.pm b/perl/Git.pm
index 5649bcc..788b9b4 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -528,7 +528,27 @@ If TIME is not supplied, the current local time is used.
 sub get_tz_offset {
 	# some systmes don't handle or mishandle %z, so be creative.
 	my $t = shift || time;
+	# timelocal() has a problem when it comes to DST ambiguity so
+	# times that are on a DST boundary cannot be properly converted
+	# using it.  we will possibly adjust its result depending on whehter
+	# pre and post conversions agree on DST
 	my $gm = timelocal(gmtime($t));
+
+	# we need to know whether we were originally in DST or not
+	my $orig_dst = (localtime($t))[8];
+	# and also whether timelocal thinks we're in DST
+	my $conv_dst = (localtime($gm))[8];
+
+	# re-adjust $gm based on the DST value for the two times we're
+	# handling.
+	if ($orig_dst != $conv_dst) {
+		if ($orig_dst == 1) {
+			$gm -= 3600;
+		} else {
+			$gm += 3600;
+		}
+	}
+
 	my $sign = qw( + + - )[ $t <=> $gm ];
 	return sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
 }
-- 
1.7.10.4
