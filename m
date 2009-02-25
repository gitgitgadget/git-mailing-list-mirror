From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 16/21] builtin-remote: fix two inconsistencies in the output of "show <remote>"
Date: Wed, 25 Feb 2009 03:32:23 -0500
Message-ID: <e4b8a7a0deac2b6ebdf05b0e664189d304358a57.1235546708.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:35:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFFA-0000Xo-OY
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760093AbZBYIdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759609AbZBYIdV
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:33:21 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:52135 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759920AbZBYIdI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:33:08 -0500
Received: by an-out-0708.google.com with SMTP id c2so1348060anc.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=PIhlW4J0P6JqOf/wtS5cnztmjQQk8iFlPVgSPU+EnC4=;
        b=tLR554GyEP1MPZuuF5ng6SFGid1IktuIOPGBeSew+n4WD9U2TsmzndROiW3Jm7cn6f
         /qvbJndr3BpsF3c1bKxd36UwREjnvk+aVT5fkPFRhsXLT+EnAF6tsdgqu1jBezsWi11j
         V+yRU7uqdPWMirFxW+zJGPUpP4I7wMxHvazlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xhO08Li2NajXuGZwxTeAkH3OameablqZtWl7XbscimvFiRVo0rJ8ouOy9htiZ+7Rxx
         +cGP4nvP4R6gjR3MQemxvGnv6Yb4nRXbVq42YBmlfyfE+Piv7EXmv74Fkda5Vld+jq8C
         0oHx96fU8n5SRSQ/TDW1NGUL9npiv+2u54Y74=
Received: by 10.100.32.6 with SMTP id f6mr834162anf.90.1235550787188;
        Wed, 25 Feb 2009 00:33:07 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b7sm12901557ana.39.2009.02.25.00.33.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:33:06 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111401>

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
index 1b5e8b6..963be6d 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -226,10 +226,8 @@ static int handle_one_branch(const char *refname,
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
@@ -258,6 +256,8 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	}
 	free_refs(fetch_map);
 
+	sort_string_list(&states->new);
+	sort_string_list(&states->tracked);
 	for_each_ref(handle_one_branch, states);
 	sort_string_list(&states->stale);
 
@@ -638,6 +638,9 @@ static int append_ref_to_tracked_list(const char *refname,
 	struct ref_states *states = cb_data;
 	struct refspec refspec;
 
+	if (flags & REF_ISSYMREF)
+		return 0;
+
 	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst = (char *)refname;
 	if (!remote_find_tracking(states->remote, &refspec))
@@ -666,8 +669,10 @@ static int get_remote_ref_states(const char *name,
 		transport_disconnect(transport);
 
 		get_ref_states(remote_refs, states);
-	} else
+	} else {
 		for_each_ref(append_ref_to_tracked_list, states);
+		sort_string_list(&states->tracked);
+	}
 
 	return 0;
 }
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index eb63718..a13d4b6 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -141,8 +141,8 @@ cat > test/expect << EOF
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
