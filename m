From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 08/23] Support for fetchThin and pushThin options in Transport
Date: Sat, 28 Jun 2008 00:06:32 +0200
Message-ID: <1214604407-30572-9-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-7-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-8-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:08:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM7f-0000rw-Oy
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757124AbYF0WHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757052AbYF0WHc
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:07:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:31033 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666AbYF0WH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:07:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so330044fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ez3YCVKfegjk+etF3C+7C4M2iEFf9hsMLogFxx36fKQ=;
        b=ADItgLkIxZXMHNf+ytXNyBkziLjwY9TwdByQhyOm1T6nSADacccAn2harOOx+Vvd0b
         65JahWpxljpzo+XDtsxzd+IsG2/qgorXn/apV2HYwulYwA+XBAdTbfGL3vXVKV53C5n6
         jRRVMOaYJJbjzO2VBAxBjowWk7f5adImVmAX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Gv4myWiNhXivov7HwJfysKcLeWXY1fz3gglRoBJQFXCU2htoB714jo9FHddYeTUlOd
         iGJ226/nLEMSeH7PZfD04r/71CRWWnWkc/R09FjwLHCyax8aPNDNdnh5PYPrg7GQHoZC
         b4bDMJv1UxFNoTLDgTfEqfNMudXReTFdOfLuk=
Received: by 10.86.90.13 with SMTP id n13mr2558921fgb.3.1214604444090;
        Fri, 27 Jun 2008 15:07:24 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id d4sm3427086fga.8.2008.06.27.15.07.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:07:22 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-8-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86646>

This option determines whether we should use thin pack when possible
during fetching from or pushing to a remote repo.

For fetching the default is to produce a thin pack when remote side
supports it, while for pushing the default setting is to not produce a
thin pack.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../jgit/transport/PackFetchConnection.java        |    4 +-
 .../src/org/spearce/jgit/transport/Transport.java  |   63 ++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PackFetchConnection.java
index 5f15a8d..6209030 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PackFetchConnection.java
@@ -150,6 +150,7 @@ abstract class PackFetchConnection extends FetchConnection {
 		local = packTransport.local;
 		uri = packTransport.uri;
 		includeTags = packTransport.getTagOpt() != TagOpt.NO_TAGS;
+		thinPack = packTransport.isFetchThin();
 
 		walk = new RevWalk(local);
 		reachableCommits = new RevCommitList<RevCommit>();
@@ -363,7 +364,8 @@ abstract class PackFetchConnection extends FetchConnection {
 			includeTags = wantCapability(line, OPTION_INCLUDE_TAG);
 		wantCapability(line, OPTION_OFS_DELTA);
 		multiAck = wantCapability(line, OPTION_MULTI_ACK);
-		thinPack = wantCapability(line, OPTION_THIN_PACK);
+		if (thinPack)
+			thinPack = wantCapability(line, OPTION_THIN_PACK);
 		if (wantCapability(line, OPTION_SIDE_BAND_64K))
 			sideband = true;
 		else if (wantCapability(line, OPTION_SIDE_BAND))
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 6cc38ec..c4b71eb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -142,6 +142,16 @@ public abstract class Transport {
 		throw new NotSupportedException("URI not supported: " + remote);
 	}
 
+	/**
+	 * Default setting for {@link #fetchThin} option.
+	 */
+	public static final boolean DEFAULT_FETCH_THIN = true;
+
+	/**
+	 * Default setting for {@link #pushThin} option.
+	 */
+	public static final boolean DEFAULT_PUSH_THIN = false;
+
 	/** The repository this transport fetches into, or pushes out of. */
 	protected final Repository local;
 
@@ -165,6 +175,12 @@ public abstract class Transport {
 	 */
 	private TagOpt tagopt = TagOpt.NO_TAGS;
 
+	/** Should fetch request thin-pack if remote repository can produce it. */
+	private boolean fetchThin = DEFAULT_FETCH_THIN;
+
+	/** Should push produce thin-pack when sending objects to remote repository. */
+	private boolean pushThin = DEFAULT_PUSH_THIN;
+
 	/**
 	 * Create a new transport instance.
 	 * 
@@ -234,6 +250,53 @@ public abstract class Transport {
 	}
 
 	/**
+	 * Default setting is: {@link #DEFAULT_FETCH_THIN}
+	 * 
+	 * @return true if fetch should request thin-pack when possible; false
+	 *         otherwise
+	 * @see PackTransport
+	 */
+	public boolean isFetchThin() {
+		return fetchThin;
+	}
+
+	/**
+	 * Set the thin-pack preference for fetch operation. Default setting is:
+	 * {@link #DEFAULT_FETCH_THIN}
+	 * 
+	 * @param fetchThin
+	 *            true when fetch should request thin-pack when possible; false
+	 *            when it shouldn't
+	 * @see PackTransport
+	 */
+	public void setFetchThin(final boolean fetchThin) {
+		this.fetchThin = fetchThin;
+	}
+
+	/**
+	 * Default setting is: {@value #DEFAULT_PUSH_THIN}
+	 * 
+	 * @return true if push should produce thin-pack in pack transports
+	 * @see PackTransport
+	 */
+	public boolean isPushThin() {
+		return pushThin;
+	}
+
+	/**
+	 * Set thin-pack preference for push operation. Default setting is:
+	 * {@value #DEFAULT_PUSH_THIN}
+	 * 
+	 * @param pushThin
+	 *            true when push should produce thin-pack in pack transports;
+	 *            false when it shouldn't
+	 * @see PackTransport
+	 */
+	public void setPushThin(final boolean pushThin) {
+		this.pushThin = pushThin;
+	}
+
+	/**
 	 * Fetch objects and refs from the remote repository to the local one.
 	 * <p>
 	 * This is a utility function providing standard fetch behavior. Local
-- 
1.5.5.3
