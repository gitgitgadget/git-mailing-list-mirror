From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 02/23] RefUpdate: new possible result Result.IO_FAILURE
Date: Sat, 28 Jun 2008 00:06:26 +0200
Message-ID: <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:08:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM7a-0000rw-AC
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756337AbYF0WHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756346AbYF0WHE
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:07:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:31033 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756143AbYF0WHB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:07:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so330044fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fPxFgpc8NwHrK6Mzj3AxGYdp8hQo7V7kAzYfJZGC76E=;
        b=VP/ZoqHsPdTDpQfTx+TbVtLShLvDJUN8eLQYEt25PfMqqeFzOkEQl0CFXI+7Ut3wkc
         pT+br/UhkvrpPLgSGamW/NRtcksYD+w7iR9trP9ty9OmyAmnuRcUTOYqaegnNuXHaPea
         +f2kKt5fDnrJGbHCeH9/g5FKnFntmCUgKMiMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IAdIFJMmOnJLwdXUMdmJRDFbpfyn81MOQYz6FmuK/7i5cUFDy/UuafhbbEgBIcjTnq
         42WzZ7Km1pgEZxnBA2FcN8eWACdCkQwNRgG4Hwd0IUyOYS19QJepGDEpm9tFoV74cy/x
         thVFW6OEoD7OO4Nb1jG/6jygX2eXHRpB3Yqu8=
Received: by 10.86.66.11 with SMTP id o11mr2505917fga.43.1214604418912;
        Fri, 27 Jun 2008 15:06:58 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id l12sm3405267fgb.6.2008.06.27.15.06.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:06:57 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86642>

This result indicates that I/O error (beyond of IOException) occurred
during RefUpdate#update().

Hitherto behaviour was to just throw IOException and leave result with
value Result.NOT_ATTEMPTED. It was just less informative.

Fetch class from pgm package needed new conditions for printing. Other
classes were reviewed and should still work just fine.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   27 +++++++++++++++++--
 .../src/org/spearce/jgit/pgm/Fetch.java            |    5 +++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 48044fb..369cb37 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -105,7 +105,18 @@ public class RefUpdate {
 		 * update to take place, so ref still contains the old value. No
 		 * previous history was lost.
 		 */
-		REJECTED
+		REJECTED,
+
+		/**
+		 * The ref was probably not updated because of I/O error.
+		 * <p>
+		 * Unexpected I/O error occurred when writing new ref. Such error may
+		 * result in uncertain state, but most probably ref was not updated.
+		 * <p>
+		 * This kind of error doesn't include {@link #LOCK_FAILURE}, which is a
+		 * different case.
+		 */
+		IO_FAILURE
 	}
 
 	/** Repository the ref is stored in. */
@@ -256,7 +267,12 @@ public class RefUpdate {
 	 */
 	public Result forceUpdate() throws IOException {
 		requireCanDoUpdate();
-		return result = forceUpdateImpl();
+		try {
+			return result = forceUpdateImpl();
+		} catch (IOException x) {
+			result = Result.IO_FAILURE;
+			throw x;
+		}
 	}
 
 	private Result forceUpdateImpl() throws IOException {
@@ -310,7 +326,12 @@ public class RefUpdate {
 	 */
 	public Result update(final RevWalk walk) throws IOException {
 		requireCanDoUpdate();
-		return result = updateImpl(walk);
+		try {
+			return result = updateImpl(walk);
+		} catch (IOException x) {
+			result = Result.IO_FAILURE;
+			throw x;
+		}
 	}
 
 	private Result updateImpl(final RevWalk walk) throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
index 6277970..3a81575 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
@@ -109,6 +109,9 @@ class Fetch extends TextBuiltin {
 		if (r == RefUpdate.Result.LOCK_FAILURE)
 			return "[lock fail]";
 
+		if (r == RefUpdate.Result.IO_FAILURE)
+			return "[i/o error]";
+
 		if (r == RefUpdate.Result.NEW) {
 			if (u.getRemoteName().startsWith(REFS_HEADS))
 				return "[new branch]";
@@ -143,6 +146,8 @@ class Fetch extends TextBuiltin {
 	private static char shortTypeOf(final RefUpdate.Result r) {
 		if (r == RefUpdate.Result.LOCK_FAILURE)
 			return '!';
+		if (r == RefUpdate.Result.IO_FAILURE)
+			return '!';
 		if (r == RefUpdate.Result.NEW)
 			return '*';
 		if (r == RefUpdate.Result.FORCED)
-- 
1.5.5.3
