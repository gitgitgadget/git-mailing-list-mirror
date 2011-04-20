From: Michael Witten <mfwitten@gmail.com>
Subject: [RFC 2/5] Pretty Print: show tz when using DATE_LOCAL
Date: Wed, 20 Apr 2011 02:45:15 +0000
Message-ID: <acbcf231-e0a6-440e-be42-5f25da3e318d-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 04:57:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCNbq-0004uu-G8
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 04:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab1DTC5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 22:57:38 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49673 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab1DTC5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 22:57:37 -0400
Received: by ewy4 with SMTP id 4so83526ewy.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 19:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:message-id:in-reply-to
         :references;
        bh=JA1lLMV52vdDmI3s6dhsPzp7ZpvJK6y+sITGKscNzIg=;
        b=fNjIQ1iwwCdmFyivypcGiVDmregpNTNXs4B8kmrnlPTNNyN9YHi9JC7obGvMn4Wonb
         zuMSC5+tghZ2aErFe3/BH7vEuAyeLkIuJOhM896KIJK8dwpqXF2Dg41ZuCMZOxvNLSI4
         vlwOgU87RPwnF1VHnR4ozl+GxXU+wgWL0jzCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:message-id:in-reply-to:references;
        b=ouv50YGbw0umgbfu/0VdnGp1jpi+j+bE/jQKa46Be8Vgw5Rwcv/DCh75AwRX7kmb9m
         EMRs4dCqauaQjFytHi2J4kRIJPRg0ovRESouNEOZaJ4vrwqEFWR5CiKmjUQerC0Bnr0M
         CnfdBI+8AiI6vkZyo9wtxqitsew0dEdYE9WfA=
Received: by 10.213.35.137 with SMTP id p9mr2743710ebd.115.1303268256390;
        Tue, 19 Apr 2011 19:57:36 -0700 (PDT)
Received: from gmail.com (server105708.santrex.net [188.165.236.117])
        by mx.google.com with ESMTPS id u1sm335478eeh.6.2011.04.19.19.57.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2011 19:57:35 -0700 (PDT)
In-Reply-To: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171833>

Date: Fri, 11 Feb 2011 16:06:36 +0000
Currently, when the date mode is DATE_LOCAL, the
time zone is never pretty printed; this seems
to be an unnecessary pecularliarity, especially
when the time zone data could be useful to
the user.

This commit removes that special handling of
time zones.

Now, for instance, fast-import.c's write_crash_report()
will produce reports that provide more meaningful
dates.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 date.c                  |    3 +--
 t/t6300-for-each-ref.sh |    4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/date.c b/date.c
index 096468f..caa14fe 100644
--- a/date.c
+++ b/date.c
@@ -186,13 +186,12 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 			month_names[tm->tm_mon], tm->tm_year + 1900,
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
 	else
-		sprintf(timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
+		sprintf(timebuf, "%.3s %.3s %d %02d:%02d:%02d %d %+05d",
 				weekday_names[tm->tm_wday],
 				month_names[tm->tm_mon],
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tm->tm_year + 1900,
-				(mode == DATE_LOCAL) ? 0 : ' ',
 				tz);
 	return timebuf;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7dc8a51..050ed7d 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -175,8 +175,8 @@ test_expect_success 'Check format "short" date fields output' '
 '
 
 cat >expected <<\EOF
-'refs/heads/master' 'Mon Jul 3 15:18:43 2006' 'Mon Jul 3 15:18:44 2006'
-'refs/tags/testtag' 'Mon Jul 3 15:18:45 2006'
+'refs/heads/master' 'Mon Jul 3 15:18:43 2006 +0000' 'Mon Jul 3 15:18:44 2006 +0000'
+'refs/tags/testtag' 'Mon Jul 3 15:18:45 2006 +0000'
 EOF
 
 test_expect_success 'Check format "local" date fields output' '
-- 
1.7.4.18.g68fe8
