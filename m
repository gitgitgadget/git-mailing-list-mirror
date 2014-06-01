From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 7/9] builtin/merge-index.c: replace signal() with sigaction()
Date: Sun,  1 Jun 2014 11:10:16 -0700
Message-ID: <e74a8efbb3a967c785fc282e5c4033dade15ebfd.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 20:11:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrAE3-0007ZL-Qz
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 20:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbaFASLM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jun 2014 14:11:12 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:51038 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbaFASLK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 14:11:10 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so399397pab.37
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=5lO3XRNMqjlmqWWQo/1839Bfhmh58/2KQR48xJzLDIc=;
        b=DJdr5qetBFUAYVIwSYKJFOTfC0iu+G3/cDBnWFtQWiNh1xUckMOqoi0uO5tTE5gGr/
         FxCz3YSuhA4orv4KT1VnXCNyR2P5i5vwOPxZ/4B63nCOJcRpIBCTj87j6u6iemZx4u9c
         MF44DPQxM+GvaACPSc3Lxn2tlaz0juRkNpptoCx3ZAG2VJaekhSSe2EdzLN8hHupOwm0
         JO5Wh64Sp1sK3oV1LlF2/PwRjZvnEIa6UWH0N5G5crXurp1inolCmyuWTJQV2l9e8A88
         c5BmnNqGDwbsPzLJ+Em+KELKzy5Fo3sObWFOREAgKEZDlDjiMrhOfwD2wNynmY6Yzity
         5tCg==
X-Received: by 10.68.129.68 with SMTP id nu4mr5140978pbb.76.1401646270105;
        Sun, 01 Jun 2014 11:11:10 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id fx5sm16478747pbb.62.2014.06.01.11.11.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 01 Jun 2014 11:11:08 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 01 Jun 2014 11:11:05 -0700
X-Mailer: git-send-email 2.0.0.8.g7bf6e1f.dirty
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250540>

=46rom the signal(2) man page:

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.

Replaced signal() with sigaction() in builtin/merge-index.c

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 builtin/merge-index.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index b416d92..25db374 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -68,11 +68,14 @@ static void merge_all(void)
 int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
 	int i, force_file =3D 0;
+	struct sigaction sa;
=20
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
 	 */
-	signal(SIGCHLD, SIG_DFL);
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D SIG_DFL;
+	sigaction(SIGCHLD, &sa, NULL);
=20
 	if (argc < 3)
 		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] <filenam=
e>*)");
--=20
2.0.0.8.g7bf6e1f.dirty
