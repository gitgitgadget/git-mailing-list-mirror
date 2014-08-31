From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] gc --auto: do not run 'pack-refs' and 'reflog expire' twice
Date: Sun, 31 Aug 2014 11:33:30 +0700
Message-ID: <1409459610-8695-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 31 06:34:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNwqN-0002og-W1
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 06:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbaHaEdW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Aug 2014 00:33:22 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:63805 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbaHaEdW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 00:33:22 -0400
Received: by mail-pd0-f180.google.com with SMTP id p10so3363061pdj.25
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 21:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=qcOxxDqsp8r45U8fVozLPJDE3SCm7ryinDtvNburiEc=;
        b=uIkjcQfZU3XTnUZbRQ6YXlTJmlkJqvsg94mnfOjOxWNQ/f49AFC8StC/gZAPMGSLN3
         dmu3Mm41YoQuRNTAReErHsJaRQReXtu5EiwmKK5rQbHBMMEOPAUCzLoO4Sw6sNyWEX1g
         K6RtopNqesHLdSR10Ii0pW0+ZdzUarlocvrj6MEp+oZXJWqyharuEa0/qwPCAnRiY0sz
         pNQO3KPE26bfBzPkS6AojAkdj+ItwCgL+/IsaNQ2VgqDDg/U0OqClwTRW9wpda0CmcR/
         etJujLQYF/1puqCHgyYN5A/PW32iL4AK9frQO5V3TfvvwLKYapK+Siljscb8SQ2fg8Wi
         tr6g==
X-Received: by 10.68.136.100 with SMTP id pz4mr27851030pbb.119.1409459601655;
        Sat, 30 Aug 2014 21:33:21 -0700 (PDT)
Received: from lanh ([115.73.242.67])
        by mx.google.com with ESMTPSA id y9sm14972230pas.23.2014.08.30.21.33.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 21:33:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 31 Aug 2014 11:33:31 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256278>

In the --auto code path, gc_before_repack() is called once in parent
process then again in the forked process. Stop the second run.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/gc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8d219d8..fb0cff3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -261,6 +261,11 @@ static const char *lock_repo_for_gc(int force, pid=
_t* ret_pid)
=20
 static int gc_before_repack(void)
 {
+	static int nr_runs;
+
+	if (nr_runs++)
+		return 0;
+
 	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
 		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
=20
--=20
2.1.0.rc0.78.gc0d8480
