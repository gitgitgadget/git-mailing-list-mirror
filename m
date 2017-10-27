Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F3DF1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbdJ0PGp (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:06:45 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:49266
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751632AbdJ0PGj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2017 11:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1509116798;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=1CYNc9l7mPQusbuBRwuM72+CfVCjxzvW6CHDDzC5hNg=;
        b=R1zwfN9P1CyJKy449Mn2wjuTDTGIlPS7lFKGkoGNnpvTXAw48TvpbrZiQD6H//q0
        6HA4wioOJf6QmayWQL9Ak2bv9hDdL5u9I+HUklG03LxgZTCDzFkZoLF3Tm/0Has/snQ
        hGxO+f1g7XZNJ+DzguvLJZ8k6r37qEJURJL5Eg/0=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015f5e5ee273-03ff1203-7c84-4260-bda7-c27a87646517-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
Subject: [PATCH v16 Part II 3/8] wrapper: move is_empty_file() and rename it
 as is_empty_or_missing_file()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 27 Oct 2017 15:06:37 +0000
X-SES-Outgoing: 2017.10.27-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

is_empty_file() can help to refactor a lot of code. This will be very
helpful in porting "git bisect" to C.

Suggested-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/am.c | 20 ++------------------
 cache.h      |  3 +++
 wrapper.c    | 13 +++++++++++++
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4b6f1534f8840..2afaaabcdbecf 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -34,22 +34,6 @@
 #include "packfile.h"
=20
 /**
- * Returns 1 if the file is empty or does not exist, 0 otherwise.
- */
-static int is_empty_file(const char *filename)
-{
-=09struct stat st;
-
-=09if (stat(filename, &st) < 0) {
-=09=09if (errno =3D=3D ENOENT)
-=09=09=09return 1;
-=09=09die_errno(_("could not stat %s"), filename);
-=09}
-
-=09return !st.st_size;
-}
-
-/**
  * Returns the length of the first line of msg.
  */
 static int linelen(const char *msg)
@@ -1298,7 +1282,7 @@ static int parse_mail(struct am_state *state, const c=
har *mail)
 =09=09goto finish;
 =09}
=20
-=09if (is_empty_file(am_path(state, "patch"))) {
+=09if (is_empty_or_missing_file(am_path(state, "patch"))) {
 =09=09printf_ln(_("Patch is empty."));
 =09=09die_user_resolve(state);
 =09}
@@ -1880,7 +1864,7 @@ static void am_run(struct am_state *state, int resume=
)
 =09=09resume =3D 0;
 =09}
=20
-=09if (!is_empty_file(am_path(state, "rewritten"))) {
+=09if (!is_empty_or_missing_file(am_path(state, "rewritten"))) {
 =09=09assert(state->rebasing);
 =09=09copy_notes_for_rebase(state);
 =09=09run_post_rewrite_hook(state);
diff --git a/cache.h b/cache.h
index 25adcf681531c..f05056a2d7fa1 100644
--- a/cache.h
+++ b/cache.h
@@ -1958,4 +1958,7 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
=20
+/* Return 1 if the file is empty or does not exists, 0 otherwise. */
+extern int is_empty_or_missing_file(const char *filename);
+
 #endif /* CACHE_H */
diff --git a/wrapper.c b/wrapper.c
index 61aba0b5c1bec..21c0fee2db459 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -690,3 +690,16 @@ int xgethostname(char *buf, size_t len)
 =09=09buf[len - 1] =3D 0;
 =09return ret;
 }
+
+int is_empty_or_missing_file(const char *filename)
+{
+=09struct stat st;
+
+=09if (stat(filename, &st) < 0) {
+=09=09if (errno =3D=3D ENOENT)
+=09=09=09return 1;
+=09=09die_errno(_("could not stat %s"), filename);
+=09}
+
+=09return !st.st_size;
+}

--
https://github.com/git/git/pull/420
