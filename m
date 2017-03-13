Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44815202F8
	for <e@80x24.org>; Mon, 13 Mar 2017 17:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbdCMR4r (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 13:56:47 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36667 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbdCMR4p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 13:56:45 -0400
Received: by mail-pg0-f65.google.com with SMTP id 25so18795977pgy.3
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OMCPrwwd6/3RZz82Mz+xYqzoSAG6/OA2E62dMRVmUgM=;
        b=A3YSSseKwS3M5FyIJwFtx62l0y6kilPefjuOU/+exfIz7iR+fHm+j+KBCEnUz3YY3C
         HMDo/GpFD9BnvzgQe4pMq6q2KsNGT/Vh3YXS0nLCHdsB/RDebrv5uFVME9VJfpELQXXK
         i1y6b0FXdIvqTYIvxSMRbar0r1+1W4la7wwvkHsdmN3k3Y8O5LeVmSb9Xe5SlAvKoQmz
         um9e6DiVjXgQwOMaZqeDWEQCXcRBw9feMPiIrvaniReWtDoq3w6iK/tkEaxXU3KPyl4j
         mYx9IIhBuhAY4F/QAbTeWZg6fy7hZ2zvFrRwG8xVivkVGPTvVNhuW+h5WKyEztif16aN
         f7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OMCPrwwd6/3RZz82Mz+xYqzoSAG6/OA2E62dMRVmUgM=;
        b=RuPVdw0vx9nB0ckSmFJPGY8CBu+AoJ4ZxvisatX0ahTMmx/5h0wmmuUR4FlxzDVTv1
         mO/3I5PYwN32kbkIroqMpZ8BvPulSfY+Il/mOfzoRDw+UXW/Uv3dPtfD471e3etVXTFU
         t5Ccg9T8fqJqRzrwiQ7qVcxabGXqWBWFGOxB6v4555suf4AEiTmvPS/LpHUzTeAFdvn5
         UPlNR/5AE3fGqua9Mp6v3YWCoDIZwMxX/PGvqS+9urPVBoLvWzQlKdUrImCl61JekOtg
         ZHQtbKEgl0Ni309jYNpkzJE/WeetMjTSJDBmBUeF5bl4lFO5GoMHJr3nybewry8k8k5j
         lnfA==
X-Gm-Message-State: AMke39l7FSsEv3bh1wrEuLEn7gW/lO6L7xSGB/gEqAnVnUx8fJc7eUpjDY1wa5j9mKIkWQ==
X-Received: by 10.84.129.3 with SMTP id 3mr50222123plb.150.1489427804042;
        Mon, 13 Mar 2017 10:56:44 -0700 (PDT)
Received: from raptor.fas.fa.disney.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by smtp.gmail.com with ESMTPSA id m29sm33960204pfi.54.2017.03.13.10.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 10:56:42 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christophe Macabiau <christophemacabiau@gmail.com>,
        Git ML <git@vger.kernel.org>
Subject: [PATCH] difftool: handle changing symlinks in dir-diff mode
Date:   Mon, 13 Mar 2017 10:56:40 -0700
Message-Id: <20170313175640.14106-1-davvid@gmail.com>
X-Mailer: git-send-email 2.12.0.266.g2235183b6f
In-Reply-To: <alpine.DEB.2.20.1703072332370.3767@virtualbox>
References: <alpine.DEB.2.20.1703072332370.3767@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Detect the null object ID for symlinks in dir-diff so that difftool can
prepare temporary files that matches how git handles symlinks.

Previously, a null object ID would crash difftool.  We now detect null
object IDs and write the symlink's content into the temporary symlink
stand-in file.

Original-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/difftool.c  | 36 +++++++++++++++++++++++++++++++++---
 t/t7800-difftool.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index d13350ce83..6c20e20b45 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -254,6 +254,31 @@ static int ensure_leading_directories(char *path)
 	}
 }
 
+static int create_symlink_file(struct cache_entry* ce, struct checkout* state)
+{
+	/*
+	 * Dereference a worktree symlink and writes its contents
+	 * into the checkout state's path.
+	 */
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf link = STRBUF_INIT;
+
+	int ok = 0;
+
+	if (strbuf_readlink(&link, ce->name, ce_namelen(ce)) == 0) {
+		strbuf_add(&path, state->base_dir, state->base_dir_len);
+		strbuf_add(&path, ce->name, ce_namelen(ce));
+
+		write_file_buf(path.buf, link.buf, link.len);
+		ok = 1;
+	}
+
+	strbuf_release(&path);
+	strbuf_release(&link);
+
+	return ok;
+}
+
 static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			int argc, const char **argv)
 {
@@ -376,13 +401,13 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			continue;
 		}
 
-		if (S_ISLNK(lmode)) {
+		if (S_ISLNK(lmode) && !is_null_oid(&loid)) {
 			char *content = read_sha1_file(loid.hash, &type, &size);
 			add_left_or_right(&symlinks2, src_path, content, 0);
 			free(content);
 		}
 
-		if (S_ISLNK(rmode)) {
+		if (S_ISLNK(rmode) && !is_null_oid(&roid)) {
 			char *content = read_sha1_file(roid.hash, &type, &size);
 			add_left_or_right(&symlinks2, dst_path, content, 1);
 			free(content);
@@ -414,7 +439,12 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 				oidcpy(&ce->oid, &roid);
 				strcpy(ce->name, dst_path);
 				ce->ce_namelen = dst_path_len;
-				if (checkout_entry(ce, &rstate, NULL))
+
+				if (S_ISLNK(rmode) && is_null_oid(&roid)) {
+					if (!create_symlink_file(ce, &rstate))
+						return error("unable to create symlink file %s",
+							     dst_path);
+				} else if (checkout_entry(ce, &rstate, NULL))
 					return error("could not write '%s'",
 						     dst_path);
 			} else if (!is_null_oid(&roid)) {
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index e1ec292718..64f8e451b5 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -623,4 +623,44 @@ test_expect_success SYMLINKS 'difftool --dir-diff symlinked directories' '
 	)
 '
 
+test_expect_success SYMLINKS 'difftool --dir-diff' '
+	touch b &&
+	ln -s b c &&
+	git add . &&
+	test_tick &&
+	git commit -m initial &&
+	touch d &&
+	rm c &&
+	ln -s d c &&
+
+	git difftool --dir-diff --extcmd ls >output &&
+	grep -v ^/ output >actual &&
+	cat >expect <<-EOF &&
+		b
+		c
+		dirlinks
+		output
+		submod
+
+		c
+		dirlinks
+		output
+		submod
+	EOF
+	test_cmp expect actual &&
+
+	# The left side contains symlink "c" that points to "b"
+	test_config difftool.cat.cmd "cat \$LOCAL/c" &&
+	git difftool --dir-diff --tool cat >actual &&
+	echo b >expect &&
+	test_cmp expect actual &&
+
+	# The right side contains symlink "c" that points to "d",
+	# which mimics the state of the worktree.
+	test_config difftool.cat.cmd "cat \$REMOTE/c" &&
+	git difftool --dir-diff --tool cat >actual &&
+	echo -n d >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.12.0.266.g44c9eec009

