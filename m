From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 15/21] builtin-remote: make get_remote_ref_states() always populate states.tracked
Date: Wed, 25 Feb 2009 03:32:22 -0500
Message-ID: <3c8edf8ff2bcf53409282ce9e6f38849e7003a8d.1235546708.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:35:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFF9-0000Xo-AU
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760049AbZBYIdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759862AbZBYIdO
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:33:14 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:59166 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759609AbZBYIdH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:33:07 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1285109yxm.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=D++RDK8kfJkDB0dyFkwLAEzvtSafhmNoHZY6S4hiMHk=;
        b=GWQUIFBH8JPZjuPo5EGpjfqQMOvhWkxAlhy9prhtnklE/Ydk5rd6M8aj4tQBvpJyzA
         Wd2sw8nOBdoHAOKvPQlcqHuor8xNaHoYCnY0nljHuwXeS4Eg67gb7BoF0INd5bos6bvx
         OoaaMz9W2Dmvqk84BpLaKObnMgpFcL2VXDQ1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KDCLM7EB/zGJs18j9RbxIHGzBCiQutTOqJWCnDO9LY3biiShWxZMYwPBhdPsHan+ni
         P8yI4BH/rNigoCqsY7CgjNVlGLkKMyzRbxYZLOyKx8O+BojeMxKJtFzE/QjpwiaEJdgw
         gHxqO6KmY/1vT3BAVqiMRLSHhlHKJitYgMt0o=
Received: by 10.100.120.19 with SMTP id s19mr827494anc.149.1235550784889;
        Wed, 25 Feb 2009 00:33:04 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c28sm4871856anc.45.2009.02.25.00.33.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:33:04 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111407>

When not querying the remote, show() was having to populate
states.tracked itself. It makes more sense for get_remote_ref_states()
to do this consistently. Since show() is the only caller of
get_remote_ref_states() with query=0, this change does not affect
other callers.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index fc02e5f..1b5e8b6 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -632,6 +632,20 @@ static void free_remote_ref_states(struct ref_states *states)
 	string_list_clear(&states->tracked, 0);
 }
 
+static int append_ref_to_tracked_list(const char *refname,
+	const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct ref_states *states = cb_data;
+	struct refspec refspec;
+
+	memset(&refspec, 0, sizeof(refspec));
+	refspec.dst = (char *)refname;
+	if (!remote_find_tracking(states->remote, &refspec))
+		string_list_append(abbrev_branch(refspec.src), &states->tracked);
+
+	return 0;
+}
+
 static int get_remote_ref_states(const char *name,
 				 struct ref_states *states,
 				 int query)
@@ -652,21 +666,8 @@ static int get_remote_ref_states(const char *name,
 		transport_disconnect(transport);
 
 		get_ref_states(remote_refs, states);
-	}
-
-	return 0;
-}
-
-static int append_ref_to_tracked_list(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
-{
-	struct ref_states *states = cb_data;
-	struct refspec refspec;
-
-	memset(&refspec, 0, sizeof(refspec));
-	refspec.dst = (char *)refname;
-	if (!remote_find_tracking(states->remote, &refspec))
-		string_list_append(abbrev_branch(refspec.src), &states->tracked);
+	} else
+		for_each_ref(append_ref_to_tracked_list, states);
 
 	return 0;
 }
@@ -720,8 +721,6 @@ static int show(int argc, const char **argv)
 				"prune')", &states.stale, "");
 		}
 
-		if (no_query)
-			for_each_ref(append_ref_to_tracked_list, &states);
 		show_list("  Tracked remote branch%s", &states.tracked, "");
 
 		if (states.remote->push_refspec_nr) {
-- 
1.6.2.rc1.291.g83eb
