From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 8/9] builtin/verify-tag.c: replace signal() with sigaction()
Date: Sun,  1 Jun 2014 11:10:17 -0700
Message-ID: <7bf6e1f7575e810bf0358346c7fa7b1eb846895a.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 20:11:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrAE4-0007ZL-B4
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 20:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbaFASLQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jun 2014 14:11:16 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:63172 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbaFASLO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 14:11:14 -0400
Received: by mail-pd0-f179.google.com with SMTP id fp1so2652528pdb.24
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 11:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=9b8OYsV4LfjGEZ+sE3PaXd8idKRmUZUdXOFpjyDDI8w=;
        b=ALSyfEyaNng2V6Zm67E2lUasOXFodia3R5p3Kq1b5W2tfgqO1kiEHVQBLZz4TU2Glf
         L+LxGFwSzfUdjS7ymc6vk4iN1Yug/XMKFe9yMKse2QLvTDGKDwUVEBlp63wYyZOHR2g4
         8J5yhl58+w4PVw2okUYXbuaTI4cNCM9D9a4knyQWklCd55VCv4nTc8XUoh5v5FYRzKKE
         BC67dPGks54CPL6wFu0Dw2X9OiUE61cOoYY1jvRTdYLKG8ZHhCqi8FqVxDT9ViZl5vYL
         dmqSPszRBk3x8wfgbzreZhtHkatXlkRJ/eDze4RklnHD7SLQiNswdat5SMI+r4VsI0ig
         TU2g==
X-Received: by 10.66.66.135 with SMTP id f7mr35311224pat.22.1401646274227;
        Sun, 01 Jun 2014 11:11:14 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id om6sm16496520pbc.43.2014.06.01.11.11.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 01 Jun 2014 11:11:13 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 01 Jun 2014 11:11:10 -0700
X-Mailer: git-send-email 2.0.0.8.g7bf6e1f.dirty
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250541>

=46rom the signal(2) man page:

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.

Replaced signal() with sigaction() in builtin/verify-tag.c

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 builtin/verify-tag.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 9cdf332..d5ccbad 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -73,6 +73,7 @@ int cmd_verify_tag(int argc, const char **argv, const=
 char *prefix)
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
 		OPT_END()
 	};
+	struct sigaction sa;
=20
 	git_config(git_verify_tag_config, NULL);
=20
@@ -83,7 +84,9 @@ int cmd_verify_tag(int argc, const char **argv, const=
 char *prefix)
=20
 	/* sometimes the program was terminated because this signal
 	 * was received in the process of writing the gpg input: */
-	signal(SIGPIPE, SIG_IGN);
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D SIG_IGN;
+	sigaction(SIGPIPE, &sa, NULL);
 	while (i < argc)
 		if (verify_tag(argv[i++], verbose))
 			had_error =3D 1;
--=20
2.0.0.8.g7bf6e1f.dirty
