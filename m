From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Save terminal width before setting up pager and
 export term_columns()
Date: Mon, 13 Feb 2012 15:00:55 -0800
Message-ID: <7vlio6baoo.fsf@alter.siamese.dyndns.org>
References: <7vsjigl79j.fsf@alter.siamese.dyndns.org>
 <1329055953-29632-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Feb 14 00:01:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx4tO-0001Zh-Gr
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 00:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758141Ab2BMXBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 18:01:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44531 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757953Ab2BMXA7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 18:00:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE6717263;
	Mon, 13 Feb 2012 18:00:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=2bHcVtiedwbUBGh1y6Akjt62d
	8U=; b=VQpl5HXNnhTrYaVvAsnyZyKbmKTQ5gi1bIN1rObTtXFMlTRYywYiypBXi
	5HjH+5JWhWOb6wu++qwoOHSRQX40uP/U5wMTPbMu0NLlsTcjNycY2r8XKBwUHS+i
	B7UcE8rlooFc+HwG7CZJEkWEtqEn0EYpg7NrAbGP7ul0gHg+Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=BXjUrKVge+ALRSXAM5L
	OmsS3hHGMuZhroCnxPtbh2TFWCcHy9swXiMUmp6IGQK9kD2iFFlqtDyB/ecoWmFn
	ikQ5boz+h91jLcR/0Mi9YT/RTjMjn5621/yqqqXyJRx3XiOp5AgNLeYiyAD9JLB4
	Ka4vUiDXvME9TUtlhqQFfwX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5C877262;
	Mon, 13 Feb 2012 18:00:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFD087261; Mon, 13 Feb 2012
 18:00:57 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9710543E-5696-11E1-A06C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190687>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> term_columns() checks for terminal width via ioctl(2). After
> redirecting, stdin is no longer terminal to get terminal width.

s/stdin/stdout/

> Check terminal width and save it before redirecting stdin in
> setup_pager() by calling term_columns().
>
> Move term_columns() to pager.c and export it in cache.h.
>
> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> ---

Thanks.

It probably is worth mentioning what the end-user visible effect of thi=
s
change is somewhere in the log message.

I somehow find "term_columns_cache" a funny name for this variable and
does not describe what it does.  Unlike a real cache, we cannot discard=
 it
and re-read it even if we later wanted to.

I am tempted to rewrite the patch like this to update other minor style
issues.

-- >8 --
=46rom: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
Date: Sun, 12 Feb 2012 15:12:32 +0100
Subject: [PATCH] pager: find out the terminal width before spawning the=
 pager

term_columns() checks for terminal width via ioctl(2) on the standard
output, but we spawn the pager too early for this check to be useful.

The effect of this buglet can be observed by opening a wide terminal an=
d
running "git -p help --all", which still shows 80-column output, while
"git help --all" uses the full terminal width. Run the check before we
spawn the pager to fix this.

While at it, move term_columns() to pager.c and export it from cache.h =
so
that callers other than the help subsystem can use it.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h |    1 +
 help.c  |   22 ----------------------
 pager.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/cache.h b/cache.h
index 79c612f..c7e3b4d 100644
--- a/cache.h
+++ b/cache.h
@@ -1172,6 +1172,7 @@ extern void setup_pager(void);
 extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
+extern int term_columns(void);
=20
 extern const char *editor_program;
 extern const char *askpass_program;
diff --git a/help.c b/help.c
index cbbe966..14eefc9 100644
--- a/help.c
+++ b/help.c
@@ -5,28 +5,6 @@
 #include "help.h"
 #include "common-cmds.h"
=20
-/* most GUI terminals set COLUMNS (although some don't export it) */
-static int term_columns(void)
-{
-	char *col_string =3D getenv("COLUMNS");
-	int n_cols;
-
-	if (col_string && (n_cols =3D atoi(col_string)) > 0)
-		return n_cols;
-
-#ifdef TIOCGWINSZ
-	{
-		struct winsize ws;
-		if (!ioctl(1, TIOCGWINSZ, &ws)) {
-			if (ws.ws_col)
-				return ws.ws_col;
-		}
-	}
-#endif
-
-	return 80;
-}
-
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
 	struct cmdname *ent =3D xmalloc(sizeof(*ent) + len + 1);
diff --git a/pager.c b/pager.c
index 975955b..e06cfa0 100644
--- a/pager.c
+++ b/pager.c
@@ -76,6 +76,12 @@ void setup_pager(void)
 	if (!pager)
 		return;
=20
+	/*
+	 * force computing the width of the terminal before we redirect
+	 * the standard output to the pager.
+	 */
+	(void) term_columns();
+
 	setenv("GIT_PAGER_IN_USE", "true", 1);
=20
 	/* spawn the pager */
@@ -110,3 +116,40 @@ int pager_in_use(void)
 	env =3D getenv("GIT_PAGER_IN_USE");
 	return env ? git_config_bool("GIT_PAGER_IN_USE", env) : 0;
 }
+
+/*
+ * Return cached value (if set) or $COLUMNS (if set and positive) or
+ * ioctl(1, TIOCGWINSZ).ws_col (if positive) or 80.
+ *
+ * $COLUMNS even if set, is usually not exported, so
+ * the variable can be used to override autodection.
+ * This behaviour conforms to The Single UNIX Specification, Version 2
+ * (http://pubs.opengroup.org/onlinepubs/7908799/xbd/envvar.html#tag_0=
02_003).
+ */
+int term_columns(void)
+{
+	static int term_columns_at_startup;
+
+	char *col_string;
+	int n_cols;
+
+	if (term_columns_at_startup)
+		return term_columns_at_startup;
+
+	term_columns_at_startup =3D 80;
+
+	col_string =3D getenv("COLUMNS");
+	if (col_string && (n_cols =3D atoi(col_string)) > 0)
+		term_columns_at_startup =3D n_cols;
+#ifdef TIOCGWINSZ
+	else {
+		struct winsize ws;
+		if (!ioctl(1, TIOCGWINSZ, &ws)) {
+			if (ws.ws_col) {
+				term_columns_at_startup =3D ws.ws_col;
+			}
+		}
+	}
+#endif
+	return term_columns_at_startup;
+}
--=20
1.7.9.300.gd47e4
