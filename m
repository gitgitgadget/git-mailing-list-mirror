From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/4] Racy pack directory fixes
Date: Sat, 25 Jul 2009 15:52:19 -0700
Message-ID: <1248562343-18815-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 00:52:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUq6X-0002UW-BV
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 00:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbZGYWwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 18:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbZGYWwY
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 18:52:24 -0400
Received: from george.spearce.org ([209.20.77.23]:58120 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbZGYWwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 18:52:23 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0947538196; Sat, 25 Jul 2009 22:52:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 95CE438196;
	Sat, 25 Jul 2009 22:52:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124086>

I noticed some "racy git" sort of problems with the pack directory.
I suspect JGit read the pack directory while a concurrent `git gc`
was still writing the outputs, leaving JGit missing a large part
of the repository because it never saw the final state.  This short
series fixes it.

Unrelated to my other two series already sent today.

Shawn O. Pearce (4):
  Avoid unnecessary stat when scanning packs in the objects directory
  Make ObjectDirectory last modified time atomically updated with list
  Don't create new pack lists if the directory hasn't changed
  Fix racy condition when a repository is repacked

 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |  235 ++++++++++++-------
 1 files changed, 148 insertions(+), 87 deletions(-)
