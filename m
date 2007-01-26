From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 1/2] UNIX reference time of 1970-01-01 00:00 is UTC timezone, not local time zone
Date: Fri, 26 Jan 2007 08:58:48 +0000
Message-ID: <200701260858.48212.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 09:58:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAMv9-0003xf-Sw
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 09:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030835AbXAZI6w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 03:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030836AbXAZI6w
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 03:58:52 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:18903 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030835AbXAZI6w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 03:58:52 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 26 Jan 2007 09:01:49 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HAMv4-0000ze-00
	for <git@vger.kernel.org>; Fri, 26 Jan 2007 08:58:50 +0000
X-TUID: 7c0d9e7b24ffa12c
X-UID: 208
X-Length: 2272
Content-Disposition: inline
X-OriginalArrivalTime: 26 Jan 2007 09:01:49.0500 (UTC) FILETIME=[9D2FC7C0:01C74128]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37814>

I got bitten because in the UK (where one would expect 1970-01-01 00:00
to be UTC 0) some politicians decided to mess around with daylight
savings time from 1968 to 1971; it was permanently BST (+0100).  That
means that on my computer the following is true:

$ date --date="1970-01-01 00:00" +"%F %T %z (%Z)"
1970-01-01 00:00:00 +0100 (BST)

This of course means that the --date argument to date is specified in
local time, not UTC.  So when the hooks--update script does this:

date=$(date --date="1970-01-01 00:00:00 +0000 $ts seconds")

It's actually saying (in my timezone) "1970-01-01 01:00:00 UTC" + $ts.
Clearly this is wrong.  The UNIX epoch started at midnight UTC not 1am
UTC.

This leads to the tagged time in hooks--update being shown as one hour
earlier than the true tagged time (in my timezone).  The problem would
be worse for other timezones.  For a +1300 timezone on 1970-01-01, the
tagged time would be 13 hours earlier.  Oops.

The solution is to force the reference time to UTC, which is what this
patch does.  In my timezone:

$ date --date="1970-01-01 00:00 +0000" +"%F %T %z (%Z)"
1970-01-01 01:00:00 +0100 (BST)

Much better.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 templates/hooks--update |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 9863a80..81f706f 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -46,7 +46,7 @@ then
 		if [ "$ref_type" = tag ]; then
 			eval $(git cat-file tag $3 | \
 				sed -n '4s/tagger \([^>]*>\)[^0-9]*\([0-9]*\).*/tagger="\1" ts="\2"/p')
-			date=$(date --date="1970-01-01 00:00:00 $ts seconds" +"$date_format")
+			date=$(date --date="1970-01-01 00:00:00 +0000 $ts seconds" +"$date_format")
 			echo "Tag '$tag' created by $tagger at $date"
 			git cat-file tag $3 | sed -n '5,$p'
 			echo
-- 
1.5.0.rc2.g017f3
