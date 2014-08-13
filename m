From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] checkout -m: attempt merge when deletion of path was
 staged
Date: Tue, 12 Aug 2014 17:03:18 -0700
Message-ID: <20140813000317.GG24621@google.com>
References: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com>
 <1407878107-22850-1-git-send-email-stefanbeller@gmail.com>
 <20140812235731.GD24621@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	barkalow@iabervon.org, git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 02:03:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHM2H-0007Mg-RM
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 02:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbaHMADW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 20:03:22 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:61599 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbaHMADV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 20:03:21 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so13378390pde.4
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 17:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rrhjPxANF3ZIOk8wNDi1kVnfwPlBIDfHJvFsecUYdgE=;
        b=mPbRk5BAY8fBl/V6/fZisSfaxy776f8OTqlcczq88eYVr5/VZRzf15r0WMaJV28wK3
         9+5IvDYuAddlvH6tr/Pb7NndYBO2EaXieOCjOXu5mQyJ0C9tcsPomRXmmVUQBlVybTTA
         btwojCZNDT4a74dDaJjYpxjvj+CU3F9LvcaWEuuAH7bgOwbDqml1Qu5P72vTj8otqpSs
         lMA735Wex1ZONNTYJ3gaA1C+K5drdUd4GuSqUQ+fd7JuS47oG+WoMZGDwToL51tjxTlB
         /ZeTXA96S1bidnmhvpqscp32DzcOCEMzVK17kx79VzznLvVBvRLcD4/l7WDEW5BqzUoI
         Dfeg==
X-Received: by 10.70.47.197 with SMTP id f5mr733672pdn.141.1407888200906;
        Tue, 12 Aug 2014 17:03:20 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b597:b557:1d91:6675])
        by mx.google.com with ESMTPSA id dn5sm140809pbd.57.2014.08.12.17.03.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Aug 2014 17:03:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140812235731.GD24621@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255179>

twoway_merge() is missing an o->gently check in the case where a file
that needs to be modified is missing from the index but present in the
old and new trees.  As a result, in this case 'git checkout -m' errors
out instead of trying to perform a merge.

Fix it by checking o->gently.  While at it, inline the o->gently check
into reject_merge to prevent future call sites from making the same
mistake.

Noticed by code inspection.  The motivating case hasn't been tested.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This is the most iffy of the three patches, mostly because I was too
lazy to write a test.  I believe it's safe as-is nonetheless.

Thanks for reading.

 unpack-trees.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 187b15b..6c45af7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1178,7 +1178,8 @@ return_failed:
 static int reject_merge(const struct cache_entry *ce,
 			struct unpack_trees_options *o)
 {
-	return add_rejected_path(o, ERROR_WOULD_OVERWRITE, ce->name);
+	return o->gently ? -1 :
+		add_rejected_path(o, ERROR_WOULD_OVERWRITE, ce->name);
 }
 
 static int same(const struct cache_entry *a, const struct cache_entry *b)
@@ -1633,7 +1634,7 @@ int threeway_merge(const struct cache_entry * const *stages,
 	/* #14, #14ALT, #2ALT */
 	if (remote && !df_conflict_head && head_match && !remote_match) {
 		if (index && !same(index, remote) && !same(index, head))
-			return o->gently ? -1 : reject_merge(index, o);
+			return reject_merge(index, o);
 		return merged_entry(remote, index, o);
 	}
 	/*
@@ -1641,7 +1642,7 @@ int threeway_merge(const struct cache_entry * const *stages,
 	 * make sure that it matches head.
 	 */
 	if (index && !same(index, head))
-		return o->gently ? -1 : reject_merge(index, o);
+		return reject_merge(index, o);
 
 	if (head) {
 		/* #5ALT, #15 */
@@ -1770,7 +1771,7 @@ int twoway_merge(const struct cache_entry * const *src,
 				else
 					return merged_entry(newtree, current, o);
 			}
-			return o->gently ? -1 : reject_merge(current, o);
+			return reject_merge(current, o);
 		} else if ((!oldtree && !newtree) || /* 4 and 5 */
 			 (!oldtree && newtree &&
 			  same(current, newtree)) || /* 6 and 7 */
@@ -1788,7 +1789,7 @@ int twoway_merge(const struct cache_entry * const *src,
 			/* 20 or 21 */
 			return merged_entry(newtree, current, o);
 		} else
-			return o->gently ? -1 : reject_merge(current, o);
+			return reject_merge(current, o);
 	}
 	else if (newtree) {
 		if (oldtree && !o->initial_checkout) {
-- 
