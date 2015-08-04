From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 44/45] builtin-am: check for valid committer ident
Date: Tue,  4 Aug 2015 21:52:05 +0800
Message-ID: <1438696326-19590-45-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:57:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcin-0004Li-IM
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbbHDN4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:56:46 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33031 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964990AbbHDNy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:56 -0400
Received: by padck2 with SMTP id ck2so9409245pad.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4UaphsQKqbuHYTWB5ue4/UtAsk/uRiL2m5Cy+R8JZHI=;
        b=XjR+uNkpT62FF7LLDqTQei02Zjwusjb2QI7gHQIg7uEtaK6lC2HuIcFP81txDQXRqd
         wT51Lez34ZTSUVvIHdr/qQ2bFsUXDW4K2P2ae1qGgrHejM+5FpPap9tngbm0ruh7foC1
         OjVTrhkvoGhWyHVBjjJNCeeRDtzZMOBzXml7PIddmri17cXYqeeZvklm137IP7VH8Cjy
         X8DPhyokKwPcNdxOYHlX4kOGe+sDTMM5GGsjNTngPNE5lit0jbalhuRSf3A+QUbOsAod
         loIUCkiXv3Tk2TXI8uMvkVhcPTTuHwJ0Om1Fxxx+/GcKdhE66PL+fjG+34OkNV07pIBw
         llsw==
X-Received: by 10.66.235.104 with SMTP id ul8mr8222041pac.33.1438696496592;
        Tue, 04 Aug 2015 06:54:56 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:53 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275310>

When commit_tree() is called, if the user does not have an explicit
committer ident configured, it will attempt to construct a default
committer ident based on the user's and system's info (e.g. gecos field,
hostname etc.) However, if a default committer ident is unable to be
constructed, commit_tree() will die(), but at this point of git-am's
execution, there will already be changes made to the index and work
tree.

This can be confusing to new users, and as such since d64e6b0 (Keep
Porcelainish from failing by broken ident after making changes.,
2006-02-18) git-am.sh will check to see if the committer ident has been
configured, or a default one can be constructed, before even starting to
apply patches.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 3c50392..1ff74ac 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2246,6 +2246,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
 				"it will be removed. Please do not use it anymore."));
 
+	/* Ensure a valid committer ident can be constructed */
+	git_committer_info(IDENT_STRICT);
+
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("failed to read the index"));
 
-- 
2.5.0.280.gd88bd6e
