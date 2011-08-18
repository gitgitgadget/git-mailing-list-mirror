From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] Add for_each_commit_graft() to iterate all grafts
Date: Thu, 18 Aug 2011 19:29:35 +0700
Message-ID: <1313670578-2939-3-git-send-email-pclouds@gmail.com>
References: <1313593326-12077-1-git-send-email-pclouds@gmail.com>
 <1313670578-2939-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 14:30:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu1jZ-0001Ok-Mp
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 14:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930Ab1HRMaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 08:30:00 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41218 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870Ab1HRM37 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 08:29:59 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so2928610pzk.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 05:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BcQ/1pgJ4kq7VVgz43EL+XOAclPf5EGZjhf29Lu41Yc=;
        b=Z6HrDaMc/BxnUO4FNRxlrvJfgmuAmQQdyDQg01SjRkgfWxDrzBePVNEhOyPmjHm967
         yPQE0+qO5g1hgbpjFmqwMCOmtI1UdIsEd9OFwMaMNGwCFORqXEvVqBMDPVlB77CxwvwR
         6Yzaleia8QEoyeohcyHPieUMn4lUXdL2ERXaY=
Received: by 10.142.49.14 with SMTP id w14mr366933wfw.443.1313670599304;
        Thu, 18 Aug 2011 05:29:59 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id g4sm1442209pbj.25.2011.08.18.05.29.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 05:29:58 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 18 Aug 2011 19:29:53 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1313670578-2939-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179591>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.c |    8 ++++++++
 commit.h |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index dc22695..efd647d 100644
--- a/commit.c
+++ b/commit.c
@@ -226,6 +226,14 @@ struct commit_graft *lookup_commit_graft(const uns=
igned char *sha1)
 	return commit_graft[pos];
 }
=20
+int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
+{
+	int i, ret;
+	for (i =3D ret =3D 0; i < commit_graft_nr && !ret; i++)
+		ret =3D fn(commit_graft[i], cb_data);
+	return ret;
+}
+
 int write_shallow_commits(struct strbuf *out, int use_pack_protocol)
 {
 	int i, count =3D 0;
diff --git a/commit.h b/commit.h
index 0e36fd0..9030d42 100644
--- a/commit.h
+++ b/commit.h
@@ -143,6 +143,7 @@ struct commit_graft {
 	int nr_parent; /* < 0 if shallow commit */
 	unsigned char parent[FLEX_ARRAY][20]; /* more */
 };
+typedef int (*each_commit_graft_fn)(const struct commit_graft *, void =
*);
=20
 struct commit_graft *read_graft_line(char *buf, int len);
 int register_commit_graft(struct commit_graft *, int);
@@ -155,6 +156,7 @@ extern struct commit_list *get_octopus_merge_bases(=
struct commit_list *in);
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
 extern int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol);
+extern int for_each_commit_graft(each_commit_graft_fn, void *);
 extern int is_repository_shallow(void);
 extern struct commit_list *get_shallow_commits(struct object_array *he=
ads,
 		int depth, int shallow_flag, int not_shallow_flag);
--=20
1.7.4.74.g639db
