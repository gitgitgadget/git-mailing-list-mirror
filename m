From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 0/4] Improve push performance with lots of refs
Date: Tue, 23 Dec 2014 12:01:18 +0000
Message-ID: <1419336082-283091-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 13:02:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3OA3-00032W-Kq
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 13:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051AbaLWMBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 07:01:39 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55913 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756038AbaLWMBd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Dec 2014 07:01:33 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C7A8F2808F;
	Tue, 23 Dec 2014 12:01:29 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261728>

This series contains patches to address a significant push performance
regression in repositories with large amounts of refs.  It avoids
performing expensive edge marking unless the repository is shallow.

The first patch in the series is a fix for a minor typo I discovered
when editing the documentation.  The second patch implements git
rev-list --objects-edge-aggressive, and the third patch ensures it's
used for shallow repos only.  The final patch ensures that sending packs
to shallow clients use --object-edge-aggressive as well.

The only change from v2 is the addition of a fourth patch, which fixes
t5500.  It's necessary because the test wants packs for fetches to
shallow clones to be minimal.

I'm not especially thrilled with having to provide a --shallow command
line argument, but the alternative is to buffer a potentially large
amount of data in order to determine whether the remote side is shallow.

The original fix was suggested by Duy Nguyen.

brian m. carlson (4):
  Documentation: add missing article in rev-list-options.txt
  rev-list: add an option to mark fewer edges as uninteresting
  pack-objects: use --objects-edge-aggressive only for shallow repos
  upload-pack: use --objects-edge-aggressive for shallow fetches

 Documentation/git-pack-objects.txt | 7 ++++++-
 Documentation/git-rev-list.txt     | 3 ++-
 Documentation/rev-list-options.txt | 7 ++++++-
 builtin/pack-objects.c             | 7 ++++++-
 list-objects.c                     | 4 ++--
 revision.c                         | 6 ++++++
 revision.h                         | 1 +
 upload-pack.c                      | 4 +++-
 8 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.2.1.209.g41e5f3a
