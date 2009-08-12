From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH (RESEND) 0/4] Fix race condition on loading pack files
Date: Wed, 12 Aug 2009 12:45:19 -0700
Message-ID: <1250106323-19408-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:45:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbJlP-0001Yh-NN
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 21:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbZHLTpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 15:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbZHLTpX
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 15:45:23 -0400
Received: from george.spearce.org ([209.20.77.23]:52206 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbZHLTpW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 15:45:22 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 510803816F; Wed, 12 Aug 2009 19:45:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DC5EF3816F;
	Wed, 12 Aug 2009 19:45:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.225.gb589e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125729>

I had sent this series while you were on vacation, so I assume it
just got lost in the shuffle and am resending.

This series tries to fix a "racy git" problem when reading pack
files in a repository; its possible that the directory is modified,
read and modified again in the same filesystem timestamp, resulting
in the reader not noticing the second modification.  This may cause
a reader to lose access to objects on disk.

Shawn O. Pearce (4):
  Avoid unnecessary stat when scanning packs in the objects directory
  Make ObjectDirectory last modified time atomically updated with list
  Don't create new pack lists if the directory hasn't changed
  Fix racy condition when a repository is repacked

 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |  235 ++++++++++++-------
 1 files changed, 148 insertions(+), 87 deletions(-)
