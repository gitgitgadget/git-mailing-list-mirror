Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DD601F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 23:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbfJVX3D (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 19:29:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60945 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729635AbfJVX3C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 19:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571786941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oohvQFoDeOE40Z3g3dzNL6Gt5UGuPwSAK86SUmOLWjA=;
        b=Skjy1wEFaqIgtR2bp91La04NB3X/ZyPf9WrA+snGRonsSGNP323MglS5wf7YHj4ZcFWZqE
        1Vggy6/1nClpq18bXq4hLSwQjaJIta8cmbrXYs7hXk+unQRr+WGJmFLpvNhZJIzuUIfAUw
        QGFo608TdNx4aFQr42zqb+JZXQIUGsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-1uF9Eu0gMfSL4ewxSkfrRg-1; Tue, 22 Oct 2019 19:28:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C31D01005509
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 23:28:57 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68B2E5C1D4;
        Tue, 22 Oct 2019 23:28:57 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     git@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] pretty: Add "%aU"|"%au" option to output author's username
Date:   Tue, 22 Oct 2019 19:28:47 -0400
Message-Id: <20191022232847.5212-1-prarit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1uF9Eu0gMfSL4ewxSkfrRg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In many projects the number of contributors is low enough that users know
each other and the full email address doesn't need to be displayed.
Displaying only the author's username saves a lot of columns on the screen.
For example displaying "prarit" instead of "prarit@redhat.com" saves 11
columns.

Add a "%aU"|"%au" option that outputs the author's email username.

Also add tests for "%ae" and "%an".

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 Documentation/pretty-formats.txt |  3 +++
 pretty.c                         |  5 +++++
 t/t4202-log.sh                   | 16 ++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-format=
s.txt
index b87e2e83e6d0..479a15a8ab12 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -163,6 +163,9 @@ The placeholders are:
 '%ae':: author email
 '%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
 =09or linkgit:git-blame[1])
+'%au':: author username
+'%aU':: author username (respecting .mailmap, see linkgit:git-shortlog[1]
+=09or linkgit:git-blame[1])
 '%ad':: author date (format respects --date=3D option)
 '%aD':: author date, RFC2822 style
 '%ar':: author date, relative
diff --git a/pretty.c b/pretty.c
index b32f0369531c..2a5b93022050 100644
--- a/pretty.c
+++ b/pretty.c
@@ -706,6 +706,11 @@ static size_t format_person_part(struct strbuf *sb, ch=
ar part,
 =09=09strbuf_add(sb, mail, maillen);
 =09=09return placeholder_len;
 =09}
+=09if (part =3D=3D 'u' || part =3D=3D 'U') {=09/* username */
+=09=09maillen =3D strstr(s.mail_begin, "@") - s.mail_begin;
+=09=09strbuf_add(sb, mail, maillen);
+=09=09return placeholder_len;
+=09}
=20
 =09if (!s.date_begin)
 =09=09goto skip;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e803ba402e9e..2fee0c067197 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1729,4 +1729,20 @@ test_expect_success 'log --end-of-options' '
        test_cmp expect actual
 '
=20
+test_expect_success 'log pretty %an %ae %au' '
+=09git checkout -b anaeau &&
+=09test_commit anaeau_test anaeau_test_file &&
+=09git log --pretty=3D"%an" > actual &&
+=09git log --pretty=3D"%ae" >> actual &&
+=09git log --pretty=3D"%au" >> actual &&
+=09git log > full &&
+=09name=3D$(cat full | grep "^Author: " | awk -F "Author: " " { print \$2 =
} " | awk -F " <" " { print \$1 } ") &&
+=09email=3D$(cat full | grep "^Author: " | awk -F "<" " { print \$2 } " | =
awk -F ">" " { print \$1 } ") &&
+=09username=3D$(cat full | grep "^Author: " | awk -F "<" " { print \$2 } "=
 | awk -F ">" " { print \$1 } " | awk -F "@" " { print \$1 } " ) &&
+=09echo "${name}" > expect &&
+=09echo "${email}" >> expect &&
+=09echo "${username}" >> expect &&
+=09test_cmp expect actual
+'
+
 test_done
--=20
2.21.0

