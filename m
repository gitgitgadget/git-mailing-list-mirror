From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 14/23] builtin-remote: fix two inconsistencies in the output of "show <remote>"
Date: Tue, 24 Feb 2009 04:51:02 -0500
Message-ID: <adaab0f7a5ce8d9b5aee492052a0a9791230f551.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:55:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbu00-0002Ej-Q1
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986AbZBXJv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755952AbZBXJv4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:56 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:58685 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbZBXJvv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:51 -0500
Received: by mail-gx0-f174.google.com with SMTP id 22so6475210gxk.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=w0ztICLi+Lhjnyqhn2e6W1hkQfM0byDqQPhVR4iyXns=;
        b=nkRkBiASnVRlif4k1XHPLkoDLcw6oN7yrZrTgcthQ7rN2u6MyOIMxK/MxG+Dv9FGqe
         HqBp39SJm7vgJUpdGtHXmZYUA2uMOEMnpPOMuxqGhVWu1Gwqu4K+op76tGe+z+PXYOjT
         tjZB0E8i8TT+BYMwUtadM3b8FSMRT4EiO1CbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vPC9kFJMKuYWq3cxajwyBW96UGagE+4cIotSH+qWOmlZyd8WdkrGs5rA7czd2rzr9+
         q4i/2TDwSHPAnmcX2M19eGb+eh4laV+Wx0iaf9HVFiPk+UFg5DAAYxVMtw8Umi3YbePp
         zzIdL+wc663rMGrcJRcaP5t21oF22gVprOddo=
Received: by 10.100.142.4 with SMTP id p4mr5518926and.23.1235469110210;
        Tue, 24 Feb 2009 01:51:50 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b29sm10645299ana.31.2009.02.24.01.51.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:49 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111268>

Remote and stale branches are emitted in alphabetical order, but new and
tracked branches are not. So sort the latter to be consistent with the
former. This also lets us use more efficient string_list_has_string()
instead of unsorted_string_list_has_string().

"show <remote>" prunes symrefs, but "show <remote> -n" does not. Fix the
latter to match the former.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c  |   15 ++++++++++-----
 t/t5505-remote.sh |    2 +-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 56d73c8..cb56565 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -227,10 +227,8 @@ static int handle_one_branch(const char *refname,
 		const char *name = abbrev_branch(refspec.src);
 		/* symbolic refs pointing nowhere were handled already */
 		if ((flags & REF_ISSYMREF) ||
-				unsorted_string_list_has_string(&states->tracked,
-					name) ||
-				unsorted_string_list_has_string(&states->new,
-					name))
+		    string_list_has_string(&states->tracked, name) ||
+		    string_list_has_string(&states->new, name))
 			return 0;
 		item = string_list_append(name, &states->stale);
 		item->util = xstrdup(refname);
@@ -259,6 +257,8 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	}
 	free_refs(fetch_map);
 
+	sort_string_list(&states->new);
+	sort_string_list(&states->tracked);
 	for_each_ref(handle_one_branch, states);
 	sort_string_list(&states->stale);
 
@@ -688,6 +688,9 @@ static int append_ref_to_tracked_list(const char *refname,
 	struct ref_states *states = cb_data;
 	struct refspec refspec;
 
+	if (flags & REF_ISSYMREF)
+		return 0;
+
 	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst = (char *)refname;
 	if (!remote_find_tracking(states->remote, &refspec))
@@ -754,8 +757,10 @@ static int show(int argc, const char **argv)
 				"prune')", &states.stale, "");
 		}
 
-		if (no_query)
+		if (no_query) {
 			for_each_ref(append_ref_to_tracked_list, &states);
+			sort_string_list(&states.tracked);
+		}
 		show_list("  Tracked remote branch%s", &states.tracked, "");
 
 		if (states.remote->push_refspec_nr) {
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 9ea923b..56146eb 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -142,8 +142,8 @@ cat > test/expect << EOF
   New remote branch (next fetch will store in remotes/origin)
     master
   Tracked remote branches
-    side
     master
+    side
   Local branches pushed with 'git push'
     master:upstream
     +refs/tags/lastbackup
-- 
1.6.2.rc1.291.g83eb
