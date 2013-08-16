From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] shallow: add setup_temporary_shallow()
Date: Fri, 16 Aug 2013 16:52:04 +0700
Message-ID: <1376646727-22318-3-git-send-email-pclouds@gmail.com>
References: <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
 <1376646727-22318-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthijs Kooijman <matthijs@stdin.nl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 16 11:52:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAGht-0007uj-Nu
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 11:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371Ab3HPJw3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 05:52:29 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:61035 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab3HPJw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 05:52:27 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so1672167pab.39
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RbHz629F0qHv+xD3xqTyngyuFrRVM6wessvmy46HFjM=;
        b=zRfceSXugpK3Y+iA7WKdF3ZKqU2H/FWE4/qRrP/3s76qflbZKInCL4UrzW52xdfJF+
         TXurd9KcHq6AHZNjmmLXc7IwLqkaGLIeIMvHcYHB1gfDpKS9FGUw/VEYQMPE6QhEEi92
         1H8eJsjgCWQwgQja2+Qzf3+cpEavpofYAH3mqIMGiAE7ci8P1j3I271CqR8ngGN9siSQ
         fh/YlT0noPau4UNIzmkmaTl1TBXs+A+gcmkzKt2N2og4+QJcozsYHgUBgntuz2AQcUZd
         PL/VrC0qQyKsAQZaRt66/1rcguhr81B1E4knRMSOfORRkqzfXEDyznfwJWkvyXAsIybS
         7GXw==
X-Received: by 10.66.162.136 with SMTP id ya8mr148108pab.110.1376646747552;
        Fri, 16 Aug 2013 02:52:27 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id oj6sm2362328pab.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 02:52:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 16 Aug 2013 16:52:21 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1376646727-22318-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232410>

This function is like setup_alternate_shallow() except that it does
not lock $GIT_DIR/shallow. It's supposed to be used when a program
generates temporary shallow for for use by another program, then throw
the shallow file away.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h  |  1 +
 shallow.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/commit.h b/commit.h
index 790e31b..c4d324c 100644
--- a/commit.h
+++ b/commit.h
@@ -201,6 +201,7 @@ extern void set_alternate_shallow_file(const char *=
path);
 extern int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol);
 extern void setup_alternate_shallow(struct lock_file *shallow_lock,
 				    const char **alternate_shallow_file);
+extern char *setup_temporary_shallow(void);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/shallow.c b/shallow.c
index 5f626c0..cdf37d6 100644
--- a/shallow.c
+++ b/shallow.c
@@ -175,6 +175,29 @@ int write_shallow_commits(struct strbuf *out, int =
use_pack_protocol)
 	return data.count;
 }
=20
+char *setup_temporary_shallow(void)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int fd;
+
+	if (write_shallow_commits(&sb, 0)) {
+		struct strbuf path =3D STRBUF_INIT;
+		strbuf_addstr(&path, git_path("shallow_XXXXXX"));
+		fd =3D xmkstemp(path.buf);
+		if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len)
+			die_errno("failed to write to %s",
+				  path.buf);
+		close(fd);
+		strbuf_release(&sb);
+		return strbuf_detach(&path, NULL);
+	}
+	/*
+	 * is_repository_shallow() sees empty string as "no shallow
+	 * file".
+	 */
+	return xstrdup("");
+}
+
 void setup_alternate_shallow(struct lock_file *shallow_lock,
 			     const char **alternate_shallow_file)
 {
--=20
1.8.2.82.gc24b958
