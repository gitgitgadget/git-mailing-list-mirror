From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 07/10] push: learn --progress
Date: Thu, 18 Feb 2010 20:37:08 +0800
Message-ID: <1266496631-3980-8-git-send-email-rctay89@gmail.com>
References: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 13:38:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni5e5-0004Ez-LK
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 13:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758218Ab0BRMh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 07:37:56 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:60410 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758183Ab0BRMhy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 07:37:54 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so6323162yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 04:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OsrBu6ZkNCIC1qdwJZ+VYV3pEwLhXvH8ft3cw+SRIfA=;
        b=HJY0pkwO53PMS3k4auyNRdOW+QwJ+y2qK8SXvQjjaMuLLfO5t3FzXCUKgtYW8ewlks
         6nxV5X1WlQT8YmdbxGoD6+RMaCaUX1mcG8anWqAPL7cZKVEMQ0T95ApQo4jX3j5/DjvM
         G2nPNaYfyDKAGzXLJHyw3BqJCBWMfyQooNSUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dJuJcCHYOwa7lhd9eKchaBIHsIHvK/ZlJe1TDAKdw9HpUMTjqWhqrrR0ozbN5evQYh
         pLry4U97499Bpl9QNKkvvTnDqI6b65Owk52G+TSzfMrfSnHgyqjjS413LhlLAIxdZvOP
         IXGEArvC6XbqJe6Mti0EHVub1/xU6L79scrgU=
Received: by 10.101.3.35 with SMTP id f35mr108357ani.55.1266496674192;
        Thu, 18 Feb 2010 04:37:54 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 21sm381013ywh.17.2010.02.18.04.37.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 04:37:53 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140331>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/git-push.txt |    9 ++++++++-
 builtin-push.c             |    4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 22cff99..8d95724 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -148,12 +148,19 @@ useful if you write an alias or script around 'git push'.
 -q::
 --quiet::
 	Suppress all output, including the listing of updated refs,
-	unless an error occurs.
+	unless an error occurs. Progress is not reported to the standard
+	error stream.
 
 -v::
 --verbose::
 	Run verbosely.
 
+--progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless -q
+	is specified. This flag forces progress status even if the
+	standard error stream is not directed to a terminal.
+
 include::urls-remotes.txt[]
 
 OUTPUT
diff --git a/builtin-push.c b/builtin-push.c
index dce3152..ba9fe49 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -18,6 +18,7 @@ static int thin;
 static int deleterefs;
 static const char *receivepack;
 static int verbosity;
+static int progress;
 
 static const char **refspec;
 static int refspec_nr;
@@ -107,7 +108,7 @@ static int push_with_options(struct transport *transport, int flags)
 	int err;
 	int nonfastforward;
 
-	transport_set_verbosity(transport, verbosity, 0);
+	transport_set_verbosity(transport, verbosity, progress);
 
 	if (receivepack)
 		transport_set_option(transport,
@@ -223,6 +224,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
 		OPT_BIT('u', "set-upstream", &flags, "set upstream for git pull/status",
 			TRANSPORT_PUSH_SET_UPSTREAM),
+		OPT_BOOLEAN(0, "progress", &progress, "force progress reporting"),
 		OPT_END()
 	};
 
-- 
1.7.0.27.g5d71b
