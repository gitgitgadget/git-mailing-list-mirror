From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/12] merge-trees: push choice to renormalize away from
 low level
Date: Thu, 5 Aug 2010 06:13:49 -0500
Message-ID: <20100805111349.GF13779@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:15:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgyPs-0001u4-FH
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760110Ab0HELPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 07:15:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59891 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757203Ab0HELPI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:15:08 -0400
Received: by iwn33 with SMTP id 33so81609iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WRbY0fgLPsliEBKdnYXbH+X45IhkewE0AvNwhXHFPAM=;
        b=JJoXxYY5HVp+lDd2YuKXWP1pIgyqzgyU+vvRJrwn0cnTvbUl+Qh2OdUsRiGBYcq7uK
         4ObcJf+T8STXZV16+FXC5DFCvm6iuZwN4iPUxaKWZHN42EmTrTH0qO9M5ZxQTF9EoKNG
         d8TOIJrWa+Jsgs0L8Yp9i8gEe9mMRLGaC3rsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bu07qlV54Q+AqvXeLZTd+zv6tYqErNJlOcjKM5qA4Jc8EL5PZ24t3myNKd3G4Sfmmv
         FC6zQunzBUrl9KS/NKkPvbvSXLU1rj2WEyIX8epbB0/Qxs4xViqjzT7eLP2MEvZd2kKy
         Pm1Ga7G9vMMO/bv0bAOyRaYcWNyngnVY7Z4FY=
Received: by 10.231.144.75 with SMTP id y11mr12263355ibu.15.1281006908143;
        Thu, 05 Aug 2010 04:15:08 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e8sm51507ibb.2.2010.08.05.04.15.07
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:15:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100805110822.GB13779@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152636>

The merge machinery decides whether to resmudge and clean relevant
entries based on the global merge_renormalize setting, which is set by
"git merge" based on its configuration (and left alone by other
commands).

A nicer interface would make that decision a parameter to merge_trees
so callers would pass in a choice made on a call-by-call basis.
Start by making blob_unchanged stop examining the merge_renormalize
global.

In other words, this change is a trivial no-op, but it brings us
closer to something good.

Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Unchanged from v1.

 merge-recursive.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5ad8fc9..2b55fc2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1074,7 +1074,7 @@ static int read_sha1_strbuf(const unsigned char *sha1, struct strbuf *dst)
 
 static int blob_unchanged(const unsigned char *o_sha,
 			  const unsigned char *a_sha,
-			  const char *path)
+			  int renormalize, const char *path)
 {
 	struct strbuf o = STRBUF_INIT;
 	struct strbuf a = STRBUF_INIT;
@@ -1082,7 +1082,7 @@ static int blob_unchanged(const unsigned char *o_sha,
 
 	if (sha_eq(o_sha, a_sha))
 		return 1;
-	if (!merge_renormalize)
+	if (!renormalize)
 		return 0;
 
 	assert(o_sha && a_sha);
@@ -1112,6 +1112,7 @@ static int process_entry(struct merge_options *o,
 	print_index_entry("\tpath: ", entry);
 	*/
 	int clean_merge = 1;
+	int normalize = merge_renormalize;
 	unsigned o_mode = entry->stages[1].mode;
 	unsigned a_mode = entry->stages[2].mode;
 	unsigned b_mode = entry->stages[3].mode;
@@ -1122,8 +1123,8 @@ static int process_entry(struct merge_options *o,
 	if (o_sha && (!a_sha || !b_sha)) {
 		/* Case A: Deleted in one */
 		if ((!a_sha && !b_sha) ||
-		    (!b_sha && blob_unchanged(o_sha, a_sha, path)) ||
-		    (!a_sha && blob_unchanged(o_sha, b_sha, path))) {
+		    (!b_sha && blob_unchanged(o_sha, a_sha, normalize, path)) ||
+		    (!a_sha && blob_unchanged(o_sha, b_sha, normalize, path))) {
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
 			if (a_sha)
-- 
1.7.2.1.544.ga752d.dirty
