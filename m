From: Junio C Hamano <gitster@pobox.com>
Subject: reflog-expire: Avoid creating new files in a directory inside readdir(3) loop
Date: Fri, 25 Jan 2008 23:53:05 -0800
Message-ID: <7v63xh2fby.fsf_-_@gitster.siamese.dyndns.org>
References: <873asmcodd.fsf@burly.wgtn.ondioline.org>
	<200801251050.16697.chris.mason@oracle.com>
	<alpine.LFD.1.00.0801250905570.14161@hp.linux-foundation.org>
	<7vmyqt657t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Mason <chris.mason@oracle.com>, btrfs-devel@oss.oracle.com,
	Paul Collins <paul@burly.ondioline.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 26 08:53:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIfrL-0004nP-Eh
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 08:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbYAZHxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 02:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbYAZHxV
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 02:53:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbYAZHxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 02:53:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A48E2F17;
	Sat, 26 Jan 2008 02:53:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 52AF22F16;
	Sat, 26 Jan 2008 02:53:12 -0500 (EST)
In-Reply-To: <7vmyqt657t.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 25 Jan 2008 12:05:42 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71765>

"git reflog expire --all" opened a directory in $GIT_DIR/logs/,
read reflog files in there readdir(3), and rewrote the file by
creating a new file and renaming it back inside the loop.  This
code structure can cause the newly created file to be returned
by subsequent call to readdir(3), and fall into an infinite loop
in the worst case.

This separates the processing to two phase.  Running
for_each_reflog() to find out and collect all refs, and then
iterate over them, calling expire_reflog().  This way, the
program would behave exactly the same way as if all the refs
were given by the user from the command line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-reflog.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index ce093ca..e6834dd 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -34,6 +34,16 @@ struct expire_reflog_cb {
 	struct cmd_reflog_expire_cb *cmd;
 };
 
+struct collected_reflog {
+	unsigned char sha1[20];
+	char reflog[FLEX_ARRAY];
+};
+struct collect_reflog_cb {
+	struct collected_reflog **e;
+	int alloc;
+	int nr;
+};
+
 #define INCOMPLETE	(1u<<10)
 #define STUDYING	(1u<<11)
 
@@ -281,6 +291,20 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	return status;
 }
 
+static int collect_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
+{
+	struct collected_reflog *e;
+	struct collect_reflog_cb *cb = cb_data;
+	size_t namelen = strlen(ref);
+
+	e = xmalloc(sizeof(*e) + namelen + 1);
+	hashcpy(e->sha1, sha1);
+	memcpy(e->reflog, ref, namelen + 1);
+	ALLOC_GROW(cb->e, cb->nr + 1, cb->alloc);
+	cb->e[cb->nr++] = e;
+	return 0;
+}
+
 static int reflog_expire_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "gc.reflogexpire"))
@@ -349,8 +373,20 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			putchar('\n');
 	}
 
-	if (do_all)
-		status |= for_each_reflog(expire_reflog, &cb);
+	if (do_all) {
+		struct collect_reflog_cb collected;
+		int i;
+
+		memset(&collected, 0, sizeof(collected));
+		for_each_reflog(collect_reflog, &collected);
+		for (i = 0; i < collected.nr; i++) {
+			struct collected_reflog *e = collected.e[i];
+			status |= expire_reflog(e->reflog, e->sha1, 0, &cb);
+			free(e);
+		}
+		free(collected.e);
+	}
+
 	while (i < argc) {
 		const char *ref = argv[i++];
 		unsigned char sha1[20];
