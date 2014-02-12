From: Johan Herland <johan@herland.net>
Subject: [PATCH] notes: Disallow reusing non-blob as a note object
Date: Wed, 12 Feb 2014 10:54:16 +0100
Message-ID: <1392198856-3908-1-git-send-email-johan@herland.net>
References: <CALKQrgdnGhc-y3WMf+zej4M+O4NMhLKusE-N6dX_xKVViZmQzA@mail.gmail.com>
Cc: git@vger.kernel.org, Joachim Breitner <mail@joachim-breitner.de>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 10:56:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDWXv-0000pg-KA
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 10:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbaBLJyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 04:54:49 -0500
Received: from mail-ee0-f41.google.com ([74.125.83.41]:58147 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaBLJyj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 04:54:39 -0500
Received: by mail-ee0-f41.google.com with SMTP id e51so3635282eek.0
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 01:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AVujFvPKp1yWtKYgStyX745pFxlT1KcveDmhgDgkHEM=;
        b=ZSgfcJrE89gt0kZXl64YoDcv7fBj1W5taYg5pTJrt5zxj2rVt/JastC+a0vkWoVq7c
         4DCsWHkA+NWcZNBy9XSkszkJlqHcAAoOuGqqkeSIOc5h0r8UUAsK2dU3vCo6PlzDc2sJ
         l9QDdAfx1slXoR4gMDFG8TgeuewwbXKYeldr1KIbld8ht9hhaC9S56pZPo+nIUxQz+7z
         khI+FMiqhVWWwTbWyw/fWYJTq4hJOjRdpGKjiBsOWApjugeyVBYhTf0huH8VUAdN7Yeo
         NNPToms4IhxjC6MlDwBQFHZGBDLQrEqnAz7jZaU0o0tuJXo/lFBnhNYAf3Xu+UdfhpEW
         XfxA==
X-Received: by 10.14.88.2 with SMTP id z2mr2920811eee.60.1392198878154;
        Wed, 12 Feb 2014 01:54:38 -0800 (PST)
Received: from beta.cisco.com (173-38-208-169.cisco.com. [173.38.208.169])
        by mx.google.com with ESMTPSA id y47sm79344982eel.14.2014.02.12.01.54.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Feb 2014 01:54:37 -0800 (PST)
X-Mailer: git-send-email 1.8.4.653.g2df02b3
In-Reply-To: <CALKQrgdnGhc-y3WMf+zej4M+O4NMhLKusE-N6dX_xKVViZmQzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241979>

Currently "git notes add -C $object" will read the raw bytes from $object,
and then copy those bytes into the note object, which is hardcoded to be
of type blob. This means that if the given $object is a non-blob (e.g.
tree or commit), the raw bytes from that object is copied into a blob
object. This is probably not useful, and certainly not what any sane
user would expect. So disallow it, by erroring out if the $object passed
to the -C option is not a blob.

The fix also applies to the -c option (in which the user is prompted to
edit/verify the note contents in a text editor), and also when -c/-C is
passed to "git notes append" (which appends the $object contents to an
existing note object). In both cases, passing a non-blob $object does not
make sense.

Also add a couple of tests demonstrating expected behavior.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c  |  6 +++++-
 t/t3301-notes.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 2b24d05..bb89930 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -269,7 +269,11 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 		die(_("Failed to resolve '%s' as a valid ref."), arg);
 	if (!(buf = read_sha1_file(object, &type, &len)) || !len) {
 		free(buf);
-		die(_("Failed to read object '%s'."), arg);;
+		die(_("Failed to read object '%s'."), arg);
+	}
+	if (type != OBJ_BLOB) {
+		free(buf);
+		die(_("Cannot read note data from non-blob object '%s'."), arg);
 	}
 	strbuf_add(&(msg->buf), buf, len);
 	free(buf);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 16de05a..3bb79a4 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -812,6 +812,33 @@ test_expect_success 'create note from non-existing note with "git notes add -C"
 	test_must_fail git notes list HEAD
 '
 
+test_expect_success 'create note from non-blob with "git notes add -C" fails' '
+	commit=$(git rev-parse --verify HEAD) &&
+	tree=$(git rev-parse --verify HEAD:) &&
+	test_must_fail git notes add -C $commit &&
+	test_must_fail git notes add -C $tree &&
+	test_must_fail git notes list HEAD
+'
+
+cat > expect << EOF
+commit 80d796defacd5db327b7a4e50099663902fbdc5c
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:20:13 2005 -0700
+
+    8th
+
+Notes (other):
+    This is a blob object
+EOF
+
+test_expect_success 'create note from blob with "git notes add -C" reuses blob id' '
+	blob=$(echo "This is a blob object" | git hash-object -w --stdin) &&
+	git notes add -C $blob &&
+	git log -1 > actual &&
+	test_cmp expect actual &&
+	test "$(git notes list HEAD)" = "$blob"
+'
+
 cat > expect << EOF
 commit 016e982bad97eacdbda0fcbd7ce5b0ba87c81f1b
 Author: A U Thor <author@example.com>
-- 
1.8.4.653.g2df02b3
