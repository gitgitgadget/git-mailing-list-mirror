From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH] git-am: add am.threeWay config variable
Date: Tue,  4 Aug 2015 22:19:26 +0800
Message-ID: <1438697966-4958-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 16:19:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMd46-0005lX-96
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 16:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733AbbHDOTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 10:19:34 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34555 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbbHDOTd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 10:19:33 -0400
Received: by pawu10 with SMTP id u10so9753673paw.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=imD8k3wq97oRzqV86rO9MOKLepm4v9XpYEeIKw6AxcI=;
        b=C4bPzRILkSTogfq6RkSsbXOgQZpAJRJCJRi0U7WMuOoXGrOQL9v8fQhLAFarRm5jTb
         hAyWSMBZnAkTUvJDVEjMsttYFp++WlhlVcz9X+BZ4F+qxYG8R208twjVyduOlXLk0P00
         WEYcuU66Vze1pWgwvdazMov1f6bDJ47HtvVZ+cXat9oJUQGNuWVme91NSMbTwt4/vtPG
         M45Ye3Ru1aRhfpxgWQjJGj6VfMQuDVlc73yA6AIqMQGZCfrzZu/djINZa45yKLzEnoLD
         ezv7FxWlUEU01zvkLKEqMETA+xL+XedYZ174L0W3fqPkkF1YAes65Xpf9uepLRc0TIpX
         8n5w==
X-Received: by 10.69.3.228 with SMTP id bz4mr8353223pbd.79.1438697973222;
        Tue, 04 Aug 2015 07:19:33 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id f1sm1656275pdp.39.2015.08.04.07.19.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 07:19:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275326>

From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>

Add the am.threeWay configuration variable to use the -3 or --3way
option of git am by default. When am.threeway is set and not desired
for a specific git am command, the --no-3way option can be used to
override it.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
I tweaked Remi's patch so it is implemented on top of builtin/am.c. Hopefully
there will be no regressions this time ;)

 Documentation/config.txt |  8 ++++++++
 Documentation/git-am.txt |  7 +++++--
 builtin/am.c             |  2 ++
 t/t4150-am.sh            | 19 +++++++++++++++++++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 315f271..fb3fc57 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -769,6 +769,14 @@ am.keepcr::
 	by giving '--no-keep-cr' from the command line.
 	See linkgit:git-am[1], linkgit:git-mailsplit[1].
 
+am.threeWay::
+	By default, `git am` will fail if the patch does not apply cleanly. When
+	set to true, this setting tells `git am` to fall back on 3-way merge if
+	the patch records the identity of blobs it is supposed to apply to and
+	we have those blobs available locally (equivalent to giving the `--3way`
+	option from the command line). Defaults to `false`.
+	See linkgit:git-am[1].
+
 apply.ignoreWhitespace::
 	When set to 'change', tells 'git apply' to ignore changes in
 	whitespace, in the same way as the '--ignore-space-change'
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 0d8ba48..dbea6e7 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
-	 [--3way] [--interactive] [--committer-date-is-author-date]
+	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
@@ -90,10 +90,13 @@ default.   You can use `--no-utf8` to override this.
 
 -3::
 --3way::
+--no-3way::
 	When the patch does not apply cleanly, fall back on
 	3-way merge if the patch records the identity of blobs
 	it is supposed to apply to and we have those blobs
-	available locally.
+	available locally. `--no-3way` can be used to override
+	am.threeWay configuration variable. For more information,
+	see am.threeWay in linkgit:git-config[1].
 
 --ignore-space-change::
 --ignore-whitespace::
diff --git a/builtin/am.c b/builtin/am.c
index 84d57d4..1399c8d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -152,6 +152,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 
 	state->prec = 4;
 
+	git_config_get_bool("am.threeway", &state->threeway);
+
 	state->utf8 = 1;
 
 	git_config_get_bool("am.messageid", &state->message_id);
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index e9b6f81..dd627c4 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -551,6 +551,25 @@ test_expect_success 'am -3 -p0 can read --no-prefix patch' '
 	git diff --exit-code lorem
 '
 
+test_expect_success 'am with config am.threeWay falls back to 3-way merge' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout -b lorem4 base3way &&
+	test_config am.threeWay 1 &&
+	git am lorem-move.patch &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code lorem
+'
+
+test_expect_success 'am with config am.threeWay overridden by --no-3way' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout -b lorem5 base3way &&
+	test_config am.threeWay 1 &&
+	test_must_fail git am --no-3way lorem-move.patch &&
+	test_path_is_dir .git/rebase-apply
+'
+
 test_expect_success 'am can rename a file' '
 	grep "^rename from" rename.patch &&
 	rm -fr .git/rebase-apply &&
-- 
2.5.0.280.gd88bd6e
