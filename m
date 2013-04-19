From: Johan Herland <johan@herland.net>
Subject: [RFD/PATCH 0/5] Improving the search for remote-tracking branches
Date: Fri, 19 Apr 2013 08:20:37 +0200
Message-ID: <1366352442-501-1-git-send-email-johan@herland.net>
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 08:21:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT4hH-0002P5-Ip
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 08:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641Ab3DSGVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 02:21:19 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:54309 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756609Ab3DSGVS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 02:21:18 -0400
Received: by mail-la0-f48.google.com with SMTP id fq13so2143527lab.21
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 23:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=qp5xQmRQV2EV/0isCAr0UIb0kSYww6eJF7zi8UIq40I=;
        b=OEYew6MPztRGyzoM0lDPFGrVs2KC7N9TcSUJ373q9K6LSntGC5lMaiZ763a1u28DGX
         pH96WklnqtUe44OBokSKkbA8iejzNfYB7Y+deaAY4hUXYXauKkgN+qxoLS+oICKbPk1T
         qERO1fpJXYlfeDP/C6ua10JbyoCs3wXl4iDIBvTFcCjw1eUcEy2N4x0RTkZNA0MrF0ri
         MISFPW3LGpy54ajJTCjOsIimlrMUW7Hjup8poi+S7ayIvXMx8vVZ0WNFzFWSDSjAZJGn
         QxX95iuNuWuYX52QYiL7ij9SNH59rvtRgBRoy+jS40wxwhhiBzpZfudfVZZYogfHR/hq
         QriQ==
X-Received: by 10.112.59.103 with SMTP id y7mr7325554lbq.16.1366352477123;
        Thu, 18 Apr 2013 23:21:17 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id f4sm2076904lbw.6.2013.04.18.23.21.15
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 23:21:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221742>

Hi,

The following patch series has three uncontroversial patches (I hope)
to improve the DWIM behavivor "git checkout foo", followed by two more
experimental patches meant to trigger discussion about how Git decides
on what is a remote-tracking branch, and what is not:

The first three patches concern the DWIMming of "git checkout foo" into
"git checkout -b foo --track refs/remotes/$remote/foo". This DWIMming
depends on finding exactly _one_ remote "$remote" having a remote-
tracking branch called "foo". Currently we find remote-tracking branches
by pattern-matching refs against "refs/remotes/*/foo", but instead we
should look at the configured refspecs to find the real set of remote-
tracking branch candidates. This fixes the DWIM behavior when the user
has tweaked refspecs to place remote-tracking branches elsewhere (e.g.
refs/remotes/$remote/heads/foo). The argument is explained more closely
in patch #3.

The remaining two patches tries to apply the same argument to the
-t/--track argument to checkout/branch: This option takes a remote-
tracking branch (or a local branch) as argument, but validating this
argument is currently done by a simple match against refs/remotes/*
(or refs/heads/*). By the same reasoning as above, we should instead
look at the configured refspecs to determine whether the argument is
a valid remote-tracking branch. However, as shown in the final patch,
this would break a few tests where we currently try to --track refs
that are not "proper" remote-tracking branches (in that they do not
correspond to a refspec of some remote).

- Should we simply "fix" these tests (t3200.39, t7201.24, t9114.*), and
  _require_ that all remote-tracking branches must have corresponding
  refspecs configured?

- Are there valid real-world use cases that would be broken by such a
  requirement?

- Is it preferable to stop after patch #4, and accept the superset of
  refs/remotes/* and refspec-matching refs as valid remote-tracking
  branches?


Have fun! :)

...Johan


Johan Herland (5):
  t2024: Add tests verifying current DWIM behavior of 'git checkout <branch>'
  t2024: Show failure to use refspec when DWIMming remote branch names
  checkout: Use remote refspecs when DWIMming tracking branches
  branch.c: Look up refspecs to validate tracking branches
  RFD: Disallow out-of-refspec refs within refs/remotes/* to be used as upstream

 Documentation/git-checkout.txt   |   6 +-
 branch.c                         |  17 +++++-
 builtin/checkout.c               |  42 +++++++-------
 t/t2024-checkout-dwim.sh         | 116 +++++++++++++++++++++++++++++++++++++++
 t/t3200-branch.sh                |   2 +-
 t/t7201-co.sh                    |   2 +-
 t/t9114-git-svn-dcommit-merge.sh |   8 +--
 7 files changed, 163 insertions(+), 30 deletions(-)
 create mode 100755 t/t2024-checkout-dwim.sh

-- 
1.8.1.3.704.g33f7d4f
