From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 6/7] Export rerere() and launch_editor().
Date: Mon, 17 Sep 2007 20:06:47 -0400
Message-ID: <1190074016669-git-send-email-krh@redhat.com>
References: <1190074008617-git-send-email-krh@redhat.com>
 <1190074014548-git-send-email-krh@redhat.com>
 <11900740142347-git-send-email-krh@redhat.com>
 <11900740153845-git-send-email-krh@redhat.com>
 <11900740154136-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 02:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXQcp-0002Qo-NU
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 02:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757159AbXIRAHJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 20:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757081AbXIRAHI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 20:07:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56231 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756920AbXIRAG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 20:06:58 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06vHD012117
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 20:06:57 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06uUm022186;
	Mon, 17 Sep 2007 20:06:56 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06sd1021539;
	Mon, 17 Sep 2007 20:06:56 -0400
X-Mailer: git-send-email 1.5.3.1.993.gbf388-dirty
In-Reply-To: <11900740154136-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58508>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-rerere.c |   16 ++++++++++++++++
 commit.h         |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 826d346..54f3575 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -395,6 +395,22 @@ static int is_rerere_enabled(void)
 	return 1;
 }
=20
+/* Export for builtin-commit. */
+int rerere(void)
+{
+	struct path_list merge_rr =3D { NULL, 0, 0, 1 };
+	int fd;
+
+	git_config(git_rerere_config);
+	if (!is_rerere_enabled())
+		return 0;
+
+	merge_rr_path =3D xstrdup(git_path("rr-cache/MERGE_RR"));
+	fd =3D hold_lock_file_for_update(&write_lock, merge_rr_path, 1);
+	read_rr(&merge_rr);
+	return do_plain_rerere(&merge_rr, fd);
+}
+
 int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
 	struct path_list merge_rr =3D { NULL, 0, 0, 1 };
diff --git a/commit.h b/commit.h
index da34c23..cc8d890 100644
--- a/commit.h
+++ b/commit.h
@@ -130,5 +130,6 @@ extern struct commit_list *get_shallow_commits(stru=
ct object_array *heads,
 int in_merge_bases(struct commit *, struct commit **, int);
=20
 extern int interactive_add(void);
+extern int rerere(void);
=20
 #endif /* COMMIT_H */
--=20
1.5.3.1.993.gbf388-dirty
