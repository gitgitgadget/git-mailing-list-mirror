Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E251FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 16:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbdFMQRk (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 12:17:40 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:46918
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750899AbdFMQRk (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Jun 2017 12:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1497370658;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=z8U5AcPWGOV+MQHMwbhktMRcPjkFZ2rSorVw9xKWjCM=;
        b=jQ9g/9OlHdboTYqalukbVGxs95izVhzGY01mhDnICPcaUA5Q6d+h+owFOH9S8mRX
        gdP5ddZ+ZFc3u9IRy9C4GfC9ehmBNbE6pvz0k6tdDx6uVGj/PZ0rfZX7SMFkBqpsGmf
        uzIXamkWU31wrQbFKXgD1SwuxoRIkJJHJt6ha9Xs=
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015ca23f0529-c860f75d-e3bb-48b0-b2c0-502f7ab9d667-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
References: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
Subject: [PATCH 2/3] branch: add test for -m renaming multiple config
 sections
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 13 Jun 2017 16:17:38 +0000
X-SES-Outgoing: 2017.06.13-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Add a test for how 'git branch -m' handles the renaming of multiple
config sections existing for one branch.

The config format we use is hybrid machine/human editable, and we do
our best to preserve the likes of comments and formatting when editing
the file with git-config.

This adds a test for the currently expected semantics in the face of
some rather obscure edge cases which are unlikely to occur in
practice.

Helped-by: Sahil Dua <sahildua2305@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 t/t3200-branch.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 10f8f026ffb4b..28c02ffeadb4f 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -341,6 +341,43 @@ test_expect_success 'config information was renamed, t=
oo' '
 =09test_must_fail git config branch.s/s.dummy
 '
=20
+test_expect_success 'git branch -m correctly renames multiple config secti=
ons' '
+=09test_when_finished "git checkout master" &&
+=09git checkout -b source master &&
+
+=09# Assert that a config file with multiple config sections has
+=09# those sections preserved...
+=09cat >expect <<-\EOF &&
+=09branch.dest.key1=3Dvalue1
+=09some.gar.b=3Dage
+=09branch.dest.key2=3Dvalue2
+=09EOF
+=09cat >config.branch <<\EOF &&
+;; Comment for source
+[branch "source"]
+=09;; Comment for the source value
+=09key1 =3D value1
+=09;; Comment for some.gar
+[some "gar"]
+=09;; Comment for the some.gar value
+=09b =3D age
+=09;; Comment for source, again
+[branch "source"]
+=09;; Comment for the source value, again
+=09key2 =3D value2
+EOF
+=09cat config.branch >>.git/config &&
+=09git branch -m source dest &&
+=09git config -f .git/config -l | grep -F -e source -e dest -e some.gar >a=
ctual &&
+=09test_cmp expect actual &&
+
+=09# ...and that the comments for those sections are also
+=09# preserved.
+=09cat config.branch | sed "s/\"source\"/\"dest\"/" >expect &&
+=09grep -A 9001 "Comment for source" .git/config >actual &&
+=09test_cmp expect actual
+'
+
 test_expect_success 'deleting a symref' '
 =09git branch target &&
 =09git symbolic-ref refs/heads/symref refs/heads/target &&

--
https://github.com/git/git/pull/363
