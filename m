From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] get_sha1: support relative path "<obj>:<sth>" syntax
Date: Wed, 10 Nov 2010 23:37:01 +0700
Message-ID: <1289407021-30287-1-git-send-email-pclouds@gmail.com>
References: <m3eiatfbg2.fsf@localhost.localdomain>
Cc: dirson@bertin.fr, kevin@sb.org, gitster@pobox.com, peff@peff.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 10 17:38:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGDh0-00010k-AA
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 17:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757006Ab0KJQi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 11:38:29 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63360 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757002Ab0KJQi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 11:38:28 -0500
Received: by iwn10 with SMTP id 10so999590iwn.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 08:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=B/vMK/BTUJcshdGs3ANFwWuVZ3XAMciPLXcOOpRmsns=;
        b=p+WyXr3aUMO9xrX2MgrOyYIO4d8ulQzgodIMbkaKfqgTYEoEzza+Poi0oHE7jz+Jek
         df07O52qihCYmimNttYkRlS1OfnbLkUX/46YilXyx+QvAPmtu1EymZARGf0EIfVL7FIf
         7zT0/A5n3BnYcvMMFtT2pUNBkTVzGWHqMlycQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JuBOEYQsXdRE0YuEuoPVsJhXPAqrGmV/1oQ8B1+MmKFjBzeoEk2Ju/vT8MxmLOtJQA
         M/YFSnJZUOnGXR2YWHCWpy5euylCdb9sQQcrM8ZzWcL6pnDYyiO8064i4SffcENFrXU8
         iAx+sUNUKlUxDuJG7B34feBDMaxdmP+PX75eM=
Received: by 10.231.59.77 with SMTP id k13mr6729933ibh.41.1289407108136;
        Wed, 10 Nov 2010 08:38:28 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id fw4sm1057418ibb.13.2010.11.10.08.38.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 08:38:26 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Nov 2010 23:37:05 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <m3eiatfbg2.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161158>

Currently :path and ref:path can be used to refer to a specific object
in index or ref respectively. "path" component is absolute path. This
patch allows "path" to be written as "./path" or "../path", which is
relative to user's original cwd.

This does not work in commands that startup_info is NULL
(i.e. non-builtin ones).
---
 On Wed, Nov 10, 2010 at 07:26:20AM -0800, Jakub Narebski wrote:
 > The <obj>:<sth> is (with single exception of ':/<regexp>') about
 > selecting subitem (path): <tree-ish>:<path>, [:<stage>]:<path>

 I feel the urge of keeping ':./path' and ':../path' out of this
 competition.

 The idea is old although I don't remember if anybody has made any
 attempt to realize it: use './' and '../' to specify the given path
 is relative, not absolute.

 I don't remember either if the idea was rejected or nobody bothered
 to implement it. Anyway, here it is (for demostration only because it
 needs two minor patches to work). Comments?
 --
 Duy

 sha1_name.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 484081d..791608d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1060,25 +1060,35 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 	if (!ret)
 		return ret;
 	/* sha1:path --> object name of path in ent sha1
-	 * :path -> object name of path in index
+	 * :path -> object name of absolute path in index
+	 * :./path -> object name of path relative to cwd in index
 	 * :[0-3]:path -> object name of path in index at stage
 	 * :/foo -> recent commit matching foo
 	 */
 	if (name[0] == ':') {
 		int stage = 0;
 		struct cache_entry *ce;
+		char *new_path = NULL;
 		int pos;
 		if (namelen > 2 && name[1] == '/')
 			return get_sha1_oneline(name + 2, sha1);
 		if (namelen < 3 ||
 		    name[2] != ':' ||
-		    name[1] < '0' || '3' < name[1])
+		    name[1] < '0' || '3' < name[1]) {
 			cp = name + 1;
+			if (startup_info && cp[0] == '.' &&
+			    (cp[1] == '/' || (cp[1] == '.' && cp[2] == '/'))) {
+				new_path = prefix_path(startup_info->prefix,
+						       strlen(startup_info->prefix),
+						       cp);
+				cp = new_path;
+			}
+		}
 		else {
 			stage = name[1] - '0';
 			cp = name + 3;
 		}
-		namelen = namelen - (cp - name);
+		namelen = strlen(cp);
 
 		strncpy(oc->path, cp,
 			sizeof(oc->path));
@@ -1096,12 +1106,14 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 				break;
 			if (ce_stage(ce) == stage) {
 				hashcpy(sha1, ce->sha1);
+				free(new_path);
 				return 0;
 			}
 			pos++;
 		}
 		if (!gently)
 			diagnose_invalid_index_path(stage, prefix, cp);
+		free(new_path);
 		return -1;
 	}
 	for (cp = name, bracket_depth = 0; *cp; cp++) {
@@ -1122,6 +1134,17 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 		}
 		if (!get_sha1_1(name, cp-name, tree_sha1)) {
 			const char *filename = cp+1;
+			char *new_filename = NULL;
+
+			if (startup_info &&
+			    filename[0] == '.' &&
+			    (filename[1] == '/' ||
+			     (filename[1] == '.' && filename[2] == '/'))) {
+				new_filename = prefix_path(startup_info->prefix,
+							   strlen(startup_info->prefix),
+							   filename);
+				filename = new_filename;
+			}
 			ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
 			if (!gently) {
 				diagnose_invalid_sha1_path(prefix, filename,
@@ -1133,6 +1156,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 				sizeof(oc->path));
 			oc->path[sizeof(oc->path)-1] = '\0';
 
+			free(new_filename);
 			return ret;
 		} else {
 			if (!gently)
-- 
1.7.3.2.210.g045198
