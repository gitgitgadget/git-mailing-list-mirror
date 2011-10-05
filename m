From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH WIP 3/3] log: add --exclude option
Date: Wed,  5 Oct 2011 18:18:08 +1100
Message-ID: <1317799088-26626-4-git-send-email-pclouds@gmail.com>
References: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 09:19:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBLkq-0005AO-1W
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 09:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757911Ab1JEHSz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 03:18:55 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64627 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757871Ab1JEHSx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 03:18:53 -0400
Received: by mail-gx0-f174.google.com with SMTP id v2so609860ggn.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7FxGwa3cN85lzsxar2JXkeE1IOBeRClKKe2mrHwHKx8=;
        b=MTEkTC7f2HTruKjPqYdyNF3ePK0YxguTJh9zGpr4SAwgbRrGQcW8ZTbv4C38O+aI6X
         il5rv8wlZ7rpXbEIxdfS6Bvum24GqTgpQhNkW1O1zbMSnq2/7WIDVtjugs22/EqICDOj
         xjzPqGS460WJpN5xxTXZz7Rq5ZcCWqm0hkZHA=
Received: by 10.236.79.72 with SMTP id h48mr12068374yhe.4.1317799133628;
        Wed, 05 Oct 2011 00:18:53 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id z15sm1159405yhg.21.2011.10.05.00.18.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 00:18:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 05 Oct 2011 18:18:40 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182833>

This only helps filtering out commits whose changes are _entirely_ filt=
ered out.
This does not affect patch generate (--patch, --stat and so on)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 revision.c |    7 +++++--
 revision.h |    2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index c46cfaa..8472553 100644
--- a/revision.c
+++ b/revision.c
@@ -334,8 +334,8 @@ static int rev_compare_tree(struct rev_info *revs, =
struct commit *parent, struct
=20
 	tree_difference =3D REV_TREE_SAME;
 	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
-	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "",
-			   &revs->pruning) < 0)
+	if (diff_tree_sha1_with_exclude(t1->object.sha1, t2->object.sha1, "",
+					&revs->pruning, &revs->el, 0, 0) < 0)
 		return REV_TREE_DIFFERENT;
 	return tree_difference;
 }
@@ -1454,6 +1454,9 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
 		return argcount;
 	} else if (!strcmp(arg, "--log-size")) {
 		revs->show_log_size =3D 1;
+	} else if (!prefixcmp(arg, "--exclude=3D")) {
+		add_exclude(arg + 10, "", 0, &revs->el);
+		revs->prune =3D 1;
 	}
 	/*
 	 * Grepping the commit log
diff --git a/revision.h b/revision.h
index 3d64ada..3709959 100644
--- a/revision.h
+++ b/revision.h
@@ -4,6 +4,7 @@
 #include "parse-options.h"
 #include "grep.h"
 #include "notes.h"
+#include "dir.h"
=20
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
@@ -133,6 +134,7 @@ struct rev_info {
 	/* diff info for patches and for paths limiting */
 	struct diff_options diffopt;
 	struct diff_options pruning;
+	struct exclude_list el;
=20
 	struct reflog_walk_info *reflog_info;
 	struct decoration children;
--=20
1.7.3.1.256.g2539c.dirty
