From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 04/31] Document/fix Transport open method for specific case
Date: Sun, 17 Aug 2008 22:43:45 +0200
Message-ID: <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp8K-0002uV-VL
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbYHQUod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbYHQUoc
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:44:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:31899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbYHQUoa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:44:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489141fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/yhJKwiF1lLp2UiXWh3TTHoapb03yo4S3OEKtsoPY3M=;
        b=UzSTTxQf36dfanIiUppo7oSf7Z81ULFKZJTRZUFK9Sj+ggSyRSyRZnFQZbWR6Lkz9m
         DCFtFBCx3s1ikjCE9H58g2Bn0NeONOH7hTe/SDQ4uSEuEkxM/yxS2GxahBap+GsQIpjB
         PG5Urogogwa6r2k38swB6E/a2tsq+xCThMf3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YHOiwnNB8XALOlMiN9dFJ/HUwBYKAst+10PkRo/bQLBZjpUFtbjIxqbzAvCoeIYoKD
         RBTNg2S9dzfRgPUGduRyOuHRt3zR37kOaNKos/CO7mDlbeVPx9EZDMOF9exAfXbtER4v
         IkS03U6mHpRuoaPY7ECMaqvKebc3Pd+6UUyns=
Received: by 10.86.52.6 with SMTP id z6mr4026508fgz.18.1219005870153;
        Sun, 17 Aug 2008 13:44:30 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 4sm2083443fge.5.2008.08.17.13.44.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:44:29 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92634>

RemoteConfig may have empty URIs list.
It would be nicer to throw documented exception than
ArrayIndexOutOfBoundsException in this case.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/transport/Transport.java  |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 5bec4d2..30175e3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -103,9 +103,16 @@ public abstract class Transport {
 	 * @return the new transport instance. Never null.
 	 * @throws NotSupportedException
 	 *             the protocol specified is not supported.
+	 * @throws IllegalArgumentException
+	 *             if provided remote configuration doesn't have any URI
+	 *             associated.
 	 */
 	public static Transport open(final Repository local, final RemoteConfig cfg)
 			throws NotSupportedException {
+		if (cfg.getURIs().isEmpty())
+			throw new IllegalArgumentException(
+					"Remote config \""
+					+ cfg.getName() + "\" has no URIs associated");
 		final Transport tn = open(local, cfg.getURIs().get(0));
 		tn.setOptionUploadPack(cfg.getUploadPack());
 		tn.fetch = cfg.getFetchRefSpecs();
-- 
1.5.6.3
