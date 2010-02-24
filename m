From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] fetch --all/--multiple: keep all the fetched branch
 information
Date: Wed, 24 Feb 2010 11:02:05 -0800
Message-ID: <7vpr3uqwya.fsf_-_@alter.siamese.dyndns.org>
References: <1267035726-2815-1-git-send-email-gitster@pobox.com>
 <1267035726-2815-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 20:02:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkMV5-0008Po-6D
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757536Ab0BXTCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 14:02:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59292 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757364Ab0BXTCR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 14:02:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B52A9CD79;
	Wed, 24 Feb 2010 14:02:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6CB4og6P+KXb4L47736Oro5phYc=; b=BVr0GX
	BwWAUkpDo3sKmSOjEO0O+BbTRYDsWCS8hxNo1OmmyuCXGQUwCKEGqpO9ZxTKLJBl
	u8d1pepfHP77bDn6wKJGQogdaI8IukysAwN30TUlsi3CPz+wyMzrBd5t3d3tDnxH
	ryphs5omcRkwu3YsifXkaGq9rmls47f+aima8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jNHbYT1+aS+9O3nDCLInMd5G36Tem8WT
	7nxY0KxLCqdvj8eguCJBccLlS/mKUH0XGlmM5pOBnJiNRxpVaxPCeFVFpJpKO225
	afHaioP6VdsQMEeBxFOGq7zBfVLCUcYENfUMOOGkqqSmnPH69DCEF7GHBZAUqN3/
	OvVFeBukjYk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1838D9CD76;
	Wed, 24 Feb 2010 14:02:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20C519CD73; Wed, 24 Feb
 2010 14:02:07 -0500 (EST)
In-Reply-To: <1267035726-2815-2-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Wed\, 24 Feb 2010 10\:22\:06 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1D49ADA4-2177-11DF-8361-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140970>

Since "git fetch" learned "--all" and "--multiple" options, it has become
tempting for users to say "git pull --all".  Even though it may fetch from
remotes that do not need to be fetched from for merging with the current
branch, it is handy.

"git fetch" however clears the list of fetched branches every time it
contacts a different remote.  Unless the current branch is configured to
merge with a branch from a remote that happens to be the last in the list
of remotes that are contacted, "git pull" that fetches from multiple
remotes will not be able to find the branch it should be merging with.

Make "fetch" clear FETCH_HEAD (unless --append is given) and then append
the list of branches fetched to it (even when --apend is not given).  That
way, "pull" will be able to find the data for the branch being merged in
FETCH_HEAD no matter where the remote appears in the list of remotes to be
contacted by "git fetch".

Reported-by: Michael Lukashov
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This obviously builds on top of the earlier two clean-up patches.

 builtin-fetch.c         |   29 ++++++++++++++++++++++-------
 t/t5521-pull-options.sh |   18 ++++++++++++++++++
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 61b2e40..b059d65 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -651,6 +651,17 @@ static void check_not_current_branch(struct ref *ref_map)
 			    "of non-bare repository", current_branch->refname);
 }
 
+static int truncate_fetch_head(void)
+{
+	char *filename = git_path("FETCH_HEAD");
+	FILE *fp = fopen(filename, "w");
+
+	if (!fp)
+		return error("cannot open %s: %s\n", filename, strerror(errno));
+	fclose(fp);
+	return 0;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
@@ -672,11 +683,9 @@ static int do_fetch(struct transport *transport,
 
 	/* if not appending, truncate FETCH_HEAD */
 	if (!append && !dry_run) {
-		char *filename = git_path("FETCH_HEAD");
-		FILE *fp = fopen(filename, "w");
-		if (!fp)
-			return error("cannot open %s: %s\n", filename, strerror(errno));
-		fclose(fp);
+		int errcode = truncate_fetch_head();
+		if (errcode)
+			return errcode;
 	}
 
 	ref_map = get_ref_map(transport, refs, ref_count, tags, &autotags);
@@ -784,8 +793,8 @@ static int add_remote_or_group(const char *name, struct string_list *list)
 static int fetch_multiple(struct string_list *list)
 {
 	int i, result = 0;
-	const char *argv[10] = { "fetch" };
-	int argc = 1;
+	const char *argv[11] = { "fetch", "--append" };
+	int argc = 2;
 
 	if (dry_run)
 		argv[argc++] = "--dry-run";
@@ -804,6 +813,12 @@ static int fetch_multiple(struct string_list *list)
 	else if (verbosity < 0)
 		argv[argc++] = "-q";
 
+	if (!append && !dry_run) {
+		int errcode = truncate_fetch_head();
+		if (errcode)
+			return errcode;
+	}
+
 	for (i = 0; i < list->nr; i++) {
 		const char *name = list->items[i].string;
 		argv[argc] = name;
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 84059d8..1b06691 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -72,4 +72,22 @@ test_expect_success 'git pull --force' '
 	)
 '
 
+test_expect_success 'git pull --all' '
+	mkdir clonedmulti &&
+	(cd clonedmulti && git init &&
+	cat >>.git/config <<-\EOF &&
+	[remote "one"]
+		url = ../parent
+		fetch = refs/heads/*:refs/remotes/one/*
+	[remote "two"]
+		url = ../parent
+		fetch = refs/heads/*:refs/remotes/two/*
+	[branch "master"]
+		remote = one
+		merge = refs/heads/master
+	EOF
+	git pull --all
+	)
+'
+
 test_done
-- 
1.7.0.207.gac4ec
