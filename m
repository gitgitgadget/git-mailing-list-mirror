From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH] builtin/send-pack.c: Respect http.signingkey
Date: Tue, 21 Jul 2015 15:06:43 -0700
Message-ID: <1437516403-13622-1-git-send-email-dborowitz@google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 00:07:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHfh6-0004hm-FF
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 00:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932995AbbGUWHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 18:07:17 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33682 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932592AbbGUWHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 18:07:16 -0400
Received: by pdbnt7 with SMTP id nt7so56251019pdb.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=uEbnxOcCgSKzoyUjCNRRlL7v6LyXz6RToGGeX5wipfQ=;
        b=jmLc8j2MZmCtfxcH/l4x0KzP0reE14oeX2uInZR4SzzOkAjc4inJG9GLUN63Zhcbtl
         JwVDCpy0GbupRldKMw0z3Uu5vy5N+hTr7hiySXu11EywCUJ2NeUt3GYmKk3vNlOw3/MW
         sVpnb/Wb/wMo4rAB5JXmUcQfv1vYwYLpRzlmiPs32J7PffIo+VJgqoFnByx/SwLYdAdw
         JIoSiSAGRNkNB8Jgde2l4bNihzeStcOmBPCPBjewWteRNFB7BWP59b2hnddp8+pVOvRx
         d2Yu0GEPmNssbZodM+0ZZX99EP/RSZ7gxo46QnB3MLPMako0wbBWCqL7Hj3U6YCwx37q
         jelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uEbnxOcCgSKzoyUjCNRRlL7v6LyXz6RToGGeX5wipfQ=;
        b=XbmipwbgqmKgt2c/pLIYP+4iRwNCau+tn1QPcAYS2FmXCSXVdz8EFuPtE3KmKmuJwa
         I7PWrJjMXz8bLnjdYxCs/EalEDUv4GL2Aq+iLNye/7GTg+nFj+PhVQ8BGJy5oGT7Jiiu
         GGF2ibUeLheybRLwDc3uHvkeQsFkCTTQgGL8DKT4O9K6Mt4ZfEm0s6Zjt1kznbCs8lFv
         EPriAG68iLWdxXtpSX5U4o6w0o73YKgxdvjk0MUPFjyH7f/dAl+Ppr5iQFY5m19gXH8N
         9WicsBQ43JCh6WgdyOnng/ANpVQ8J+4fL9OtaNqnTkq82HSPUAsEgt+BBQJ3buT4kcX2
         LJqA==
X-Gm-Message-State: ALoCoQmO+Y7Bo61TfVuWK2lqP7rYzX1T6YuMpqPK1JVEH13joGGFP4criFq4rjlgqjMX5fXdr35K
X-Received: by 10.70.59.41 with SMTP id w9mr76705527pdq.5.1437516435438;
        Tue, 21 Jul 2015 15:07:15 -0700 (PDT)
Received: from serval.mtv.corp.google.com ([172.27.69.27])
        by smtp.gmail.com with ESMTPSA id b3sm29275989pdg.67.2015.07.21.15.07.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jul 2015 15:07:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.573.g4eafbef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274429>

From: Junio C Hamano <gitster@pobox.com>

Prior to this patch, when git-send-pack was exec'ed, as is done by
git-remote-http, it did not reread the config, so it did not respect
the configured value of http.signingkey. Thus it was impossible to
specify a signing key over HTTP, other than the default key in the
keyring having a User ID matching the "Name <email>" format.

This patch at least partially fixes the problem by reading in the GPG
config from within send-pack. It does not address the related problem
of plumbing a value for this configuration option using
`git -c http.signingkey push ...`.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 builtin/send-pack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index b961e5a..23b2962 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -11,6 +11,7 @@
 #include "transport.h"
 #include "version.h"
 #include "sha1-array.h"
+#include "gpg-interface.h"
 
 static const char send_pack_usage[] =
 "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic] [<host>:]<directory> [<ref>...]\n"
@@ -113,6 +114,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int from_stdin = 0;
 	struct push_cas_option cas = {0};
 
+	git_config(git_gpg_config, NULL);
+
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
 		const char *arg = *argv;
-- 
2.4.3.573.g4eafbef
