From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 08/10] push: learn --progress
Date: Wed, 24 Feb 2010 20:50:27 +0800
Message-ID: <1267015829-5344-9-git-send-email-rctay89@gmail.com>
References: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@googlemail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:51:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkGi6-0005M5-BC
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 13:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917Ab0BXMvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 07:51:13 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:5349 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756888Ab0BXMvG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 07:51:06 -0500
Received: by qw-out-2122.google.com with SMTP id 8so870409qwh.37
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 04:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HaQlnS3vZjyCqpOvoCR2KtlYE6aUPJo41Cm7BWVrv0g=;
        b=bzJNeo6A13rBpwILYtY3UQR4NEJaeHlqW/DnjuTbDWSrcOW2L2ZQfxs44rm54QFPtT
         coSN/6KX0o+7NuTug1e1geIy2FjF/pY0UYC5iX65x1c72kj34sO+xPJcCGuZY3i5Bjd2
         hVgtLql3+mqVNiFa4bHVHZlWz1XwXhd7fSL+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qEOdskwaQdU8oPM2V0YNcwvjjram3oA073poqaXprYHdaOrbanPXKdIg7ImVqx1w1C
         Vf7/vvLMo4Rh0wihzu4VHkmyGzs14vBQBfbAHxTvCu0g8XuzmuHwr5RBtc93tifrIhdM
         D8NVgfNle9gDdBbnND1T8KFQnncofCD1yNJTw=
Received: by 10.229.219.8 with SMTP id hs8mr160084qcb.25.1267015865703;
        Wed, 24 Feb 2010 04:51:05 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 23sm253680qyk.15.2010.02.24.04.51.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 04:51:05 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140938>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/git-push.txt |    9 ++++++++-
 builtin-push.c             |    4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index ddb78eb..59dc8b1 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -149,12 +149,19 @@ useful if you write an alias or script around 'git push'.
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
1.7.0.20.gcb44ed
