From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 03/13] remote: fix two inconsistencies in the output of "show <remote>"
Date: Mon, 23 Feb 2009 01:28:51 -0500
Message-ID: <30b0e9a2ad91f17f9ebbfe9954522dcbf3b24f5e.1235368324.git.jaysoffian@gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 07:31:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbULL-00072Y-5Z
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:31:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbZBWG3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbZBWG3R
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:29:17 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:12876 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbZBWG3N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:29:13 -0500
Received: by yx-out-2324.google.com with SMTP id 8so746765yxm.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Ko72vWWs4svEhsm6NgZ4GNwNqaB3QUQiHRZ4IdjR9N8=;
        b=oEDT7NH+a+BFACZeKTA3Bd6Etq5+CkZaD9olz46qZ3MonZFdOoW/EwGajoXUYj1CgT
         JYHkYwDAbnOr2NPR1CeqvG2hxmTV/NOxSxaFVUPmINwatIHUDKJ5u6m44HXw/dMdkGQV
         05iIuML6IU7soAta1a9+ml6bdFlg2w3zy3HTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jDjoUpWpg8U/BRR+aqt47xg7NKAHE3WE7bHQ05nTg+BZcMd1MOZkSUIpWN4Nb4FB0X
         oDdljp94QZo2adPb3KUbo0i0JD8iTncooe/VWTtYkHDJXOEuyo7q6+vwT5T+YnfF+474
         NrTP5zDGFvJ8qJX7sODkUPphHIUW8I2Qa/dvs=
Received: by 10.100.3.13 with SMTP id 13mr3567061anc.74.1235370551917;
        Sun, 22 Feb 2009 22:29:11 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d12sm11276968and.44.2009.02.22.22.29.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 22:29:11 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.223.gfed32
In-Reply-To: <cover.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111089>

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
index f2ef08a..31fbd1e 100644
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
@@ -258,6 +256,8 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
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
index 104433d..fdc4a29 100755
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
1.6.2.rc1.223.gfed32
