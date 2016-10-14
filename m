Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D3F1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 14:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757349AbcJNOO1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:14:27 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:32820
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757276AbcJNOOT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=JaNQMc937vPqZqgByxGTa3sfuyPcnK1uK70dnwUM4Co=;
        b=Us/0hUib0bIEkqyrI/ANg65/YBZs8EV4DdpmXroukedC6slvEkeOMUvWb1+hqwFX
        4Q8f4eXI7i34bmHhFhp6fnIijQNFxW+UgNJ8RWXun+vAAf5s1x1uePrE3pc0pCE3nXK
        lYBL4i2kKaKSbIhDEiurxRV+b47kl4e+LZjSbo6w=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1a96-b0b1eef2-f637-4840-816f-373c500b7f4d-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 06/27] wrapper: move is_empty_file() and rename it as
 is_empty_or_missing_file()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 14 Oct 2016 14:14:16 +0000
X-SES-Outgoing: 2016.10.14-54.240.7.20
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
index 739b34d..9e1e9d6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -30,22 +30,6 @@
 #include "mailinfo.h"
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
@@ -1324,7 +1308,7 @@ static int parse_mail(struct am_state *state, const c=
har *mail)
 =09=09goto finish;
 =09}
=20
-=09if (is_empty_file(am_path(state, "patch"))) {
+=09if (is_empty_or_missing_file(am_path(state, "patch"))) {
 =09=09printf_ln(_("Patch is empty. Was it split wrong?"));
 =09=09die_user_resolve(state);
 =09}
@@ -1896,7 +1880,7 @@ static void am_run(struct am_state *state, int resume=
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
index b780a91..49f214b 100644
--- a/cache.h
+++ b/cache.h
@@ -1916,4 +1916,7 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
=20
+/* Return 1 if the file is empty or does not exists, 0 otherwise. */
+extern int is_empty_or_missing_file(const char *filename);
+
 #endif /* CACHE_H */
diff --git a/wrapper.c b/wrapper.c
index e7f1979..78f6431 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -679,3 +679,16 @@ void sleep_millisec(int millisec)
 {
 =09poll(NULL, 0, millisec);
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
https://github.com/git/git/pull/287
