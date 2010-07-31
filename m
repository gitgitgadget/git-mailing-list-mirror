From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/16] Allow to invalidate a commit in in-memory object store
Date: Sat, 31 Jul 2010 23:18:13 +0700
Message-ID: <1280593105-22015-5-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:38:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfORP-0002q6-SR
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab0HACiN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:38:13 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47922 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585Ab0HACiL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:38:11 -0400
Received: by pwi5 with SMTP id 5so977053pwi.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HTYsLc8hF1eJd1N2BRFp7xYSvHMZmeXiWp0Qvu16BG0=;
        b=wMsh8cKhMCTc+d9UdxNJm6vO3qYZIJjR8MHoNAB3rR/iN4dxuNz/FokqkYIaLgFLdT
         KUm6Jo6op8Dt8OLVRG8fMcKxrhgB87fwIJg5FJi6dXWc0PZUaWjgT3Mz7+Z4QovdrOda
         nLuB0zMzKJXVQMJ5Fs6gDXmNQ+xaD2J2jjq0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sZfXGjQh7ZKNTV50pVZz8Pr071Xl5Re352K9pDOshGwI1vfXxvRO5xMxeDx5oROuR+
         CLDX2q3YsdgdILhBU34nuVkDWu8d4hcMFbZGu+csHPi699PhUxEvUFOAM2guzP4x1Gtn
         i+cbov7tVNjBbSa0EPfE/6JyF8Fn3XO5TBEmI=
Received: by 10.142.147.7 with SMTP id u7mr3525949wfd.216.1280630290123;
        Sat, 31 Jul 2010 19:38:10 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id f2sm5245116wfp.23.2010.07.31.19.38.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:38:09 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:19:04 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152351>

This is needed if replacing object happens at run time.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.c |   15 +++++++++++++++
 commit.h |    2 ++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index e9b0750..d1e30b2 100644
--- a/commit.c
+++ b/commit.c
@@ -315,6 +315,21 @@ int parse_commit(struct commit *item)
 	return ret;
 }
=20
+int invalidate_commit(struct commit *item)
+{
+	if (!item)
+		return -1;
+
+	if (item->object.parsed) {
+		item->object.parsed =3D 0;
+		if (item->buffer) {
+			free(item->buffer);
+			item->buffer =3D NULL;
+		}
+	}
+	return 0;
+}
+
 struct commit_list *commit_list_insert(struct commit *item, struct com=
mit_list **list_p)
 {
 	struct commit_list *new_list =3D xmalloc(sizeof(struct commit_list));
diff --git a/commit.h b/commit.h
index eb2b8ac..d8c01ea 100644
--- a/commit.h
+++ b/commit.h
@@ -41,6 +41,8 @@ int parse_commit_buffer(struct commit *item, void *bu=
ffer, unsigned long size);
=20
 int parse_commit(struct commit *item);
=20
+int invalidate_commit(struct commit *item);
+
 struct commit_list * commit_list_insert(struct commit *item, struct co=
mmit_list **list_p);
 unsigned commit_list_count(const struct commit_list *l);
 struct commit_list * insert_by_date(struct commit *item, struct commit=
_list **list);
--=20
1.7.1.rc1.69.g24c2f7
