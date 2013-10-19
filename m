From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Fix calling parse_pathspec with no paths nor PATHSPEC_PREFER_* flags
Date: Sat, 19 Oct 2013 09:41:24 +0700
Message-ID: <1382150484-13207-1-git-send-email-pclouds@gmail.com>
References: <CALWbr2zTZzGZ9fkUonQr77Vn_dfzP57CZR1vNxNJW_touxNstQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 19 04:37:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXMQI-0003Cu-8y
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 04:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350Ab3JSChd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Oct 2013 22:37:33 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:52720 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801Ab3JSChc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 22:37:32 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so5411582pad.21
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 19:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=spSagxGDdmbTsOFLoc9T2viGK/H4aLHZ6nUXP5KwT+c=;
        b=HEO5A8V3vF9q7Q0MW52dxjRrKpOHune4P8o599Gnwn+D8KCzrjm4Tl/9/xMgafs8gy
         4LIJx16pR3MOiSe5mEExQRWYKOLj7XrZ/IbCHzJeJJrxCT2m5DtxI0DTeedx88Egw36B
         7ilLuRgvDRnfjK7KE7ZBWQx72WqVwK9Zs+oE2gbJvfUHuq8c2gFy9ycYekHvYO0rHPke
         q4qVzcSwsYWRgEdWUy/yLutdz29f5dspZx1SfnCWjygAxISm/jTgOyScL8T1fc/SYzrx
         fke6yTtq/qJhqlGxRh2zFUn6XiqgAgU+SWYqI4+k16BZozZzi06BPNcs0iOe/J71DjgP
         U5rw==
X-Received: by 10.66.171.204 with SMTP id aw12mr6414479pac.7.1382150252105;
        Fri, 18 Oct 2013 19:37:32 -0700 (PDT)
Received: from lanh ([115.73.255.166])
        by mx.google.com with ESMTPSA id ab4sm5401043pbc.43.2013.10.18.19.37.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Oct 2013 19:37:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 19 Oct 2013 09:41:25 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <CALWbr2zTZzGZ9fkUonQr77Vn_dfzP57CZR1vNxNJW_touxNstQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236383>

When parse_pathspec() is called with no paths, the behavior could be
either return no paths, or return one path that is cwd. Some commands
do the former, some the latter. parse_pathspec() itself does not make
either the default and requires the caller to specify either flag if
it may run into this situation.

I've grep'd through all parse_pathspec() call sites. Some pass
neither, but those are guaranteed never pass empty path to
parse_pathspec(). There are two call sites that may pass empty path
and are fixed with this patch.

Reported-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 line-log.c | 3 ++-
 revision.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/line-log.c b/line-log.c
index 8b6e497..717638b 100644
--- a/line-log.c
+++ b/line-log.c
@@ -760,7 +760,8 @@ void line_log_init(struct rev_info *rev, const char=
 *prefix, struct string_list
 			r =3D r->next;
 		}
 		paths[count] =3D NULL;
-		parse_pathspec(&rev->diffopt.pathspec, 0, 0, "", paths);
+		parse_pathspec(&rev->diffopt.pathspec, 0,
+			       PATHSPEC_PREFER_FULL, "", paths);
 		free(paths);
 	}
 }
diff --git a/revision.c b/revision.c
index 0173e01..dd994e9 100644
--- a/revision.c
+++ b/revision.c
@@ -1372,7 +1372,8 @@ static void prepare_show_merge(struct rev_info *r=
evs)
 			i++;
 	}
 	free_pathspec(&revs->prune_data);
-	parse_pathspec(&revs->prune_data, PATHSPEC_ALL_MAGIC, 0, "", prune);
+	parse_pathspec(&revs->prune_data, PATHSPEC_ALL_MAGIC,
+		       PATHSPEC_PREFER_FULL, "", prune);
 	revs->limited =3D 1;
 }
=20
--=20
1.8.2.83.gc99314b
