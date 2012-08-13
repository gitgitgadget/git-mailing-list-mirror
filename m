From: y@google.com
Subject: [PATCH 4/4] cherry-pick/revert: default to topological sorting
Date: Sun, 12 Aug 2012 23:27:20 -0700
Message-ID: <50289e51.29d0320a.65ff.2c48SMTPIN_ADDED@gmr-mx.google.com>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <1344839240-17402-1-git-send-email-y>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 08:27:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0o7w-0007LB-J1
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 08:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288Ab2HMG1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 02:27:36 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:36752 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab2HMG13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 02:27:29 -0400
Received: by obbwc20 with SMTP id wc20so2563653obb.1
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BjLVxhnZJu0WEuoutn+3durerbRH9Z76zyL87j5rf3I=;
        b=J1nbkDiOI5c/sxZZ9yQcVQJYKhQ6ueECrh1uFzx4baJn31s4+2LHwlpJK5ydAAjs9A
         lOp5HRjj0EwJtBrYxxxNjefwZnMdjXam8v84vHMiK/wf+EbGmUlWE51SbnrN2kFXzph5
         oIZ+ZGtlagR1oLzr4kXDk+wOV3xwEEjefita8zSy7mTjZfWuvzWDXlAUyTvNtz/HQTHY
         fd5QNkhWn65sbgmuTYHHasVtX4gWMfafunMdSU4kL5WKKKyh/RuPBahWxmleU3fifKhr
         Dp6aCFSkAlsIr41Gh0cS6IHfqTZZB4OREKKKomDM3Trb5uNU7LaQ1yNwEtwcvvsr3833
         ykkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=BjLVxhnZJu0WEuoutn+3durerbRH9Z76zyL87j5rf3I=;
        b=oR+dqP+J9YaTQvsgGYMlYDE9HBFc3Mh9vxy3Sk3IcCqqsblla7tchNmBLHnZNM5jab
         ct6XR5GRWPXb9zW5N2TGBBf3+xKcheZNl73Q/UnDhR3MaBjDlk1Iz1V+qp+CG5SqTUaD
         Wj631KxEPzm+BcpBz6hPNO/+Tx/hqfZuflXLmUtGZSFgjELDSRvFpOCuPuisLOGYaMD6
         ZBHMcHyDZ7sWFD8u33Sen+OxlZQ+tt6tkXKMiVsUhqd9s1k751re0dxvZv1WO+xM2/z2
         9LpIRmMUrT5in+gADCtntEx6bijXVguvdIQAGCdq8stu4DJXE6qZi2AvtuIjeQtqZfAg
         /cqg==
Received: by 10.42.127.211 with SMTP id j19mr650031ics.16.1344839249217;
        Sun, 12 Aug 2012 23:27:29 -0700 (PDT)
Received: by 10.42.127.211 with SMTP id j19mr650026ics.16.1344839249179;
        Sun, 12 Aug 2012 23:27:29 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id mb9si1436445igc.1.2012.08.12.23.27.29
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sun, 12 Aug 2012 23:27:29 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id C6402100049;
	Sun, 12 Aug 2012 23:27:28 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 570A1C1A18; Sun, 12 Aug 2012 23:27:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1344839240-17402-1-git-send-email-y>
X-Gm-Message-State: ALoCoQl3eh/MPbKmFGM+iu2CGi2FskNkph7byBIWwPlWG8/XyNHvHk8VDyUB1+sqyAqASXLd/utpWP/eEqols33zWRevlIK0iMhxS2IeZhFC7TSZImkTOsCumVoYKbfKoVThEjz4jcUC0mv3m9Z/q5kcYHEETZWGuyAODI+1NK1mq2R9xO4DMt/4c+bc4/8OPFwJpNK0ysDu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203324>

From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

When 'git cherry-pick' and 'git revert' are used with ranges such as
'git cherry-pick A..B', the order of the commits to pick are
determined by the default date-based sorting. If a commit has a commit
date before the commit date of its parent, it will therfore be applied
before its parent. In the context of cherry-pick/revert, this is most
likely not what the user expected, so let's enable topological sorting
by default.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 builtin/revert.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index 98ad641..6880ce5 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -194,6 +194,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		opts->revs = xmalloc(sizeof(*opts->revs));
 		init_revisions(opts->revs, NULL);
 		opts->revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
+		opts->revs->topo_order = 1;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
 		memset(&s_r_opt, 0, sizeof(s_r_opt));
-- 
1.7.11.1.104.ge7b44f1
