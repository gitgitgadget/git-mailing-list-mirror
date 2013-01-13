From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 08/31] parse_pathspec: add PATHSPEC_EMPTY_MATCH_ALL
Date: Sun, 13 Jan 2013 19:35:16 +0700
Message-ID: <1358080539-17436-9-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:36:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMo2-0006KC-EF
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044Ab3AMMge convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:36:34 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:60842 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035Ab3AMMgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:36:33 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so1760382pad.3
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=z7GrKHJvk3S66s8/17Sgp3/7y/Hcd6S1n1YEJyAX8PE=;
        b=f5Gay+2CiV2WrzcDx17ibDHS23wq+pmyYpgtbyypX3HDOpBO8WwEP+RQYdosqy5ZGk
         nvvc7o4LMiH1LNlaJldIL/Wgc7AiZloPftUhOtqdyecVGWHxqcqC9bRH06CjU8LWCKuF
         V7sAKWDVcvudfTTLthf8sUEjoxmNcFqn7hIKvZ5i88sFuPb1Z2jKWRIo3LHK73rAso2T
         xW6ztjOUaI9sfbOH6oLyRjfIVMxNzT0/idzSSxMZAyyDYdD4q8GObE7dtppLJsURVyY7
         /GcrxkDjkmgNqc4mkbTAeYq9LJnRzi4lFwnB0HaTkvJ7aTcnvDbfx4FZ9WKApqUDEdjz
         M2Sw==
X-Received: by 10.66.90.35 with SMTP id bt3mr5007565pab.57.1358080593341;
        Sun, 13 Jan 2013 04:36:33 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id vk5sm6289479pbc.34.2013.01.13.04.36.30
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:36:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:36:43 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213348>

We have two ways of dealing with empty pathspec:

1. limit it to current prefix
2. match the entire working directory

Some commands go with #1, some with #2. get_pathspec() and
parse_pathspec() only supports #1. Make it support #2 too via
PATHSPEC_EMPTY_MATCH_ALL flag.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h | 3 +++
 setup.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/cache.h b/cache.h
index 1f51423..32231d8 100644
--- a/cache.h
+++ b/cache.h
@@ -503,6 +503,9 @@ struct pathspec {
 			    __FILE__, __LINE__, (ps)->magic & ~(mask)); \
 	} while (0)
=20
+/* parse_pathspec flags */
+#define PATHSPEC_EMPTY_MATCH_ALL (1<<0) /* No args means match everyth=
ing */
+
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec, unsigned magic_m=
ask,
 			   unsigned flags, const char *prefix,
diff --git a/setup.c b/setup.c
index 0c9fc75..d0b1d1f 100644
--- a/setup.c
+++ b/setup.c
@@ -289,6 +289,9 @@ void parse_pathspec(struct pathspec *pathspec,
 	if (!entry && !prefix)
 		return;
=20
+	if (!*argv && (flags & PATHSPEC_EMPTY_MATCH_ALL))
+		return;
+
 	/* No arguments with prefix -> prefix pathspec */
 	if (!entry) {
 		static const char *raw[2];
--=20
1.8.0.rc2.23.g1fb49df
