From: y@google.com
Subject: [PATCH 3/4] cherry-pick/revert: respect order of revisions to pick
Date: Sun, 12 Aug 2012 23:27:19 -0700
Message-ID: <50289e51.29d0320a.65ff.2c47SMTPIN_ADDED@gmr-mx.google.com>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <1344839240-17402-1-git-send-email-y>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 08:27:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0o7w-0007LB-3e
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 08:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab2HMG1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 02:27:35 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:33631 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab2HMG13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 02:27:29 -0400
Received: by obbwc20 with SMTP id wc20so2563652obb.1
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=l6P6flGUOqp5CJ0J5vfO3IPi6m3UrSSO0bUxCMA7CrE=;
        b=bw/99q+cfnWawNrdB4zplVHo2lDhXb2w/FmmETU1NHpbZRi4csKqX0y1GvAoSTKUNU
         3xkxO7Lg4UXBukb3Le97+spB9QHC7GQSrR0yhKzUoPVr0IKMSSzsFvJnXYV+mfRQwTHN
         9enjQcKiyNkzW1yuRUUFm3qLZ+dwFgRcvmXGzrbz/qSX6AVz/+4iaorP07Nx/wixRFSL
         ePDGux8Q/+oMf/QkaZsSHDeU/5q6KqjuoU+HqU4d1jFf9CHGGt6EySmfwYiy8SbtVswV
         vg+5TI+7j4MVeEnEI8uc7plkINYK5xtuj+X8MhmYJuSuAp3/qczcoylLZQaCZuZ/6e+j
         QmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=l6P6flGUOqp5CJ0J5vfO3IPi6m3UrSSO0bUxCMA7CrE=;
        b=IP6VfgfLMBJYYxjfYdr6w599DUezwTcLLreHs0byR3awzPEusXo/dz7onUpyIXWSJ9
         6vMkgyne5UBX6vpQl0Rp65pemvW2tQg27FBNl7VEjR9dc9redzl2PJ7qABk9BVAsdsUC
         t8bW5+msAw1yiVqeamu6BylFRYCqjto2BLkU8pMMCdIlPM2CNsDy8nzu2hfiVIb00R4h
         OpOmsbodJR2178/pb5a+xZV1SYRqYvzqMbiEcrqMIylzKXSEESnMfPzc3Z1OA4hNMgZn
         frxqK+FfLowLNz/Wcw8TTOdqegZdGmME89mEpoASX0d0uoLuz+CLOpOyI5+63OjVf5yu
         q29w==
Received: by 10.50.34.197 with SMTP id b5mr2589194igj.5.1344839249202;
        Sun, 12 Aug 2012 23:27:29 -0700 (PDT)
Received: by 10.50.34.197 with SMTP id b5mr2589188igj.5.1344839249137;
        Sun, 12 Aug 2012 23:27:29 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id mb9si1436220igc.1.2012.08.12.23.27.29
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sun, 12 Aug 2012 23:27:29 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id BBBA8100048;
	Sun, 12 Aug 2012 23:27:28 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 31FC4C1A17; Sun, 12 Aug 2012 23:27:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1344839240-17402-1-git-send-email-y>
X-Gm-Message-State: ALoCoQn3hfRbOLZ+TzZPgOQGiWV0dtWIIqEjIn51lK+yKkBk0GYnqZR3xw7PmS8ps8cUy6B1A8NSGBEnwWl2GjxYNF6NnoT7QTzYQ75LoJ43brnTGuOFMA9rtpLJlv4Xo9FaKlcz1Y6V68zdZNJGet/C0kAwjTcjzPuIjkmSPTD/sDmCT1dYtYuYxn6ZH5iXs58CMYYpiVX0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203325>

From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

'git cherry-pick A B' implicitly sends --no-walk=sorted to the
revision walker, which means that the older of A and B will be applied
first, which is most likely surprising to most. Fix this by instead
sending --no-walk=unsorted to the revision walker.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

This has actually been reported before, in
http://thread.gmane.org/gmane.comp.version-control.git/164794/focus=164807,
where I apparently replied myself. Incidentally, it seems like the
unrelated bug in 'git show' I reported in that thread is the one that
Junio mentioned got fixed recently.

 builtin/revert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 42ce399..98ad641 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -193,7 +193,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		struct setup_revision_opt s_r_opt;
 		opts->revs = xmalloc(sizeof(*opts->revs));
 		init_revisions(opts->revs, NULL);
-		opts->revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
+		opts->revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
 		memset(&s_r_opt, 0, sizeof(s_r_opt));
-- 
1.7.11.1.104.ge7b44f1
