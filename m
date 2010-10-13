From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 3/3] push: pass --progress down to git-pack-objects
Date: Thu, 14 Oct 2010 03:31:51 +0800
Message-ID: <1286998311-5112-4-git-send-email-rctay89@gmail.com>
References: <1286998311-5112-1-git-send-email-rctay89@gmail.com>
 <1286998311-5112-2-git-send-email-rctay89@gmail.com>
 <1286998311-5112-3-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 21:32:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P673q-0006Qs-Bp
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 21:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab0JMTcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 15:32:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47692 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476Ab0JMTcF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 15:32:05 -0400
Received: by mail-iw0-f174.google.com with SMTP id 9so165884iwn.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SXXPbluVJCim2VaSfjiPkmw2WH3KQZQLqRGlBxQ/Mn8=;
        b=lGhaMgfmN85mV0RXL9Yr0KVahKd4cE6OHFYp1pL/L0BUggQTIyKBGVhg97WdCGRxP2
         ZnDgpFgSARMfzN5K+63kyhdq0gm+zgG4WJIQ750Byj1m+nFxDFGF9s+B3jv65xvWkEzq
         UHEk9Oa6ZfuOD0ktqKOCI8Itbho9MhSGbFyaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fkALvLaGJvSV+LRmZ+KBRwMtan07rsfSDRqlMDFUHmKrJ5mvu7Bn5RzeAmRUnpQ/S/
         1ydtYIJMeW2v4fgqkPbZqqyrPqer4DJT1yjOHfzqUAnnSJjMYIZHktU+K/k1vQrY1dBt
         DGSbFSrvxtOFUmG8rxKcWjykRXAOWR7eBM4uk=
Received: by 10.231.191.74 with SMTP id dl10mr7473533ibb.157.1286998324364;
        Wed, 13 Oct 2010 12:32:04 -0700 (PDT)
Received: from localhost.localdomain (cm147.zeta152.maxonline.com.sg [116.87.152.147])
        by mx.google.com with ESMTPS id 8sm3050710iba.16.2010.10.13.12.32.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 12:32:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1286998311-5112-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158967>

From: Jeff King <peff@peff.net>

When pushing via builtin transports (like file://, git://), the
underlying transport helper (in this case, git-pack-objects) did not get
the --progress option, even if it was passed to git push.

Fix this, and update the tests to reflect this.

Note that according to the git-pack-objects documentation, we can safely
apply the usual --progress semantics for the transport commands like
clone and fetch (and for pushing over other smart transports).

Reported-by: Chase Brammer <cbrammer@gmail.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/send-pack.c      |    3 +++
 send-pack.h              |    1 +
 t/t5523-push-upstream.sh |    4 ++--
 transport.c              |    1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 481602d..efd9be6 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -48,6 +48,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		NULL,
 		NULL,
 		NULL,
+		NULL,
 	};
 	struct child_process po;
 	int i;
@@ -59,6 +60,8 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		argv[i++] = "--delta-base-offset";
 	if (args->quiet)
 		argv[i++] = "-q";
+	if (args->progress)
+		argv[i++] = "--progress";
 	memset(&po, 0, sizeof(po));
 	po.argv = argv;
 	po.in = -1;
diff --git a/send-pack.h b/send-pack.h
index 60b4ba6..05d7ab1 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -5,6 +5,7 @@ struct send_pack_args {
 	unsigned verbose:1,
 		quiet:1,
 		porcelain:1,
+		progress:1,
 		send_mirror:1,
 		force_update:1,
 		use_thin_pack:1,
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 554f55e..113626b 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -72,7 +72,7 @@ test_expect_success 'push -u HEAD' '
 	check_config headbranch upstream refs/heads/headbranch
 '
 
-test_expect_failure 'progress messages to non-tty' '
+test_expect_success 'progress messages to non-tty' '
 	ensure_fresh_upstream &&
 
 	# skip progress messages, since stderr is non-tty
@@ -80,7 +80,7 @@ test_expect_failure 'progress messages to non-tty' '
 	! grep "Writing objects" err
 '
 
-test_expect_failure 'progress messages to non-tty (forced)' '
+test_expect_success 'progress messages to non-tty (forced)' '
 	ensure_fresh_upstream &&
 
 	# force progress messages to stderr, even though it is non-tty
diff --git a/transport.c b/transport.c
index 4dba6f8..0078660 100644
--- a/transport.c
+++ b/transport.c
@@ -789,6 +789,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.use_thin_pack = data->options.thin;
 	args.verbose = (transport->verbose > 0);
 	args.quiet = (transport->verbose < 0);
+	args.progress = transport->progress;
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 
-- 
1.7.2.2.513.ge1ef3
