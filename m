From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [JGIT] Questions about binary right shifting
Date: Thu, 05 Feb 2009 15:37:37 +0100
Message-ID: <498AF9B1.1060200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 15:39:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV5Nl-0002Ko-PQ
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 15:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbZBEOhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 09:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbZBEOhl
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 09:37:41 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:60045 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZBEOhk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 09:37:40 -0500
Received: by fg-out-1718.google.com with SMTP id 16so190756fgg.17
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 06:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=DeKFOf2nXzrZM6AystRjOQPleQP6tcV3S/uPEIgRvHs=;
        b=jUTGdrOHa1YNDoAaPngWq6hC0Fj0vV4DDQhfOvm1kVuS9MWJYSzvTkMlLYXi6VjutL
         yzXSX18JjJllKqh1YmVnmwtoqNapdNBOccUlzHEIRg+KCfR6zxOIO34oft0u0Pk7vcRd
         ls+YLKvSJdWof/DPJ9CfoJJiiIL0olQT5ZkL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=ZpNttSIFvbBNbwydK5V3kyeLGKFI82DevBE9NNUw0DRqo2ldmv3yyEXkFTJGjYVmsu
         H8OvFLScyNEcdXT9/VuMN5SvjMNMZouXDiSTqnPSM9o53rp6peo99E54WcM8a53gZjwH
         hobvB7fGvzXfDMFrxvL+c9MYb4gA+MjvB5l0s=
Received: by 10.86.93.19 with SMTP id q19mr355921fgb.62.1233844658735;
        Thu, 05 Feb 2009 06:37:38 -0800 (PST)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id 4sm1447095fgg.55.2009.02.05.06.37.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Feb 2009 06:37:38 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108566>

Hi,

I can see in the code that the signed right shifting is used.
Could it be a problem? Or do we manipulate only positive numbers?

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index 8eb4022..d70eca0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -577,7 +577,7 @@ int findEntry(final byte[] p, final int pLen) {
 		int low = 0;
 		int high = entryCnt;
 		do {
-			int mid = (low + high) >> 1;
+			int mid = (low + high) >>> 1;
 			final int cmp = cmp(p, pLen, sortedEntries[mid]);
 			if (cmp < 0)
 				high = mid;

And could we used right shifting to optimize a division per 2?

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
index 0ecd04d..ff9e666 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
@@ -136,7 +136,7 @@ private static final int binarySearch(final TreeEntry[] entries,
 		int high = entries.length;
 		int low = 0;
 		do {
-			final int mid = (low + high) / 2;
+			final int mid = (low + high) >>> 1;
 			final int cmp = compareNames(entries[mid].getNameUTF8(), nameUTF8,
 					nameStart, nameEnd, TreeEntry.lastChar(entries[mid]), nameUTF8last);
 			if (cmp < 0)

Yann
