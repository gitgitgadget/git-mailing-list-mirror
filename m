From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule update: continue when a clone fails
Date: Thu,  9 Jun 2016 12:06:37 -0700
Message-ID: <20160609190637.21177-3-sbeller@google.com>
References: <20160609190637.21177-1-sbeller@google.com>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 09 21:07:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB5IU-0000jT-DQ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 21:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbcFITHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 15:07:07 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36293 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbcFITHD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 15:07:03 -0400
Received: by mail-pf0-f174.google.com with SMTP id t190so15540321pfb.3
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JxgpfdBkTMs0xNsQ5UpScaMItVgEJxGbAO+0MbqPeDA=;
        b=dsBeTC+Sp6wtp99BmBM3VcQ7opywyWpHcXIAmegQ5jEuSMbpAbaaDrEgIeYQVkr1Iz
         VcdfKeOlZAb4UTHeZC2Stk7v3xTsbyJejt6Pf0TBrd2M90ODpgN66qQ+dR9BlkMnnVJd
         NNha94d6n2Sau/I1ZCfrLH82QVnxLI3aV+AaC605TRc3rQ8ce3Q1wPqz6+NZ03HHuRei
         zFHH+hcozVDp0UR44PgqhgZ5cjhPTCIDymAHYdr8MIqvoKcGE9XM4v4mp5BrVl1IYr+9
         PBQV7T0OWSx2dQe6uWp/LqYq3CdCAXMXPv1ce7BaQaM0E7fnwNtc3XCn7Uory8u4cKMj
         MG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JxgpfdBkTMs0xNsQ5UpScaMItVgEJxGbAO+0MbqPeDA=;
        b=Tkr2vYxb+TTQLW6a0KaCdXolXI/LmqpZcGZsLZ6y2joiOOlVo5xih1XWR6yTPpz6Lq
         sFq6Cfi5JOHtNJFR0BHiwGEARMM++ebIHTr92y09FwFXMdHOzhCCyZcj5glsWOgDYG7e
         ze5jtBspYuGygsDxGDA0ltsIjFFzs8nr9yBPS7xod+ZwyBbOEf7NvDy+62KWzArm+4O+
         hl1ciRHB6kCSSlIeSdvyCImkvviyWIsvUd9hR2ozY8L5YcVaw1d2ZzfR+6yDRt3Xk1T8
         Pz2GzfctRvjxQEuc0jU+9UELcyeIjR6RUkxm6OtuTL2bl+wBw8Wdupu0Juz0VHIESsZe
         4tSg==
X-Gm-Message-State: ALyK8tKaETEG3/+v0wnTnTEkrsS+LC+cWj6ytnNLnHUnQX2BvW/fKbPrfmUl86VgIfMcvOtt
X-Received: by 10.98.89.85 with SMTP id n82mr1609282pfb.23.1465499221757;
        Thu, 09 Jun 2016 12:07:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f5a6:3f4d:c2c2:71e])
        by smtp.gmail.com with ESMTPSA id d69sm6485705pfj.31.2016.06.09.12.07.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Jun 2016 12:07:01 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc2.368.gdadd65c
In-Reply-To: <20160609190637.21177-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296916>

In 15ffb7cde48 (2011-06-13, submodule update: continue when a checkout
fails), we reasoned it is ok to continue, when there is not much of
a mental burden by the failure. If a recursive submodule fails to clone
because a .gitmodules file is broken (e.g. :
fatal: No url found for submodule path 'foo/bar' in .gitmodules
Failed to recurse into submodule path 'foo', signaled by exit code 128),
this is one of the cases where the user is not expected to have much of
a burden afterwards, so we can also continue in that case.

This means we only want to stop for updating submodules in case of rebase,
merge or custom update command failures, which are all signaled with
exit code 2.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b39ac10..7c62b53 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -705,7 +705,7 @@ cmd_update()
 			if test $res -gt 0
 			then
 				die_msg="$(eval_gettext "Failed to recurse into submodule path '\$displaypath'")"
-				if test $res -eq 1
+				if test $res -ne 2
 				then
 					err="${err};$die_msg"
 					continue
-- 
2.9.0.rc2.368.gdadd65c
