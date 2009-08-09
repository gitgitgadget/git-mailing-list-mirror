From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: indicate remote tracking branches in merge
 message
Date: Sun, 09 Aug 2009 00:31:04 -0700
Message-ID: <7vab29a1fr.fsf@alter.siamese.dyndns.org>
References: <20090809065936.GA24112@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 09 09:31:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma2sa-0006k9-W0
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 09:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbZHIHbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 03:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbZHIHbe
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 03:31:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbZHIHbe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 03:31:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 642CB228CA;
	Sun,  9 Aug 2009 03:31:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 30568228C7; Sun,  9 Aug 2009
 03:31:24 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA4D0E34-84B6-11DE-8F84-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125325>

Jeff King <peff@peff.net> writes:

> Previously when merging directly from a local tracking
> branch like:
>
>   git merge origin/master
>
> The merge message said:
>
>    Merge commit 'origin/master'
>
>      * commit 'origin/master':
>        ...
>
> Instead, let's be more explicit about what we are merging:
>
>    Merge remote branch 'origin/master'
>
>      * origin/master:
>        ...
>
> We accomplish this by recognizing remote tracking branches
> in git-merge when we build the simulated FETCH_HEAD output
> that we feed to fmt-merge-msg.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is a repost of
>
>   http://article.gmane.org/gmane.comp.version-control.git/119909
>
> which got no response from you. I think it is a good idea, but I am not
> deeply committed to it. I mainly want a yes or no so I can clean it out
> of my patch queue.

I somewhat suspect that the patch was not applied because it also lacked
necessary adjustments to tests.  With this patch, I think the tests would
fail.

Nevertheless, I think it is a good thing to do.  But I am unsure about the
implementation.

Shouldn't it instead feed what it got from the end user to the dwim
machinery, and make sure it dwims into refs/remotes/ hierarchy?

In other words, like this.  Note that it would be much clearer to see
what's needed, if you want to extend it to refs/tags hierarchy ;-)

 builtin-merge.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 82b5466..f4de73f 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -358,6 +358,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf bname = STRBUF_INIT;
 	const char *ptr;
+	char *found_ref;
 	int len, early;
 
 	strbuf_branchname(&bname, remote);
@@ -368,14 +369,17 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	if (!remote_head)
 		die("'%s' does not point to a commit", remote);
 
-	strbuf_addstr(&buf, "refs/heads/");
-	strbuf_addstr(&buf, remote);
-	resolve_ref(buf.buf, branch_head, 0, NULL);
-
-	if (!hashcmp(remote_head->sha1, branch_head)) {
-		strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
-			sha1_to_hex(branch_head), remote);
-		goto cleanup;
+	if (dwim_ref(remote, strlen(remote), branch_head, &found_ref) > 0) {
+		if (!prefixcmp(found_ref, "refs/heads/")) {
+			strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
+				    sha1_to_hex(branch_head), remote);
+			goto cleanup;
+		}
+		if (!prefixcmp(found_ref, "refs/remotes/")) {
+			strbuf_addf(msg, "%s\t\tremote branch '%s' of .\n",
+				    sha1_to_hex(branch_head), remote);
+			goto cleanup;
+		}
 	}
 
 	/* See if remote matches <name>^^^.. or <name>~<number> */
