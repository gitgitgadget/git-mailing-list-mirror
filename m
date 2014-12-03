From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/14] rerere: error out on autoupdate failure
Date: Tue, 2 Dec 2014 21:22:27 -0800
Message-ID: <20141203052227.GT6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 06:22:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw2OY-00005b-Ve
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbaLCFWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:22:31 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:55888 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaLCFWa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:22:30 -0500
Received: by mail-ie0-f172.google.com with SMTP id tr6so13084449ieb.31
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZsU/8vu/cxfpM2AHmWZqUDarhvfJqEe1e9+/nJAEJdo=;
        b=CYK3/lx81Pd3/8sXcscNC2SW9Y7v/gGr2XGf1ndoQ/rCohcWqsWbmMCnrrQhp6NcOC
         /sfw4zshbyanfgGxnKA1h2AciUrF8S3SauQ8JjlmzZmOpP3U9fVeifi5ErKbjnNVqEzh
         SvNiILx6APnGFnWp1mLzWkZDB4aToCLsj62h194SWrNUfwP8z02CULm6HflhVIFPz7mj
         9XvqMmFxOPX41od/yrY6sMLbAmzxwQnaUVVZgHZ9CbReHdynqa9GFSdLuXFRZzpzelpQ
         S7/yt6kzea9Kiob25uf52icSAyhNYdt0QtQ4z+hK/iRvKqoFZbutdg1GQXsRFMRYgDTX
         XNbQ==
X-Received: by 10.50.3.8 with SMTP id 8mr55976711igy.45.1417584149873;
        Tue, 02 Dec 2014 21:22:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id ro6sm13021237igb.3.2014.12.02.21.22.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:22:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203050217.GJ6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260634>

We have been silently tolerating errors by returning early with an
error that the caller ignores since rerere.autoupdate was introduced
in v1.6.0-rc0~120^2 (2008-06-22).  So on error (for example if the
index is already locked), rerere can return success silently without
updating the index or with only some items in the index updated.

Better to treat such failures as a fatal error so the operator can
figure out what is wrong and fix it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Also sent separately at
http://thread.gmane.org/gmane.comp.version-control.git/260623

 rerere.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/rerere.c b/rerere.c
index 1b0555f..195f663 100644
--- a/rerere.c
+++ b/rerere.c
@@ -477,27 +477,23 @@ out:
 
 static struct lock_file index_lock;
 
-static int update_paths(struct string_list *update)
+static void update_paths(struct string_list *update)
 {
 	int i;
-	int fd = hold_locked_index(&index_lock, 0);
-	int status = 0;
 
-	if (fd < 0)
-		return -1;
+	hold_locked_index(&index_lock, 1);
 
 	for (i = 0; i < update->nr; i++) {
 		struct string_list_item *item = &update->items[i];
 		if (add_file_to_cache(item->string, ADD_CACHE_IGNORE_ERRORS))
-			status = -1;
+			die("staging updated %s failed", item->string);
 	}
 
-	if (!status && active_cache_changed) {
+	if (active_cache_changed) {
 		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 			die("Unable to write new index file");
-	} else if (fd >= 0)
+	} else
 		rollback_lock_file(&index_lock);
-	return status;
 }
 
 static int do_plain_rerere(struct string_list *rr, int fd)
