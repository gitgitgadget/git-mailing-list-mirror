From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 20/24] introduce GIT_INDEX_VERSION environment variable
Date: Wed, 27 Nov 2013 13:00:55 +0100
Message-ID: <1385553659-9928-21-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:02:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VldpH-0002E4-II
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409Ab3K0MCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:02:36 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34803 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab3K0MCd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:02:33 -0500
Received: by mail-lb0-f169.google.com with SMTP id y6so5342151lbh.14
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ERTKjTqzUzq4cSpu0qIKsVzyTz0yB6h7zwfX8Mlt6sE=;
        b=P2v4ulfwYHTJiobpbA79Ai1XFGaT4uAUrx9Hl3tUaDGTgw2fZnb10htN0xzuSwXIuG
         zED50USZgMn3ghVwTQPvOUVV0u2kVCIYv1RulNaXr0SAu/7VcSTo7LsJ8eya9wd/6Rv+
         aw+6WCfQY7DAqaY1cvxGyJvLXTaNcDAeVl1uEdh5jGzglC75NBg1W5rFvVjcwRNzyl2R
         nQ3wUMjZVzcBKoFgv39fQs36zZ6SB5BTaDAyn3qFGXMaZ1esmhPL3veOJ/sxJCWPUyu9
         Alu2CJJrSh9zHLNLRRyKx3ezOGH7BN6wGrAXqnxzMlW5GjLgKYq07WQy2Qr/br/1Cl05
         tX4w==
X-Received: by 10.112.189.202 with SMTP id gk10mr22746807lbc.11.1385553752722;
        Wed, 27 Nov 2013 04:02:32 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id np10sm21769659lbb.7.2013.11.27.04.02.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:02:31 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238433>

Respect a GIT_INDEX_VERSION environment variable, when a new index is
initialized.  Setting the environment variable will not cause existing
index files to be converted to another format for additional safety.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git.txt | 5 +++++
 read-cache.c          | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 10cddb5..2b2aad5 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -703,6 +703,11 @@ Git so take care if using Cogito etc.
 	index file. If not specified, the default of `$GIT_DIR/index`
 	is used.
 
+'GIT_INDEX_VERSION'::
+	This environment variable allows the specification of an index
+	version for new repositories.  It won't affect existing index
+	files.  By default index file version 3 is used.
+
 'GIT_OBJECT_DIRECTORY'::
 	If the object storage directory is specified via this
 	environment variable then the sha1 directories are created
diff --git a/read-cache.c b/read-cache.c
index 46551af..04430e5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1233,8 +1233,13 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
 void initialize_index(struct index_state *istate, int version)
 {
 	istate->initialized = 1;
-	if (!version)
-		version = INDEX_FORMAT_DEFAULT;
+	if (!version) {
+		char *envversion = getenv("GIT_INDEX_VERSION");
+		if (!envversion)
+			version = INDEX_FORMAT_DEFAULT;
+		else
+			version = atoi(envversion);
+	}
 	istate->version = version;
 	set_istate_ops(istate);
 }
-- 
1.8.4.2
