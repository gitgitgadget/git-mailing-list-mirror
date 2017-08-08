Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE3E81F991
	for <e@80x24.org>; Tue,  8 Aug 2017 10:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbdHHK0B (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 06:26:01 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:20481 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdHHK0A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 06:26:00 -0400
Received: from lindisfarne.localdomain ([92.22.15.146])
        by smtp.talktalk.net with SMTP
        id f1hwdMv23iSHaf1i2d0Ljj; Tue, 08 Aug 2017 11:25:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1502187959; bh=76pjR7Flwbtkn/QX/N5aposNhkyHHJ4OIfsR37OKw1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=aPJJhDA9iNnnP17P//0zZMeApxra8zKEj0ZWwCa4vNNaQwgcTSU8GkaAXOyhRXBZg
         3L76qvHDAhQs8GLmiptxZnY0ttOYTh/3mTpw4DDjbtvq7V4vfSBEstBnrWbkdomokw
         AS6RPrQzgwywBrtusPozrpWBS4k6q6btgR18yt4s=
X-Originating-IP: [92.22.15.146]
X-Spam: 0
X-OAuthority: v=2.2 cv=UoATD64B c=1 sm=1 tr=0 a=PRKyDR6jJsLBrgZYJ8A23w==:117
 a=PRKyDR6jJsLBrgZYJ8A23w==:17 a=evINK-nbAAAA:8 a=ybZZDoGAAAAA:8
 a=A1X0JdhQAAAA:8 a=R8ma5VRaUaS0arCI8YoA:9 a=Z1gtGaqjNhd5KXlp:21
 a=KoWVofXTuOwdiWcM:21 a=cssNWy7hh4kA:10 a=RfR_gqz1fSpA9VikTjo0:22
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=Df3jFdWbhGDLdZNm0fyq:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2] am: fix signoff when other trailers are present
Date:   Tue,  8 Aug 2017 11:25:33 +0100
Message-Id: <20170808102533.27516-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170807102929.25151-1-phillip.wood@talktalk.net>
References: <20170807102929.25151-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJaGblB2P4QHDUVlUMtmhxu9XnOaddSjNG6jDDaN+Sh85rlXcH+vgkiawQJj/G5to3jEti2s3c7hm/a9SVRwasLoKoxmke/Ur9jhrNZ1Sq5QMyvPv12B
 CZtICqyBO44tVA/TFvQ8OnP2MMs1n2r89qGX8p4SIo4r7QIMQipFdZA4O6DMiUonx/uh7BEA8uPXz/2yM8uHaBaZlFfs3dx2aZWpq5j2a7VEf9EB3cccu6AK
 O6f+cs2l30RwodsawKr3P7YRa04eRRaqGOWQSx77DSCnz+blVfOAeKSkAb38UG11qYXyC2otplHvZkaSPl+mbalIUURICF4qX+/Db6CN84w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there was no 'Signed-off-by:' trailer but another trailer such as
'Reported-by:' then 'git am --signoff' would add a blank line between
the existing trailers and the added 'Signed-off-by:' line. e.g.

    Rebase accepts '--rerere-autoupdate' as an option but only honors
    it if '-m' is also given. Fix it for a non-interactive rebase by
    passing on the option to 'git am' and 'git cherry-pick'.

    Reported-by: Junio C Hamano <gitster@pobox.com>

    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

Fix by using the code provided for this purpose in sequencer.c.
Change the tests so that they check the formatting of the
'Signed-off-by:' lines rather than just grepping for them.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
I've removed the call to ignore_non_trailer(), otherwise this is
unchanged from v1

 builtin/am.c  | 26 +------------------
 t/t4150-am.sh | 83 +++++++++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 64 insertions(+), 45 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index c973bd96dcb5d630d56e935733bfa4530ccd2872..3aaef59676452fd2e7c6d4a375dc7c95558744c6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1181,34 +1181,10 @@ static void NORETURN die_user_resolve(const struct am_state *state)
  */
 static void am_append_signoff(struct am_state *state)
 {
-	char *cp;
-	struct strbuf mine = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 
 	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len);
-
-	/* our sign-off */
-	strbuf_addf(&mine, "\n%s%s\n",
-		    sign_off_header,
-		    fmt_name(getenv("GIT_COMMITTER_NAME"),
-			     getenv("GIT_COMMITTER_EMAIL")));
-
-	/* Does sb end with it already? */
-	if (mine.len < sb.len &&
-	    !strcmp(mine.buf, sb.buf + sb.len - mine.len))
-		goto exit; /* no need to duplicate */
-
-	/* Does it have any Signed-off-by: in the text */
-	for (cp = sb.buf;
-	     cp && *cp && (cp = strstr(cp, sign_off_header)) != NULL;
-	     cp = strchr(cp, '\n')) {
-		if (sb.buf == cp || cp[-1] == '\n')
-			break;
-	}
-
-	strbuf_addstr(&sb, mine.buf + !!cp);
-exit:
-	strbuf_release(&mine);
+	append_signoff(&sb, 0, 0);
 	state->msg = strbuf_detach(&sb, &state->msg_len);
 }
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 44807e218d7016f58bd41b89af71104a37f31a8b..73b67b4280b99e0328e201e6b69c3d88b766ea84 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -40,6 +40,8 @@ test_expect_success 'setup: messages' '
 	dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio
 	dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te
 	feugait nulla facilisi.
