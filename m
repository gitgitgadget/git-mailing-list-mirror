Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79AA42035A
	for <e@80x24.org>; Tue, 11 Jul 2017 23:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756191AbdGKXif (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 19:38:35 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35066 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756185AbdGKXie (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 19:38:34 -0400
Received: by mail-pg0-f52.google.com with SMTP id j186so3485462pge.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 16:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SkP5YViWWNZq/0r2hpNfALY0yRvMVV6V17+ExjFshoA=;
        b=vAE3ee3iZSEUWMwdU2gAMEWZQEqVDOAcwZMY/V4WUaNlY3+zYdYln+1YHmfWKjzuiq
         +WdIuvEkcQjQJJgn33lbuns4iuGlFjfm3yEQdEmR+BlTJB5dcs+njsjBTVGcwA1KuU6x
         8gyXHmxbtemvycEu40K0qW8Y6mFmZ80oShA44KOdz6JL2GxgLrxYXm2Fu8Q8L5peLi6B
         TWj/Cf0Jh1q4tkP6BEb9VKePeLtAhJ3MJJUb/OevTwgd43pM+H5KyrgM3TqM+CnPif6U
         tY7UedHiFN+ONNQcboTBLqxxitRqGLrtBUOqJMUtT44ZGYsN3yxK3RlG9HtWAX3hhHwq
         S7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SkP5YViWWNZq/0r2hpNfALY0yRvMVV6V17+ExjFshoA=;
        b=IJ0zntagxsbX2mmPsq3m8fvGhr/sojr5rKvlwNC705wEtzmSAJiAJa9ITNd85mNDuC
         D6h5xsPxpve1W+EPnbCmgQi7Gg1hT8DVU6V8S3F5Q/HbbeiRAcI1b/QlmM7WwHoPE5MI
         iquZG4P55oPvOP39F5t4B4Ou0EFGdOPwBbSp6c9r1mQVRbB2S58TyaZip8lKlU/k2437
         mjHUSJxA9Mps6AmlXSrYv06Zo5lVQPGeNnCkaXSns6iGmZRuLr6LOew7UHYtKxdQKhOE
         sJZrHxk8AKcrOh8f6LLtlsWaCi9JeqrYB/7KvrxW53kUZhamPZEfNCjb26f546+qo4dA
         jsQQ==
X-Gm-Message-State: AIVw111RZEUkscpAc5mOCcZoOkO5cAjvpNu7w3Tmhyj06yUGM3lL57qj
        ugkF+pc3YisHrZXGsHQqHA==
X-Received: by 10.98.150.16 with SMTP id c16mr48173143pfe.64.1499816313035;
        Tue, 11 Jul 2017 16:38:33 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c5c5:d093:97f5:26db])
        by smtp.gmail.com with ESMTPSA id f70sm802259pfk.27.2017.07.11.16.38.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 16:38:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH] RFC: Introduce '.gitorderfile' 
Date:   Tue, 11 Jul 2017 16:38:27 -0700
Message-Id: <20170711233827.23486-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.2.695.g117ddefdb4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Conceptually the file order as set with command line -O or via the config
'diff.orderFile' is interesting to both the author (when I run a quick git
 diff locally) as well as reviewer (a patch floating on the mailing list),
so it is not just the author who should be responsible for getting their
config in order, but a project would benefit when they could give a good
default for such an order.

While the change in this RFC patch to diff.c may look uncontroversial,
(Oh look! it's just another knob we can turn!), the change to the
newly introduced '.gitorderfile' may be more controversial. Here is my
rationale for proposing it:

  I want to force myself to think about the design before pointing out
  memory leaks and coding style, so the least I would wish for is:
    *.h
    *.c
  but as we have more to look at, I would want to have the most abstract
  thing to come first. And most abstract from the actual code is the
  user interaction, the documentation.  I heard the claim that the git
  project deliberately names the directory 'Documentation/' with a capital
  D such that we had this property by default already. With a patch like
  this we could rename Documentation/ to docs and still enjoy reading the
  docs first.
  Given this alibi, I would claim that t/ is misnamed though! I personally
  would prefer to review tests just after the documentation instead of
  after the code as the tests are more abstract and encode promises to the
  user unlike the code itself that is truth at the end of the day.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I wrote:
> offtopic: As a general thing for our patches, can we configure
> (or even convince Git in general), that headers ought to be sent *before*
> its accompanying source? I think that would help reviewers like me, who
> tend to start reading linearly and then giving random thoughts, because the
> header prepares the reviewer for the source code with expectations. Also
> by having it the other way around, the review first focuses on design
> (Is this function signature sane; the docs said it would do X while not
> doing Y, is that sane?) instead of code.

and hence I came up with this patch, as I think we would want to expose
such a good feature ('diff.orderFile') even for those who are not looking
for it themselves.

Thanks,
Stefan


 .gitorderfile |  6 ++++++
 diff.c        | 11 +++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 .gitorderfile

diff --git a/.gitorderfile b/.gitorderfile
new file mode 100644
index 0000000000..5131ede927
--- /dev/null
+++ b/.gitorderfile
@@ -0,0 +1,6 @@
+Documentation/*
+t/*
+*.sh
+*.h
+*.c
+Makefile
diff --git a/diff.c b/diff.c
index 00b4c86698..8d537db06a 100644
--- a/diff.c
+++ b/diff.c
@@ -3398,6 +3398,17 @@ void diff_setup(struct diff_options *options)
 	if (diff_indent_heuristic)
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 
+	if (!diff_order_file_cfg) {
+		struct stat st;
+		int c = lstat(".gitorderfile", &st);
+		if (c == 0 && S_ISREG(st.st_mode))
+			diff_order_file_cfg = ".gitorderfile";
+		else if (c < 0 && errno == ENOENT)
+			; /* File does not exist. no preset. */
+		else
+			die_errno("stat '.gitorderfile'");
+	}
+
 	options->orderfile = diff_order_file_cfg;
 
 	if (diff_no_prefix) {
-- 
2.13.2.695.g117ddefdb4

