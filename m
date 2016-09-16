Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA10C207E6
	for <e@80x24.org>; Fri, 16 Sep 2016 00:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757260AbcIPAMb (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 20:12:31 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34820 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbcIPAM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 20:12:27 -0400
Received: by mail-qk0-f195.google.com with SMTP id w204so4450382qka.2
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 17:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=k+AJFpotPrcddrj4FLRJHFvupE+ZFr3yKixIfs1sVos=;
        b=atKO8u0pdWUUn4M9+LfwFpWU9tv0NBQV3/yxrj9aMz09g1B5XLlbZNEigLGME65pbB
         bZsO5qMlUO3VGlCtVZiYoyHHEfqXPguT0X4/LuNdPWoghUzgh8S2pH9h+UhQYPcAs0I3
         1mXh3QEAgSz+jVLFYs3aJlSuquJv90bSkDSwpLs7wZl/ZBNPkKUfzMJfQLA2sCj2e6hW
         8CAjg06Wz3Kjp94tL0pWVjGyZChAobhkzjJjo2S4dwzPMSpUzHFw4efxnCPALqC1+pa8
         /GEJSHnvLLZAVhzOWNUXExZg5fWAvUMgpATbr06kfgvZeVOdBcJz/JGtBo3ezSVkI2nD
         YNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=k+AJFpotPrcddrj4FLRJHFvupE+ZFr3yKixIfs1sVos=;
        b=J9mhZga5kle3kYanOfK8K53z/E9qh7jNpIF2+nllHWFxZ9awGJkv17It5eMnl0Jfnv
         Z3qIe9vMoa1N8JsQRLxVtii4+OLdzGcsirf5P+m/eha2iY1EJwrlut1QQUHtxiki5bFh
         CzgiQkx+s0P64hVOuCIOjN3/uwJVLJGDsnK1vtaER9jhCRiQSVRyW6tUCPonKD78nBY9
         +qe+N5+Jbt+EyAt1E0ILBbfP4mgoVlfLE2oojHvN0LyAaiKpXWEWRIekerqcQOcVzvFc
         lBNnUiDuwTlzm8kQIZ7u4ooP3oif15Ms9EzF/1VquYzPygksoUf7eKl2VMvxtpxyIFYS
         W2Yg==
X-Gm-Message-State: AE9vXwN4ygajddREQBNlmmyknPRRtLDnm5TlzxuwHhbAPncRehnEYu24TdKdYz1fOxmm1Q==
X-Received: by 10.55.7.129 with SMTP id 123mr12540125qkh.229.1473984745978;
        Thu, 15 Sep 2016 17:12:25 -0700 (PDT)
Received: from localhost.localdomain (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id d27sm3227196qtd.37.2016.09.15.17.12.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 17:12:25 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 02/11] Resumable clone: add prime-clone endpoints
Date:   Thu, 15 Sep 2016 20:12:13 -0400
Message-Id: <1473984742-12516-3-git-send-email-kevin.m.wern@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add logic to serve git-prime-clone to git and http clients.

Do not pass --stateless-rpc and --advertise-refs options to
prime-clone. It is inherently stateless and an 'advertisement'.

Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
---
 Documentation/git-daemon.txt       |  7 +++++++
 Documentation/git-http-backend.txt |  7 +++++++
 daemon.c                           |  7 +++++++
 http-backend.c                     | 22 +++++++++++++++++-----
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index a69b361..853faab 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -231,6 +231,13 @@ receive-pack::
 	enabled by setting `daemon.receivepack` configuration item to
 	`true`.
 
+primeclone::
+	This serves 'git prime-clone' service to clients, allowing
+	'git clone' clients to get the location of a static resource
+	to download and integrate before performing an incremental
+	fetch. It is 'false' by default, but can be enabled by setting
+	it to `true`.
+
 EXAMPLES
 --------
 We assume the following in /etc/services::
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 9268fb6..40be74e 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -54,6 +54,13 @@ http.receivepack::
 	disabled by setting this item to `false`, or enabled for all
 	users, including anonymous users, by setting it to `true`.
 
+http.primeclone::
+	This serves 'git prime-clone' service to clients, allowing
+	'git clone' clients to get the location of a static resource
+	to download and integrate before performing an incremental
+	fetch. It is 'false' by default, but can be enabled by setting
+	it to `true`.
+
 URL TRANSLATION
 ---------------
 To determine the location of the repository on disk, 'git http-backend'
diff --git a/daemon.c b/daemon.c
index 8d45c33..c2f539c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -475,10 +475,17 @@ static int receive_pack(void)
 	return run_service_command(argv);
 }
 
+static int prime_clone(void)
+{
+	static const char *argv[] = { "prime-clone", "--strict", ".", NULL };
+	return run_service_command(argv);
+}
+
 static struct daemon_service daemon_service[] = {
 	{ "upload-archive", "uploadarch", upload_archive, 0, 1 },
 	{ "upload-pack", "uploadpack", upload_pack, 1, 1 },
 	{ "receive-pack", "receivepack", receive_pack, 0, 1 },
+	{ "prime-clone", "primeclone", prime_clone, 0, 1 },
 };
 
 static void enable_service(const char *name, int ena)
diff --git a/http-backend.c b/http-backend.c
index 8870a26..9c89a10 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -27,6 +27,7 @@ struct rpc_service {
 static struct rpc_service rpc_service[] = {
 	{ "upload-pack", "uploadpack", 1, 1 },
 	{ "receive-pack", "receivepack", 0, -1 },
+	{ "prime-clone", "primeclone", 0, -1 },
 };
 
 static struct string_list *get_parameters(void)
@@ -450,11 +451,22 @@ static void get_info_refs(char *arg)
 	hdr_nocache();
 
 	if (service_name) {
-		const char *argv[] = {NULL /* service name */,
-			"--stateless-rpc", "--advertise-refs",
-			".", NULL};
+		struct argv_array argv;
 		struct rpc_service *svc = select_service(service_name);
 
+		argv_array_init(&argv);
+		argv_array_push(&argv, svc->name);
+
+		// prime-clone does not need --stateless-rpc and
+		// --advertise-refs options. Maybe it will in the future, but
+		// until then it seems best to do this instead of adding
+		// "dummy" options.
+		if (strcmp(svc->name, "prime-clone") != 0) {
+			argv_array_pushl(&argv, "--stateless-rpc",
+					 "--advertise-refs", NULL);
+		}
+
+		argv_array_pushl(&argv, ".", NULL);
 		strbuf_addf(&buf, "application/x-git-%s-advertisement",
 			svc->name);
 		hdr_str(content_type, buf.buf);
@@ -463,8 +475,8 @@ static void get_info_refs(char *arg)
 		packet_write(1, "# service=git-%s\n", svc->name);
 		packet_flush(1);
 
-		argv[0] = svc->name;
-		run_service(argv, 0);
+		run_service(argv.argv, 0);
+		argv_array_clear(&argv);
 
 	} else {
 		select_getanyfile();
-- 
2.7.4

