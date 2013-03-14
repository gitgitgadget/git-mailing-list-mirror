From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] entry: fix filter lookup
Date: Thu, 14 Mar 2013 20:00:51 +0000
Message-ID: <bede6d48dd44f7ed4a11da5821bb112b700475d5.1363291173.git.john@keeping.me.uk>
References: <7vehfhyjgv.fsf@alter.siamese.dyndns.org>
 <cover.1363291173.git.john@keeping.me.uk>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 21:01:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGELd-0003Rq-Qx
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 21:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab3CNUBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 16:01:31 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:38621 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab3CNUBa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 16:01:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 1E4C4161E529;
	Thu, 14 Mar 2013 20:01:30 +0000 (GMT)
X-Quarantine-ID: <5o6URWnL6CIY>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5o6URWnL6CIY; Thu, 14 Mar 2013 20:01:29 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 9E535161E54C;
	Thu, 14 Mar 2013 20:01:19 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.rc2.4.g7799588
In-Reply-To: <cover.1363291173.git.john@keeping.me.uk>
In-Reply-To: <cover.1363291173.git.john@keeping.me.uk>
References: <cover.1363291173.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218163>

When looking up the stream filter, write_entry() should be passing the
path of the file in the repository, not the path to which the content is
going to be written.  This allows the file to be correctly looked up
against the .gitattributes files in the working tree.

This change makes the streaming case match the non-streaming case which
passes ce->name to convert_to_working_tree later in the same function.

The two tests added here test the different paths through write_entry
since the CRLF filter is a streaming filter but the user-defined smudge
filter is not streamed.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 entry.c                         |  2 +-
 t/t2003-checkout-cache-mkdir.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/entry.c b/entry.c
index 17a6bcc..63c52ed 100644
--- a/entry.c
+++ b/entry.c
@@ -145,7 +145,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 	struct stat st;
 
 	if (ce_mode_s_ifmt == S_IFREG) {
-		struct stream_filter *filter = get_stream_filter(path, ce->sha1);
+		struct stream_filter *filter = get_stream_filter(ce->name, ce->sha1);
 		if (filter &&
 		    !streaming_write_entry(ce, path, filter,
 					   state, to_tempfile,
diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
index 63fd0a8..4c97468 100755
--- a/t/t2003-checkout-cache-mkdir.sh
+++ b/t/t2003-checkout-cache-mkdir.sh
@@ -90,4 +90,30 @@ test_expect_success SYMLINKS 'use --prefix=tmp- where tmp-path1 is a symlink' '
 	test -f tmp-path1/file1
 '
 
+test_expect_success 'apply filter from working tree .gitattributes with --prefix' '
+	rm -fr path0 path1 path2 tmp* &&
+	mkdir path1 &&
+	mkdir tmp &&
+	git config filter.replace-all.smudge "sed -e s/./=/g" &&
+	git config filter.replace-all.clean cat &&
+	git config filter.replace-all.required true &&
+	echo "file1 filter=replace-all" >path1/.gitattributes &&
+	git checkout-index --prefix=tmp/ -f -a &&
+	echo frotz >expected &&
+	test_cmp expected tmp/path0 &&
+	echo ====== >expected &&
+	test_cmp expected tmp/path1/file1
+'
+
+test_expect_success 'apply CRLF filter from working tree .gitattributes with --prefix' '
+	rm -fr path0 path1 path2 tmp* &&
+	mkdir path1 &&
+	mkdir tmp &&
+	echo "file1 eol=crlf" >path1/.gitattributes &&
+	git checkout-index --prefix=tmp/ -f -a &&
+	echo rezrovQ >expected &&
+	tr \\015 Q <tmp/path1/file1 >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.2.rc2.4.g7799588
