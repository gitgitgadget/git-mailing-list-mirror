From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] sha1_name: fix error message for @{<N>}, @{<date>}
Date: Wed, 22 May 2013 16:09:55 +0530
Message-ID: <1369219195-20096-3-git-send-email-artagnon@gmail.com>
References: <1369219195-20096-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 22 12:38:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf6RA-0002Rl-D5
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 12:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092Ab3EVKiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 06:38:21 -0400
Received: from mail-da0-f41.google.com ([209.85.210.41]:32833 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab3EVKiU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 06:38:20 -0400
Received: by mail-da0-f41.google.com with SMTP id y19so1065163dan.0
        for <git@vger.kernel.org>; Wed, 22 May 2013 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lu3yWBsDC9ig4wPdF7/6HBWwJN2Y70GJkKXbd+cNJ90=;
        b=cnVj9m/pIJwuVk4P6RX4kDkK0EnWUAKiD2Lytg7tAjhNT993XCpm4F9qhh9TT4XrTU
         vFYzDucnE4nd0aPXGiMOrY/hRdQXVlVQ8XQUYt/BcEKfFPDWV9wnjXG472EPES7ggTTe
         Z/kwznyAedv86dI2MfzOn0OsCrOfA7156hLO6mcfyiPCoMSsCRXW6MCeKTwCLo7TM4NI
         VvE3Ex/C0hc3mVZhcN5zjhoj279PsOmxMldCF/kH21dp/YMLGYsjijcOREIXDGoxP2by
         wvqiIf7mb4smmqd16Adcz0mxjY8xGQusah4BOHCtkLu3VIBuJPnDnexquNpSOenWtmgX
         k/qA==
X-Received: by 10.68.130.199 with SMTP id og7mr7198474pbb.132.1369219099593;
        Wed, 22 May 2013 03:38:19 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id un15sm5905724pab.7.2013.05.22.03.38.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 May 2013 03:38:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.10.g6f8d616
In-Reply-To: <1369219195-20096-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225143>

Currently, when we try to resolve @{<N>} or @{<date>} when the reflog
doesn't go back far enough, we get errors like:

  # on branch master
  $ git show @{10000}
  fatal: Log for '' only has 7 entries.

  $ git show @{10000.days.ago}
  warning: Log for '' only goes back to Tue, 21 May 2013 14:14:45 +0530.
  ...

  # detached HEAD case
  $ git show @{10000}
  fatal: Log for '' only has 2005 entries.

  $ git show master@{10000}
  fatal: Log for 'master' only has 7 entries.

The empty string '' is ugly, inconsistent, and failing to convey
information about whose logs we are inspecting.  Change this so that we
get:

  # on branch master
  $ git show @{10000}
  fatal: Log for 'master' only has 7 entries.

  $ git show @{10000.days.ago}
  warning: Log for 'master' only goes back to Tue, 21 May 2013 14:14:45 +0530.
  ...

  # detached HEAD case
  $ git show @{10000}
  fatal: Log for 'HEAD' only has 2005 entries.

  $ git show master@{10000}
  fatal: Log for 'master' only has 7 entries.

Simple, consistent, and informative; suitable for output even from
plumbing commands like rev-parse.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sha1_name.c b/sha1_name.c
index 416a673..b7e008a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -517,6 +517,16 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		}
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
+			if (!len) {
+				if (!prefixcmp(real_ref, "refs/heads/")) {
+					str = real_ref + 11;
+					len = strlen(real_ref + 11);
+				} else {
+					/* detached HEAD */
+					str = "HEAD";
+					len = 4;
+				}
+			}
 			if (at_time)
 				warning("Log for '%.*s' only goes "
 					"back to %s.", len, str,
-- 
1.8.3.rc3.10.g6f8d616
