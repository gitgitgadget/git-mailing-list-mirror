From: Doug Bell <madcityzen@gmail.com>
Subject: [PATCH] show-ref: make --head always show the HEAD ref
Date: Tue, 16 Jul 2013 19:05:14 -0500
Message-ID: <1374019514-15309-2-git-send-email-madcityzen@gmail.com>
References: <7vtxjvbwyo.fsf@alter.siamese.dyndns.org>
 <1374019514-15309-1-git-send-email-madcityzen@gmail.com>
Cc: Doug Bell <madcityzen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 02:07:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzFHF-00034P-KU
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 02:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933967Ab3GQAHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 20:07:25 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:58857 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933956Ab3GQAHY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 20:07:24 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so1506645obb.22
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 17:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zutelZMWy7ldvzbBZn/RN1FDQcIKQTLoPpwXE8ikBc0=;
        b=ZnnoXOWjQaxD7yyniu9Lux6zfLOqE4JCzR0LTXUaxilLxpXG53ymo/QB38Ilnf47x1
         DIS7t1dPToD8QLSUVX/1+3JmTwmEF6CQrUbiZePQr6OcV6VqCZPbBbkw8xBN2Z3Nk2by
         jevEofDz6OQtRN0MpH7S/VwdL4zV1lSZ5Gku+lDFnHmAmQAqE/bECBBf7j4emU1wBpPj
         s50tu2IY3bjYcXSvsXaFtGx+mOYVkTWi3JPomPIxtKys3/h6bHdTHs4Ubd27w5eDthEs
         14FUdbrBE2CcCmc0/eET6TbDYl5TWUIBTh/G0yEYOd5rPz4zFTIfX9rjDAtgojP+uSWX
         2Yag==
X-Received: by 10.60.45.138 with SMTP id n10mr4875914oem.101.1374019644499;
        Tue, 16 Jul 2013 17:07:24 -0700 (PDT)
Received: from localhost.localdomain (c-67-162-112-255.hsd1.il.comcast.net. [67.162.112.255])
        by mx.google.com with ESMTPSA id b7sm3633983oby.5.2013.07.16.17.07.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 17:07:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1374019514-15309-1-git-send-email-madcityzen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230598>

The docs seem to say that doing

	git show-ref --head --tags

would show both the HEAD ref and all the tag refs. However, doing
both --head and either of --tags or --heads would filter out the HEAD
ref.

Also update the documentation to describe the new behavior and add
tests for the show-ref command.

Signed-off-by: Doug Bell <madcityzen@gmail.com>
Tested-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-show-ref.txt |  10 ++-
 builtin/show-ref.c             |   8 +-
 t/t1403-show-ref.sh            | 167 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+), 6 deletions(-)
 create mode 100755 t/t1403-show-ref.sh

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index de4d352..b0a309b 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -21,6 +21,8 @@ commit IDs. Results can be filtered using a pattern and tags can be
 dereferenced into object IDs. Additionally, it can be used to test whether a
 particular ref exists.
 
+By default, shows the tags, heads, and remote refs.
+
 The --exclude-existing form is a filter that does the inverse, it shows the
 refs from stdin that don't exist in the local repository.
 
@@ -32,14 +34,14 @@ OPTIONS
 
 --head::
 
-	Show the HEAD reference.
+	Show the HEAD reference, even if it would normally be filtered out.
 
 --tags::
 --heads::
 
-	Limit to only "refs/heads" and "refs/tags", respectively.  These
-	options are not mutually exclusive; when given both, references stored
-	in "refs/heads" and "refs/tags" are displayed.
+	Limit to "refs/heads" and "refs/tags", respectively.  These options
+	are not mutually exclusive; when given both, references stored in
+	"refs/heads" and "refs/tags" are displayed.
 
 -d::
 --dereference::
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 4a0310d..87806ad 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -31,6 +31,9 @@ static int show_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	const char *hex;
 	unsigned char peeled[20];
 
