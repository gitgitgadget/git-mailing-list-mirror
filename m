From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 16/40] builtin/apply: make gitdiff_*() return -1 on error
Date: Mon, 13 Jun 2016 18:09:18 +0200
Message-ID: <20160613160942.1806-17-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSq-0004h1-PU
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425004AbcFMQLh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 12:11:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35917 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424914AbcFMQKU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id m124so15998706wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8pToD7UbWLY75RRKnZYpOZrVhNBkw27MpmJrMUYzFE=;
        b=e/oHKMo5omfJmAzXTdhkTmiulrUQUTkoFKHHVmIJdtUgr9nlvdFut7PeTX5kibiX+o
         ThpqnM1miFRzzkmvtoGxpsJs4umFeMlsZRuI22zswNUw+JSObu2sxLYwCnthE1xLvZ++
         Ir+3c7eg9TZBGSj4sgesbfBh4VC2gEcLSVAw/6b5nNfGyyAya0JAL1nPDrNFfF+XTzyv
         INLMpFgGqRZux87JY3lJggQngG+os/9xwiqMWfxyLb+uSZwlDfrkFyF7hqpbzaqZBhes
         ditIF54G7ZjQ+E4q9pJAJT8I9M2tkzTO+ApAjwZmlwCmGqm6CTn4BJk/GC78u9VCsDpM
         kF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8pToD7UbWLY75RRKnZYpOZrVhNBkw27MpmJrMUYzFE=;
        b=YILRx3fNroIEoxP3qTDqllOa495WOYDISWIYeIDw9ZED7+odC5ygRpsrf3tw072iii
         j065lR6wJh3UlaSbFV+SRhJlMMPtBtIysQwhufjxDpl3CF4alibNOGdZ8Jdf7K4HouO6
         x30+NlXUPzrCuXRQXAQ5jzhDJwC7oseZ/MLq49PYsIYVs1ohGdR/NBoi006g+jay/Jpv
         0aU/LmTnBMvjwVXw7cn46uriTbOwQffw/A/QNIKss8YGzlFnhuWTJvO4vZqxbFLBtOc2
         AnI4mk+kF+hyZtkg7W77nGfbV0o55IBPumet7uaj2r8hWEXGOc+gk9zpo1xStIQP9xl7
         0+Ew==
X-Gm-Message-State: ALyK8tIFkgKin80xTJ1Ru5CHBuvk+31N056Bf1mXoqBD/471y/XGRP2yqF0c2b3YwXmkFA==
X-Received: by 10.194.153.65 with SMTP id ve1mr1914450wjb.106.1465834218775;
        Mon, 13 Jun 2016 09:10:18 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:18 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297223>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", gitdiff_*() functions should return -1 instead
of calling die().

A previous patch made it possible for gitdiff_*() functions to
return -1 in case of error. Let's take advantage of that to
make gitdiff_verify_name() return -1 on error, and to have
gitdiff_oldname() and gitdiff_newname() directly return
what gitdiff_verify_name() returns.

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 1142514..b506369 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -827,54 +827,56 @@ static int gitdiff_hdrend(struct apply_state *sta=
te,
 #define DIFF_OLD_NAME 0
 #define DIFF_NEW_NAME 1
=20
-static void gitdiff_verify_name(struct apply_state *state,
-				const char *line,
-				int isnull,
-				char **name,
-				int side)
+static int gitdiff_verify_name(struct apply_state *state,
+			       const char *line,
+			       int isnull,
+			       char **name,
+			       int side)
 {
 	if (!*name && !isnull) {
 		*name =3D find_name(state, line, NULL, state->p_value, TERM_TAB);
-		return;
+		return 0;
 	}
=20
 	if (*name) {
 		int len =3D strlen(*name);
 		char *another;
 		if (isnull)
-			die(_("git apply: bad git-diff - expected /dev/null, got %s on line=
 %d"),
-			    *name, state->linenr);
+			return error(_("git apply: bad git-diff - expected /dev/null, got %=
s on line %d"),
+				     *name, state->linenr);
 		another =3D find_name(state, line, NULL, state->p_value, TERM_TAB);
-		if (!another || memcmp(another, *name, len + 1))
-			die((side =3D=3D DIFF_NEW_NAME) ?
+		if (!another || memcmp(another, *name, len + 1)) {
+			free(another);
+			return error((side =3D=3D DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line =
%d") :
 			    _("git apply: bad git-diff - inconsistent old filename on line =
%d"), state->linenr);
+		}
 		free(another);
 	} else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] !=3D '\n')
-			die(_("git apply: bad git-diff - expected /dev/null on line %d"), s=
tate->linenr);
+			return error(_("git apply: bad git-diff - expected /dev/null on lin=
e %d"), state->linenr);
 	}
+
+	return 0;
 }
=20
 static int gitdiff_oldname(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	gitdiff_verify_name(state, line,
-			    patch->is_new, &patch->old_name,
-			    DIFF_OLD_NAME);
-	return 0;
+	return gitdiff_verify_name(state, line,
+				   patch->is_new, &patch->old_name,
+				   DIFF_OLD_NAME);
 }
=20
 static int gitdiff_newname(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	gitdiff_verify_name(state, line,
-			    patch->is_delete, &patch->new_name,
-			    DIFF_NEW_NAME);
-	return 0;
+	return gitdiff_verify_name(state, line,
+				   patch->is_delete, &patch->new_name,
+				   DIFF_NEW_NAME);
 }
=20
 static int gitdiff_oldmode(struct apply_state *state,
--=20
2.9.0.rc2.411.g3e2ca28
