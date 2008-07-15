From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [RFC/PATCH 1/2] Avoid rescanning unchanged entries in search for copies.
Date: Wed, 16 Jul 2008 01:59:56 +0400
Organization: TEPKOM
Message-ID: <200807160159.56228.angavrilov@gmail.com>
References: <200807160158.34994.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 00:01:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIsa3-0006RX-U1
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 00:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755AbYGOWAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 18:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755621AbYGOWAI
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 18:00:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:33994 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524AbYGOWAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 18:00:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2348732fgg.17
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 15:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dwozTNZAERgxPghk783UpbeTdjAXYSBTbRP3CQpKdfI=;
        b=Ox/ZF7WYYcnuNc9x+3wY8ymvWTIuwQrnlCm+7cYfZbBLj39zXLJnEi/bRuB0QFptdw
         YhK1kSEWPVkrOQN1XHOnUmDVqTTNjlYMMGCGgKE0YAHSIhZkQikgPIvOIz+CFS7k1tIz
         3MwbxmEaln/qKGyAUjum5F9sNp9ks4N/GgqvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EV5b3vfQksuUYF/BKRUvtHopj9MFHxWP1ZFAqqR++NvHdc9kpo6HWrm54YOTr8XDeS
         aY1IxZgwl5OtnOqSYH2iTDXn6qUqijOYPLk8snZAfGldYmABEvaeuWAHWLOiKEhrgWQl
         1TXe9gIer3e8l0cSou03fB6iyv+LxWC+6/J/Q=
Received: by 10.86.31.18 with SMTP id e18mr950108fge.52.1216159205139;
        Tue, 15 Jul 2008 15:00:05 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id l19sm5416992fgb.7.2008.07.15.15.00.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jul 2008 15:00:04 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200807160158.34994.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88606>

Repeatedly comparing the same entry against the same set
of blobs in search for copies is quite pointless. This
huge waste of effort can be avoided using a flag in
the blame_entry structure.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 builtin-blame.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index b451f6c..a6cf6b6 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -161,6 +161,10 @@ struct blame_entry {
 	 */
 	char guilty;
 
+	/* true if the entry has been scanned for copies in the current parent
+	 */
+	char scanned;
+
 	/* the line number of the first line of this group in the
 	 * suspect's file; internally all line numbers are 0 based.
 	 */
@@ -1048,12 +1052,12 @@ static struct blame_list *setup_blame_list(struct 
scoreboard *sb,
 	struct blame_list *blame_list = NULL;
 
 	for (e = sb->ent, num_ents = 0; e; e = e->next)
-		if (!e->guilty && same_suspect(e->suspect, target))
+		if (!e->scanned && !e->guilty && same_suspect(e->suspect, target))
 			num_ents++;
 	if (num_ents) {
 		blame_list = xcalloc(num_ents, sizeof(struct blame_list));
 		for (e = sb->ent, i = 0; e; e = e->next)
-			if (!e->guilty && same_suspect(e->suspect, target))
+			if (!e->scanned && !e->guilty && same_suspect(e->suspect, target))
 				blame_list[i++].ent = e;
 	}
 	*num_ents_p = num_ents;
@@ -1061,6 +1065,16 @@ static struct blame_list *setup_blame_list(struct 
scoreboard *sb,
 }
 
 /*
+ * Reset the scanned status on all entries.
+ */
+static void reset_scanned_flag(struct scoreboard *sb)
+{
+	struct blame_entry *e;
+	for (e = sb->ent; e; e = e->next)
+		e->scanned = 0;
+}
+
+/*
  * For lines target is suspected for, see if we can find code movement
  * across file boundary from the parent commit.  porigin is the path
  * in the parent we already tried.
@@ -1152,6 +1166,8 @@ static int find_copy_in_parent(struct scoreboard *sb,
 				split_blame(sb, split, blame_list[j].ent);
 				made_progress = 1;
 			}
+			else
+				blame_list[j].ent->scanned = 1;
 			decref_split(split);
 		}
 		free(blame_list);
@@ -1164,6 +1180,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 			break;
 		}
 	}
+	reset_scanned_flag(sb);
 	diff_flush(&diff_opts);
 	diff_tree_release_paths(&diff_opts);
 	return retval;
-- 
1.5.6.2.39.gd084