+	if (show_head && !strcmp(refname, "HEAD"))
+		goto match;
+
 	if (tags_only || heads_only) {
 		int match;
 
@@ -167,9 +170,10 @@ static const struct option show_ref_options[] = {
 	OPT_BOOLEAN(0, "verify", &verify, N_("stricter reference checking, "
 		    "requires exact ref path")),
 	{ OPTION_BOOLEAN, 'h', NULL, &show_head, NULL,
-	  N_("show the HEAD reference"),
+	  N_("show the HEAD reference, even if it would be filtered out"),
 	  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
-	OPT_BOOLEAN(0, "head", &show_head, N_("show the HEAD reference")),
+	OPT_BOOLEAN(0, "head", &show_head,
+	  N_("show the HEAD reference, even if it would be filtered out")),
 	OPT_BOOLEAN('d', "dereference", &deref_tags,
 		    N_("dereference tags into object IDs")),
 	{ OPTION_CALLBACK, 's', "hash", &abbrev, N_("n"),
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
new file mode 100755
index 0000000..3e500ed
--- /dev/null
+++ b/t/t1403-show-ref.sh
@@ -0,0 +1,167 @@
+#!/bin/sh
+
+test_description='show-ref'
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit A &&
+	git tag -f -a -m "annotated A" A &&
+	git checkout -b side &&
+	test_commit B &&
+	git tag -f -a -m "annotated B" B &&
+	git checkout master &&
+	test_commit C &&
+	git branch B A^0
+'
+
+test_expect_success 'show-ref' '
+	echo $(git rev-parse refs/tags/A) refs/tags/A >expect &&
+
+	git show-ref A >actual &&
+	test_cmp expect actual &&
+
+	git show-ref tags/A >actual &&
+	test_cmp expect actual &&
+
+	git show-ref refs/tags/A >actual &&
+	test_cmp expect actual &&
+
+	>expect &&
+
+	test_must_fail git show-ref D >actual
+	test_cmp expect actual
+'
+
+test_expect_success 'show-ref -q' '
+	>expect &&
+
+	git show-ref -q A >actual &&
+	test_cmp expect actual &&
+
+	git show-ref -q tags/A >actual &&
+	test_cmp expect actual &&
+
+	git show-ref -q refs/tags/A >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref -q D >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'show-ref --verify' '
+	echo $(git rev-parse refs/tags/A) refs/tags/A >expect &&
+
+	git show-ref --verify refs/tags/A >actual &&
+	test_cmp expect actual &&
+
+	>expect &&
+
+	test_must_fail git show-ref --verify A >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref --verify tags/A >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref --verify D >actual
+	test_cmp expect actual
+'
+
+test_expect_success 'show-ref --verify -q' '
+	>expect &&
+
+	git show-ref --verify -q refs/tags/A >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref --verify -q A >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref --verify -q tags/A >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref --verify -q D >actual
+	test_cmp expect actual
+'
+
+test_expect_success 'show-ref -d' '
+	{
+		echo $(git rev-parse refs/tags/A) refs/tags/A &&
+		echo $(git rev-parse refs/tags/A^0) "refs/tags/A^{}"
+		echo $(git rev-parse refs/tags/C) refs/tags/C
+	} >expect &&
+	git show-ref -d A C >actual &&
+	test_cmp expect actual &&
+
+	git show-ref -d tags/A tags/C >actual &&
+	test_cmp expect actual &&
+
+	git show-ref -d refs/tags/A refs/tags/C >actual &&
+	test_cmp expect actual &&
+
+	echo $(git rev-parse refs/heads/master) refs/heads/master >expect &&
+	git show-ref -d master >actual &&
+	test_cmp expect actual &&
+
+	git show-ref -d heads/master >actual &&
+	test_cmp expect actual &&
+
+	git show-ref -d refs/heads/master >actual &&
+	test_cmp expect actual
+
+	git show-ref -d --verify refs/heads/master >actual &&
+	test_cmp expect actual
+
+	>expect &&
+
+	test_must_fail git show-ref -d --verify master >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref -d --verify heads/master >actual &&
+	test_cmp expect actual
+
+'
+
+test_expect_success 'show-ref --heads, --tags, --head, pattern' '
+	for branch in B master side
+	do
+		echo $(git rev-parse refs/heads/$branch) refs/heads/$branch
+	done >expect.heads &&
+	git show-ref --heads >actual &&
+	test_cmp expect.heads actual &&
+
+	for tag in A B C
+	do
+		echo $(git rev-parse refs/tags/$tag) refs/tags/$tag
+	done >expect.tags &&
+	git show-ref --tags >actual &&
+	test_cmp expect.tags actual &&
+
+	cat expect.heads expect.tags >expect &&
+	git show-ref --heads --tags >actual &&
+	test_cmp expect actual &&
+
+	{
+		echo $(git rev-parse HEAD) HEAD &&
+		cat expect.heads expect.tags
+	} >expect &&
+	git show-ref --heads --tags --head >actual &&
+	test_cmp expect actual &&
+
+	{
+		echo $(git rev-parse HEAD) HEAD &&
+		echo $(git rev-parse refs/heads/B) refs/heads/B
+		echo $(git rev-parse refs/tags/B) refs/tags/B
+	} >expect &&
+	git show-ref --head B >actual &&
+	test_cmp expect actual &&
+
+	{
+		echo $(git rev-parse HEAD) HEAD &&
+		echo $(git rev-parse refs/heads/B) refs/heads/B
+		echo $(git rev-parse refs/tags/B) refs/tags/B
+		echo $(git rev-parse refs/tags/B^0) "refs/tags/B^{}"
+	} >expect &&
+	git show-ref --head -d B >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.12.4
