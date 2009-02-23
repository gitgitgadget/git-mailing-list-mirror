From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 04/13] remote: make get_remote_ref_states() always populate states.tracked
Date: Mon, 23 Feb 2009 01:28:52 -0500
Message-ID: <2185ca69c518d60276ba1bc613b7699a6bca7c68.1235368324.git.jaysoffian@gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 07:31:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbULL-00072Y-Sq
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbZBWG3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbZBWG3S
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:29:18 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:12887 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbZBWG3P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:29:15 -0500
Received: by yx-out-2324.google.com with SMTP id 8so746768yxm.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=pdwQ2QcvV5cViFU03/opxFBjl6nXdM7BFKZkrEnXb1Y=;
        b=N+SddTrNW1+cnaWztEXxTwdlp2uADqlcSQxUHcFMvot9aRyiXVGQeM3DKTfb0czpYq
         ZaDFjNYpWm45+TGqbBCnYJpYbcjFjWgkKMoMbshBx9dicVsEmJNzLzosKytOeO4E+aRv
         M9L6tDKXjX9g1yG78LFwhGuiM+lthzcBj+ZoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=iZoHKMHXmTP2nZG24EiOciXAy462o7kc8+KiB6AQn4SdD1yk4GJC6DkIG9l/msoil+
         J+RlOw9760OEm9eELwjdTJ7HapVGH0maH+jj6pMlCbjLdmUAcWErOTfkOUhLAAoSDZY2
         7w0PUKVnXaO2+LNolgF3VKWYxp0xhnDRxyd3s=
Received: by 10.100.135.16 with SMTP id i16mr143571and.99.1235370554030;
        Sun, 22 Feb 2009 22:29:14 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d35sm12280548and.58.2009.02.22.22.29.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 22:29:13 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.223.gfed32
In-Reply-To: <cover.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111094>

When not querying the remote, show() was having to populate
states.tracked itself. It makes more sense for get_remote_ref_states()
to do this consistently. Since show() is the only caller of
get_remote_ref_states() with query=0, this change does not affect the
other call sites.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   41 ++++++++++++++++++++---------------------
 1 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 31fbd1e..b61f754 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -656,6 +656,23 @@ static void free_remote_ref_states(struct ref_states *states)
 	string_list_clear(&states->heads, 0);
 }
 
+static int append_ref_to_tracked_list(const char *refname,
+	const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct ref_states *states = cb_data;
+	struct refspec refspec;
+
+	if (flags & REF_ISSYMREF)
+		return 0;
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
@@ -677,28 +694,14 @@ static int get_remote_ref_states(const char *name,
 
 		get_head_names(ref, name, states);
 		get_ref_states(ref, states);
+	} else {
+		for_each_ref(append_ref_to_tracked_list, states);
+		sort_string_list(&states->tracked);
 	}
 
 	return 0;
 }
 
-static int append_ref_to_tracked_list(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
-{
-	struct ref_states *states = cb_data;
-	struct refspec refspec;
-
-	if (flags & REF_ISSYMREF)
-		return 0;
-
-	memset(&refspec, 0, sizeof(refspec));
-	refspec.dst = (char *)refname;
-	if (!remote_find_tracking(states->remote, &refspec))
-		string_list_append(abbrev_branch(refspec.src), &states->tracked);
-
-	return 0;
-}
-
 static int show(int argc, const char **argv)
 {
 	int no_query = 0, result = 0;
@@ -757,10 +760,6 @@ static int show(int argc, const char **argv)
 				"prune')", &states.stale, "");
 		}
 
-		if (no_query) {
-			for_each_ref(append_ref_to_tracked_list, &states);
-			sort_string_list(&states.tracked);
-		}
 		show_list("  Tracked remote branch%s", &states.tracked, "");
 
 		if (states.remote->push_refspec_nr) {
-- 
1.6.2.rc1.223.gfed32
