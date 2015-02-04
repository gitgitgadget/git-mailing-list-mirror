From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/4] apply: do not read from beyond a symbolic link
Date: Tue,  3 Feb 2015 16:44:21 -0800
Message-ID: <1423010662-26497-4-git-send-email-gitster@pobox.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
 <1423010662-26497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 01:44:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIo58-0004Wn-Ha
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 01:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966832AbbBDAoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 19:44:34 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52835 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966826AbbBDAo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 19:44:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4246B365DC;
	Tue,  3 Feb 2015 19:44:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ewh2
	SIkfC3QstcJlNyU8lZsesZU=; b=U5FtSQvH8cAHL/bkZgLaXCbIiTucjLgYlnnW
	XHrXKsq4rGN378JzoQgNcTL6is3/i0NInJDA3MMhsuhzlSV8/xeLEl+LtfTyBkvI
	yvNHK/piBv9U6b78q1OHbdyk5CLjlJRE6hvYJda6bVsAByz0K9+5hE37wRMFtsRe
	FK3Ixvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=cBp0kY
	GFOoKAfx9sM7SxbHzhkttIbgDc/N8NLst7fHqN55aoNAJ0MJKM1ffn6JefExJiOK
	4q30XLbpCN3pcbAQjQD6s5zqPViwiUcZqeOuGw4pePLei2ckzRiv0JPkTeAM2vzQ
	Lb5bea+64wmiohQYpd8iN2ebrenGadh2BiAiI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 39551365DB;
	Tue,  3 Feb 2015 19:44:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE4FC365DA;
	Tue,  3 Feb 2015 19:44:27 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc2-168-g106c876
In-Reply-To: <1423010662-26497-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F91DDB56-AC06-11E4-8DEF-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263344>

We should reject a patch, whether it renames/copies dir/file to
elsewhere with or without modificiation, or updates dir/file in
place, if "dir/" part is actually a symbolic link to elsewhere,
by making sure that the code to read the preimage does not read
from a path that is beyond a symbolic link.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Same as v2

 builtin/apply.c                 |  2 ++
 t/t4122-apply-symlink-inside.sh | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 05eaf54..60d821c 100644
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
2.3.0-rc2-168-g106c876
