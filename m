From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] apply: do not read from beyond a symbolic link
Date: Mon,  2 Feb 2015 15:27:29 -0800
Message-ID: <1422919650-13346-4-git-send-email-gitster@pobox.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 00:27:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIQPG-000360-6H
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 00:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbbBBX1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 18:27:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965145AbbBBX1n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 18:27:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D92335A9A;
	Mon,  2 Feb 2015 18:27:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=BFii
	7/MPYyZLSCPjBTdTo8zhuF4=; b=qSs98eOaGldHQi3I1TguCfQ9FiTHYM1u3+xx
	pkoV/pXBOLyYV4kiG55lq5b/o2aFObwaWdOrwlElbLs/aGrSMgmfNTKwDVFtK9gB
	2ctSeMEXkOkwQJLO35/skP8+M9GzWDg67YATmK6HROLExjaBErJB3EGEjdvbJzbG
	x9CSbKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=taLe4L
	wdf4bi55vi7ghYTh5F8o0q91p9U/SlDubNXRCkYHvC/T+K7Tze0jxR6PTvP8IiTx
	zAU/nZtJnqgdSHWdKIsWVVDzYokmUsN05CgocDp7cC3RWcPh94+3dHlAkkZXnOUP
	LltAFnwDkGTHIEv+y52cTlUt7Wc0msJuZ7u3s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45C4D35A99;
	Mon,  2 Feb 2015 18:27:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B76335A8E;
	Mon,  2 Feb 2015 18:27:36 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc2-166-g7339d96
In-Reply-To: <1422919650-13346-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 12359B94-AB33-11E4-B113-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263294>

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
2.3.0-rc2-164-g799cdce
