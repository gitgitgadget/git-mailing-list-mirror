From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] unpack-trees: simplify 'all other failures' case
Date: Tue, 12 Aug 2014 16:59:31 -0700
Message-ID: <20140812235931.GE24621@google.com>
References: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com>
 <1407878107-22850-1-git-send-email-stefanbeller@gmail.com>
 <20140812235731.GD24621@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	barkalow@iabervon.org, git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 01:59:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHLyd-0005sn-6j
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 01:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbaHLX7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 19:59:35 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:48605 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbaHLX7e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 19:59:34 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so13453242pdj.12
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 16:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aT6aUDDImq1L1kJlL7YjI9NzgUBYOaNR6iUlWwrCVPs=;
        b=tX1sdxbi159O+Y1auc+WisM5+OS2rK9UceK+UJMwbKZF5dMURBcjVdWVhh0R+IyCa0
         +oLAkTa9aASz1YVjooWwvqvcn43kixSrbtbvigGZ6IZG/HKws7QBB72lg9lw2r01crZM
         /a4VChfhUWlzE6qNF1Dv2gWM1m/XNFUMSd1RPBNIyDqV8KLFebAgIwZnyqkmnYXcVlfI
         wtr9P8wJBd3R8TzQDsmBUUyRXEo+rFI+TkkiSQvE4bGLfwpmncSwkZVwjIXu4L99QJtG
         ZMus5BWCjDxex3NAtXKVAwhK0A24EcQ/QgCWNqomQuriBYGnFkBhjUM4FY+yzDkoNTmq
         luFg==
X-Received: by 10.68.245.162 with SMTP id xp2mr892844pbc.60.1407887974394;
        Tue, 12 Aug 2014 16:59:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b597:b557:1d91:6675])
        by mx.google.com with ESMTPSA id qp12sm241750pdb.80.2014.08.12.16.59.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Aug 2014 16:59:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140812235731.GD24621@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255177>

From: Stefan Beller <stefanbeller@gmail.com>

In the 'if (current)' block of twoway_merge, we handle the boring
errors by checking if the entry from the old tree, current index, and
new tree are present, to get a pathname for the error message from one
of them:

	if (oldtree)
		return o->gently ? -1 : reject_merge(oldtree, o);
	if (current)
		return o->gently ? -1 : reject_merge(current, o);
	if (newtree)
		return o->gently ? -1 : reject_merge(newtree, o);
	return -1;

Since this is guarded by 'if (current)', the second test is guaranteed
to succeed.  Moreover, any of the three entries, if present, would
have the same path because there is no rename detection in this code
path.   Even if some day in the future the entries' paths differ, the
'current' path used in the index and worktree would presumably be the
most recognizable for the end user.

Simplify by just using 'current'.

Noticed by coverity, Id:290002

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 unpack-trees.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index ad3e9a0..f4a9aa9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1791,16 +1791,8 @@ int twoway_merge(const struct cache_entry * const *src,
 			/* 20 or 21 */
 			return merged_entry(newtree, current, o);
 		}
-		else {
-			/* all other failures */
-			if (oldtree)
-				return o->gently ? -1 : reject_merge(oldtree, o);
-			if (current)
-				return o->gently ? -1 : reject_merge(current, o);
-			if (newtree)
-				return o->gently ? -1 : reject_merge(newtree, o);
-			return -1;
-		}
+		else
+			return o->gently ? -1 : reject_merge(current, o);
 	}
 	else if (newtree) {
 		if (oldtree && !o->initial_checkout) {
-- 
