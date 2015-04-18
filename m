From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH/RFC v3 0/4] Improving performance of git clean
Date: Sat, 18 Apr 2015 22:41:08 +0200
Message-ID: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 22:41:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjZYg-0005eB-Hm
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 22:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbbDRUll convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2015 16:41:41 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:36751 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbbDRUlk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 16:41:40 -0400
Received: by lagv1 with SMTP id v1so102290067lag.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=vt7pvA5A9FEN7l1D3BCKAixyEff5dXFvm4Sfh6MSc7Y=;
        b=Rr0wxkkMgRbt5U/vqlG4kA3BKiOUC2RFQS8e3rBhbhd6yr7kxL9eGu2XZt+8cXgTTM
         /Mr4iwTRAa3rpiyj7N1m89KQQ5+52HbGeh6moa5rqRzusV8+al3R5b//fuwplLH5Vieu
         L2dw8vRiuYHVbYNByXF0WFPLIrRnAiscWDANBpHY/d+FEcvgQU9fe2m1M54zgtXbiw+w
         rZTmXItaJ9M5PIlVoY3fuSaKBdYUrNEPvfgYPIdIy70HnxNrHwTDOYQB6lZ4BpkCYevu
         jSoT2/lGnHR7pNxua2K8QtM6UX3yQIYzvUXIvxkjjVKrm2Bd6YgLhyCbGra1eAivNZTI
         FKrw==
X-Received: by 10.112.125.33 with SMTP id mn1mr1953417lbb.82.1429389699170;
        Sat, 18 Apr 2015 13:41:39 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id sh6sm3249256lbb.31.2015.04.18.13.41.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Apr 2015 13:41:38 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc2.5.g2871d5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267422>

I've marked this RFC since there are known problems here.

v2 of the patch can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/267023/focus=3D2=
67023

Changes in v3:
* Created setup.c:read_gitfile_gently to use for submodule
  probing
* Cleanup of some tests by use of test_commit helper
* Added more tests of cleaning in the presence of submodules
* Reversed expectation of test for cleaning nested bare repos.
  They are now expected to be cleaned. Added one more case.
* Fixed bug where submodules could be cleaned by using new
  read_gitfile_gently for additional submodule check in
  clean.c:is_git_repository
* Attempt to change behavior of patch implementation to clean
  bare repositories (only partially successful)
* Reworded commit message of the performance fix commit

Known Problems:
* Unsure about the setup.c:read_gitfile refactor, feels a bit
  messy?
* Potentially a missing sanity check of git file size in
  setup.c:read_gitfile_gently_or_non_gently
* We still get a behavioral change for empty bare repositories
  placed in a ".git" directory. Currently we clean empty bare
  repos in a .git folder but not non-empty one. After this
  patch we won't clean either. How serious is this? Is there
  an easy fix (preferebly to clean all bare repositories)?
* Still have issues in the performance tests, see comments
  from Thomas Gummerer on v2

Thanks to Junio C Hamano and Jeff King for spotting fundamental
problems in v2 and suggesting a solution.

Erik Elfstr=C3=B6m (4):
  setup: add gentle version of read_gitfile
  t7300: add tests to document behavior of clean and nested git
  p7300: add performance tests for clean
  clean: improve performance when removing lots of directories

 builtin/clean.c       |  25 ++++++++--
 cache.h               |   1 +
 setup.c               |  94 ++++++++++++++++++++++++++++---------
 t/perf/p7300-clean.sh |  37 +++++++++++++++
 t/t7300-clean.sh      | 125 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 257 insertions(+), 25 deletions(-)
 create mode 100755 t/perf/p7300-clean.sh

--=20
2.4.0.rc2.5.g2871d5e
