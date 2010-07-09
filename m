From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 6/6] fast-import: Improve robustness when D->F changes provided in wrong order
Date: Fri,  9 Jul 2010 07:10:56 -0600
Message-ID: <1278681056-31460-7-git-send-email-newren@gmail.com>
References: <1278681056-31460-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, agladysh@gmail.com,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 09 15:03:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXDEd-0008K3-Jc
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 15:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756187Ab0GINDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 09:03:14 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45877 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756138Ab0GINDM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 09:03:12 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so806555pwi.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 06:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZGrfS5nozeJrauqIiykQcStVk77+zMSQwsMQLOKjXls=;
        b=oHTpn8PeWE2YsbPBEGo19x88kbcAWf3WMRiUBjwa0BbhWja2fpFB0rqMLf0Ihadu3Q
         lOoTXOMArSHMbtD6yOMYyJB2/aNsuxZwiEnCpeBXuV3jmT8ktSm3vkQqfWxo9jtn3MT0
         jRAMVvZqrgKzEjSRMGlKnDjyXFkO1JwK0T26Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lLiyplWNx1Ke9IYExyn3QW6y2x3KWNhyfkvJX62WyXksGUFnJxk3WNIdfWzT3r25+R
         LuaMA2C6zgzRJaD4cHleOxH1+16pizPWsbH4mK0uR+Rudte89y5HQyl+hehLQNBU+kss
         e35lSXrBehbka36tER7vtu7vCT77CTegUMIrA=
Received: by 10.115.75.3 with SMTP id c3mr11316794wal.111.1278680592280;
        Fri, 09 Jul 2010 06:03:12 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id b1sm700259rvn.2.2010.07.09.06.03.10
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 06:03:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.23.gafea6
In-Reply-To: <1278681056-31460-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150660>

When older versions of fast-export came across a directory changing to a
symlink (or regular file), it would output the changes in the form
  M 120000 :239821 dir-changing-to-symlink
  D dir-changing-to-symlink/filename1
When fast-import sees the first line, it deletes the directory named
dir-changing-to-symlink (and any files below it) and creates a symlink in
its place.  When fast-import came across the second line, it was previously
trying to remove the file and relevant leading directories in
tree_content_remove(), and as a side effect it would delete the symlink
that was just created.  This resulted in the symlink silently missing from
the resulting repository.

To improve robustness, we ignore file deletions underneath directory names
that correspond to non-directories.  This can also be viewed as a minor
optimization: since there cannot be a file and a directory with the same
name in the same directory, the file clearly can't exist so nothing needs
to be done to delete it.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fast-import.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 309f2c5..75ed738 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1528,6 +1528,14 @@ static int tree_content_remove(
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
+			if (slash1 && !S_ISDIR(e->versions[1].mode))
+				/*
+				 * If p names a file in some subdirectory, and a
+				 * file or symlink matching the name of the
+				 * parent directory of p exists, then p cannot
+				 * exist and need not be deleted.
+				 */
+				return 1;
 			if (!slash1 || !S_ISDIR(e->versions[1].mode))
 				goto del_entry;
 			if (!e->tree)
-- 
1.7.1.1.23.gafea6
