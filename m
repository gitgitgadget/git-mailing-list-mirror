From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/4] apply: do not read from beyond a symbolic link
Date: Tue, 10 Feb 2015 14:36:10 -0800
Message-ID: <1423607771-27157-4-git-send-email-gitster@pobox.com>
References: <1423010662-26497-1-git-send-email-gitster@pobox.com>
 <1423607771-27157-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 23:36:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLJPv-000540-3I
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 23:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbbBJWgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 17:36:23 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752370AbbBJWgT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 17:36:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D628A374A3;
	Tue, 10 Feb 2015 17:36:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/+mn
	vo9ROrDrR021Ng4eN3aDAcA=; b=D+GlKZADmbyd/L8CA6d7GRYIO3IzYx9dL8N5
	kU/gYEknBTpiCGDexStWScyADPJomRJqdubVTAw4/JuX5E60/XsjZhmTnkLBHjy5
	iByHQk83VnQRC/U5CRzp2hJ8Sz/SgQWbIS03dB9g3d7XybpG7D44kWucZdSPRjIi
	CzbZzlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=R5uxTI
	0tHNMhNo2Maydadny8GLwYV1HIyKB5RMbMe6LcAX3tVbSU79IroKX90bWZSZ1ImV
	Dwg6c4zrllrfak4utt6Cx9pC5aluBhKf8e88ylNP10FrYFQeNc03Thudd6/NQ6vb
	jbSpbiqxa/j+REcBgvGYwiekAQXUEdp7ems1g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE01A374A2;
	Tue, 10 Feb 2015 17:36:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4940D374A1;
	Tue, 10 Feb 2015 17:36:18 -0500 (EST)
X-Mailer: git-send-email 2.3.0-185-g073f588
In-Reply-To: <1423607771-27157-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3AC4D8AC-B175-11E4-999F-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263655>

We should reject a patch, whether it renames/copies dir/file to
elsewhere with or without modificiation, or updates dir/file in
place, if "dir/" part is actually a symbolic link to elsewhere,
by making sure that the code to read the preimage does not read
from a path that is beyond a symbolic link.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c                 |  2 ++
 t/t4122-apply-symlink-inside.sh | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 21e45a0..422e4ce 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3145,6 +3145,8 @@ static int load_patch_target(struct strbuf *buf,
 				return read_file_or_gitlink(ce, buf);
 			else
 				return SUBMODULE_PATCH_WITHOUT_INDEX;
+		} else if (has_symlink_leading_path(name, strlen(name))) {
+			return error(_("reading from '%s' beyond a symbolic link"), name);
 		} else {
 			if (read_old_data(st, name, buf))
 				return error(_("read of %s failed"), name);
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index 70b3a06..035c080 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -52,4 +52,23 @@ test_expect_success 'check result' '
 
 '
 
+test_expect_success SYMLINKS 'do not read from beyond symbolic link' '
+	git reset --hard &&
+	mkdir -p arch/x86_64/dir &&
+	>arch/x86_64/dir/file &&
+	git add arch/x86_64/dir/file &&
+	echo line >arch/x86_64/dir/file &&
+	git diff >patch &&
+	git reset --hard &&
+
+	mkdir arch/i386/dir &&
+	>arch/i386/dir/file &&
+	ln -s ../i386/dir arch/x86_64/dir &&
+
+	test_must_fail git apply patch &&
+	test_must_fail git apply --cached patch &&
+	test_must_fail git apply --index patch
+
+'
+
 test_done
-- 
2.3.0-185-g073f588
