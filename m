From: Greg Price <price@ksplice.com>
Subject: [PATCH 2/4] log --decorate=full: drop the "tag: " prefix
Date: Tue, 22 Dec 2009 17:22:38 -0500
Message-ID: <20091222222238.GW30538@dr-wily.mit.edu>
References: <20091222222032.GU30538@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 23:22:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NND7w-0003XN-L5
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 23:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbZLVWWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 17:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755193AbZLVWWn
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 17:22:43 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:41962 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755179AbZLVWWn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 17:22:43 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id nBMMM46P007375;
	Tue, 22 Dec 2009 17:22:05 -0500 (EST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id nBMMMpCX028826;
	Tue, 22 Dec 2009 17:22:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20091222222032.GU30538@dr-wily.mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135603>

The "tag: " prefix complicates machine parsing of decorations, so we
drop it from the output formats intended to be parsed by machine,
namely --decorate=full and the %D format code.

The prefix is helpful for a human reader to see that the ref is an
(annotated) tag, especially since we omit the "refs/tags/" prefix in
the default output of "git log --decorate".  In a script, however, it
is easy to use "git cat-file -t" to distinguish annotated tags from
commits when the distinction is relevant.

Signed-off-by: Greg Price <price@ksplice.com>
---
 log-tree.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 0fdf159..5eb6b00 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -22,17 +22,18 @@ static void add_name_decoration(const char *prefix, const char *name, struct obj
 
 static int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
+	int short_refs = !!(!cb_data || *(int *)cb_data == DECORATE_SHORT_REFS);
 	struct object *obj = parse_object(sha1);
 	if (!obj)
 		return 0;
-	if (!cb_data || *(int *)cb_data == DECORATE_SHORT_REFS)
+	if (short_refs)
 		refname = prettify_refname(refname);
 	add_name_decoration("", refname, obj);
 	while (obj->type == OBJ_TAG) {
 		obj = ((struct tag *)obj)->tagged;
 		if (!obj)
 			break;
-		add_name_decoration("tag: ", refname, obj);
+		add_name_decoration(short_refs ? "tag: " : "", refname, obj);
 	}
 	return 0;
 }
-- 
1.6.6.rc1.9.g2ad41.dirty
