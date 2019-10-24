Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50491F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 12:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502206AbfJXMxu (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 08:53:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31923 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2502185AbfJXMxt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 08:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571921627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=R/arp1HI+VmWOZTYN63SI8qxftey90DFn97n+wf8Pw8=;
        b=M+JIojbXbhXZVfj23QPGMpaeYKMVN1lfy1HesC9NafCesV0iUe93U4/iS2YBmxrDHPWAZg
        zMLV8TYE384DwPCrudt210mfVEPL7R6Kl4+0AKWyRxYH9rxS++kgdHDdWet0Lch61TB9zf
        oEHKmodaqGo3jL+cy9SZiOlanvXfCCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-IupVSTeHMYGHkqiK0-DavA-1; Thu, 24 Oct 2019 08:53:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CB03800D49;
        Thu, 24 Oct 2019 12:53:43 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AAD65D9CA;
        Thu, 24 Oct 2019 12:53:37 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     git@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2] pretty: add "%aL"|"%al|%cL|%cl" option to output local-part of email addresses
Date:   Thu, 24 Oct 2019 08:53:32 -0400
Message-Id: <20191024125332.29958-1-prarit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: IupVSTeHMYGHkqiK0-DavA-1
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

Add a "%aL"|"%al|%cL|%cl" option that output the local-part of an email
address.

Also add tests for "%ae","%an", "%ce", and "%cn".

Changes in v2:
- Changed option to 'L' based on https://www.ietf.org/rfc/rfc2822.txt
  definition of 'local-part' of email addresses.
- added additional information to documentation for %cL and %cl
- added mailmap output test
- modified code to use mailmap output for "L" option
- modified code to check if email address field has '@' symbol
- modified tests based on input from Peff

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: brian m. carlson <sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>
---
 Documentation/pretty-formats.txt | 10 ++++++++++
 pretty.c                         |  9 ++++++++-
 t/t4202-log.sh                   | 30 ++++++++++++++++++++++++++++++
 t/test-lib.sh                    | 10 ++++++++--
 4 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-format=
s.txt
index b87e2e83e6d0..9a1f900f114a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -163,6 +163,11 @@ The placeholders are:
 '%ae':: author email
 '%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
 =09or linkgit:git-blame[1])
+'%al':: author local-part (the portion of the email address preceding the =
'@'
+=09symbol)
+'%aL':: author local-part (the portion of the email address preceding the =
'@'
+=09symbol, respecting .mailmap, see linkgit:git-shortlog[1] or
+=09linkgit:git-blame[1])
 '%ad':: author date (format respects --date=3D option)
 '%aD':: author date, RFC2822 style
 '%ar':: author date, relative
@@ -175,6 +180,11 @@ The placeholders are:
 '%ce':: committer email
 '%cE':: committer email (respecting .mailmap, see
 =09linkgit:git-shortlog[1] or linkgit:git-blame[1])
+'%cl':: author local-part (the portion of the email address preceding the =
'@'
+=09symbol)
+'%cL':: author local-part (the portion of the email address preceding the =
'@'
+=09symbol, respecting .mailmap, see linkgit:git-shortlog[1] or
+=09linkgit:git-blame[1])
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
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e803ba402e9e..fa6ecf3588b7 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1729,4 +1729,34 @@ test_expect_success 'log --end-of-options' '
        test_cmp expect actual
 '
=20
+test_expect_success 'log pretty %an %ae %al %aN %aE %aL' '
+=09git checkout -b anaeal &&
+=09test_commit anaeal_test anaeal_test_file &&
+=09git log --pretty=3D"%an%n%ae%n%al%n%aN%n%aE%n%aL" -1 > actual &&
+=09{
+=09=09echo "${GIT_AUTHOR_NAME}" &&
+=09=09echo "${GIT_AUTHOR_EMAIL}" &&
+=09=09echo "${TEST_AUTHOR_LOCALNAME}"
+=09=09echo "${GIT_AUTHOR_NAME}" &&
+=09=09echo "${GIT_AUTHOR_EMAIL}" &&
+=09=09echo "${TEST_AUTHOR_LOCALNAME}"
+=09} > expect &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'log pretty %cn %ce %cl %cN %cE %cL' '
+=09git checkout -b cncecl &&
+=09test_commit cncecl_test cncecl_test_file &&
+=09git log --pretty=3D"%cn%n%ce%n%cl%n%cN%n%cE%n%cL" -1 > actual &&
+=09{
+=09=09echo "${GIT_COMMITTER_NAME}" &&
+=09=09echo "${GIT_COMMITTER_EMAIL}" &&
+=09=09echo "${TEST_COMMITTER_LOCALNAME}"
+=09=09echo "${GIT_COMMITTER_NAME}" &&
+=09=09echo "${GIT_COMMITTER_EMAIL}" &&
+=09=09echo "${TEST_COMMITTER_LOCALNAME}"
+=09} > expect &&
+=09test_cmp expect actual
+'
+
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e06fa02a0eec..5ef0ad8c1a2a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -404,14 +404,20 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e=
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
 export GIT_MERGE_VERBOSITY GIT_MERGE_AUTOEDIT
+export TEST_AUTHOR_LOCALNAME TEST_AUTHOR_DOMAIN
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
+export TEST_COMMITTER_LOCALNAME TEST_COMMITTER_DOMAIN
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
=20
--=20
2.21.0

