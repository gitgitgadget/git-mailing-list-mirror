From: Deskin Miller <deskinm@umich.edu>
Subject: [RFC PATCH 4/4] Teach pretty-printer new reflog format codes
Date: Wed, 25 Feb 2009 23:44:07 -0500
Message-ID: <eee1f8e216d3813a1dce153dae58aeda5412c418.1235622145.git.deskinm@umich.edu>
References: <cover.1235622145.git.deskinm@umich.edu>
Cc: trast@student.ethz.ch, Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 05:46:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcY8M-0000kl-U8
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 05:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754514AbZBZEo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 23:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754394AbZBZEo1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 23:44:27 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:17938 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbZBZEoY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 23:44:24 -0500
Received: by an-out-0708.google.com with SMTP id c2so302988anc.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 20:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:in-reply-to
         :references;
        bh=cbGwEAygFDeTrAg68PMBF8m4wOyFC3YHC9jk70zBOSo=;
        b=gNFBCClQO7vAEUOXv41B+3uymjbMxKgSK5R9A/JD1XIWzXokIQh3kHKsC4vT2fNTvG
         0WCGoARsLbhZEztkGftlowZPbr0M9JBYmFHOfZCgFO3oskdCntV9OpdwrA0P+Sprgeiy
         csZwcZ1HymYKcCJZ4gMmOEXF4TpTmbhC77KF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=RvVRxwDJCqOo+tH/Is/fbtX+ww3+569SWlVFMw8DIwzpyFKCvfGzJ5VXc9RNfjG4Aq
         nwPVoxg68ZYArlpFZvwnPW7q7SC543sfgfAVs+mJBSau6VA+vv2WmL9wPHY+EkLuGA2R
         YDFRUr9zsK0NAXPdzNjQ0hF8pN1dAhFQsIXxQ=
Received: by 10.231.10.194 with SMTP id q2mr1389064ibq.0.1235623458985;
        Wed, 25 Feb 2009 20:44:18 -0800 (PST)
Received: from localhost.localdomain (67-194-38-22.wireless.umnet.umich.edu [67.194.38.22])
        by mx.google.com with ESMTPS id s35sm3517319qbs.6.2009.02.25.20.44.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 20:44:18 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.90.g0753
In-Reply-To: <cover.1235622145.git.deskinm@umich.edu>
In-Reply-To: <cover.1235622145.git.deskinm@umich.edu>
References: <cover.1235622145.git.deskinm@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111526>

By using %r<char>, one may obtain information from the reflog when
using --pretty=format in conjunction with git log -g or
git rev-list --walk-reflogs.  The following format codes are supported:

%rp, %rP: abbreviated and full old commit hash
%rm: reflog message
%rn, %re, %rt, %rd, etc: all the formats that work for committer and
author work with the reflog printer as well.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
 pretty.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6cd9149..9303958 100644
--- a/pretty.c
+++ b/pretty.c
@@ -7,6 +7,7 @@
 #include "mailmap.h"
 #include "log-tree.h"
 #include "color.h"
+#include "reflog-walk.h"
 
 static char *user_format;
 
@@ -544,6 +545,40 @@ static void format_decoration(struct strbuf *sb, const struct commit *commit)
 		strbuf_addch(sb, ')');
 }
 
+static size_t format_reflog_item(struct strbuf *sb, void *util, char part,
+				 enum date_mode dmode)
+{
+	struct reflog_info *reflog_info = (struct reflog_info *)util;
+	struct strbuf buf = STRBUF_INIT;
+	ssize_t ret;
+
+	if (!util) {
+		return 0;
+	}
+
+	switch (part) {
+	case 'P':
+		strbuf_addstr(sb, sha1_to_hex(reflog_info->osha1));
+		return 2;
+	case 'p':		/* abbreviated commit hash */
+		strbuf_addstr(sb, find_unique_abbrev(reflog_info->osha1,
+						DEFAULT_ABBREV));
+		return 2;
+	case 'm':
+		/* don't print trailing newline */
+		strbuf_add(sb, reflog_info->message,
+			   strlen(reflog_info->message) - 1);
+		return 2;
+	}
+
+	strbuf_addf(&buf, "%s %lu %+04d", reflog_info->email,
+		reflog_info->timestamp, reflog_info->tz);
+	ret = format_person_part(sb, part, buf.buf, buf.len, dmode);
+	strbuf_release(&buf);
+	return ret;
+
+}
+
 static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
                                void *context)
 {
@@ -650,6 +685,9 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	case 'd':
 		format_decoration(sb, commit);
 		return 1;
+	case 'r':
+		return format_reflog_item(sb, commit->util, placeholder[1],
+					c->dmode);
 	}
 
 	/* For the rest we have to parse the commit header. */
-- 
1.6.2.rc0.90.g0753
