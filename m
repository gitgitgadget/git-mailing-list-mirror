From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/7] Raw gpg output support for verify-commit and verify-tag
Date: Sun, 21 Jun 2015 23:14:36 +0000
Message-ID: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 01:15:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6oS8-00066b-7y
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 01:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbbFUXO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 19:14:56 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51173 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752277AbbFUXOy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jun 2015 19:14:54 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1062A28093;
	Sun, 21 Jun 2015 23:14:53 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272302>

Currently, verify-commit and verify-tag produce human-readable output.
This is great for humans, and awful for machines.  It also lacks a lot
of the information that GnuPG's --status-fd output provides.

For example, if you wanted to know
* the hash algorithm;
* whether the signature was made with a subkey; or
* the OpenPGP signature version
none of that information is available in the human-readable output.

This series introduces a --raw option for verify-commit and verify-tag.
If it's used, they provide the gpg --status-fd output on standard error
instead of the human-readable output.  The series also adds tests for
verify-tag, since there were none; these are based off the ones for
verify-commit.

v2 of the series corrects one of two incompatibilities between
verify-commit and verify-tag.  If a valid signature was made with an
untrusted key, verify-commit would exit 1, but verify-tag would exit 0.
This has been corrected (as Michael J Gruber suggested); both now return
0, as the signature is in fact good.

The other incompatibility is that verify-tag --verbose always prints the
tag contents even if no signature is found, while verify-commit
--verbose does not print the commit.  I left this alone, as it seemed
easy enough to accommodate at the expense of making the code slightly
uglier.

Changes since v1:
* Unify some of the code between verify-commit and verify-tag.
* Pass the --verbose and --raw options as flags instead of individual
  boolean arguments.
* Reorder the patches to ensure that verify-tag tests came before
  refactors, to avoid regressing functionality.
* Changed verify-commit to succeed if a signature is good, regardless of
  whether it is trusted, at Michael J Gruber's suggestion.

brian m. carlson (7):
  verify-tag: add tests
  verify-tag: share code with verify-commit
  verify-commit: add test for exit status on untrusted signature
  gpg: centralize signature check
  gpg: centralize printing signature buffers
  verify-commit: add option to print raw gpg status information
  verify-tag: add option to print raw gpg status information

 Documentation/git-verify-commit.txt |   4 ++
 Documentation/git-verify-tag.txt    |   4 ++
 builtin/verify-commit.c             |  25 ++++----
 builtin/verify-tag.c                |  30 +++++++---
 commit.c                            |  21 ++-----
 commit.h                            |   2 +-
 gpg-interface.c                     |  37 ++++++++++++
 gpg-interface.h                     |   6 ++
 t/t7030-verify-tag.sh               | 115 ++++++++++++++++++++++++++++++++++++
 t/t7510-signed-commit.sh            |  38 ++++++++++++
 10 files changed, 246 insertions(+), 36 deletions(-)
 create mode 100755 t/t7030-verify-tag.sh

-- 
2.4.0
