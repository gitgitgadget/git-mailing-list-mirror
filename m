Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A3F1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 12:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbfJ2MJb (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 08:09:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60570 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727681AbfJ2MJa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 08:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572350968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=e4TNn08xpQBh4nN8v+5WU5Oi4bvwRLNIJnQmZBKtp0Q=;
        b=M4N6QEIG3Du73KS2MtHxPcvkjlt+ouJhhBHMZb70XUSTkq4ASAGkvlAnesTsYmHQQZsZml
        FGcpgmKe74xUqOLEIHDDgZdOUR+KrENeW9QrKpjSMRp0KkbhT33KWQhq3nbfMyZL+wK361
        NtaG4mbb4J/Ps6VVVtm1w3aSbHZaHos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-vI3xJt97MQmkatqkn2sJZQ-1; Tue, 29 Oct 2019 08:09:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C63175E6;
        Tue, 29 Oct 2019 12:09:19 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC79E5C1B2;
        Tue, 29 Oct 2019 12:09:18 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, peff@peff.net,
        szeder.dev@gmail.com, Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v4] pretty: add "%aL" etc. to show local-part of email addresses
Date:   Tue, 29 Oct 2019 08:09:14 -0400
Message-Id: <20191029120914.14756-1-prarit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: vI3xJt97MQmkatqkn2sJZQ-1
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

Existing 'e/E' (as in "%ae" and "%aE") placeholders would show the
author's address as "prarit@redhat.com", which would waste columns to show
the same domain-part for all contributors when used in redhat-only
project.  Introduce 'l/L' placeholders that strip '@' and domain part from
the e-mail address.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
Changes in v2:
- Changed option to 'L' based on https://www.ietf.org/rfc/rfc2822.txt
  definition of 'local-part' of email addresses.
- added additional information to documentation for %cL and %cl
- added mailmap output test
- modified code to use mailmap output for "L" option
- modified code to check if email address field has '@' symbol
- modified tests based on input from Peff

Changes in v3:
- Adjust Documentation descriptions for %aL and %cL
- remove exports of TEST* variables from test-lib.sh
- move testing to t6006 and t4203

Changes in v4:
- Change subject and patch description
- Update Documentation descriptions for %aL and %cL

 Documentation/pretty-formats.txt |  6 ++++++
 pretty.c                         |  9 ++++++++-
 t/t4203-mailmap.sh               | 28 ++++++++++++++++++++++++++++
 t/t6006-rev-list-format.sh       |  8 ++++++--
 t/test-lib.sh                    |  8 ++++++--
 5 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-format=
s.txt
index b87e2e83e6d0..31c6e8d2b86a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -163,6 +163,9 @@ The placeholders are:
 '%ae':: author email
 '%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
 =09or linkgit:git-blame[1])
+'%al':: author email local-part (the part before the '@' sign)
+'%aL':: author local-part (see '%al') respecting .mailmap, see
+=09linkgit:git-shortlog[1] or linkgit:git-blame[1])
 '%ad':: author date (format respects --date=3D option)
 '%aD':: author date, RFC2822 style
 '%ar':: author date, relative
@@ -175,6 +178,9 @@ The placeholders are:
 '%ce':: committer email
 '%cE':: committer email (respecting .mailmap, see
 =09linkgit:git-shortlog[1] or linkgit:git-blame[1])
+'%cl':: author email local-part (the part before the '@' sign)
+'%cL':: author local-part (see '%cl') respecting .mailmap, see
+=09linkgit:git-shortlog[1] or linkgit:git-blame[1])
 '%cd':: committer date (format respects --date=3D option)
 '%cD':: committer date, RFC2822 style
 '%cr':: committer date, relative
