Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E68A201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 16:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932587AbdBVQT4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 11:19:56 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:34790 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932358AbdBVQTx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 11:19:53 -0500
Received: from homiemail-a1.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 1DE67C1D76
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 08:19:24 -0800 (PST)
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id AAEF934807F
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 08:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:in-reply-to:references:from:date:subject:to
        :content-transfer-encoding:mime-version; s=mattmccutchen.net;
         bh=PpqZ6OCrkHn7TtK1e75INVsvFE4=; b=TsRxavyp5tcDiMY4hdY+llfVONZu
        EzI3KJGK7LkKJSFiaz+ePclbTZZKuvYiuttY0Cg+aW2O/nGQPlErpUJ1sQF8fQ6+
        CHVCFjbJJBjqMPqsbJwPdpmChCeTs9/fJsxexvlE7CYrepF/p3u++rZLDlNOMkKW
        fxPYguJFUjFPaD0=
Received: from main (30-86-202.dynamic.csail.mit.edu [128.30.86.202])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id 6AAA434807B
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 08:18:23 -0800 (PST)
Message-Id: <1f0552fda52507b2242890755d97bf07576547fb.1487779910.git.matt@mattmccutchen.net>
In-Reply-To: <xmqqvas4gie9.fsf@gitster.mtv.corp.google.com>
References: <xmqqvas4gie9.fsf@gitster.mtv.corp.google.com>
From:   Matt McCutchen <matt@mattmccutchen.net>
Date:   Wed, 22 Feb 2017 11:02:15 -0500
Subject: [PATCH 2/3] fetch_refs_via_pack: call report_unmatched_refs
To:     git@vger.kernel.org
X-Mailer: Evolution 3.22.4 (3.22.4-2.fc25) 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git fetch" currently doesn't bother to check that it got all refs it
sought, because the common case of requesting a nonexistent ref triggers
a die() in get_fetch_map.  However, there's at least one case that
slipped through: "git fetch REMOTE SHA1" if the server doesn't allow
requests for unadvertised objects.  Make fetch_refs_via_pack (which is
on the "git fetch" code path) call report_unmatched_refs so that we at
least get an error message in that case.
---
 t/t5516-fetch-push.sh |  3 ++-
 transport.c           | 14 +++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 26b2caf..0d13a45 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1098,7 +1098,8 @@ test_expect_success 'fetch exact SHA1' '
 		test_must_fail git cat-file -t $the_commit &&
 
 		# fetching the hidden object should fail by default
-		test_must_fail git fetch -v ../testrepo $the_commit:refs/heads/copy &&
+		test_must_fail git fetch -v ../testrepo $the_commit:refs/heads/copy 2>err &&
+		test_i18ngrep "no such remote ref" err &&
 		test_must_fail git rev-parse --verify refs/heads/copy &&
 
 		# the server side can allow it to succeed
diff --git a/transport.c b/transport.c
index 04e5d66..c377907 100644
--- a/transport.c
+++ b/transport.c
@@ -204,6 +204,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
+	int ret = 0;
 	struct git_transport_data *data = transport->data;
 	struct ref *refs;
 	char *dest = xstrdup(transport->url);
@@ -241,19 +242,22 @@ static int fetch_refs_via_pack(struct transport *transport,
 			  &transport->pack_lockfile);
 	close(data->fd[0]);
 	close(data->fd[1]);
-	if (finish_connect(data->conn)) {
-		free_refs(refs);
-		refs = NULL;
-	}
+	if (finish_connect(data->conn))
+		ret = -1;
 	data->conn = NULL;
 	data->got_remote_heads = 0;
 	data->options.self_contained_and_connected =
 		args.self_contained_and_connected;
 
+	if (refs == NULL)
+		ret = -1;
+	if (report_unmatched_refs(to_fetch, nr_heads))
+		ret = -1;
+
 	free_refs(refs_tmp);
 	free_refs(refs);
 	free(dest);
-	return (refs ? 0 : -1);
+	return ret;
 }
 
 static int push_had_errors(struct ref *ref)
-- 
2.9.3


