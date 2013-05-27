From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] commit: don't use-editor when allow-empty-message
Date: Mon, 27 May 2013 19:50:19 +0530
Message-ID: <1369664419-16440-1-git-send-email-artagnon@gmail.com>
References: <1369663431-2405-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?q?Mislav=20Marohni=C4=87?= <mislav.marohnic@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 27 16:18:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgyG6-0007Hv-Tu
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 16:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679Ab3E0OSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 May 2013 10:18:34 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:50084 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932537Ab3E0OSe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 10:18:34 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so6827550pbc.31
        for <git@vger.kernel.org>; Mon, 27 May 2013 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/rYtgsddWqZiFguotfoMD8L9GSOxaKVeD4x6Z7bFfzU=;
        b=x1+SAkKukhm7zZdMZ5XzfpAAsb/11yNTmWPPZW9SaS8laoeS6q9dgllzsHWgOqZMYn
         7S1BZMnmdVXWxOV1BEjRfm0AtqKE92txUkSs3aRZbQdhGbXCE59tpp0ycBzntVhwWpqO
         CB6yhIY69BtGGTDGl6XXFHZuhU9qRTmt1vyvlw1S4XFIUybaqPmz8+Bmiyem3PsMvEqj
         yLXvGqtImcEcJeU/N9DpsyZJlvFIcvJbvtAFsNzw+9iKAdk04PE0lYUQ3VJSVaAEGeHD
         21Odom4bvOE3q64Igr/tTlimuwTZylK9BK2pSDPrS3q4TLFUNc8q3uGrNMPrSOALuch6
         mDaw==
X-Received: by 10.66.144.98 with SMTP id sl2mr30389560pab.92.1369664313729;
        Mon, 27 May 2013 07:18:33 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vu10sm28757050pbc.27.2013.05.27.07.18.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 May 2013 07:18:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.g33669de.dirty
In-Reply-To: <1369663431-2405-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225591>

Commit a24a41e (git-commit: only append a newline to -m mesg if
necessary, 2013-02-18) introduced a regression: when
--allow-empty-message is used and an empty message is explicitly
specified with -m "", git commit still launches $EDITOR unnecessarily.
The commit (correctly) fixes opt_parse_m() to not fill in two newlines
into the message buffer unconditionally.  The real problem is that
launching $EDITOR only depends on use_editor and whether message is
empty.  Fix the problem by setting explicit_message in the codepath
where an explicit string is passed via -m, and then checking it before
launching $EDITOR.

Reported-by: Mislav Marohni=C4=87 <mislav.marohnic@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Works?

 builtin/commit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d2f30d9..7d72ba7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -108,6 +108,7 @@ static const char *cleanup_arg;
 static enum commit_whence whence;
 static int use_editor =3D 1, include_status =3D 1;
 static int show_ignored_in_status;
+static int explicit_message =3D 0;
 static const char *only_include_assumed;
 static struct strbuf message =3D STRBUF_INIT;
=20
@@ -128,6 +129,7 @@ static int opt_parse_m(const struct option *opt, co=
nst char *arg, int unset)
 			strbuf_addch(buf, '\n');
 		strbuf_addstr(buf, arg);
 		strbuf_complete_line(buf);
+		explicit_message =3D 1;
 	}
 	return 0;
 }
@@ -824,7 +826,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 		     git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
 		return 0;
=20
-	if (use_editor) {
+	if (use_editor && !explicit_message) {
 		char index[PATH_MAX];
 		const char *env[2] =3D { NULL };
 		env[0] =3D  index;
--=20
1.8.3.1.g33669de.dirty
