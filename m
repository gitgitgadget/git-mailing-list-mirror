From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/5] delete_ref(): Remove the correct reflog when deleting symrefs
Date: Tue, 16 Oct 2012 15:44:52 +0200
Message-ID: <1350395094-11404-4-git-send-email-johan@herland.net>
References: <CAPc5daUws-MfzC9imkytTrLaHyyywE4_OX1jAUVPCTK2WyUF=w@mail.gmail.com>
 <1350395094-11404-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx, vmiklos@suse.cz,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 16 15:45:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO7Sr-0004ua-Nk
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 15:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236Ab2JPNp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 09:45:29 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63923 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171Ab2JPNpK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 09:45:10 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so3506457eek.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 06:45:10 -0700 (PDT)
Received: by 10.14.205.3 with SMTP id i3mr20991072eeo.18.1350395110136;
        Tue, 16 Oct 2012 06:45:10 -0700 (PDT)
Received: from gamma.cisco.com (64-103-25-233.cisco.com. [64.103.25.233])
        by mx.google.com with ESMTPS id o47sm11333415eem.11.2012.10.16.06.45.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Oct 2012 06:45:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.609.g5cd6968
In-Reply-To: <1350395094-11404-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207829>

When deleting a symref (e.g. HEAD), we would incorrectly remove the
reflog of the dereferenced ref (e.g. .git/logs/refs/heads/master),
insted of the symref's reflog (e.g. .git/logs/HEAD).

This patch ensures that we remove the reflog that corresponds to the
removed (sym)ref.

Signed-off-by: Johan Herland <johan@herland.net>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index df4fe20..f2508bf 100644
--- a/refs.c
+++ b/refs.c
@@ -1781,7 +1781,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	if (!delete_symref)
 		ret |= repack_without_ref(refname);
 
-	unlink_or_warn(git_path("logs/%s", lock->ref_name));
+	unlink_or_warn(git_path("logs/%s", refname));
 	invalidate_ref_cache(NULL);
 	unlock_ref(lock);
 	return ret;
-- 
1.7.12.1.609.g5cd6968
