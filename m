From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/3] Raw gpg output support for verify-commit and verify-tag
Date: Sun, 14 Jun 2015 18:51:47 +0000
Message-ID: <1434307910-705555-1-git-send-email-sandals@crustytoothpaste.net>
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 20:52:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4D11-0003RX-Um
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 20:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbbFNSwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 14:52:17 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:43776 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753199AbbFNSwL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2015 14:52:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DCBA82808F;
	Sun, 14 Jun 2015 18:52:09 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
X-Spam-Score: -1 ALL_TRUSTED
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271643>

Currently, verify-commit and verify-tag produce human-readable output.
This is great for humans, and awful for machines.  It also lacks a lot
of the information that GnuPG's --status-fd output provides.

For example, if you wanted to know
* the hash algorithm;
* whether the signature was made with a subkey; or
* the OpenPGP signature version
none of that information is available in the human-readable output.

We've had people in the past come to the list who require signed commits
in their corporate environment.  It's not unreasonable to expect that
they might want to programmatically verify signatures, including aspects
of the signatures we don't currently expose.  It's also much nicer to
parse the machine-readable output we already collect than hoping GnuPG
doesn't change its output.

This series introduces a --raw option for verify-commit and verify-tag.
If it's used, they provide the gpg --status-fd output on standard error
instead of the human-readable output.  The series also adds tests for
verify-tag, since there were none; these are based off the ones for
verify-commit.

In writing this series, I noticed an incompatibility between
verify-commit and verify-tag.  If a valid signature is made with an
untrusted key, verify-commit will exit 1, but verify-tag will exit 0.
I'm unclear on what we can do about this now, short of adding another
option.  This is because the two commands share little common code.

brian m. carlson (3):
  verify-commit: add option to print raw gpg status information
  verify-tag: add tests
  verify-tag: add option to print raw gpg status information

 Documentation/git-verify-commit.txt |   4 ++
 Documentation/git-verify-tag.txt    |   4 ++
 builtin/verify-commit.c             |  13 ++--
 builtin/verify-tag.c                |  21 +++++--
 t/t7030-verify-tag.sh               | 116 ++++++++++++++++++++++++++++++++++++
 t/t7510-signed-commit.sh            |  32 ++++++++++
 6 files changed, 178 insertions(+), 12 deletions(-)
 create mode 100755 t/t7030-verify-tag.sh

-- 
2.4.0
