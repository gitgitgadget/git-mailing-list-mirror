Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2225C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A250A61400
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhD3O4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 10:56:48 -0400
Received: from elephants.elehost.com ([216.66.27.132]:40899 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3O4r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 10:56:47 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 13UEttUk089431
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 10:55:57 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant set.
Date:   Fri, 30 Apr 2021 10:55:56 -0400
Message-ID: <011f01d73dd0$ecf91e00$c6eb5a00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: Adc90KEqOMyQZxLPSF6mxwToAoF6Iw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From ba4beb8ed0dff67ae6b95692d346adce346e2871 Mon Sep 17 00:00:00 2001
From: "Randall S. Becker" <rsbecker@nexbridge.com>
Date: Fri, 30 Apr 2021 09:56:09 -0400
Subject: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant set.

This enhancement allows the NonStop SSH subsystem to be supported by
git without the need of a wrapper script. The command arguments for
the platform SSH client in /G/system/zssh/sshoss are constructed based
on optional supplied environment variables SSH2_PROCESS_NAME (system
defined), SSH_SUPPRESS_QUIET, and SSH_SUPPRESS_BANNER.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 connect.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/connect.c b/connect.c
index 40b5c15f81..34e9c4ac33 100644
--- a/connect.c
+++ b/connect.c
@@ -1091,6 +1091,7 @@ enum ssh_variant {
        VARIANT_PLINK,
        VARIANT_PUTTY,
        VARIANT_TORTOISEPLINK,
+       VARIANT_NONSTOPSSH,
 };

 static void override_ssh_variant(enum ssh_variant *ssh_variant)
@@ -1108,6 +1109,8 @@ static void override_ssh_variant(enum ssh_variant *ssh_variant)
                *ssh_variant = VARIANT_PUTTY;
        else if (!strcmp(variant, "tortoiseplink"))
                *ssh_variant = VARIANT_TORTOISEPLINK;
+       else if (!strcmp(variant, "nonstopssh"))
+               *ssh_variant = VARIANT_NONSTOPSSH;
        else if (!strcmp(variant, "simple"))
                *ssh_variant = VARIANT_SIMPLE;
        else
@@ -1156,6 +1159,8 @@ static enum ssh_variant determine_ssh_variant(const char *ssh_command,
        else if (!strcasecmp(variant, "tortoiseplink") ||
                 !strcasecmp(variant, "tortoiseplink.exe"))
                ssh_variant = VARIANT_TORTOISEPLINK;
+       else if (!strcasecmp(variant, "sshoss"))
+               ssh_variant = VARIANT_NONSTOPSSH;

        free(p);
        return ssh_variant;
@@ -1275,6 +1280,7 @@ static void push_ssh_options(struct strvec *args, struct strvec *env,
                case VARIANT_SIMPLE:
                        die(_("ssh variant 'simple' does not support setting port"));
                case VARIANT_SSH:
+               case VARIANT_NONSTOPSSH:
                        strvec_push(args, "-p");
                        break;
                case VARIANT_PLINK:
@@ -1285,6 +1291,17 @@ static void push_ssh_options(struct strvec *args, struct strvec *env,

                strvec_push(args, port);
        }
+
+       if (variant == VARIANT_NONSTOPSSH) {
+               if (!getenv("SSH_SUPPRESS_BANNER"))
+                       strvec_push(args, "-Z");
+               if (!getenv("SSH_SUPPRESS_QUIET"))
+                       strvec_push(args, "-Q");
+               if (getenv("SSH2_PROCESS_NAME")) {
+                       strvec_push(args, "-S");
+                       strvec_push(args, getenv("SSH2_PROCESS_NAME"));
+               }
+       }
 }

 /* Prepare a child_process for use by Git's SSH-tunneled transport. */
--
2.29.2


