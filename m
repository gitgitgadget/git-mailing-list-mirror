From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2] tag.c: use the correct algorithm for the '--contains' option
Date: Sun, 18 Oct 2015 15:55:04 +0530
Message-ID: <1445163904-24611-1-git-send-email-Karthik.188@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, jsnitsel@redhat.com,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 18 12:25:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znl9c-00081G-Ne
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 12:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbbJRKY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 06:24:56 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35025 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbbJRKYv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 06:24:51 -0400
Received: by pabws5 with SMTP id ws5so675221pab.2
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 03:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=a00y7q85RsvK/+8OChhSSq40GoSojccmgFKfKxu99GI=;
        b=rrwF+LzpfAhMLif0Wu23AP22ZgpL9Ykv3WNC7GZlVall71P79Je+Ri0qTXD0MJ1J+s
         nRPD8GYgmYkAmSYrucXNzEGE+/B7cFr4HJcdMyz2Pb6FI/p5hr4I6M1yIxjbtKnMHffU
         5V8xp/F043R5scK9euqCuo6WKUdaWzljmOuq53vDhJU9jIPji6dMEQooDwxTca59m7kf
         KuA0G98fj6X47e0Hsp5XS0jYSsmgA6/rLVgyimwK54mBGU53qhT958Y79d4eX1JWHjxP
         YdhqR4UaheiqKqpgTVlyjEmSaVH02EhCbyRKQlMxW+cDvwUu1pDy7tfWn1dsMNmqKJgh
         aGIg==
X-Received: by 10.66.145.193 with SMTP id sw1mr27715970pab.74.1445163890445;
        Sun, 18 Oct 2015 03:24:50 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id tk4sm30841413pab.45.2015.10.18.03.24.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Oct 2015 03:24:49 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279804>

In b7cc53e92c806b73e14b03f60c17b7c29e52b4a4 we port tag.c to use
ref-filter APIs for filtering and printing refs. In ref-filter we have
two implementations for filtering refs when the '--contains' option is
used. Although they do the same thing, one is optimized for filtering
branches and the other for tags (borrowed from branch.c and tag.c
respectively) and the 'filter->with_commit_tag_algo' bit decides which
algorithm must be used. Maybe we'd want to unify these eventually.

When we ported tag.c to use ref-filter APIs we missed out on setting
the 'filter->with_commit_tag_algo' bit.  As reported by Jerry
Snitselaar, this causes the '--contains' option to work way slower
than expected, fix this by setting 'filter->with_commit_tag_algo' in
tag.c before calling 'filter_refs()'.

Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/tag.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/tag.c b/builtin/tag.c
index 977a18c..2c5a9f1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -49,6 +49,7 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
 		format = "%(refname:short)";
 
 	verify_ref_format(format);
+	filter->with_commit_tag_algo = 1;
 	filter_refs(&array, filter, FILTER_REFS_TAGS);
 	ref_array_sort(sorting, &array);
 
-- 
2.6.1
