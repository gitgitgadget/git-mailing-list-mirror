From: Harry Jeffery <harry@exec64.co.uk>
Subject: [PATCH 1/2] log-tree: make format_decorations more flexible
Date: Wed, 10 Sep 2014 22:58:48 +0100
Message-ID: <5410C998.5060701@exec64.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 23:58:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRpuY-0000lW-5T
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 23:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbaIJV6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 17:58:32 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:49231 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbaIJV6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 17:58:31 -0400
Received: by mail-wi0-f177.google.com with SMTP id em10so2922449wid.10
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 14:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=mSwSwL4gbs6u1qrqxx3bFUWqO1D30O3at108plpgpzM=;
        b=KI6Lz529+dhZWV6m/2b65+E8LuqNlokZrOhCFbWIZhom4cRYCeaM7hnMASJWFkQcvf
         bGLWaiH0UsJmGu/QyaF4l8myP6bEvDUw8WJonq8MzfjwqCN+SnKYBKtj0w7d9lHQxtz1
         nsl2sYg6eBDNMe5n0WL7CFENDkcahU2utDB/VQ/5hTL5szWldBGqIO2RlWx21zR7/oaU
         ii+5n73P32fsA0rEyNGInVMQYal8iTimM2+dnyZix77fRReArB2tXXJZ9hOFjvSsgOyM
         7oz0uoyJRc77DFVPBb1dOvyno8ymbmLnXLGPLxhK12xBLWOBjkEvLT/YYDWPWKNDXMAn
         CwhQ==
X-Gm-Message-State: ALoCoQldjIfEnWvhGOA0NMcpKBJEraHN3QfiAa0uuTMgGToEsESxml/ZLHzSn14RwnmED13bHp1g
X-Received: by 10.180.20.196 with SMTP id p4mr39499740wie.56.1410386309398;
        Wed, 10 Sep 2014 14:58:29 -0700 (PDT)
Received: from [192.168.0.14] (cpc69047-oxfd25-2-0-cust267.4-3.cable.virginm.net. [81.109.93.12])
        by mx.google.com with ESMTPSA id fy4sm3852138wib.22.2014.09.10.14.58.28
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 14:58:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256771>

The prefix, separator and suffix for decorations are hard-coded. Make
format_decorations more flexible by having the caller specify the
prefix, separator and suffix.

Signed-off-by: Harry Jeffery <harry@exec64.co.uk>
---
  log-tree.c | 16 +++++++++-------
  log-tree.h |  2 +-
  pretty.c   |  2 +-
  3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 95e9b1d..860694c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -184,9 +184,11 @@ static void show_children(struct rev_info *opt, 
struct commit *commit, int abbre
   */
  void format_decorations(struct strbuf *sb,
  			const struct commit *commit,
-			int use_color)
+			int use_color,
+			const char* prefix,
+			const char* sep,
+			const char* suffix)
  {
-	const char *prefix;
  	struct name_decoration *decoration;
  	const char *color_commit =
  		diff_get_color(use_color, DIFF_COMMIT);
@@ -196,20 +198,20 @@ void format_decorations(struct strbuf *sb,
  	decoration = lookup_decoration(&name_decoration, &commit->object);
  	if (!decoration)
  		return;
-	prefix = " (";
+	strbuf_addstr(sb, prefix);
  	while (decoration) {
  		strbuf_addstr(sb, color_commit);
-		strbuf_addstr(sb, prefix);
  		strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
  		if (decoration->type == DECORATION_REF_TAG)
  			strbuf_addstr(sb, "tag: ");
  		strbuf_addstr(sb, decoration->name);
+		if(decoration->next)
+			strbuf_addstr(sb, sep);
  		strbuf_addstr(sb, color_reset);
-		prefix = ", ";
  		decoration = decoration->next;
  	}
  	strbuf_addstr(sb, color_commit);
-	strbuf_addch(sb, ')');
+	strbuf_addstr(sb, suffix);
  	strbuf_addstr(sb, color_reset);
  }

@@ -221,7 +223,7 @@ void show_decorations(struct rev_info *opt, struct 
commit *commit)
  		printf("\t%s", (char *) commit->util);
  	if (!opt->show_decorations)
  		return;
-	format_decorations(&sb, commit, opt->diffopt.use_color);
+	format_decorations(&sb, commit, opt->diffopt.use_color, " (", ", ", ")");
  	fputs(sb.buf, stdout);
  	strbuf_release(&sb);
  }
diff --git a/log-tree.h b/log-tree.h
index d6ecd4d..4816911 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -13,7 +13,7 @@ int log_tree_diff_flush(struct rev_info *);
  int log_tree_commit(struct rev_info *, struct commit *);
  int log_tree_opt_parse(struct rev_info *, const char **, int);
  void show_log(struct rev_info *opt);
-void format_decorations(struct strbuf *sb, const struct commit *commit, 
int use_color);
+void format_decorations(struct strbuf *sb, const struct commit *commit, 
int use_color, const char* prefix, const char* sep, const char* suffix);
  void show_decorations(struct rev_info *opt, struct commit *commit);
  void log_write_email_headers(struct rev_info *opt, struct commit *commit,
  			     const char **subject_p,
diff --git a/pretty.c b/pretty.c
index 44b9f64..e4dc093 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1195,7 +1195,7 @@ static size_t format_commit_one(struct strbuf *sb, 
/* in UTF-8 */
  		return 1;
  	case 'd':
  		load_ref_decorations(DECORATE_SHORT_REFS);
-		format_decorations(sb, commit, c->auto_color);
+		format_decorations(sb, commit, c->auto_color, " (", ", ", ")");
  		return 1;
  	case 'g':		/* reflog info */
  		switch(placeholder[1]) {
-- 
2.1.0
