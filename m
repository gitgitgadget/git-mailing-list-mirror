From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] transport-helper: die on errors reading refs.
Date: Fri, 31 Jul 2015 16:57:57 -0700
Message-ID: <1438387077-10181-1-git-send-email-sbeller@google.com>
Cc: barkalow@iabervon.org, mhagger@alum.mit.edu, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 01 01:58:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLKBi-0000UC-9k
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 01:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbbGaX6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 19:58:01 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35207 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbbGaX6A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 19:58:00 -0400
Received: by pabkd10 with SMTP id kd10so48092439pab.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 16:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5f2QRYN8UFsEX02mTYjATFUJfxIjlde61W2AQesPW74=;
        b=QtA/hp8UBCu3edgtuqFzpgto0NK1I4T4W3ZTXM0SLflWWRfpSpLaCNUy1B/5r8vXVl
         fehv2c/h99MBaarCSGAH4iL6NOKiACLQg2QU2qbGVmjYajQQbewO2hwHRe/qksWsoUsK
         PlhnXtynsOcAl9q7foREzWhnKnDIKU5i7W7nNmAAlCpHHcDEEV9Ardu2AfP1MjurOYKL
         9gs2IYUTZJK8lfwQZGHNOJ0GcSe2I7kUPUUdIGHhS4fkQVPE1DpXnVTqkeCGoIo1m7OH
         4DECoWRoJD1dljRFGSbgJFsvNa9ty7el980xhUVzeoVlleZz5JrRHtkyHylrfM8tBz1b
         GPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5f2QRYN8UFsEX02mTYjATFUJfxIjlde61W2AQesPW74=;
        b=JPgVdPt0lwY4cabqrxqq/DcIi0NLpcc9L0A2MFaoLHbmAHshwJRAjkn/O1Eh0BN6bD
         OUg1mYrEpSGq5dE6sZwwyovkvJEskUgpwaZ1RwkeNVoSFwx8KyLxSsbSN4Gx24fdR6aP
         SUkBn3RZncAqC974iCKFA1tIs65oVFRQY1NEmlAtaaK7IS/OnTByX7HaOaV+ALd+/RmZ
         +JVBJi/dDZ+yIUudtuyyLBCE8gv8gcmmKSHTDnEjmusoLKysGZdfliURZt6eEyO0uD2d
         AUEHhLotmsEhYJX1ECJ/enWcob+6giWu1x6KDXQR3fuqQXvKEUGcbkoHs9nAHWt5B7xL
         7D2w==
X-Gm-Message-State: ALoCoQmXO3ZNJEuuMvNc/VuNUFiqBJCAqiZtI1nCFIqMyr9nO9Uv6cF/oVtuLt/8rdmnO752awiX
X-Received: by 10.68.200.162 with SMTP id jt2mr442545pbc.29.1438387079568;
        Fri, 31 Jul 2015 16:57:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:e5af:ce62:986f:5269])
        by smtp.gmail.com with ESMTPSA id jr10sm73344pbc.43.2015.07.31.16.57.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 16:57:59 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.5.gf4cd9ae.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275100>

We check the return value of read_ref in 19 out of 21 cases.
This adds checks to the missing cases.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 transport-helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 5d99a6b..68e498e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -490,7 +490,8 @@ static int fetch_with_import(struct transport *transport,
 		else
 			private = xstrdup(name);
 		if (private) {
-			read_ref(private, posn->old_sha1);
+			if (read_ref(private, posn->old_sha1) < 0)
+				die("Could not read ref %s", private);
 			free(private);
 		}
 	}
@@ -1019,7 +1020,10 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 		if (eon) {
 			if (has_attribute(eon + 1, "unchanged")) {
 				(*tail)->status |= REF_STATUS_UPTODATE;
-				read_ref((*tail)->name, (*tail)->old_sha1);
+				if (read_ref((*tail)->name,
+					     (*tail)->old_sha1) < 0)
+					die(N_("Could not read ref %s"),
+					    (*tail)->name);
 			}
 		}
 		tail = &((*tail)->next);
-- 
2.5.0.5.gf4cd9ae.dirty
