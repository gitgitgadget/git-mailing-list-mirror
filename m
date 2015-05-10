From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v6 0/7] Improving performance of git clean
Date: Sun, 10 May 2015 22:00:34 +0200
Message-ID: <1431288041-21077-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 22:02:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrXQm-0004lk-Nb
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 22:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbbEJUC0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2015 16:02:26 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34444 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbbEJUCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 16:02:25 -0400
Received: by lbcga7 with SMTP id ga7so81727278lbc.1
        for <git@vger.kernel.org>; Sun, 10 May 2015 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=tmyYIhfz5+erEEPXH7xMalgoCbUGKVR9vB1H9OEDgRg=;
        b=loM9MU5AT67dDuLDbW7SgN6eNpVtnDZ4Utc9OKjbxt5N7jEvBYSrInm+nkwNoXN346
         P08H2HA5kZ02PfWsawy6+qUdi+pWyYDgeQI8JdGuBMJqXMzLkKxhLlcsouiykIClA20F
         DxmMKLtcVMSO9UjWMrJS83cKDHDhAo2L0GK5CR6OZOkYI5sILiIrAGMO3BWjw+zMIOYK
         cnmEkX3AYSHYZpC/r3B0te3aRENXC7qbA3h4tdl1xGnVYY7tksH9iFRXiXPvbq7AH23w
         2irAawRXo4SD2CfBXpjwjOpoB0RaWjM+YV+CJ+k/ulFVohhT0QheL/z/iHZY0xQ+3aVX
         Bn3g==
X-Received: by 10.152.115.232 with SMTP id jr8mr5457343lab.2.1431288143464;
        Sun, 10 May 2015 13:02:23 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id k15sm2586218laa.28.2015.05.10.13.02.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 May 2015 13:02:22 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.60.gf7143f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268741>

Here is v6 of of this series. v5 can be found at:

http://thread.gmane.org/gmane.comp.version-control.git/267823

Sorry for the slow progress on this, I've been busy with other things.

Changes in v6:
* added gentle version of is_git_directory and used it in
  read_gitfile_gently
* use 1MB as size limit for read_gitfile_gently instead of
  PATH_MAX*4
* fixed file descriptor leak in read_gitfile_gently
* avoid cleaning if we can't open, read or validate the path in a git
  file (we used to die on these cases).
* added one more testcase to cover the behavior mention above.
* switched to default repo in performance test


Erik Elfstr=C3=B6m (7):
  setup: add gentle version of is_git_directory
  setup: add gentle version of read_gitfile
  setup: sanity check file size in read_gitfile_gently
  t7300: add tests to document behavior of clean and nested git
  p7300: add performance tests for clean
  clean: improve performance when removing lots of directories
  RFC: Change error handling scheme in read_gitfile_gently

 builtin/clean.c       |  32 ++++++++--
 cache.h               |  16 +++++
 setup.c               | 158 ++++++++++++++++++++++++++++++++++++++++++=
+-------
 t/perf/p7300-clean.sh |  31 ++++++++++
 t/t7300-clean.sh      | 144 ++++++++++++++++++++++++++++++++++++++++++=
+++
 5 files changed, 355 insertions(+), 26 deletions(-)
 create mode 100755 t/perf/p7300-clean.sh

--=20
2.4.0.60.gf7143f7
