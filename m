From: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
Subject: [PATCH] git-format-patch: add --no-binary to omit binary changes in the patch.
Date: Tue,  6 May 2008 14:47:59 -0300
Message-ID: <1210096079-32399-1-git-send-email-cmarcelo@gmail.com>
Cc: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 19:54:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtRN9-0005fT-NB
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 19:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbYEFRxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 13:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbYEFRxu
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 13:53:50 -0400
Received: from ag-out-0708.google.com ([72.14.246.249]:63414 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbYEFRxs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 13:53:48 -0400
Received: by ag-out-0708.google.com with SMTP id 31so1783310agc.10
        for <git@vger.kernel.org>; Tue, 06 May 2008 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=gKEjQQBUwCjK3rIVp/8jcb/v/wXUAqiWsAZ793ulFfc=;
        b=RIzSx0W0pZvoxUQf6tjgD+9SON+HrGr0q5YeV0WYz6RrfTLRK4upDCwGc1o2GALUbSdSGavV70FZZjn3Fw8Hz0yKSeEKU6kkXxRDtyHe6pIYqFc6Eya5FmEzcSeqRGygqGPiwK8ozSV6GXng9ASMnSY7pCrbcshH17Y6u5DOSUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=v6UMGqBrYUfD/pQL1MGGu1v3fhfEzBjnKb35wjKCxvrcJEb2EnTSosWy98izhP922TdW8PvdQU9VL9uFhZcjK6lxrEiZbC8uJFW4Awg3535r83u+66ALn7jQ4jlli74aMQtz2917SedxZ55UXexWu4b00jTFfWNV6lWCCP8ve0s=
Received: by 10.150.12.3 with SMTP id 3mr1071458ybl.16.1210096427406;
        Tue, 06 May 2008 10:53:47 -0700 (PDT)
Received: from anon3167.osmtc.indt.org.br ( [200.184.118.132])
        by mx.google.com with ESMTPS id i13sm1297878wxd.5.2008.05.06.10.53.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 May 2008 10:53:46 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.147.g867f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81373>

Add a new option --no-binary to git-format-patch so that no binary
changes are included in the generated patches, only notices that those
files changed.  This generate patches that cannot be applied, but still
is useful for generating mails for code review purposes.

See also: commit e47f306d4bf964def1a0b29e8f7cea419471dffd, where --binary
option was turned on by default.

Signed-off-by: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
---

This is a first try on the patch.  The extra option affects only
git-format-patch, since the special case (activating --binary if
--text wasn't set) is only there.


 Documentation/git-format-patch.txt |    6 ++++++
 builtin-log.c                      |    5 ++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index b5207b7..81c930a 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -150,6 +150,12 @@ include::diff-options.txt[]
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specified suffix.  A common alternative is
 	`--suffix=.txt`.
+
+--no-binary::
+	Don't output contents of changes in binary files, just take note
+	that they differ.  Note that this disable the patch to be properly
+	applied.  By default the contents of changes in those files are
+	encoded in the patch.
 +
 Note that you would need to include the leading dot `.` if you
 want a filename like `0001-description-of-my-change.patch`, and
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
