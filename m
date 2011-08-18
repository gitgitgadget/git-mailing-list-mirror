From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] Move write_shallow_commits to fetch-pack.c
Date: Thu, 18 Aug 2011 19:29:36 +0700
Message-ID: <1313670578-2939-4-git-send-email-pclouds@gmail.com>
References: <1313593326-12077-1-git-send-email-pclouds@gmail.com>
 <1313670578-2939-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 14:30:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu1ji-0001TN-9X
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 14:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953Ab1HRMaJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 08:30:09 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41218 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555Ab1HRMaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 08:30:08 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so2928610pzk.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 05:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=G5kTGxOmfS+0HYiDa4TOIZxInC2Je4J+cAwCxUJ5Unc=;
        b=Gz2IQLiXaKgQL/6Us3UCHczDB/ArMrC1DdwsmVabooGu/KwtyKkuCr6EAh45OP/iqB
         F9mhN7WC7U6GdeX/wxyvHHtJ3/0RZLHIems7fuZp/+jZPxhtNxzW5qkRc4QitHMtcHX7
         JBsdMtFFULbimmSge1OvQk6O8ACxTL4SB7AyM=
Received: by 10.143.97.24 with SMTP id z24mr383665wfl.212.1313670608015;
        Thu, 18 Aug 2011 05:30:08 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id e6sm1439155pbm.71.2011.08.18.05.30.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 05:30:04 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 18 Aug 2011 19:29:59 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1313670578-2939-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179592>

This function produces network traffic and should be in fetch-pack. It
has been in commit.c because it needs to iterate (private) graft
list. It can now do so using for_each_commit_graft().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c |   30 ++++++++++++++++++++++++++++++
 commit.c             |   18 ------------------
 commit.h             |    1 -
 3 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4367984..cb5b20a 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -185,6 +185,36 @@ static void consume_shallow_list(int fd)
 	}
 }
=20
+struct write_shallow_data {
+	struct strbuf *out;
+	int use_pack_protocol;
+	int count;
+};
+
+static int write_one_shallow(const struct commit_graft *graft, void *c=
b_data)
+{
+	struct write_shallow_data *data =3D cb_data;
+	const char *hex =3D sha1_to_hex(graft->sha1);
+	data->count++;
+	if (data->use_pack_protocol)
+		packet_buf_write(data->out, "shallow %s", hex);
+	else {
+		strbuf_addstr(data->out, hex);
+		strbuf_addch(data->out, '\n');
+	}
+	return 0;
+}
+
+static int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol)
+{
+	struct write_shallow_data data;
+	data.out =3D out;
+	data.use_pack_protocol =3D use_pack_protocol;
+	data.count =3D 0;
+	for_each_commit_graft(write_one_shallow, &data);
+	return data.count;
+}
+
 static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 {
 	static char line[1000];
diff --git a/commit.c b/commit.c
index efd647d..661ff0d 100644
--- a/commit.c
+++ b/commit.c
@@ -234,24 +234,6 @@ int for_each_commit_graft(each_commit_graft_fn fn,=
 void *cb_data)
 	return ret;
 }
=20
-int write_shallow_commits(struct strbuf *out, int use_pack_protocol)
-{
-	int i, count =3D 0;
-	for (i =3D 0; i < commit_graft_nr; i++)
-		if (commit_graft[i]->nr_parent < 0) {
-			const char *hex =3D
-				sha1_to_hex(commit_graft[i]->sha1);
-			count++;
-			if (use_pack_protocol)
-				packet_buf_write(out, "shallow %s", hex);
-			else {
-				strbuf_addstr(out, hex);
-				strbuf_addch(out, '\n');
-			}
-		}
-	return count;
-}
-
 int unregister_shallow(const unsigned char *sha1)
 {
 	int pos =3D commit_graft_pos(sha1);
diff --git a/commit.h b/commit.h
index 9030d42..82d5aeb 100644
--- a/commit.h
+++ b/commit.h
@@ -155,7 +155,6 @@ extern struct commit_list *get_octopus_merge_bases(=
struct commit_list *in);
=20
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
-extern int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
 extern int is_repository_shallow(void);
 extern struct commit_list *get_shallow_commits(struct object_array *he=
ads,
--=20
1.7.4.74.g639db
