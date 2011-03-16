From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/6] rsync transport: clarify insert_packed_refs
Date: Wed, 16 Mar 2011 06:37:31 -0500
Message-ID: <20110316113731.GF15739@elie>
References: <20110316024959.GA24932@elie>
 <7vfwqnabbi.fsf@alter.siamese.dyndns.org>
 <4D807E66.40504@viscovery.net>
 <20110316094639.GA8180@elie>
 <4D8088C1.5050901@viscovery.net>
 <20110316105709.GC8277@elie>
 <20110316113540.GB15739@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 12:37:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzp2r-0001bq-7U
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 12:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711Ab1CPLhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 07:37:37 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:35047 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab1CPLhf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 07:37:35 -0400
Received: by yia27 with SMTP id 27so612886yia.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 04:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Lq2Cj7Wz9XXpDq3OO2ZVPprazDEOvKhnMh9GoSiSidQ=;
        b=Y4lxz0MxOb/2SbOSaD+GTu6c4gV5qjwGEDJS4lQBoWsmDeFiPrkR1PnM6XG6oJaDm1
         77MJ80uP9+CgUsb24tG32RLuNAydeTgcNbptFco50GZN3Tltc4Zh2CxleKdlxAvnnMkX
         Uq42hTdKd1DkN0460nPvBscXTVSVbU8G8VDzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B8DiFDBJTAyWoR1dIAvl4V8EZnswcLJ3c4KJA0zrWRoXs8I8yiBEKrQWupT92Hk3UH
         TnqTbcZllZapgBXmsE7r2Zvt24FtPjeLv76JyG3qmr/ixNRNnGl3eHoooxoUly19SVwk
         bgHIyWKtIXWkiObdOaqu5XfHuYKFdERXw3Bcg=
Received: by 10.236.182.200 with SMTP id o48mr574757yhm.315.1300275455306;
        Wed, 16 Mar 2011 04:37:35 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id i10sm560344yhd.10.2011.03.16.04.37.33
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 04:37:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316113540.GB15739@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169145>

gcc -Wuninitialized warns us that it might be confusing.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 transport.c |   35 +++++++++++++++++++----------------
 1 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/transport.c b/transport.c
index 718605f..0f06720 100644
--- a/transport.c
+++ b/transport.c
@@ -104,7 +104,8 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 		return;
 
 	for (;;) {
-		int cmp, len;
+		int cmp = 1, len;
+		struct ref *next;
 
 		if (!fgets(buffer, sizeof(buffer), f)) {
 			fclose(f);
@@ -118,22 +119,24 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 			buffer[--len] = '\0';
 		if (len < 41)
 			continue;
-		while ((*list)->next &&
-				(cmp = strcmp(buffer + 41,
-				      (*list)->next->name)) > 0)
-			list = &(*list)->next;
-		if (!(*list)->next || cmp < 0) {
-			struct ref *next = alloc_ref(buffer + 41);
-			buffer[40] = '\0';
-			if (get_sha1_hex(buffer, next->old_sha1)) {
-				warning ("invalid SHA-1: %s", buffer);
-				free(next);
-				continue;
-			}
-			next->next = (*list)->next;
-			(*list)->next = next;
-			list = &(*list)->next;
+		for (; (*list)->next; list = &(*list)->next) {
+			cmp = strcmp(buffer + 41, (*list)->next->name);
+			if (cmp <= 0)
+				break;
+		}
+		if (!cmp)	/* already inserted. */
+			continue;
+
+		next = alloc_ref(buffer + 41);
+		buffer[40] = '\0';
+		if (get_sha1_hex(buffer, next->old_sha1)) {
+			warning ("invalid SHA-1: %s", buffer);
+			free(next);
+			continue;
 		}
+		next->next = (*list)->next;
+		(*list)->next = next;
+		list = &(*list)->next;
 	}
 }
 
-- 
1.7.4.1
