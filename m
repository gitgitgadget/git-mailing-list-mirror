From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v7 0/9] submodule: improve robustness of path handling
Date: Mon, 28 May 2012 01:34:02 +1000
Message-ID: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 17:35:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYfUj-00059m-6E
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 17:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406Ab2E0PeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 11:34:23 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58786 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab2E0PeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 11:34:23 -0400
Received: by dady13 with SMTP id y13so3166603dad.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=fPpr6aL1nRyXW1I5FMmfhN1vvtTTc2AbKTjlu7iM7Pg=;
        b=tiXiajtpJGMlRYRo0bsUKwmuCOA21b76PKh0k7oIG9NtJyHkXCbIjGzh1q0XOKGbBb
         h5sRkYLgOh2tv1YhE4Ha164SIzuCZxp7iTPVoimmXtMwfyA4FF/vVVN5UDG5mrtfkFqb
         +elTCH+bCtopXu2QuGWW4FIQBrb5quO3OrV/ShQIQUYfpNiEG9WeqB50dLk3wE5kAzU2
         GeyKHYawoozZZThgy3ZtBE3UlPSOUrH4bdzxj8QJk31GyyjbPbTmRAk/gfqNJ6GJLNgl
         6IgqPBZcTip9xjWB1ewDH4A5XRiIaO9nMx70N13vflGoVE3AMjHFwXiEKDZrrNp3cwUO
         NTYQ==
Received: by 10.68.228.170 with SMTP id sj10mr17948302pbc.106.1338132862373;
        Sun, 27 May 2012 08:34:22 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id rk4sm16128261pbc.48.2012.05.27.08.34.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 08:34:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.g24a6219
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198604>

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

This series differs from v6 by applying the fix in 8/9 to a wider set of tests.

Each patch in the series has been regression tested against the following tests:

   t2013-checkout-submodule.sh
   t2103-update-index-ignore-missing.sh
   t2105-update-index-gitfile.sh
   t2201-add-update-typechange.sh
   t3000-ls-files-others.sh
   t3030-merge-recursive.sh
   t3404-rebase-interactive.sh
   t4027-diff-submodule.sh
   t4041-diff-submodule-option.sh
   t4134-apply-submodule.sh
   t5526-fetch-submodules.sh
   t5531-deep-submodule-push.sh
   t6008-rev-list-submodule.sh
   t7003-filter-branch.sh
   t7400-submodule-basic.sh
   t7401-submodule-summary.sh
   t7402-submodule-rebase.sh
   t7403-submodule-sync.sh
   t7405-submodule-merge.sh
   t7406-submodule-update.sh
   t7407-submodule-foreach.sh
   t7408-submodule-reference.sh
   t7506-status-submodule.sh
   t7508-status.sh
   t7610-mergetool.sh
   t9300-fast-import.sh
   t9350-fast-export.sh

which are the tests that match a grep search for submodule.

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

 git-submodule.sh             | 118 +++++++++++++----
 t/t7400-submodule-basic.sh   | 297 ++++++++++++++++++++++++++++++++++++++++++-
 t/t7403-submodule-sync.sh    |  97 +++++++++++++-
 t/t7406-submodule-update.sh  |  16 ++-
 t/t7407-submodule-foreach.sh |  14 +-
 t/t7506-status-submodule.sh  |  10 +-
 6 files changed, 504 insertions(+), 48 deletions(-)

-- 
1.7.10.2.656.g24a6219
