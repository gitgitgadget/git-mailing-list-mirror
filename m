From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v8 0/7] bisect: Add support for --no-checkout and --update-ref=<ref> options.
Date: Sun, 31 Jul 2011 21:55:14 +1000
Message-ID: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 13:56:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnUd9-0002eN-Pc
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 13:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234Ab1GaLzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 07:55:51 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:33709 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab1GaLzt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 07:55:49 -0400
Received: by pzk37 with SMTP id 37so9556049pzk.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 04:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=vE1gkrtoVn3VRHTMNFYFf8CXU63dTNpHthm5ia2zyVE=;
        b=pwMbkXZjnhP6KowGxsO7wdPGwpkGtXnACREf2lX+FVGoVXriT3aJipzc8puUEc+VWL
         8XFBYiZ+3QG5/RWbqnRDW7bj+mreY8CctTipJIna8hyqZ3YpxUNnQCMugdjTBmSehAE2
         XM8BBORgW24Rw/nh3xVEGJ4lVdlhB8kUMJ1VA=
Received: by 10.68.49.70 with SMTP id s6mr5663644pbn.233.1312113348820;
        Sun, 31 Jul 2011 04:55:48 -0700 (PDT)
Received: from localhost.localdomain ([120.16.239.154])
        by mx.google.com with ESMTPS id g4sm4306620pbj.41.2011.07.31.04.55.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 04:55:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g62761
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178237>

For some bisection tasks, checking out the commit at each stage of the bisection process is unecessary or undesirable.

This series adds support for --no-checkout and --update-ref=<ref> options to git-bisect.

If specified on a start command, --no-checkout causes 'git bisect' to update HEAD at each stage of the bisection process instead of checking out the commit at that point. An alternative reference to update may be specified with --update-ref=<ref>.

One application of the --no-checkout option is to find, within a partially damaged repository, a commit that has at least one parent whose graph is fully reachable in the sense of 'git pack-objects'.

For example:

	git bisect run eval '
		rc=1;
		if git rev-list --objects HEAD >tmp.$$; then
		   git pack-objects --stdout >/dev/null < tmp.$$ && rc=0;
		fi;
		rm tmp.$$;
		test $rc -eq 0;'

Assuming this git bisect run completes successfully, bisect/bad will refer to a commit which has at least one parent that is fully reachable in the sense of 'git pack-objects'.

PLEASE NOTE: the initial patch in this series "bisect: move argument parsing before state modification." changes existing behaviour in the case that an invalid revision argument is supplied to 'git bisect start'. In particular, in this case, bisection state is neither created or modified if argument validation fails. Previously, existing bisection state would be cleared even if the revision arguments were subsequently determined to be invalid.

v8:
	Further feedback from Christian Couder. Support --update-ref <ref>.
v6: 
	This series includes numerous improvements suggested by Christian Couder.
Reworks: 
	"bisect: allow git bisect to be used with repos containing damaged trees." 
	Replaced --ignore-checkout-failure with --no-checkout option suggested by Junio.

Also pushed to github:
	https://github.com/jonseymour/git/commits/no-checkout-v8
	git://github.com/jonseymour/git.git refs/tags/no-checkout-v8:refs/tags/no-checkout-v8


Jon Seymour (7):
  bisect: move argument parsing before state modification.
  bisect: add tests to document expected behaviour in presence of
    broken trees.
  bisect: introduce support for --update-ref=<ref> option.
  bisect: introduce --no-checkout, --update-ref=<ref> support into
    porcelain.
  bisect: add tests for the --no-checkout and --update-ref options.
  bisect: add documentation for --no-checkout and --update-ref=<ref>
    options.
  bisect: support --update-ref <ref>

 Documentation/git-bisect.txt |   34 ++++++++-
 bisect.c                     |   34 ++++++---
 bisect.h                     |    2 +-
 builtin/bisect--helper.c     |    7 +-
 git-bisect.sh                |  109 +++++++++++++++++----------
 t/t6030-bisect-porcelain.sh  |  168 +++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 296 insertions(+), 58 deletions(-)

-- 
1.7.6.391.g168d0.dirty
