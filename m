From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Inefficient use of keySet iterator instead of entrySet
 iterator
Date: Thu, 19 Mar 2009 10:17:56 +0100
Message-ID: <49C20DC4.1090600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 10:19:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkEPU-0002zp-Ic
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 10:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903AbZCSJSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 05:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756314AbZCSJSF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 05:18:05 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:33075 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993AbZCSJSD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 05:18:03 -0400
Received: by ewy9 with SMTP id 9so324027ewy.37
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 02:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=rb/z7EVse7LbChYrooHSqYKB7h5dIoHISWVwg43WIAc=;
        b=puU7Op4y6eOfpxJVLvLmGxJJUO8iCbD54VQyo7302hPejBrTFY5a6FMMI1hlpxykIZ
         5BaG4sD8ApMT+vpmNYpux9+/8XowykQ5apaKkQfAjzp5yz3wfclVv+8RiHGuvggJVLvN
         LxGMVPYJ9+PCdotc9V+J+CCKYjR3QcMlXOel0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=jcGFUuKHsL5vBykVujvFmw9S7925Wv8HuUvdPPg/4mZjU1t8S91qNqlXi6Xr2+glNs
         +q/7nH70dqYofRU6z4sFn3Yeol1eIGrPZC2k22DhKwRf+MZNyh4qAA2FuIdsyUtPfTiz
         y2DjALHzf4WyYtH0Z3MU/mEQf6kbinhiohyDU=
Received: by 10.216.71.82 with SMTP id q60mr968982wed.169.1237454278924;
        Thu, 19 Mar 2009 02:17:58 -0700 (PDT)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id 10sm978814eyz.19.2009.03.19.02.17.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Mar 2009 02:17:57 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113741>

>From FindBugs:
This method accesses the value of a Map entry, using a key that
was retrieved from a keySet iterator. It is more efficient to use
an iterator on the entrySet of the map, to avoid the Map.get(key)
lookup.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
 .../src/org/spearce/jgit/lib/ObjectIdMap.java      |    5 +++--
 .../src/org/spearce/jgit/transport/AmazonS3.java   |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
index d3c7f1d..10feaf9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
@@ -183,8 +183,9 @@ public V put(ObjectId key, V value) {
 	}
 
 	public void putAll(Map<? extends ObjectId, ? extends V> arg0) {
-		for (ObjectId k : arg0.keySet()) {
-			V v=arg0.get(k);
+		for (Map.Entry<? extends ObjectId, ? extends V> entry : arg0.entrySet()) {
+			ObjectId k = entry.getKey();
+			V v=entry.getValue();
 			put(k,v);
 		}
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java b/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
index 59337f8..3d8bdca 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
@@ -572,9 +572,10 @@ private HttpURLConnection open(final String method, final String bucket,
 	private void authorize(final HttpURLConnection c) throws IOException {
 		final Map<String, List<String>> reqHdr = c.getRequestProperties();
 		final SortedMap<String, String> sigHdr = new TreeMap<String, String>();
-		for (final String hdr : reqHdr.keySet()) {
+		for (final Map.Entry<String, List<String>> entry : reqHdr.entrySet()) {
+			final String hdr = entry.getKey();
 			if (isSignedHeader(hdr))
-				sigHdr.put(hdr.toLowerCase(), toCleanString(reqHdr.get(hdr)));
+				sigHdr.put(hdr.toLowerCase(), toCleanString(entry.getValue()));
 		}
 
 		final StringBuilder s = new StringBuilder();
-- 
1.6.1.2
