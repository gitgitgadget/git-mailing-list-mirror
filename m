From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/32] commit-tree: require --narrow-base in narrow repo
Date: Wed, 25 Aug 2010 08:20:13 +1000
Message-ID: <1282688422-7738-24-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:24:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1uP-00030j-UC
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111Ab0HXWXa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:23:30 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49107 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756091Ab0HXWXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:23:25 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so2814108pvg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=+v5abUr9Z+9zr3Q7zX5j6rUDv6/sP5hWjTdPE160C44=;
        b=i6D+1CmbmZ1uAfW71NjRfDtk4/3qgsQ9YxUp9SjH7DlPg0SahxS0s20dEKCN7PLO8B
         xfYAMPfOMVccYug/+csk+nUbtsmZyPiXgBf4yS8zeyt3L/DyLLN21wEmPZ++bkB/wBsW
         K4jzeGd3hPcDObpu6a98uVSb+/+9aKvOKUMx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=BUHFwIXxcCNRiMllAI3ZMzIlyx/XLTf55Jm4yqW2zderALnZ0MV5jIIS5HsdmISmLs
         q/CQMnX8cOHPtmwKJCol7Zb7e4fPw2rCEsll9Jo3rXjUPHou4JteHEcbjUPMtkDQkrf+
         HnXERJp9l4qI1HZ2MMUf0dT6r3QqbWaSjGTDo=
Received: by 10.114.111.1 with SMTP id j1mr8432052wac.207.1282688605653;
        Tue, 24 Aug 2010 15:23:25 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id g4sm948636wae.14.2010.08.24.15.23.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:23:24 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:23:19 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154370>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit-tree.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 87f0591..0c71925 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -32,11 +32,29 @@ int cmd_commit_tree(int argc, const char **argv, co=
nst char *prefix)
 	unsigned char tree_sha1[20];
 	unsigned char commit_sha1[20];
 	struct strbuf buffer =3D STRBUF_INIT;
+	unsigned char narrow_base[20];
=20
 	git_config(git_default_config, NULL);
=20
 	if (argc < 2 || !strcmp(argv[1], "-h"))
 		usage(commit_tree_usage);
+
+	if (get_narrow_prefix()) {
+		unsigned char sha1[20];
+		unsigned long size;
+		void *buf;
+
+		if (prefixcmp(argv[1], "--narrow-base=3D"))
+			die("--narrow-base required in narrow mode");
+		if (get_sha1(argv[1]+4, sha1))
+			die("Invalid SHA1");
+		buf =3D read_object_with_reference(sha1, tree_type, &size, narrow_ba=
se);
+		if (!buf)
+			die("Bad treeish %s", sha1_to_hex(sha1));
+		free(buf);
+		argv++;
+	}
+
 	if (get_sha1(argv[1], tree_sha1))
 		die("Not a valid object name %s", argv[1]);
=20
@@ -56,7 +74,7 @@ int cmd_commit_tree(int argc, const char **argv, cons=
t char *prefix)
 	if (strbuf_read(&buffer, 0, 0) < 0)
 		die_errno("git commit-tree: failed to read");
=20
-	if (!commit_tree(buffer.buf, tree_sha1, parents, commit_sha1, NULL)) =
{
+	if (!commit_narrow_tree(buffer.buf, tree_sha1, narrow_base, parents, =
commit_sha1, NULL)) {
 		printf("%s\n", sha1_to_hex(commit_sha1));
 		return 0;
 	}
--=20
1.7.1.rc1.69.g24c2f7
