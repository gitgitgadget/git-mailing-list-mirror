From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 00/11] transport-helper: updates
Date: Tue, 12 Nov 2013 14:56:53 -0600
Message-ID: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:04:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL89-0007Gw-0P
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204Ab3KLVEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:04:09 -0500
Received: from mail-oa0-f51.google.com ([209.85.219.51]:46413 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170Ab3KLVED (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:04:03 -0500
Received: by mail-oa0-f51.google.com with SMTP id i4so4111261oah.38
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yjOsTEerELivgQDP/9y0pJFDB4WOOQGUkcAm+RYlDJY=;
        b=KEuVODt/k45SgxXHkAyREPrxX7KYiYsmD0+oCAez24BZ86QBT5R24YYNfvDjas74xg
         NoPNTvrcmoHyuXW2x0DhgmVOt83cpkS/fYlc4c318oyJ6Gj9FLsj0ruLnpiaROmrfZHf
         xjNvG0S1s5A5a+e7NRRbDpSQJt5du4UdhLEnQp0fVGKmHxIFVwoxZgZTRd74XJZNpIR6
         iJisysiNxtYGLgPWqP85PzbgYdZ6O6Uc2E7zzujSO73/2QubujI3b7ie/wtJtWyda3iF
         2R1n9iMCZCdmRQl7D55TRcrzG3gHQG3f56egxT/3AASHd8S3PSf628VF6L6NB/2/SeQo
         E10g==
X-Received: by 10.182.61.8 with SMTP id l8mr3319938obr.88.1384290242412;
        Tue, 12 Nov 2013 13:04:02 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm35382558obu.4.2013.11.12.13.04.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:04:01 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237738>

Hi,

Here are the patches that allow transport helpers to be completely transparent;
renaming branches, deleting them, custom refspecs, --force, --dry-run,
reporting forced update, everything works.

Changes since v6:

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 72f745d..aacd8a9 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -599,7 +599,7 @@ test_expect_success 'remote big push fetch first' '
 	)
 '
 
-test_expect_failure 'remote big push force' '
+test_expect_success 'remote big push force' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
 	setup_big_push
@@ -629,7 +629,7 @@ test_expect_failure 'remote big push force' '
 	check_bookmark hgrepo new_bmark six
 '
 
-test_expect_failure 'remote big push dry-run' '
+test_expect_success 'remote big push dry-run' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
 	setup_big_push
diff --git a/transport-helper.c b/transport-helper.c
index 2257588..7a95125 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -863,7 +863,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (flags & TRANSPORT_PUSH_FORCE) {
 		if (set_helper_option(transport, "force", "true") != 0)
-			die("helper %s does not support 'force'", data->name);
+			warning("helper %s does not support 'force'", data->name);
 	}
 
 	helper = get_helper(transport);

Felipe Contreras (10):
  transport-helper: fix extra lines
  transport-helper: don't update refs in dry-run
  transport-helper: add 'force' to 'export' helpers
  transport-helper: check for 'forced update' message
  fast-export: improve argument parsing
  fast-export: add new --refspec option
  transport-helper: add support for old:new refspec
  fast-import: add support to delete refs
  fast-export: add support to delete refs
  transport-helper: add support to delete branches

Richard Hansen (1):
  test-hg.sh: tests are now expected to pass

 Documentation/git-fast-export.txt   |  4 +++
 Documentation/git-fast-import.txt   |  3 +++
 Documentation/gitremote-helpers.txt |  4 +++
 builtin/fast-export.c               | 49 ++++++++++++++++++++++++++++++++++++-
 contrib/remote-helpers/test-hg.sh   |  4 +--
 fast-import.c                       | 13 +++++++---
 git-remote-testgit.sh               | 18 ++++++++++++++
 t/t5801-remote-helpers.sh           | 23 ++++++++++++++++-
 t/t9300-fast-import.sh              | 18 ++++++++++++++
 t/t9350-fast-export.sh              | 18 ++++++++++++++
 transport-helper.c                  | 47 +++++++++++++++++++++++------------
 11 files changed, 179 insertions(+), 22 deletions(-)

-- 
1.8.4.2+fc1
