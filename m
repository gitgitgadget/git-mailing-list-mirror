From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] fsck_commit_buffer(): do not special case the last validation
Date: Thu, 14 Apr 2016 11:07:08 -0700
Message-ID: <20160414180709.28968-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 20:07:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqlfx-0005Wr-Pc
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbcDNSHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:07:31 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32790 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349AbcDNSHM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:07:12 -0400
Received: by mail-pa0-f66.google.com with SMTP id vv3so7359088pab.0
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id;
        bh=pKGi5juDs0zUbD9kGrLAq44hdFwafnsc+juPjqcEfzg=;
        b=xsuKTxqlVVX38VP3755Zn5IPBUZXCoH5TYHnC3MOBKx4zrGAZq6+5mdDHpNborYU2z
         HkgVYFk9whURUrBkBU0+aue2j1oJnREDFK4Pd/IONj8I4G3Hx90Vue3Qvi3zgOHAU+L3
         ZY1kGweOyJVR9Cj+55rY5pxfz+pc/HGdMQAD76KRN4cZgV/zC7xHGtrxxiNKhTmYH4yU
         gWTdpHwjK3cmZwB1eQlNIMGUigjL2HxX6iv0Jw6Xa17NBwt7GSL2VLJWCY7DsKoY/PZT
         1DOKj00JMBtWOv3WPQHL3JODi1i821M0EXy9czuaGOQ/gFjC1G2MsKyK1lGsppALoLWo
         VkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=pKGi5juDs0zUbD9kGrLAq44hdFwafnsc+juPjqcEfzg=;
        b=i3zZQCrlBaav84GltinGA9AcIIU1SMNQ5btIwILqqZkMhlGhCpecIcOJQz8GeyiKuv
         MMQ32kyIhv5+U2CWqx6NjBd0RLYqybpwwEuT2ozj/OrN2LBVzcivh0KIQHB0uckq6a2b
         8JL3jfdtIJ5bybiSIbdmowtiNngP9Zz1/5YqzzFt08GFLheK1vxmOol8Kvl34TKxuOVy
         LZTp0e2cqbIBl9OW948bXpaUgyVuxkduIf6wSRiNmUeV4UK88Cc4sTJx091JjOM4bxNc
         ar3u1YKMlEtdjxoOAtcGl1jADiD+pAHenmSNk8hSbrBgwcgAwYenxH6XcUo/Rjf6M4GC
         L5jA==
X-Gm-Message-State: AOPr4FX+hda2870Pe5JB8EpCfRM35eVlEFGcTZmqso5qARbGBAhOpWUDihjy+/GGc8oBtA==
X-Received: by 10.66.136.41 with SMTP id px9mr23085079pab.80.1460657231166;
        Thu, 14 Apr 2016 11:07:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b81a:d884:c9a1:bffc])
        by smtp.gmail.com with ESMTPSA id y27sm59414014pfi.11.2016.04.14.11.07.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Apr 2016 11:07:10 -0700 (PDT)
X-Mailer: git-send-email 2.8.1-355-gcea30bb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291540>

The pattern taken by all the validations in this function is:

	if (notice a violation exists) {
		err = report(... VIOLATION_KIND ...);
		if (err)
			return err;
	}

where report() returns zero if specified kind of violation is set to
be ignored, and otherwise shows an error message and returns non-zero.

The last validation in the function immediately after the function
returns 0 to declare "all good" can cheat and directly return the
return value from report(), and the current code does so, i.e.

	if (notice a violation exists)
		return report(... VIOLATION_KIND ...);
	return 0;

But that is a selfish code that declares it is the ultimate and
final form of the function, never to be enhanced later.  To allow
and invite future enhancements, make the last test follow the same
pattern.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fsck.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fsck.c b/fsck.c
index ca4c685..21dfa5f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -666,9 +666,11 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	err = fsck_ident(&buffer, &commit->object, options);
 	if (err)
 		return err;
-	if (!commit->tree)
-		return report(options, &commit->object, FSCK_MSG_BAD_TREE, "could not load commit's tree %s", sha1_to_hex(tree_sha1));
-
+	if (!commit->tree) {
+		err = report(options, &commit->object, FSCK_MSG_BAD_TREE, "could not load commit's tree %s", sha1_to_hex(tree_sha1));
+		if (err)
+			return err;
+	}
 	return 0;
 }
 
-- 
2.8.1-355-gcea30bb
