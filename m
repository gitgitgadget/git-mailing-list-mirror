From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] Fix line numbers emitted by "git diff --check"
Date: Fri, 15 Feb 2008 18:33:43 -0500
Message-ID: <1203118423-32642-1-git-send-email-jaysoffian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 00:34:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQA4n-0000PP-He
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 00:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760459AbYBOXds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 18:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756454AbYBOXds
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 18:33:48 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:54594 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbYBOXdr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 18:33:47 -0500
Received: by an-out-0708.google.com with SMTP id d31so190774and.103
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 15:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:content-type:content-transfer-encoding;
        bh=0jGuHlDwD8EyXCCXKuv4pwQV9L52HzlUtveA7Xl8wY4=;
        b=b4uNRUF4c5wKtZmpKU8gsFFUFHdhDzeze/5CozPea1c98aZmVQiYgx9/xTQOCqlwisRBmUt5FdI4iFjXZLsfDwAY9ZrtQ+pUAtpP82sSD+0AAvjkRft/CkfdybI9EVXLj+U85oL76jH6Z8QkSUe+zj46o1nMjdRvdCxichGwpWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:content-type:content-transfer-encoding;
        b=tj7DXd6ZiE3J6p/km5Aj6dP7tDKpzYpXQRHhvDZbLkLwZARPFGB+yChs45hhtc97fptGXG8d9V98M8/jTkWEUDzBofHESyUewBm3eyRqhVUSTT3ZlTJofaMOiIDKTTObDmontkB5lWXBttPS3Y/ohd6dsnx9o376t6YX0Un/X0U=
Received: by 10.100.241.17 with SMTP id o17mr4833480anh.116.1203118426386;
        Fri, 15 Feb 2008 15:33:46 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id c16sm7791956anc.10.2008.02.15.15.33.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Feb 2008 15:33:45 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1.1281.g75df
In-Reply-To: 76718490802151218s62c4f884u39353b66540b347a@mail.gmail.com
References: 76718490802151218s62c4f884u39353b66540b347a@mail.gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73997>

Fixes a problem where git diff --check was emitting incorrect lines
numbers. Adds a test to verify the fix.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 diff.c                     |    4 +++-
 t/t4015-diff-whitespace.sh |    9 +++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index cd8bc4d..a002573 100644
--- a/diff.c
+++ b/diff.c
@@ -1023,8 +1023,10 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 	if (line[0] == '+') {
 		data->status = check_and_emit_line(line + 1, len - 1,
 		    data->ws_rule, NULL, NULL, NULL, NULL);
-		if (!data->status)
+		if (!data->status) {
+			data->lineno++;
 			return;
+		}
 		err = whitespace_error_string(data->status);
 		printf("%s:%d: %s.\n", data->filename, data->lineno, err);
 		free(err);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index d30169f..83c54b7 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -326,4 +326,13 @@ test_expect_success 'check tabs and spaces as indentation (indent-with-non-tab:
 	! git diff --check
 
 '
+
+test_expect_success 'line numbers in --check output are correct' '
+
+	echo "" > x &&
+	echo "foo(); " >> x &&
+	git diff --check | grep "x:2:"
+
+'
+
 test_done
-- 
1.5.4.1.1281.g75df
