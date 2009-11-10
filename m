From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 5/8] teach warn_dangling_symref to take a FILE argument
Date: Tue, 10 Nov 2009 09:14:15 +0100
Message-ID: <4AF920D7.2020208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 09:14:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7lrs-0007GU-D7
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 09:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbZKJION convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 03:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbZKJION
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 03:14:13 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:50753 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbZKJIOM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 03:14:12 -0500
Received: by ewy3 with SMTP id 3so3973280ewy.37
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 00:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=yBg3sHNMePGjRX80eErvjAz1k2AAxBdNtkDuXM3jPBk=;
        b=BjV+5+WaTQZ4+S1bF4dQVxX7/zU/ryVd4t6eS58pDnpLGvh0HvVx+KEMYpDziPstwd
         w6q+hSSAYk/Ib68oKwG3vJ6XjzFt0QIumH0qWEtj3YevV3WnMd77wvF15pZzGzjKDTYZ
         6K/0Ov3fiwR1p0w8n4+JSyF9sFm+tw8jCbEEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=klTJjXgd+G8Y/x+xlrXSaI4KX9DEjhm6YrLp14jlgbcZggkvGN1e8U06PAm6NdXyIq
         sFURZzEio1MdBSLXB2L/5uVa7L4iwhbvOfIMElqb2Kq6WvNo8yQ1T9i7sj4K79FecSch
         u6g/ppgKWaz6MMxYrwveYnhyejnOFpPSmSqso=
Received: by 10.213.23.200 with SMTP id s8mr455263ebb.52.1257840857035;
        Tue, 10 Nov 2009 00:14:17 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 28sm1166414eyg.14.2009.11.10.00.14.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 00:14:16 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132545>

=46rom: Jay Soffian <jaysoffian@gmail.com>

Different callers of warn_dangling_symref() may want to control whether=
 its
output goes to stdout or stderr so let it take a FILE argument.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 builtin-remote.c |    2 +-
 refs.c           |    7 ++++---
 refs.h           |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index b48267b..56cd5af 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1166,7 +1166,7 @@ static int prune_remote(const char *remote, int d=
ry_run)
=20
 		printf(" * [%s] %s\n", dry_run ? "would prune" : "pruned",
 		       abbrev_ref(refname, "refs/remotes/"));
-		warn_dangling_symref(dangling_msg, refname);
+		warn_dangling_symref(stdout, dangling_msg, refname);
 	}
=20
 	free_remote_ref_states(&states);
diff --git a/refs.c b/refs.c
index 808f56b..3e73a0a 100644
--- a/refs.c
+++ b/refs.c
@@ -286,6 +286,7 @@ static struct ref_list *get_ref_dir(const char *bas=
e, struct ref_list *list)
 }
=20
 struct warn_if_dangling_data {
+	FILE *fp;
 	const char *refname;
 	const char *msg_fmt;
 };
@@ -304,13 +305,13 @@ static int warn_if_dangling_symref(const char *re=
fname, const unsigned char *sha
 	if (!resolves_to || strcmp(resolves_to, d->refname))
 		return 0;
=20
-	printf(d->msg_fmt, refname);
+	fprintf(d->fp, d->msg_fmt, refname);
 	return 0;
 }
=20
-void warn_dangling_symref(const char *msg_fmt, const char *refname)
+void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *r=
efname)
 {
-	struct warn_if_dangling_data data =3D { refname, msg_fmt };
+	struct warn_if_dangling_data data =3D { fp, refname, msg_fmt };
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
=20
diff --git a/refs.h b/refs.h
index 777b5b7..e141991 100644
--- a/refs.h
+++ b/refs.h
@@ -29,7 +29,7 @@ extern int for_each_replace_ref(each_ref_fn, void *);
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn, void *);
=20
-extern void warn_dangling_symref(const char *msg_fmt, const char *refn=
ame);
+extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const =
char *refname);
=20
 /*
  * Extra refs will be listed by for_each_ref() before any actual refs
--=20
1.6.5.1.69.g36942
