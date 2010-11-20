From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/15] vcs-svn: Split off function for handling of individual
 properties
Date: Fri, 19 Nov 2010 18:54:20 -0600
Message-ID: <20101120005420.GN17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:55:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbjZ-0003U9-1X
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987Ab0KTAzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:55:11 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56280 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755795Ab0KTAzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:55:09 -0500
Received: by mail-yx0-f174.google.com with SMTP id 34so3101826yxf.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2lCOn4e2PtgLOiEHhj0qqBTIXVNCJegvYnFMdwBsrD4=;
        b=buBoZjns6v6L0/eX7tUpEsWOlR21oKSxOmmwfS4yVFyPN+aKeAO8uoUBuliKT9+EgL
         z9cdo9X9++SpIDhuaqFx7cw2/hlsXCyv8dsvdCrgoUCITkJ1O4ID6Km45MO6wgYGv5mv
         VusEyO0UxkmfrrpSQ+AOeFfES4cV+AImdaUnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gP30BDAQiSJs9ioOFwY8xIRxGC/Ra/TAnSaxyuGSPOc3m7cBSAIAwPnYcriGC+1MOr
         fL+HRuhadIbnvJlmYYDcjLY2FHgauloEkIEPJEvJeS5jwCG4bo4o74HP1ylMaE8GieKI
         HcRJRdjdUafQwONHt7QIJyOPLjQ+cnAQGTTW4=
Received: by 10.151.109.15 with SMTP id l15mr4624478ybm.339.1290214508417;
        Fri, 19 Nov 2010 16:55:08 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v6sm1443571yhg.33.2010.11.19.16.55.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:55:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161813>

The handle_property function is the part of read_props that would be
interesting for most people: semantics of properties rather than the
algorithm for parsing them.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndump.c |   33 +++++++++++++++++++--------------
 1 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 5de32e1..3acc36c 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -30,7 +30,7 @@
 /* Create memory pool for log messages */
 obj_pool_gen(log, char, 4096)
 
-static char* log_copy(uint32_t length, char *log)
+static char *log_copy(uint32_t length, const char *log)
 {
 	char *buffer;
 	log_free(log_pool.size);
@@ -115,6 +115,23 @@ static void init_keys(void)
 	keys.prop_delta = pool_intern("Prop-delta");
 }
 
+static void handle_property(uint32_t key, const char *val, uint32_t len)
+{
+	if (key == keys.svn_log) {
+		/* Value length excludes terminating nul. */
+		rev_ctx.log = log_copy(len + 1, val);
+	} else if (key == keys.svn_author) {
+		rev_ctx.author = pool_intern(val);
+	} else if (key == keys.svn_date) {
+		if (parse_date_basic(val, &rev_ctx.timestamp, NULL))
+			fprintf(stderr, "Invalid timestamp: %s\n", val);
+	} else if (key == keys.svn_executable) {
+		node_ctx.type = REPO_MODE_EXE;
+	} else if (key == keys.svn_special) {
+		node_ctx.type = REPO_MODE_LNK;
+	}
+}
+
 static void read_props(void)
 {
 	uint32_t len;
@@ -129,19 +146,7 @@ static void read_props(void)
 		} else if (!strncmp(t, "V ", 2)) {
 			len = atoi(&t[2]);
 			val = buffer_read_string(len);
-			if (key == keys.svn_log) {
-				/* Value length excludes terminating nul. */
-				rev_ctx.log = log_copy(len + 1, val);
-			} else if (key == keys.svn_author) {
-				rev_ctx.author = pool_intern(val);
-			} else if (key == keys.svn_date) {
-				if (parse_date_basic(val, &rev_ctx.timestamp, NULL))
-					fprintf(stderr, "Invalid timestamp: %s\n", val);
-			} else if (key == keys.svn_executable) {
-				node_ctx.type = REPO_MODE_EXE;
-			} else if (key == keys.svn_special) {
-				node_ctx.type = REPO_MODE_LNK;
-			}
+			handle_property(key, val, len);
 			key = ~0;
 			buffer_read_line();
 		}
-- 
1.7.2.3
