From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [RFC PATCH] commit: Warn about encodings unsupported by iconv.
Date: Tue, 21 Oct 2008 01:25:18 +0400
Message-ID: <1224537918-14024-1-git-send-email-angavrilov@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 01:08:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks2Ia-0004Qi-88
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 23:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbYJTV1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 17:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbYJTV1M
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 17:27:12 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:58792 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbYJTV1K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 17:27:10 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2184043fkq.5
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 14:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=dMeLZaMDxJQ6sRLYzzounIK4owYiPmvuOlUlGR6zDn0=;
        b=UwvKIj7hoAZ5MpHt2CRmDYbhbXf748ykxzrF7/hyl4IgfobIvtklHYTEWg0gMBFUD0
         KI8xJfmtnsmYcAMWH3Il8JLJRYr76i1/ixj/rYh2LdjayTa+DPwoIsdTSBvB31lrgnGP
         guyyQFJlIQn4c2Iqg/40qz7S/fe2u+mNNpr2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DMXaiPaqCpqI44A9jcCJY/emquGpt8qbpHy8V+ujeuEZIfWF5UEkWHkdH+dQxxlc5s
         e8x2Kgng6kVOcujXj79Bq88XwlbHc3Nu/wuy4Q4bG1ufQOfm0aPvPa7U0oV6tQQxRMaA
         xn+D7Q6utCzwPAIoiChOhgrKoTnJO85dL8woY=
Received: by 10.181.156.12 with SMTP id i12mr975645bko.140.1224538028265;
        Mon, 20 Oct 2008 14:27:08 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id p17sm8383556fka.14.2008.10.20.14.27.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Oct 2008 14:27:07 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98740>

Currently git-commit and git-commit-tree silently allow
usage of encodings that are unknown to iconv. This may
confuse the user, who then won't be able to use automatic
encoding conversion in git-log and friends without any
immediately obvious reason. Note that the difference
between a supported and an unsupported name may be as
small as CP1251 vs CP-1251, or Shift-JIS vs ShiftJIS.

This commit adds a check for such cases, which produces
a warning similar to the one issued when a message claims
to be utf-8, but actually is not.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	I wonder how common such situation may actually be, and 
	whether gitk & git-gui (or core git itself) should explicitly
	provide some way to deal with it in old commits. I personally
	hit it during experimenting, and wrongly concluded that gitk
	does not support using multiple encodings in one repository.
	
	Current gitk implementation generally allows working around
	it by setting i18n.commitencoding to a valid name of the
	encoding used in the mislabeled commits. However, the
	downside is that if the selected encoding cannot represent
	some characters of an otherwise completely valid commit,
	they come out as garbage. Always using --encoding=utf-8
	from GUI and relying on conversion done by git-log should
	fix this case, but it breaks the workaround.
	
	-- Alexander

 builtin-commit-tree.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 0453425..7f325a3 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -45,6 +45,28 @@ static const char commit_utf8_warn[] =
 "You may want to amend it after fixing the message, or set the config\n"
 "variable i18n.commitencoding to the encoding your project uses.\n";
 
+static const char commit_bad_encoding_warn[] =
+"Warning: commit encoding '%s' is not supported.\n"
+"You may want to change the value of the i18n.commitencoding config\n"
+"variable, and redo the commit. Use 'iconv --list' to see the list of\n"
+"available encoding names.\n";
+
+static void verify_commit_encoding(const char *text, const char *encoding)
+{
+	if (is_encoding_utf8(encoding)) {
+		if (!is_utf8(text))
+			fprintf(stderr, commit_utf8_warn);
+	}
+#ifndef NO_ICONV
+	else {
+		char *conv = reencode_string("", "utf-8", encoding);
+		if (!conv)
+			fprintf(stderr, commit_bad_encoding_warn, encoding);
+		free(conv);
+	}
+#endif
+}
+
 int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author)
@@ -87,8 +109,7 @@ int commit_tree(const char *msg, unsigned char *tree,
 	strbuf_addstr(&buffer, msg);
 
 	/* And check the encoding */
-	if (encoding_is_utf8 && !is_utf8(buffer.buf))
-		fprintf(stderr, commit_utf8_warn);
+	verify_commit_encoding(buffer.buf, git_commit_encoding);
 
 	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
 	strbuf_release(&buffer);
-- 
1.6.0.20.g6148bc
