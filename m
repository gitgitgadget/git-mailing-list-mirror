From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/11] sha1_name: check @{-N} errors sooner
Date: Tue,  7 May 2013 16:55:11 -0500
Message-ID: <1367963711-8722-12-git-send-email-felipe.contreras@gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 23:57:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZpt6-0000Gi-Q2
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 23:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305Ab3EGV5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 17:57:22 -0400
Received: from mail-gg0-f178.google.com ([209.85.161.178]:37246 "EHLO
	mail-gg0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab3EGV5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 17:57:16 -0400
Received: by mail-gg0-f178.google.com with SMTP id l2so247150ggn.37
        for <git@vger.kernel.org>; Tue, 07 May 2013 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=CoeCOjeXwTlN8sfdWFdk8vn2jYn5UmoCDav4/6/VFxc=;
        b=XDM2xbQbIWIgl4Dzk2r4tr66J882C3jRupAzYRpurC4swfGeeCW8mFkjabBNrZeb/p
         8MhuF+y+MEkMBJJ+eHyQbsJyZEipdAtO4w9kx69Mwni4MxvJtHCDWl1toThtffXM8OqB
         AA12BkzdNSKm30iyHihNfa9fl5qBdwbTKf1e4WCIK453cH3ISVDoTxX4uD+EXPn0tELp
         tETUneru+2QSIME27khxZ67ZyuTgTZjUgQ15EMm0L1KRDvwys6UUSC0PHSS/msg0LGem
         vKYfGeJDg0Wo0Pe+RkTXVM5MVhVpWi7XHcRqibiwAwp1TTgDzC+JSQnMaqiy0WrNKpUT
         k28Q==
X-Received: by 10.236.119.13 with SMTP id m13mr3864767yhh.155.1367963835309;
        Tue, 07 May 2013 14:57:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i67sm58480218yhq.25.2013.05.07.14.57.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 14:57:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223616>

From: Ramkumar Ramachandra <artagnon@gmail.com>

It's trivial to check for them in the @{N} parsing loop.

[fc: style]

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index c512c69..db965af 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -448,7 +448,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	if (len && str[len-1] == '}') {
 		for (at = len-4; at >= 0; at--) {
 			if (str[at] == '@' && str[at+1] == '{') {
-				if (at == 0 && str[2] == '-') {
+				if (str[at+2] == '-') {
+					if (at != 0)
+						/* @{-N} not at start */
+						return -1;
 					nth_prior = 1;
 					continue;
 				}
@@ -497,10 +500,6 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		unsigned long co_time;
 		int co_tz, co_cnt;
 
-		/* a @{-N} placed anywhere except the start is an error */
-		if (str[at+2] == '-')
-			return -1;
-
 		/* Is it asking for N-th entry, or approxidate? */
 		for (i = nth = 0; 0 <= nth && i < reflog_len; i++) {
 			char ch = str[at+2+i];
-- 
1.8.3.rc0.401.g45bba44
