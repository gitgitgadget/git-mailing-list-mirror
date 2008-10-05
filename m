From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] error out if path is invalid
Date: Sun,  5 Oct 2008 06:14:41 +0400
Message-ID: <1223172881-4948-2-git-send-email-dpotapov@gmail.com>
References: <20081005004036.GO21650@dpotapov.dyndns.org>
 <1223172881-4948-1-git-send-email-dpotapov@gmail.com>
Cc: Dmitry Potapov <dpotapov@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 04:16:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmJA9-0005Yy-60
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 04:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbYJECOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 22:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbYJECOx
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 22:14:53 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:3115 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbYJECOw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 22:14:52 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1660507fkq.5
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 19:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DYHhf+B6P/a4T1aRIse9zjbqIrGSf8dIxxZdCdEt+PA=;
        b=OmIR6e1z29W57qJhweU0ATAw1mhwnkKlEa9tie6Derv4tleD0m18deZ8pLBpVyTb3j
         sDj5lUh/yg5i4NjxOxW9okDrJY1woS0VwCTnXNkke0l4tNGyLpw1M3Hw2URB05Cwo02V
         SwhwnYEH0gs8bA+4L/6mJmXZE4GxLN6EkjBvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Fcx58OyXUH1pjm2C2qxbGbcmYJjNJ2dr5rl8/VRQIO43YR6AReS2HrGkuRBnTVuG7b
         ha77lJ1uUeQH7WFyQYSHZXyWYvd0V1rKc9/4PsNMpsBVcTCZrB8xoro/SfpxGepAfaFu
         Q370aWElLVq378jW+kn0EDz52EUlJROcju7JU=
Received: by 10.103.226.20 with SMTP id d20mr1818751mur.10.1223172889911;
        Sat, 04 Oct 2008 19:14:49 -0700 (PDT)
Received: from localhost (ppp83-237-185-144.pppoe.mtu-net.ru [83.237.185.144])
        by mx.google.com with ESMTPS id j2sm20980735mue.4.2008.10.04.19.14.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Oct 2008 19:14:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <1223172881-4948-1-git-send-email-dpotapov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97491>

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 builtin-update-index.c |    2 +-
 read-cache.c           |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 417f972..3a2291b 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -218,7 +218,7 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 	struct cache_entry *ce;
 
 	if (!verify_path(path))
-		return -1;
+		return error("Invalid path '%s'", path);
 
 	len = strlen(path);
 	size = cache_entry_size(len);
diff --git a/read-cache.c b/read-cache.c
index 972592e..43dc338 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -591,8 +591,10 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	int size, len;
 	struct cache_entry *ce;
 
-	if (!verify_path(path))
+	if (!verify_path(path)) {
+		error("Invalid path '%s'", path);
 		return NULL;
+	}
 
 	len = strlen(path);
 	size = cache_entry_size(len);
@@ -884,7 +886,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	if (!ok_to_add)
 		return -1;
 	if (!verify_path(ce->name))
-		return -1;
+		return error("Invalid path '%s'", ce->name);
 
 	if (!skip_df_check &&
 	    check_file_directory_conflict(istate, ce, pos, ok_to_replace)) {
-- 
1.6.0
