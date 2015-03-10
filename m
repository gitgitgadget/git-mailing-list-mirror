From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] bundle.c: fix memory leak
Date: Tue, 10 Mar 2015 16:51:48 -0700
Message-ID: <1426031508-7575-1-git-send-email-sbeller@google.com>
References: <xmqqk2yoxx1u.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 11 00:58:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVU2c-0007If-3X
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 00:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbbCJX6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 19:58:21 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33538 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbbCJX6U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 19:58:20 -0400
Received: by iecvj10 with SMTP id vj10so1032801iec.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kaXWf4SJJ/axMR1Lx1R3KClm9c9n6mDM6/De8OjNd2Q=;
        b=pPjipo0qSnE5LvraSBqC6qoEGb4PPS2sIweUn9coCsXFRO72ySemfRrzHe3fnSiTY4
         PdslBsLiPlEGHyBqt6g3ycb5BzCCBmlLA0VaMSQ8kUhAixgpaSgfdQm6fo6XBT3COG4H
         dwLCuaeo1ahQXrI43TzWMfZVVDhIoc1+xQPbTX/C1FPolXd+xKJJn/9ZIbB0apWj4YK6
         h3AgeStDeqGiOqVPcNiDD7RqaW1QgpGj82LJfUCRlYSwybV7qRDDIo5ps659f8QbIj+Z
         uhe0B5sInL4q0onCN3rX/OGPIGUBBqiW9ODyblMlu+pSX7fQUL796shjE6i5R9cLUv60
         qHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kaXWf4SJJ/axMR1Lx1R3KClm9c9n6mDM6/De8OjNd2Q=;
        b=U8FdaMhuocjXAGSK1ZUDNweJckdHRWhLs1vsaU/kGldrynk1t7BaOe3DI0sI1TeThD
         xO1JeQa0CJE3XKUcI/q3tDULfEmWyfcadmY6RDkQcCgf993aOVoVbZGxlKPv+cH/C8qH
         1NKq7HlgEyDJm0PUYMxa+0yt92Ba98l/Gc+JEfkvxmM2ScAEe6zfZO9KNJ2LbbPv+kM7
         kQMKAzZMomSNQfM29ZpQDOBFtpAQawCP9ux63Gw+R14OM5YeQN9PUOB2KJnnk93/Wl+T
         7/Zj3tqmvbqeikOJAPAFZSFGuV/a4qddmK8Q2x1PSAeVVmgba8R6uPfcUB/gkppb90m5
         WZAg==
X-Gm-Message-State: ALoCoQnslR3IFXFDBzYBxtZL1fyLVwLPb8k0i2rt6iFgckAzXAknkD89otxJ4WUvlbAjmVe2V13d
X-Received: by 10.107.15.155 with SMTP id 27mr42863749iop.49.1426031511856;
        Tue, 10 Mar 2015 16:51:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:89e3:41de:f077:72dc])
        by mx.google.com with ESMTPSA id i20sm1423761igh.16.2015.03.10.16.51.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Mar 2015 16:51:51 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <xmqqk2yoxx1u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265287>

There was one continue statement without an accompanying `free(ref)`.
Instead of adding that, replace all the free&&continue with a goto
just after writing the refs, where we'd do the free anyway and then
reloop.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 bundle.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/bundle.c b/bundle.c
index 2e2dbd5..f732c92 100644
--- a/bundle.c
+++ b/bundle.c
@@ -334,7 +334,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		if (e->item->flags & UNINTERESTING)
 			continue;
 		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
-			continue;
+			goto skip_write_ref;
 		if (read_ref_full(e->name, RESOLVE_REF_READING, sha1, &flag))
 			flag = 0;
 		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
@@ -342,7 +342,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		if (e->item->type == OBJ_TAG &&
 				!is_tag_in_date_range(e->item, revs)) {
 			e->item->flags |= UNINTERESTING;
-			continue;
+			goto skip_write_ref;
 		}
 
 		/*
@@ -357,8 +357,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		if (!(e->item->flags & SHOWN) && e->item->type == OBJ_COMMIT) {
 			warning(_("ref '%s' is excluded by the rev-list options"),
 				e->name);
-			free(ref);
-			continue;
+			goto skip_write_ref;
 		}
 		/*
 		 * If you run "git bundle create bndl v1.0..v2.0", the
@@ -388,8 +387,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 				obj->flags |= SHOWN;
 				add_pending_object(revs, obj, e->name);
 			}
-			free(ref);
-			continue;
+			goto skip_write_ref;
 		}
 
 		ref_count++;
@@ -397,6 +395,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		write_or_die(bundle_fd, " ", 1);
 		write_or_die(bundle_fd, display_ref, strlen(display_ref));
 		write_or_die(bundle_fd, "\n", 1);
+ skip_write_ref:
 		free(ref);
 	}
 
-- 
2.3.0.81.gc37f363
