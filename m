From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/6] merge-trees: push choice to renormalize away from low
 level
Date: Tue, 3 Aug 2010 22:20:43 -0500
Message-ID: <20100804032043.GB19699@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 05:22:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgUYX-0008Tm-Af
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 05:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133Ab0HDDWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 23:22:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41453 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757520Ab0HDDWF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 23:22:05 -0400
Received: by gwb20 with SMTP id 20so1811329gwb.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 20:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7sjwQEumzOu5Wi62JeNN2i8/1PcuWCDzEjzZjtMthEU=;
        b=jmbt71fNQlFqJyjZDTin/5F4W+mBBiba2zdDQ6HlHSGqF1ervltxcf523Mu+kgnXnO
         LYuoaA2/+ItCAZ2C6FW4UahZ0ZyLaS86RTJfmIA65kh7zASheyhnSC6MmG9wOwTej5ri
         GpepeXDB3ilNreg5tC0mbgld7dramUoByNGBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RrWjLlRqdFSxbYwjaVnFhv7VNE7hp+sjCsRxpcjt+OoZKMit+wvir9r6KtaSv9BJcE
         dMZBvYdZCg+Wa7I06hTLZudKjg29QC6lKebWtYulFWGRsg/DB73F1WHz/Jto6YHqjEGZ
         E/AW/nrdWPaVqj2A4pJfyYHGygQ3AT0b89xGc=
Received: by 10.151.109.13 with SMTP id l13mr3881597ybm.205.1280892123058;
        Tue, 03 Aug 2010 20:22:03 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id q25sm7399438ybk.18.2010.08.03.20.22.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 20:22:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100804031935.GA19699@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152556>

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