diff --git a/pretty.c b/pretty.c
index b32f0369531c..93eb6e837071 100644
--- a/pretty.c
+++ b/pretty.c
@@ -696,7 +696,7 @@ static size_t format_person_part(struct strbuf *sb, cha=
r part,
 =09mail =3D s.mail_begin;
 =09maillen =3D s.mail_end - s.mail_begin;
=20
-=09if (part =3D=3D 'N' || part =3D=3D 'E') /* mailmap lookup */
+=09if (part =3D=3D 'N' || part =3D=3D 'E' || part =3D=3D 'L') /* mailmap l=
ookup */
 =09=09mailmap_name(&mail, &maillen, &name, &namelen);
 =09if (part =3D=3D 'n' || part =3D=3D 'N') {=09/* name */
 =09=09strbuf_add(sb, name, namelen);
@@ -706,6 +706,13 @@ static size_t format_person_part(struct strbuf *sb, ch=
ar part,
 =09=09strbuf_add(sb, mail, maillen);
 =09=09return placeholder_len;
 =09}
+=09if (part =3D=3D 'l' || part =3D=3D 'L') {=09/* local-part */
+=09=09const char *at =3D memchr(mail, '@', maillen);
+=09=09if (at)
+=09=09=09maillen =3D at - mail;
+=09=09strbuf_add(sb, mail, maillen);
+=09=09return placeholder_len;
+=09}
=20
 =09if (!s.date_begin)
 =09=09goto skip;
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index e8f9c0f5bc8c..586c3a86b1d2 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -412,6 +412,34 @@ test_expect_success 'Log output (complex mapping)' '
 =09test_cmp expect actual
 '
=20
+cat >expect << EOF
+Author email cto@coompany.xx has local-part cto
+Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALN=
AME
+
+Author email me@company.xx has local-part me
+Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALN=
AME
+
+Author email me@company.xx has local-part me
+Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALN=
AME
+
+Author email nick2@company.xx has local-part nick2
+Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALN=
AME
+
+Author email bugs@company.xx has local-part bugs
+Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALN=
AME
+
+Author email bugs@company.xx has local-part bugs
+Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALN=
AME
+
+Author email author@example.com has local-part author
+Committer email $GIT_COMMITTER_EMAIL has local-part $TEST_COMMITTER_LOCALN=
AME
+EOF
+
+test_expect_success 'Log output (local-part email address)' '
+=09git log --pretty=3Dformat:"Author email %ae has local-part %al%nCommitt=
er email %ce has local-part %cl%n" >actual &&
+=09test_cmp expect actual
+'
+
 cat >expect << EOF
 Author: CTO <cto@company.xx>
 Author: Santa Claus <santa.claus@northpole.xx>
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 1f7d3f7acc9c..ebdc49c4965e 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -109,31 +109,35 @@ commit $head1
 EOF
=20
 # we don't test relative here
-test_format author %an%n%ae%n%ad%n%aD%n%at <<EOF
+test_format author %an%n%ae%n%al%n%ad%n%aD%n%at <<EOF
 commit $head2
 $GIT_AUTHOR_NAME
 $GIT_AUTHOR_EMAIL
+$TEST_AUTHOR_LOCALNAME
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 commit $head1
 $GIT_AUTHOR_NAME
 $GIT_AUTHOR_EMAIL
+$TEST_AUTHOR_LOCALNAME
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 EOF
=20
-test_format committer %cn%n%ce%n%cd%n%cD%n%ct <<EOF
+test_format committer %cn%n%ce%n%cl%n%cd%n%cD%n%ct <<EOF
 commit $head2
 $GIT_COMMITTER_NAME
 $GIT_COMMITTER_EMAIL
+$TEST_COMMITTER_LOCALNAME
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 commit $head1
 $GIT_COMMITTER_NAME
 $GIT_COMMITTER_EMAIL
+$TEST_COMMITTER_LOCALNAME
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e06fa02a0eec..46c44408432e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -404,9 +404,13 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e =
'
 unset XDG_CACHE_HOME
 unset XDG_CONFIG_HOME
 unset GITPERLLIB
-GIT_AUTHOR_EMAIL=3Dauthor@example.com
+TEST_AUTHOR_LOCALNAME=3Dauthor
+TEST_AUTHOR_DOMAIN=3Dexample.com
+GIT_AUTHOR_EMAIL=3D${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
 GIT_AUTHOR_NAME=3D'A U Thor'
-GIT_COMMITTER_EMAIL=3Dcommitter@example.com
+TEST_COMMITTER_LOCALNAME=3Dcommitter
+TEST_COMMITTER_DOMAIN=3Dexample.com
+GIT_COMMITTER_EMAIL=3D${TEST_COMMITTER_LOCALNAME}@${TEST_COMMITTER_DOMAIN}
 GIT_COMMITTER_NAME=3D'C O Mitter'
 GIT_MERGE_VERBOSITY=3D5
 GIT_MERGE_AUTOEDIT=3Dno
--=20
2.21.0

