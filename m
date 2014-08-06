From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] apply: use the right attribute for paths in non-Git patches
Date: Wed,  6 Aug 2014 15:58:03 -0700
Message-ID: <1407365885-1628-2-git-send-email-gitster@pobox.com>
References: <xmqq8un1ml7e.fsf@gitster.dls.corp.google.com>
 <1407365885-1628-1-git-send-email-gitster@pobox.com>
Cc: Peyton Randolph <prandolph@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 00:58:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFAA8-0001gl-Dt
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 00:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbaHFW6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 18:58:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52774 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754715AbaHFW6X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 18:58:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3AD2830775;
	Wed,  6 Aug 2014 18:58:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=BwIE
	gUR/bUQsJHSBzPRt2lAX548=; b=e/8Kr6A7bJl5AChSP1nh9OySFh5GuiDtIffX
	KmOwZu74xEoHE7csTqCti/IgCeEpMFXGsjHb5Edk4i1qwWJcqN6YncQZh7D0MS8e
	D/aASojXq53xxO69NXYu6MthQzkBnThZ9HhNWcL1jZ/vXzZm31vs8Qpf2NbWl+Be
	HneuLr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	nB0LInbzSyLZgf81AO0A1C0P+gahlEFshUIA0zucvY/1Nsa7hoHyposRTAp1wOMc
	gQYrZOQwsNUWtJ6oNPjQVdvfY52RwxHaE8WnEtDJ4hHHhx6KMxu5lZesEPlj4P37
	CbCpKPzgcLV7l8sB2SBNgCDAWNYJ78sqk5BLuz+ZT5g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 30E8830774;
	Wed,  6 Aug 2014 18:58:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 54EF330770;
	Wed,  6 Aug 2014 18:58:16 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-rc1-209-g4e1b551
In-Reply-To: <1407365885-1628-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 26B81D20-1DBD-11E4-ABF2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254910>

We parse each patchfile and find to what path it applies to and then
use that name to consult the attribute system to find what
whitespace rules to be applied, and also which target file (either
in the working tree or in the index) to replay the changes the patch
represents.

A non-Git patch is taken as relative to the current working
directory, and the prefix_patches() helper function introduced in
56185f49 (git-apply: require -p<n> when working in a subdirectory.,
2007-02-19) is used to prepend the prefix to these names found in
the patch input.

However, this prepending of the prefix to the pathnames is done
after the patch is fully parsed and affects only what target files
are patched.  Because the attributes are checked against the names
found in the patch during the parsing, not against the final path,
whitespace checks that are done during parsing end up using
attributes for a wrong path.

Because a Git-generated patch records the full path to the target
with -p$n prefix (e.g. a/ and b/) and we apply it relative to the
top of the working tree, prefix_patches() is a no-op and this
problem does not manifest for them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c         | 41 +++++++++++++++++++----------------------
 t/t4119-apply-config.sh | 17 +++++++++++++++++
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6013e19..4270cde 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1920,6 +1920,23 @@ static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 	return used;
 }
 
+static void prefix_one(char **name)
+{
+	char *old_name = *name;
+	if (!old_name)
+		return;
+	*name = xstrdup(prefix_filename(prefix, prefix_length, *name));
+	free(old_name);
+}
+
+static void prefix_patch(struct patch *p)
+{
+	if (!prefix || p->is_toplevel_relative)
+		return;
+	prefix_one(&p->new_name);
+	prefix_one(&p->old_name);
+}
+
 /*
  * Read the patch text in "buffer" that extends for "size" bytes; stop
  * reading after seeing a single patch (i.e. changes to a single file).
@@ -1935,6 +1952,8 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 	if (offset < 0)
 		return offset;
 
+	prefix_patch(patch);
+
 	patch->ws_rule = whitespace_rule(patch->new_name
 					 ? patch->new_name
 					 : patch->old_name);
@@ -4164,26 +4183,6 @@ static int use_patch(struct patch *p)
 	return !has_include;
 }
 
-
-static void prefix_one(char **name)
-{
-	char *old_name = *name;
-	if (!old_name)
-		return;
-	*name = xstrdup(prefix_filename(prefix, prefix_length, *name));
-	free(old_name);
-}
-
-static void prefix_patches(struct patch *p)
-{
-	if (!prefix || p->is_toplevel_relative)
-		return;
-	for ( ; p; p = p->next) {
-		prefix_one(&p->new_name);
-		prefix_one(&p->old_name);
-	}
-}
-
 #define INACCURATE_EOF	(1<<0)
 #define RECOUNT		(1<<1)
 
@@ -4209,8 +4208,6 @@ static int apply_patch(int fd, const char *filename, int options)
 			break;
 		if (apply_in_reverse)
 			reverse_patches(patch);
-		if (prefix)
-			prefix_patches(patch);
 		if (use_patch(patch)) {
 			patch_stats(patch);
 			*listp = patch;
diff --git a/t/t4119-apply-config.sh b/t/t4119-apply-config.sh
index 3d0384d..be325fa 100755
--- a/t/t4119-apply-config.sh
+++ b/t/t4119-apply-config.sh
@@ -159,4 +159,21 @@ test_expect_success 'same but with traditional patch input of depth 2' '
 	check_result sub/file1
 '
 
+test_expect_success 'in subdir with traditional patch input' '
+	cd "$D" &&
+	git config apply.whitespace strip &&
+	cat >.gitattributes <<-EOF &&
+	/* whitespace=blank-at-eol
+	sub/* whitespace=-blank-at-eol
+	EOF
+	rm -f sub/file1 &&
+	cp saved sub/file1 &&
+	git update-index --refresh &&
+
+	cd sub &&
+	git apply ../gpatch.file &&
+	echo "B " >expect &&
+	test_cmp expect file1
+'
+
 test_done
-- 
2.1.0-rc1-209-g4e1b551
