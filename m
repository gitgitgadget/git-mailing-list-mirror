From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git-remote: reject adding remotes with invalid names
Date: Sun, 13 Apr 2008 11:56:54 +0200
Message-ID: <20080413095654.GA26713@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 11:57:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkyxz-0004vk-OB
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 11:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbYDMJ46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 05:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753750AbYDMJ46
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 05:56:58 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:54717 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664AbYDMJ45 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 05:56:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 48BDA52C384;
	Sun, 13 Apr 2008 11:56:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cS218QeQa7Up; Sun, 13 Apr 2008 11:56:54 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id C93A052C373;
	Sun, 13 Apr 2008 11:56:54 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id E5F186DFAFC; Sun, 13 Apr 2008 11:55:22 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id B3E3B1DC9C8; Sun, 13 Apr 2008 11:56:54 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79402>

This can happen if the arguments to git-remote add is switched by the
user, and git would only show an error if fetching was also requested.
Fix it by using the refspec parsing engine to check if the requested
name can be parsed as a remote before add it.

Also cleanup so that the "remote.<name>.url" config name buffer is only
initialized once.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 This happened for me the other day, and with the recent discussion
 about the usability of remote it might be an acceptible improvement.

 builtin-remote.c  |   10 +++++++---
 remote.c          |   21 ++++++++++++++++++---
 remote.h          |    1 +
 t/t5505-remote.sh |    6 ++++++
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 06d33e5..a3ee1ac 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -90,18 +90,22 @@ static int add(int argc, const char **argv)
 	strbuf_init(&buf, 0);
 	strbuf_init(&buf2, 0);
 
+	strbuf_addf(&buf2, "refs/heads/test:refs/remotes/%s/test", name);
+	if (!valid_fetch_refspec(buf2.buf))
+		die("'%s' is not a valid remote name", name);
+
 	strbuf_addf(&buf, "remote.%s.url", name);
 	if (git_config_set(buf.buf, url))
 		return 1;
 
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "remote.%s.fetch", name);
+
 	if (track.nr == 0)
 		path_list_append("*", &track);
 	for (i = 0; i < track.nr; i++) {
 		struct path_list_item *item = track.items + i;
 
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "remote.%s.fetch", name);
-
 		strbuf_reset(&buf2);
 		if (mirror)
 			strbuf_addf(&buf2, "refs/%s:refs/%s",
diff --git a/remote.c b/remote.c
index 369dc33..06ad156 100644
--- a/remote.c
+++ b/remote.c
@@ -409,7 +409,7 @@ static void read_config(void)
 	alias_all_urls();
 }
 
-static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch)
+static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
 {
 	int i;
 	int st;
@@ -519,17 +519,32 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 	return rs;
 
  invalid:
+	if (verify) {
+		free(rs);
+		return NULL;
+	}
 	die("Invalid refspec '%s'", refspec[i]);
 }
 
+int valid_fetch_refspec(const char *fetch_refspec_str)
+{
+	const char *fetch_refspec[] = { fetch_refspec_str };
+	struct refspec *refspec;
+
+	refspec = parse_refspec_internal(1, fetch_refspec, 1, 1);
+	if (refspec)
+		free(refspec);
+	return !!refspec;
+}
+
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec)
 {
-	return parse_refspec_internal(nr_refspec, refspec, 1);
+	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
 }
 
 struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
 {
-	return parse_refspec_internal(nr_refspec, refspec, 0);
+	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
 }
 
 static int valid_remote_nick(const char *name)
diff --git a/remote.h b/remote.h
index 7e9ae79..a38774b 100644
--- a/remote.h
+++ b/remote.h
@@ -67,6 +67,7 @@ void free_refs(struct ref *ref);
  */
 void ref_remove_duplicates(struct ref *ref_map);
 
+int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
 struct refspec *parse_push_refspec(int nr_refspec, const char **refspec);
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 0a7fea8..af2d077 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -253,4 +253,10 @@ test_expect_success '"remote show" does not show symbolic refs' '
 
 '
 
+test_expect_success 'reject adding remote with an invalid name' '
+
+	! git remote add some:url desired-name
+
+'
+
 test_done
-- 
1.5.5.104.ge4331.dirty

-- 
Jonas Fonseca
