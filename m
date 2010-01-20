From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] rev-parse --namespace
Date: Wed, 20 Jan 2010 08:29:03 +0100
Message-ID: <4B56B0BF.6020102@viscovery.net>
References: <1263798952-27624-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 20 08:44:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXVEf-0002X0-8I
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 08:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756201Ab0ATH3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 02:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756140Ab0ATH3K
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 02:29:10 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:39960 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767Ab0ATH3H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 02:29:07 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NXUzv-00027z-VE; Wed, 20 Jan 2010 08:29:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 989071660F;
	Wed, 20 Jan 2010 08:29:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1263798952-27624-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137522>

I've implemented --remotes=foo on top of your patch because I needed it,
and --namespace=remotes/foo was too much to type. Are you interested in
integrating this in your series in some way?

I only needed the --remotes=foo part; the --branches=foo is only
"because we can". Note that 'foo' is always a complete path component,
because it is the name of a remote (the trailing slash is implied), e.g.,
'--remotes=origin'.

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] revision options --remotes=prefix and --branches=prefix

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin-rev-parse.c |    2 ++
 revision.c          |   23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 34af347..08b0555 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -42,6 +42,7 @@ static int is_rev_argument(const char *arg)
 		"--bisect",
 		"--dense",
 		"--branches",
+		"--branches=",
 		"--header",
 		"--max-age=",
 		"--max-count=",
@@ -52,6 +53,7 @@ static int is_rev_argument(const char *arg)
 		"--parents",
 		"--pretty",
 		"--remotes",
+		"--remotes=",
 		"--namespace=",
 		"--sparse",
 		"--tags",
diff --git a/revision.c b/revision.c
index ec63fa0..68e251b 100644
--- a/revision.c
+++ b/revision.c
@@ -714,6 +714,21 @@ static void handle_refs(struct rev_info *revs, unsigned flags,
 	for_each(handle_one_ref, &cb);
 }

+static void handle_ref_subset(struct rev_info *revs, unsigned flags,
+			      const char *prefix, const char *postfix)
+{
+	struct strbuf name = STRBUF_INIT;
+	struct all_refs_cb cb;
+
+	strbuf_addstr(&name, prefix);
+	strbuf_addstr(&name, postfix);
+	if (name.buf[name.len - 1] != '/')
+		strbuf_addch(&name, '/');
+	init_all_refs_cb(&cb, revs, flags);
+	for_each_ref_in(name.buf, handle_one_ref, &cb);
+	strbuf_release(&name);
+}
+
 static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
@@ -1344,6 +1359,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				handle_refs(revs, flags, for_each_branch_ref);
 				continue;
 			}
+			if (!prefixcmp(arg, "--branches=")) {
+				handle_ref_subset(revs, flags, "refs/heads/", arg + 11);
+				continue;
+			}
 			if (!strcmp(arg, "--bisect")) {
 				handle_refs(revs, flags, for_each_bad_bisect_ref);
 				handle_refs(revs, flags ^ UNINTERESTING, for_each_good_bisect_ref);
@@ -1358,6 +1377,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				handle_refs(revs, flags, for_each_remote_ref);
 				continue;
 			}
+			if (!prefixcmp(arg, "--remotes=")) {
+				handle_ref_subset(revs, flags, "refs/remotes/", arg + 10);
+				continue;
+			}
 			if (!prefixcmp(arg, "--namespace=")) {
 				struct all_refs_cb cb;

-- 
1.6.6.1301.g354d
