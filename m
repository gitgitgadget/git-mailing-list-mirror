From: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
Subject: [PATCH] git-format-patch: add --no-binary to omit binary changes in the patch.
Date: Fri,  9 May 2008 19:55:43 -0300
Message-ID: <1210373743-5646-1-git-send-email-cmarcelo@gmail.com>
References: <2c6b72b30805091408i1924b755k3d1f5f4bb0cfaf08@mail.gmail.com>
Cc: gitster@pobox.com,
	Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 01:03:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JubcQ-0003TE-GP
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 01:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbYEIXCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 19:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbYEIXCZ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 19:02:25 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:29462 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbYEIXCY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 19:02:24 -0400
Received: by yw-out-2324.google.com with SMTP id 9so831743ywe.1
        for <git@vger.kernel.org>; Fri, 09 May 2008 16:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Pm8YJmk1xUcDCyhzBHaw1ZagavaRu9YJdpFKRZGcHX4=;
        b=QNpTmmoL8/Rou8ODDMuqn3CBHZY1qRywJT4rZ5Tban37qf8t8c7kPmEx/mpwx3Lymci0MlT8o3kqUj+euWo8F8M2cRuUAvY6sD5bL+9NzzfvkobO2M7jWap5kQyHGqMpLLJTcCpuosFYAOlRdKM+TXukv7SqxxVYyC87yC7el9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=R8QkFS2Wj7eM+zKtHOghQgKXWPQ8cpUq0tLLBz5va3roa5HFyyfFm27Pw3lyLKPrHFsQ/qIQszyqLUR95/cUn1ZOlz/RLVghbagkw6hc7f6tgrP38S/sX0E/Ruchl03qgWiEyeO0x03VWKJIQNudEiCH9QDIwjwq9JnwiG10pRQ=
Received: by 10.150.82.41 with SMTP id f41mr5468655ybb.172.1210374132038;
        Fri, 09 May 2008 16:02:12 -0700 (PDT)
Received: from anon3167.osmtc.indt.org.br ( [200.184.118.132])
        by mx.google.com with ESMTPS id 8sm9112483ywg.6.2008.05.09.16.02.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 May 2008 16:02:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.179.gf4df2
In-Reply-To: <2c6b72b30805091408i1924b755k3d1f5f4bb0cfaf08@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81632>

Add a new option --no-binary to git-format-patch so that no binary
changes are included in the generated patches, only notices that those
files changed.  This generate patches that cannot be applied, but still
is useful for generating mails for code review purposes.

See also: commit e47f306d4bf964def1a0b29e8f7cea419471dffd, where --binary
option was turned on by default.

Signed-off-by: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
---

Fixed the manpage, thanks Jonas Fonseca.

 Documentation/git-format-patch.txt |    6 ++++++
 builtin-log.c                      |    5 ++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 87e491b..7548a21 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -156,6 +156,12 @@ want a filename like `0001-description-of-my-change.patch`, and
 the first letter does not have to be a dot.  Leaving it empty would
 not add any suffix.
 
+--no-binary::
+	Don't output contents of changes in binary files, just take note
+	that they differ.  Note that this disable the patch to be properly
+	applied.  By default the contents of changes in those files are
+	encoded in the patch.
+
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message
diff --git a/builtin-log.c b/builtin-log.c
index 256bbac..80a01f8 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -757,6 +757,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int thread = 0;
 	int cover_letter = 0;
 	int boundary_count = 0;
+	int no_binary_diff = 0;
 	struct commit *origin = NULL, *head = NULL;
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
@@ -862,6 +863,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			fmt_patch_suffix = argv[i] + 9;
 		else if (!strcmp(argv[i], "--cover-letter"))
 			cover_letter = 1;
+		else if (!strcmp(argv[i], "--no-binary"))
+			no_binary_diff = 1;
 		else
 			argv[j++] = argv[i];
 	}
@@ -914,7 +917,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY | DIFF_FORMAT_PATCH;
 
-	if (!DIFF_OPT_TST(&rev.diffopt, TEXT))
+	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)
 		DIFF_OPT_SET(&rev.diffopt, BINARY);
 
 	if (!output_directory && !use_stdout)
-- 
1.5.5.1.147.g867f.dirty
