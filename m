From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH v2] builtin/rm.c: Use ALLOC_GROW instead of alloc_nr and xrealloc.
Date: Sun, 19 Dec 2010 09:56:25 -0200
Message-ID: <97af5e0255d234e3a7ec5df1e387bec39ed94206.1292759580.git.tfransosi@gmail.com>
References: <AANLkTim4GE0mnCBqz6QubpL6g9Bz5U-jHoOw=_MR5-1j@mail.gmail.com>
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 19 12:58:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUHuZ-0001Es-2V
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 12:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976Ab0LSL4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 06:56:36 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49789 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab0LSL4f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 06:56:35 -0500
Received: by yxt3 with SMTP id 3so947552yxt.19
        for <git@vger.kernel.org>; Sun, 19 Dec 2010 03:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KcSpk0SQ643L1whoHIMay2IaooB/l9MiIp2esI3gJ4A=;
        b=p5fv22NdealsqsIMebHa8vksCRzKBFKpVMQ+fut6oK7TlWqYHMIot9porSZ2XbdRxG
         5a3UKUceWSzSJZ5hJGC/aHNEcrmaM9JnwGmhsylksnH+ewXt+3OZGcCSDrxPdkcXU2i2
         41SwTFeKylMH6mgJltvw8HlpBIlSxwM8ZTVcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vV3x1zoPhhJiIsmzcpUi5OlZUHpkaDvaKhuHGsxRRgV1y+O7edzxjS7ak1r/zkE4IO
         x3e98uGAq7Os6KGLHNDm/ItgOqj+qL0/BjNDf9aJj4eTmXyV2yTJEcORmC9Q3kPi27fN
         EuF6NXgD9YvEULxEEAuy8VqEY5KQdNnux4NK0=
Received: by 10.151.9.17 with SMTP id m17mr5278252ybi.30.1292759794064;
        Sun, 19 Dec 2010 03:56:34 -0800 (PST)
Received: from localhost ([186.205.6.151])
        by mx.google.com with ESMTPS id v8sm3589832ybe.13.2010.12.19.03.56.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Dec 2010 03:56:33 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.343.g7d43d
In-Reply-To: <AANLkTim4GE0mnCBqz6QubpL6g9Bz5U-jHoOw=_MR5-1j@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163955>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 Changes from v1:
 - Remove the add_list function since it's used only once per Nguyen Thai Ngoc Duy
   review.

 builtin/rm.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index c7b7bb3..ff491d7 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -20,15 +20,6 @@ static struct {
 	const char **name;
 } list;
 
-static void add_list(const char *name)
-{
-	if (list.nr >= list.alloc) {
-		list.alloc = alloc_nr(list.alloc);
-		list.name = xrealloc(list.name, list.alloc * sizeof(const char *));
-	}
-	list.name[list.nr++] = name;
-}
-
 static int check_local_mod(unsigned char *head, int index_only)
 {
 	/*
@@ -182,7 +173,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		struct cache_entry *ce = active_cache[i];
 		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
 			continue;
-		add_list(ce->name);
+		ALLOC_GROW(list.name, list.nr + 1, list.alloc);
+		list.name[list.nr++] = ce->name;
 	}
 
 	if (pathspec) {
-- 
1.7.3.2.343.g7d43d
