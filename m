From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] commit -s: allow "(cherry picked " lines in sign-off section
Date: Tue, 16 Nov 2010 14:25:56 -0600
Message-ID: <20101116202556.GA27390@burratino>
References: <d0318dcd2b52f2e818888003e3dd81c7b713fec6.1289920242.git.git@drmicha.warpmail.net>
 <20101116193018.GA31036@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Martin Svensson <martin.k.svensson@netinsight.se>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 16 21:27:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIS7A-0004mH-CL
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 21:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab0KPU0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 15:26:42 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56171 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab0KPU0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 15:26:41 -0500
Received: by gxk23 with SMTP id 23so663514gxk.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 12:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=N8d+khhU5QVFXmF4EAVHrLl7pW1FaJvJ34g6cLakOzk=;
        b=RGUXjnNPCQgKoRqOq1jTXga+Nw2vtTxWxwdYFsiELo7YVYkVH+yNvqit5EEVQXA7W2
         2yLKmjkKpQ78JwDmjKFIxi/emNixRRADRtI5E2OOT9ILfuRw5g+Bg82MY/+YQFq6U0s2
         sVe5j0cwlATG8pLHdyvlo+ZnbJuZXUNqt9ezc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LRSW3L6lVQf2BPFLR8lk1am9PKzGXGb2voHvlW1aDW+14Wo0sRY5D+FxbKSbzmh4tY
         kx3CxD7eGqMZP0KVtnlnTOfFw0u33mIyurOWRKQok9Sj/dvrdnXZzBF5fsciTArMkxqB
         YdirDlSE5nm9O9TnkfhEFRQLq7oJdzFZ070ZM=
Received: by 10.223.70.133 with SMTP id d5mr81306faj.64.1289939199379;
        Tue, 16 Nov 2010 12:26:39 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id b20sm1454169fab.11.2010.11.16.12.26.37
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 12:26:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101116193018.GA31036@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161586>

Using cherry-pick -x -s to backport a public commit results in
an unsightly gap in the sign-off chain:

	Reported-by: Jarek Poplawski <jarkao2@gmail.com>
	Tested-by: Jarek Poplawski <jarkao2@gmail.com>
	Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
	Cc: Jeff Mahoney <jeffm@suse.com>
	Cc: All since 2.6.32 <stable@kernel.org>
	Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
	Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
	(cherry picked from commit 9d8117e72bf453dd9d85e0cd322ce4a0f8bccbc0)

	Signed-off-by: Back Porter <backporter@example.com>

The cherry-pick is a step in the line of a patch like any other,
so one might prefer to lose the extra newline.

	...
	Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
	(cherry picked from commit 9d8117e72bf453dd9d85e0cd322ce4a0f8bccbc0)
	Signed-off-by: Back Porter <backporter@example.com>

This commit teaches "git commit --signoff", and thus cherry-pick -s,
to do exactly that.  It works by treating the "(cherry picked" line as
just another line in the signoff chain, except as the first line (that
last exception is to avoid false positives).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:

> Even better, I wonder if it should actually be:
> 
>   message subject
> 
>   Message body.
> 
>   Signed-off-by: Jeff King <peff@peff.net>
>   Cherry-picked-from: ...

Here's something like that.  I use "git cherry-pick -x -s" to
backport patches from a public upstream.  Now you can, too.

Ideally inline notes like

	 [akpm@linux-foundation.org: coding-style fixes]

also ought to be tolerated.

 builtin/commit.c               |   20 +++++++
 t/t3510-cherry-pick-message.sh |  112 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+), 0 deletions(-)
 create mode 100755 t/t3510-cherry-pick-message.sh

diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..71dd52b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -528,6 +528,8 @@ static int ends_rfc2822_footer(struct strbuf *sb)
 		i++;
 
 	for (; i < len; i = k) {
+		static const char cherry_pick[] = "(cherry picked from commit ";
+
 		for (k = i; k < len && buf[k] != '\n'; k++)
 			; /* do nothing */
 		k++;
@@ -535,6 +537,20 @@ static int ends_rfc2822_footer(struct strbuf *sb)
 		if ((buf[k] == ' ' || buf[k] == '\t') && !first)
 			continue;
 
+		if (!first && buf[k] == '(' && k + strlen(cherry_pick) < len) {
+			/* Might be a cherry-pick notice. */
+			const char *p = buf + k;
+			if (!memcmp(p, cherry_pick, strlen(cherry_pick))) {
+				p = memchr(buf + k, '\n', len - k);
+				if (!p)
+					return 0;
+				if (p + 1 == buf + len)
+					return 1;
+				k = p - buf;
+				continue;
+			}
+		}
+
 		first = 0;
 
 		for (j = 0; i + j < len; j++) {
@@ -625,6 +641,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		for (i = sb.len - 1; i > 0 && sb.buf[i - 1] != '\n'; i--)
 			; /* do nothing */
 		if (prefixcmp(sb.buf + i, sob.buf)) {
+			/*
+			 * Only insert an extra newline if the previous line
+			 * is not part of a Signed-off-by:/Acked-by:/etc chain.
+			 */
 			if (!i || !ends_rfc2822_footer(&sb))
 				strbuf_addch(&sb, '\n');
 			strbuf_addbuf(&sb, &sob);
diff --git a/t/t3510-cherry-pick-message.sh b/t/t3510-cherry-pick-message.sh
new file mode 100755
index 0000000..83e50a3
--- /dev/null
+++ b/t/t3510-cherry-pick-message.sh
@@ -0,0 +1,112 @@
+#!/bin/sh
+
+test_description='tests for the log messages cherry-pick produces
+
+  ----
+  +      cherry-pick of branch
+     +   signoff
+    +    basic
+  ++     mainline
+  +++    initial
+'
+. ./test-lib.sh
+
+prepare_commit () {
+	git checkout initial &&
+	test_commit "$1" &&
+	test_tick &&
+	git commit --amend --allow-empty-message -F "$1.message" &&
+	git tag -d "$1" &&
+	git tag "$1"
+}
+
+test_cmp_message () {
+	expect=$1 &&
+	shift &&
+	git log -1 --pretty=format:%B "$@" >actual &&
+	test_cmp "$expect" actual
+}
+
+cat >basic.message <<\EOF
+ A branch
+
+Here comes the lovely description of a change to pick up.
+Contributions come from many people:
+EOF
+
+{
+	cat basic.message
+	cat <<-\EOF
+
+	Signed-off-by: Foo <foo@example.com>
+	Signed-off-by: Bar <bar@example.com>
+	Tested-by: Baz <baz@example.com>
+	EOF
+} >signoff.message
+
+test_expect_success 'setup' '
+	test_commit initial &&
+	prepare_commit basic &&
+	prepare_commit signoff
+'
+
+test_expect_success 'cherry-pick preserves message' '
+	cat basic.message >expect &&
+	git checkout initial &&
+	git cherry-pick basic &&
+	test_cmp_message expect
+'
+
+test_expect_success 'cherry-pick -s adds signoff' '
+	{
+		cat basic.message &&
+		echo &&
+		echo "Signed-off-by: C O Mitter <committer@example.com>"
+	} >expect &&
+	git checkout initial &&
+	git cherry-pick -s basic &&
+	test_cmp_message expect HEAD
+'
+
+test_expect_success 'cherry-pick -s integrates into existing signoff chain' '
+	{
+		cat signoff.message &&
+		echo "Signed-off-by: C O Mitter <committer@example.com>"
+	} >expect &&
+	git checkout initial &&
+	git cherry-pick -s signoff &&
+	test_cmp_message expect HEAD
+'
+
+test_expect_success 'cherry-pick -x adds old commit id' '
+	{
+		cat basic.message &&
+		echo "(cherry picked from commit $(git rev-parse basic^0))"
+	} >expect &&
+	git checkout initial &&
+	git cherry-pick -x basic &&
+	test_cmp_message expect HEAD
+'
+
+test_expect_success 'cherry-pick -x integrates into signoff chain' '
+	{
+		cat signoff.message &&
+		echo "(cherry picked from commit $(git rev-parse signoff^0))"
+	} >expect &&
+	git checkout initial &&
+	git cherry-pick -x signoff &&
+	test_cmp_message expect HEAD
+'
+
+test_expect_success 'cherry-pick -x -s' '
+	{
+		cat signoff.message &&
+		echo "(cherry picked from commit $(git rev-parse signoff^0))"
+		echo "Signed-off-by: C O Mitter <committer@example.com>"
+	} >expect &&
+	git checkout initial &&
+	git cherry-pick -x -s signoff &&
+	test_cmp_message expect HEAD
+'
+
+test_done
-- 
1.7.2.3.551.g13682.dirty
