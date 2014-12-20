From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/3] Improve push performance with lots of refs
Date: Sat, 20 Dec 2014 22:51:10 +0000
Message-ID: <1419115873-166686-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 20 23:51:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2Sry-0001Dq-Nq
	for gcvg-git-2@plane.gmane.org; Sat, 20 Dec 2014 23:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbaLTWv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2014 17:51:26 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55864 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751104AbaLTWvY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Dec 2014 17:51:24 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EC16D2808F;
	Sat, 20 Dec 2014 22:51:20 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261608>

This series contains patches to address a significant push performance
regression in repositories with large amounts of refs.  It avoids
performing expensive edge marking unless the repository is shallow.

The first patch in the series is a fix for a minor typo I discovered
when editing the documentation.  The second patch implements git
rev-list --objects-edge-aggressive, and the final patch ensures it's
used for shallow repos only.  As the final patch was suggested by Junio,
it will need his sign-off.

I considered Junio's suggestion for a --thin-aggressive, but felt that
it was better to have the fix localized to a single location to improve
maintainability and that --thin-aggressive would be uncommonly used
outside of automatic invocations.

Also, as I understand it, the goal of thin packs is to improve
performance by sending fewer objects.  In most cases, the benefit of the
decreased time spent marking edges push times will dwarf the increase in
time it takes for a slightly larger pack to go over the wire, so it
doesn't make sense to make this a tunable.

The original fix was suggested by Duy Nguyen.

brian m. carlson (3):
  Documentation: add missing article in rev-list-options.txt
  rev-list: add an option to mark fewer edges as uninteresting
  pack-objects: use --objects-edge-aggressive only for shallow repos

 Documentation/git-rev-list.txt     | 3 ++-
 Documentation/rev-list-options.txt | 7 ++++++-
 builtin/pack-objects.c             | 4 +++-
 list-objects.c                     | 4 ++--
 revision.c                         | 6 ++++++
 revision.h                         | 1 +
 6 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.2.1.209.g41e5f3a
