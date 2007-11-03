From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-reset: do not call "ls-files --unmerged"
Date: Sat, 3 Nov 2007 14:33:01 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031417440.4362@racer.site>
References: <46E60946.4000803@gmail.com> <7v3axlodw9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 15:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoK4m-0003V5-0Y
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 15:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbXKCOeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 10:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754217AbXKCOd7
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 10:33:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:36093 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754050AbXKCOd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 10:33:59 -0400
Received: (qmail invoked by alias); 03 Nov 2007 14:33:56 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp055) with SMTP; 03 Nov 2007 15:33:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18HiiEwwysHgp4wVpdjFWeVDatdObYK2Q7gszobE9
	Hn8gg37fx9gDYG
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3axlodw9.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63275>


Since reset is a builtin now, it can use the full power of libgit.a
and check for unmerged entries itself.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 11 Sep 2007, Junio C Hamano wrote:

	> Carlos Rica <jasampler@gmail.com> writes:
	> 
	> > +static int unmerged_files(void)
	> > +{
	> > [...]
	> > +}
	> 
	> Not that git-reset is so performance sensitive, but you could do
	> this from built-in without exec, by just reading the index and
	> checking if you have a higher-stage entry yourself.

	Hereby done.

 builtin-reset.c  |   28 ++++++++--------------------
 t/t7102-reset.sh |    9 +++++++++
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 5467e36..79792ee 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -46,26 +46,14 @@ static inline int is_merge(void)
 
 static int unmerged_files(void)
 {
-	char b;
-	ssize_t len;
-	struct child_process cmd;
-	const char *argv_ls_files[] = {"ls-files", "--unmerged", NULL};
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.argv = argv_ls_files;
-	cmd.git_cmd = 1;
-	cmd.out = -1;
-
-	if (start_command(&cmd))
-		die("Could not run sub-command: git ls-files");
-
-	len = xread(cmd.out, &b, 1);
-	if (len < 0)
-		die("Could not read output from git ls-files: %s",
-						strerror(errno));
-	finish_command(&cmd);
-
-	return len;
+	int i;
+	read_cache();
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (ce_stage(ce))
+			return 1;
+	}
+	return 0;
 }
 
 static int reset_index_file(const unsigned char *sha1, int is_hard_reset)
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index cea9afb..506767d 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -59,6 +59,15 @@ test_expect_success 'giving a non existing revision should fail' '
 	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
 '
 
+test_expect_success 'reset --soft with unmerged index should fail' '
+	touch .git/MERGE_HEAD &&
+	echo "100644 44c5b5884550c17758737edcced463447b91d42b 1	un" |
+		git update-index --index-info &&
+	! git reset --soft HEAD &&
+	rm .git/MERGE_HEAD &&
+	git rm --cached -- un
+'
+
 test_expect_success \
 	'giving paths with options different than --mixed should fail' '
 	! git reset --soft -- first &&
-- 
1.5.3.5.1506.g83995
