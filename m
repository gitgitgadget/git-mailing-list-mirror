From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH] tag.c: use the correct algorithm for the '--contains' option
Date: Sat, 17 Oct 2015 23:53:44 +0530
Message-ID: <1445106224-21013-1-git-send-email-Karthik.188@gmail.com>
References: <AOLa=ZSjNjey3zWozFkyFw-X-BPtsVNpQKqG5hO9-7qJOBR_KA@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, jsnitsel@redhat.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 17 20:23:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnW8k-0006Kh-6a
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 20:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbbJQSX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 14:23:29 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36775 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbbJQSX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 14:23:29 -0400
Received: by pacik9 with SMTP id ik9so16201096pac.3
        for <git@vger.kernel.org>; Sat, 17 Oct 2015 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a36pU0EijOzV0Ez+6Z1nSLjjjFf7XCG6SpF1j3AGfsY=;
        b=XEPlZR7BZ5WH2tvY/JgA363S3U2aMFw8lxQEXL2vUR+mdoFOwK/S0bqsDyLuikW5tE
         tDuhOrmHdKGrdV2uZsxZ+QFMZDDJy89KNtqjsugihpntQ63U8ZUsVpm+ihYcfGmHMnfy
         csanjF1Cn7ttyLxsA63xtWgy41t8vIrgykvKORRe7gcGQ4JXbKmC2+XD/s93Ba/wYd+H
         gswZOUwka3PNtmkNNw55aET9VmWG7/+YiG9xQlMLTYjcpNsBoDectqZYhS5J401d52rD
         FhHvFl5xoT58cgTRsjokbhEcXb7HWCxyr4MdvTjklppKPeO4qOs+iBSthM+JD+eH2u6e
         8JyQ==
X-Received: by 10.66.221.104 with SMTP id qd8mr24914233pac.155.1445106208676;
        Sat, 17 Oct 2015 11:23:28 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id rl17sm28019458pab.2.2015.10.17.11.23.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Oct 2015 11:23:28 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <AOLa=ZSjNjey3zWozFkyFw-X-BPtsVNpQKqG5hO9-7qJOBR_KA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279792>

In b7cc53e92c806b73e14b03f60c17b7c29e52b4a4 we port tag.c to use
ref-filter APIs for filtering and printing refs. But that commit
missed out on setting 'filter->with_commit_tag_algo' which would
ensure the correct algorithm is used for the '--contains' option.
As reported by Jerry Snitselaar, this causes the option to work way
slower than expected, fix this by setting 'filter->with_commit_tag_algo'
in tag.c before calling 'filter_refs()'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
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
