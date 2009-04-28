From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 09/13] Replace inefficient new String(String) constructor to silence FindBugs
Date: Tue, 28 Apr 2009 14:12:22 -0700
Message-ID: <1240953146-12878-10-git-send-email-spearce@spearce.org>
References: <1240953146-12878-1-git-send-email-spearce@spearce.org>
 <1240953146-12878-2-git-send-email-spearce@spearce.org>
 <1240953146-12878-3-git-send-email-spearce@spearce.org>
 <1240953146-12878-4-git-send-email-spearce@spearce.org>
 <1240953146-12878-5-git-send-email-spearce@spearce.org>
 <1240953146-12878-6-git-send-email-spearce@spearce.org>
 <1240953146-12878-7-git-send-email-spearce@spearce.org>
 <1240953146-12878-8-git-send-email-spearce@spearce.org>
 <1240953146-12878-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, Yann Simon <yann.simon.fr@gmail.com>,
	Matthias Sohn <matthias.sohn@sap.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:15:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyueN-0006Nh-37
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 23:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757405AbZD1VMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 17:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757365AbZD1VMm
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 17:12:42 -0400
Received: from george.spearce.org ([209.20.77.23]:58335 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756166AbZD1VMf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 17:12:35 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id F352538265; Tue, 28 Apr 2009 21:12:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id BB8B938269;
	Tue, 28 Apr 2009 21:12:29 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
In-Reply-To: <1240953146-12878-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117815>

FindBugs keeps reporting that our usage of new String(String)
is not the most efficient way to construct a string.

http://thread.gmane.org/gmane.comp.version-control.git/113739/focus=113787
> I had a specific reason for forcing a new String object here.
>
> The line in question, p, is from the packed-refs file and
> contains the entire SHA-1 in hex form at the beginning of it.
> We've converted that into binary as an ObjectId, it uses 1/4 the
> space of the string portion.
>
> The Ref object, its ObjectId, and its name string, are going to be
> cached in a Map, probably long-term.  We're better off shedding the
> 80 bytes of memory used to hold the hex SHA-1 then risk substring()
> deciding its "faster" to reuse the char[] then to make a copy of it.

Another way to force this new unique String instance with its own
private char[] is to use a StringBuilder and append onto it the
ref name.  This shouldn't be a warning for FindBugs, but it would
accomplish the same goal of producing 1 clean copy, with no extra
transient temporary array.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Yann Simon <yann.simon.fr@gmail.com>
CC: Matthias Sohn <matthias.sohn@sap.com>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 87f26bf..bccf2d0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -447,7 +447,8 @@ private synchronized void refreshPackedRefs() {
 
 					final int sp = p.indexOf(' ');
 					final ObjectId id = ObjectId.fromString(p.substring(0, sp));
-					final String name = new String(p.substring(sp + 1));
+					final String name = new StringBuilder(p.length() - (sp + 1))
+							.append(p, sp + 1, p.length()).toString();
 					last = new Ref(Ref.Storage.PACKED, name, name, id);
 					newPackedRefs.put(last.getName(), last);
 				}
-- 
1.6.3.rc1.205.g37f8
