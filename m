From: Adam Brewster <adambrewster@gmail.com>
Subject: [PATCH] Move read_revisions_from_stdin from builtin-rev-list.c to revision.c
Date: Sat,  5 Jul 2008 17:26:39 -0400
Message-ID: <1215293200-28199-2-git-send-email-adambrewster@gmail.com>
References: <20080705204849.GJ4729@genesis.frugalware.org>
 <1215293200-28199-1-git-send-email-adambrewster@gmail.com>
Cc: gitster@pobox.com, mdl123@verizon.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, adambrewster@gmail.com, vmiklos@frugalware.org,
	Adam Brewster <asb@bu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 23:27:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFFIN-00028d-Aa
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 23:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbYGEV0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 17:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbYGEV0s
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 17:26:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:50261 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbYGEV0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 17:26:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so739846ywe.1
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 14:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=puvXK4ZEZueuzllp5wrG4cc/5xxJ+cz3ktCnhoBL9cI=;
        b=OS39halZoDwX9RazK4YTmVbCuHFUcgW8Sr022XV3wZlvQkMEjEIn1yf0zbr6pNlePd
         pyhBs0vDzPThmo3htfeQSVUG+zzEd9xzxYr8z/4qxR5mxd+Q2bAR5yQEh4KMLurR3Uu7
         4qKXehTheSkBgjn99o728+PnkDEKYPrcjOPvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HTI51Jf31MmKBAJTQqQ8m9vYOfSyFPgBpack0MwJrzVMRA3DvVrajYpFsBBOGh6Xzs
         kqgd3DscGDinECtHKGi/WD2ogWh2IhqHvpb2PRgo9Vh43STwQz7IWsMmjd7A+r+7sJm2
         Wx2UDekKwcIcHZbUXHAZTswxv/7OwMdgAbAPE=
Received: by 10.150.58.5 with SMTP id g5mr4767197yba.90.1215293204882;
        Sat, 05 Jul 2008 14:26:44 -0700 (PDT)
Received: from MBE.internal ( [65.96.168.20])
        by mx.google.com with ESMTPS id 4sm2795691yxd.2.2008.07.05.14.26.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jul 2008 14:26:42 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id CE74E10494F; Sat,  5 Jul 2008 17:26:40 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
In-Reply-To: <1215293200-28199-1-git-send-email-adambrewster@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87469>

Some other commands might like to support the --stdin option like
git-rev-list.  Since they don't want to depend on builtin-rev-list, the
function has to be somewhere else.

Signed-off-by: Adam Brewster <asb@bu.edu>
---
 builtin-rev-list.c |   17 -----------------
 revision.c         |   17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 11a7eae..b4a2c44 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -575,23 +575,6 @@ static struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
-static void read_revisions_from_stdin(struct rev_info *revs)
-{
-	char line[1000];
-
-	while (fgets(line, sizeof(line), stdin) != NULL) {
-		int len = strlen(line);
-		if (len && line[len - 1] == '\n')
-			line[--len] = 0;
-		if (!len)
-			break;
-		if (line[0] == '-')
-			die("options not supported in --stdin mode");
-		if (handle_revision_arg(line, revs, 0, 1))
-			die("bad revision '%s'", line);
-	}
-}
-
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
diff --git a/revision.c b/revision.c
index 5a1a948..0191160 100644
--- a/revision.c
+++ b/revision.c
@@ -911,6 +911,23 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	return 0;
 }
 
+void read_revisions_from_stdin(struct rev_info *revs)
+{
+	char line[1000];
+
+	while (fgets(line, sizeof(line), stdin) != NULL) {
+		int len = strlen(line);
+		if (len && line[len - 1] == '\n')
+			line[--len] = '\0';
+		if (!len)
+			break;
+		if (line[0] == '-')
+			die("options not supported in --stdin mode");
+		if (handle_revision_arg(line, revs, 0, 1))
+			die("bad revision '%s'", line);
+	}
+}
+
 static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
 {
 	if (!revs->grep_filter) {
-- 
1.5.5.1.211.g65ea3.dirty
