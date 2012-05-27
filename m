From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 0/9] submodule: improve robustness of path handling
Date: Sun, 27 May 2012 23:43:21 +1000
Message-ID: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 15:43:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYdl5-0005fy-3r
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 15:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab2E0Nnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 09:43:43 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41007 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab2E0Nnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 09:43:42 -0400
Received: by pbbrp8 with SMTP id rp8so3605857pbb.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=yvH+BVybMeLuX35rUhJHlspUKQCD4FPBk14pPPTjXSM=;
        b=o3Int6JLXk6zk+DK1jpemK2BqajsHRQpfd+Db9MSrnWo8HIOpHIW6voFr+dLoqzSAS
         ziMBjJDZMslIstl73sPYGLG6QZCp7WaHY+7o9ccPSnFUYzd+VSGLDOqFIH1DB+dAvYjK
         FjMwDh7RDjnLeRqnlsdBnVtwLbprqUJA9Co79tBt9rR6vBQLgCMEflLt461tlQ1PT3BV
         dPaMHDnCQR3SyDulRsRShE86TNpSzdJrrss3yDmW5p6RcGY3oruqMSqH7DSKLoakWcqe
         rxZRBNvYy0Sv5J7fZvf+xPgyYpwZj5G0/8/Ms85VhxrKSNQFPAZOeAgpftvunowPQ+EB
         Du9g==
Received: by 10.68.200.9 with SMTP id jo9mr16985885pbc.122.1338126221788;
        Sun, 27 May 2012 06:43:41 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id ru4sm15870005pbc.66.2012.05.27.06.43.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 06:43:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.gb5a46db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198591>

This series improves the robustness of path handling by 'git submodule' by:

* detecting submodule URLs that will result in non-sensical submodule origin URLs

* improving handling of various kinds of relative superproject origin URLs

* improving handling of various kinds of denormalized superproject origin URLs

This series differs from v5 in the following ways, by:

* Adding a more extensive set of failure tests to illustrate the conditions 
being addressed.

* Modifying the ../ processing loop in resolve_relative_url to exclude the 
'invariant' parts of absolute URLs from relative URL processing and thereby 
enable earlier and more accurate detection of edits that are going to 
produce a non-sensical output.

* Simplifying relative superproject origin URL support, by taking advantage of
the modifications above.

* Adding support for normalizing denormalized superproject origin URLs.

* Adding some additional regression tests to help guard against 
unintended regressions by this series.

* Improving the source code comments to better explain the purpose
of various code functions and code blocks

Jon Seymour (9):
  submodule: additional regression tests for relative URLs
  submodule: document failure to detect invalid submodule URLs
  submodule: document failure to handle relative superproject origin
    URLs
  submodule: document failure to handle improperly normalized remote
    origin URLs
  submodule: extract normalize_path into standalone function
  submodule: fix detection of invalid submodule URL
  submodule: fix sync handling of relative superproject origin URLs
  submodule: fix handling of denormalized superproject origin URLs
  submodule: fix normalization to handle repeated ./

 git-submodule.sh           | 118 +++++++++++++-----
 t/t7400-submodule-basic.sh | 297 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t7403-submodule-sync.sh  |  84 ++++++++++++-
 3 files changed, 468 insertions(+), 31 deletions(-)

-- 
1.7.10.2.656.gb5a46db
