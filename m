From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 06/33] Fix the do_get_patch function.
Date: Sun, 18 May 2014 23:59:42 +0200
Message-ID: <1400450409-30998-7-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:04:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9CF-0008ML-HY
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbaERWEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:04:40 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:56003 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbaERWEj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:04:39 -0400
Received: by mail-la0-f41.google.com with SMTP id e16so3510501lan.0
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E0dOF6Wl/e8iUfL+xziqJ9pwWu0F+7vJxV3PrhFIXzQ=;
        b=FLbjscdWA1mjaI1qfV58PeewnXg9fy5Bu0wu/Xa+hJ40s0U7Sl8YdOvkpx3bpDVXRP
         YXJuD0o4vCVdTmKve5J3mgvANl7nQsIadgBYhLEdRew6FAG+dNHZw7pXqlMQVGnnrRT/
         DOd6Hrwo/T6GHMDuSkh2ZyXzWOrEQBipLgNOas48rYYMVJCWeEFPBQmVRzpdu5GXaYwC
         Zr2lvaMIDNHQX3jhjwi2mFQZ6g2D6zNnpQH2ZvrfQHNPwSl+M+svJPxgd4jXXQo4cxfr
         xkwJTgKjbs8r9ivoPEpuStLG7lUXGB4DZY97m2ag9/z/ndWitf/MLMeQN2h/EoPMWfRe
         8Vkw==
X-Gm-Message-State: ALoCoQlzBybmaqIfKJbLzYcLTK0FdmxwdSFOuu+gKw+faqoNfkXsjGVUhvGBUWob9cn6kXdqtU6G
X-Received: by 10.112.41.101 with SMTP id e5mr12452903lbl.46.1400450678100;
        Sun, 18 May 2014 15:04:38 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.04.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:04:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249521>

A patch file consists of:

(1) the description
(2) optional diffstat
(3) the patches

When extracting the patch, we only want part 3.  The do_get_patch used
to give us part 2 and part 3.  That made for instance this series of
operations fail if guilt.diffstat is true:

    $ guilt new empty-1
    $ guilt new empty-2
    $ guilt pop
    Now at empty-1
    $ guilt fold empty-2
    $ guilt pop
    All patches popped.
    $ guilt push
    Applying patch..empty-1
    fatal: unrecognized input
    To force apply this patch, use 'guilt push -f'

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt b/guilt
index 8701481..3fc524e 100755
--- a/guilt
+++ b/guilt
@@ -334,7 +334,7 @@ do_get_patch()
 {
 	awk '
 BEGIN{}
-/^(diff |---$|--- )/ {patch = 1}
+/^(diff |--- )/ {patch = 1}
 patch == 1 {print $0}
 END{}
 ' < "$1"
-- 
1.8.3.1
