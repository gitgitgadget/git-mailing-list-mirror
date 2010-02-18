From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 08/10] fetch: learn --progress
Date: Thu, 18 Feb 2010 20:37:09 +0800
Message-ID: <1266496631-3980-9-git-send-email-rctay89@gmail.com>
References: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 13:38:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni5e6-0004Ez-7o
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 13:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758224Ab0BRMiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 07:38:00 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:60410 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758183Ab0BRMh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 07:37:57 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so6323162yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 04:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8Unu7OVpJ9y+5KRKDEvLqAHfQqS5y/2olTaZtJH3c3w=;
        b=HCeUcKXGTPm2rypXxNdF7PhgCWNcAfR3gUUAmelr6vgdytIxAIBCGR5Dk/8mDoMCtV
         BIRtfyh+KmQtG4OtkmJwmlC9SjMSnWeEE7PbsgXs7sD/LOfxvfKvcpC0awjkEiSlsL36
         7+oWWcncOlZq7UIkqPfFMzzwEJh+oZYix7nhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RqsjKjBVe1BKlztqlJIP+DfGe8NmyR8O1TpRM+ZHXkkqzrCdFsGR/n2AlPvwFHIW0s
         IxEVhWDb0RtHLlFYBWKmb8qR0qCl6qhqPu4Nz03BMlq8XwAW8ITQnYrfTp7P4pOglPzc
         uCiQrDBS6qXkQnwruJIMwZ4ZOKlj9462NW1Ss=
Received: by 10.100.24.40 with SMTP id 40mr515373anx.56.1266496677014;
        Thu, 18 Feb 2010 04:37:57 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 21sm381013ywh.17.2010.02.18.04.37.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 04:37:56 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140329>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/fetch-options.txt |    9 ++++++++-
 builtin-fetch.c                 |    4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 83606f4..db1ea25 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -77,8 +77,15 @@ endif::git-pull[]
 -q::
 --quiet::
 	Pass --quiet to git-fetch-pack and silence any other internally
-	used git commands.
+	used git commands. Progress is not reported to the standard error
+	stream.
 
 -v::
 --verbose::
 	Be verbose.
+
+--progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless -q
+	is specified. This flag forces progress status even if the
+	standard error stream is not directed to a terminal.
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 6b96b41..7f9f669 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -27,6 +27,7 @@ enum {
 };
 
 static int all, append, dry_run, force, keep, multiple, prune, update_head_ok, verbosity;
+static int progress;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -56,6 +57,7 @@ static struct option builtin_fetch_options[] = {
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
 	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
 		    "allow updating of HEAD ref"),
+	OPT_BOOLEAN(0, "progress", &progress, "force progress reporting"),
 	OPT_STRING(0, "depth", &depth, "DEPTH",
 		   "deepen history of shallow clone"),
 	OPT_END()
@@ -823,7 +825,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 		die("Where do you want to fetch from today?");
 
 	transport = transport_get(remote, NULL);
-	transport_set_verbosity(transport, verbosity, 0);
+	transport_set_verbosity(transport, verbosity, progress);
 	if (upload_pack)
 		set_option(TRANS_OPT_UPLOADPACK, upload_pack);
 	if (keep)
-- 
1.7.0.27.g5d71b