+
+	Reported-by: A N Other <a.n.other@example.com>
 	EOF
 
 	cat >failmail <<-\EOF &&
@@ -93,7 +95,7 @@ test_expect_success setup '
 	echo world >>file &&
 	git add file &&
 	test_tick &&
-	git commit -s -F msg &&
+	git commit -F msg &&
 	git tag second &&
 
 	git format-patch --stdout first >patch1 &&
@@ -124,8 +126,6 @@ test_expect_success setup '
 		echo "Date: $GIT_AUTHOR_DATE" &&
 		echo &&
 		sed -e "1,2d" msg &&
-		echo &&
-		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
 		echo "---" &&
 		git diff-tree --no-commit-id --stat -p second
 	} >patch1-stgit.eml &&
@@ -144,8 +144,6 @@ test_expect_success setup '
 		echo "# Parent  $_z40" &&
 		cat msg &&
 		echo &&
-		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
-		echo &&
 		git diff-tree --no-commit-id -p second
 	} >patch1-hg.eml &&
 
@@ -470,13 +468,15 @@ test_expect_success 'am --signoff adds Signed-off-by: line' '
 	git reset --hard &&
 	git checkout -b master2 first &&
 	git am --signoff <patch2 &&
-	printf "%s\n" "$signoff" >expected &&
-	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >>expected &&
-	git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
-	test_cmp expected actual &&
-	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected &&
-	git cat-file commit HEAD | grep "Signed-off-by:" >actual &&
-	test_cmp expected actual
+	{
+		printf "third\n\nSigned-off-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" &&
+		cat msg &&
+		printf "Signed-off-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL"
+	} >expected-log &&
+	git log --pretty=%B -2 HEAD >actual &&
+	test_cmp expected-log actual
 '
 
 test_expect_success 'am stays in branch' '
@@ -486,17 +486,60 @@ test_expect_success 'am stays in branch' '
 '
 
 test_expect_success 'am --signoff does not add Signed-off-by: line if already there' '
-	git format-patch --stdout HEAD^ >patch3 &&
-	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2] [foo," patch3 >patch4 &&
-	rm -fr .git/rebase-apply &&
-	git reset --hard &&
-	git checkout HEAD^ &&
-	git am --signoff patch4 &&
-	git cat-file commit HEAD >actual &&
-	test $(grep -c "^Signed-off-by:" actual) -eq 1
+	git format-patch --stdout first >patch3 &&
+	git reset --hard first &&
+	git am --signoff <patch3 &&
+	git log --pretty=%B -2 HEAD >actual &&
+	test_cmp expected-log actual
+'
+
+test_expect_success 'am --signoff adds Signed-off-by: if another author is preset' '
+	NAME="A N Other" &&
+	EMAIL="a.n.other@example.com" &&
+	{
+		printf "third\n\nSigned-off-by: %s <%s>\nSigned-off-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
+			"$NAME" "$EMAIL" &&
+		cat msg &&
+		printf "Signed-off-by: %s <%s>\nSigned-off-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
+			"$NAME" "$EMAIL"
+	} >expected-log &&
+	git reset --hard first &&
+	GIT_COMMITTER_NAME="$NAME" GIT_COMMITTER_EMAIL="$EMAIL" \
+		git am --signoff <patch3 &&
+	git log --pretty=%B -2 HEAD >actual &&
+	test_cmp expected-log actual
+'
+
+test_expect_success 'am --signoff duplicates Signed-off-by: if it is not the last one' '
+	NAME="A N Other" &&
+	EMAIL="a.n.other@example.com" &&
+	{
+		printf "third\n\nSigned-off-by: %s <%s>\n\
+Signed-off-by: %s <%s>\nSigned-off-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
+			"$NAME" "$EMAIL" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" &&
+		cat msg &&
+		printf "Signed-off-by: %s <%s>\nSigned-off-by: %s <%s>\n\
+Signed-off-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
+			"$NAME" "$EMAIL" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL"
+	} >expected-log &&
+	git format-patch --stdout first >patch3 &&
+	git reset --hard first &&
+	git am --signoff <patch3 &&
+	git log --pretty=%B -2 HEAD >actual &&
+	test_cmp expected-log actual
 '
 
 test_expect_success 'am without --keep removes Re: and [PATCH] stuff' '
+	git format-patch --stdout HEAD^ >tmp &&
+	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2] [foo," tmp >patch4 &&
+	git reset --hard HEAD^ &&
+	git am <patch4 &&
 	git rev-parse HEAD >expected &&
 	git rev-parse master2 >actual &&
 	test_cmp expected actual
-- 
2.13.3

