From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/4] check stderr with isatty() instead of stdout when deciding to show progress
Date: Sat, 26 Dec 2009 01:12:03 +0800
Message-ID: <1261761126-5784-2-git-send-email-rctay89@gmail.com>
References: <1261761126-5784-1-git-send-email-rctay89@gmail.com>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 25 18:12:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NODid-0002ZR-Aw
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 18:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429AbZLYRM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 12:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756389AbZLYRM2
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 12:12:28 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:34685 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388AbZLYRMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 12:12:25 -0500
Received: by mail-yw0-f176.google.com with SMTP id 6so9018585ywh.4
        for <git@vger.kernel.org>; Fri, 25 Dec 2009 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cs+wvTuNo0OGK0WFUp1OPAwYIDzvZ1ObeXpUybMZPDw=;
        b=jDq8LBU+v/T+ezr3D72PF6RFN3dHaWnr3eFyPoOzi4kO3mlJ9XvuedbMoLT7xWpUXD
         G1Zffz0dyOzCndkn3Wsai7gl+JUCgW3qvaMllxYmB3TJf3ZYo5eEQornLTkN/C4AAWvk
         hg344fkNzpEXcuX33GPTcIe1cmATsP8uv5mMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=acZdCrZc688L0pGgFhBcQ9TUOF1ZjTVf15MIOLKhmjWxl3RZIuqRshGxBPzyRj4WAZ
         3hFFHW3AokHnyUw3ELRoiyOa7GpK71zaFUr7fSd2G0itmOmRTahgjk9DQIXubjtGhINz
         qC2DCjTXrY9bgdI7EexGQPAZO5AfG+0HTICWM=
Received: by 10.91.161.31 with SMTP id n31mr4264536ago.96.1261761145406;
        Fri, 25 Dec 2009 09:12:25 -0800 (PST)
Received: from localhost.localdomain (cm133.zeta152.maxonline.com.sg [116.87.152.133])
        by mx.google.com with ESMTPS id 14sm4629570gxk.2.2009.12.25.09.12.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Dec 2009 09:12:25 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1261761126-5784-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135677>

Make transport code (viz. transport.c::fetch_refs_via_pack() and
transport-helper.c::standard_options()) that decides to show progress
check if stderr is a terminal, instead of stdout. After all, progress
reports (via the API in progress.[ch]) are sent to stderr.

Update the documentation for git-clone to say "standard error" as well.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/git-clone.txt |    2 +-
 transport-helper.c          |    2 +-
 transport.c                 |    2 +-
 transport.h                 |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 7ccd742..f298fdd 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -101,7 +101,7 @@ objects from the source repository into a pack in the cloned repository.
 
 --verbose::
 -v::
-	Display the progress bar, even in case the standard output is not
+	Display the progress bar, even in case the standard error is not
 	a terminal.
 
 --no-checkout::
diff --git a/transport-helper.c b/transport-helper.c
index 11f3d7e..b886985 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -169,7 +169,7 @@ static void standard_options(struct transport *t)
 	char buf[16];
 	int n;
 	int v = t->verbose;
-	int no_progress = v < 0 || (!t->progress && !isatty(1));
+	int no_progress = v < 0 || (!t->progress && !isatty(2));
 
 	set_helper_option(t, "progress", !no_progress ? "true" : "false");
 
diff --git a/transport.c b/transport.c
index 3eea836..24c7f1d 100644
--- a/transport.c
+++ b/transport.c
@@ -476,7 +476,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.include_tag = data->followtags;
 	args.verbose = (transport->verbose > 0);
 	args.quiet = (transport->verbose < 0);
-	args.no_progress = args.quiet || (!transport->progress && !isatty(1));
+	args.no_progress = args.quiet || (!transport->progress && !isatty(2));
 	args.depth = data->depth;
 
 	for (i = 0; i < nr_heads; i++)
diff --git a/transport.h b/transport.h
index 9e74406..68fda6a 100644
--- a/transport.h
+++ b/transport.h
@@ -63,7 +63,7 @@ struct transport {
 	int (*disconnect)(struct transport *connection);
 	char *pack_lockfile;
 	signed verbose : 3;
-	/* Force progress even if the output is not a tty */
+	/* Force progress even if stderr is not a tty */
 	unsigned progress : 1;
 };
 
-- 
1.6.6.278.g3f5f
