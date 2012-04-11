From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] fast-import: use DIV_ROUND_UP
Date: Wed, 11 Apr 2012 07:15:31 -0500
Message-ID: <20120411121531.GF19568@burratino>
References: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
 <20120411121259.GB19568@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:15:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHwSf-0000V9-L4
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 14:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760133Ab2DKMPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 08:15:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36755 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760124Ab2DKMPi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 08:15:38 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so1198737iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TbicF88soR/TECdnEmJ6MXEltystqaBShtbDZ1BknZ4=;
        b=Cap0vPopcdjS+Tt8vZsSriJKfrB03n70NjXJ5VRWMY7k2m/Doma7N0leIWe7FaDY+x
         H0qJVI2Mmb8mMx0leodLUzrpzaKxnY2c3vA7lvbpRw6qcTN2Sy7QSby/zUHeP8ARHG48
         ziD/Ng/PIsNo+hPihC7MJNd6c6ol/W8xFHkGkwi4IDcgONO3VMY+A8Z3ORdKrgES9Vh+
         276hgW6c4ePrmoVyhcGZMckTK2HnDmWJ/0fdFzwcyYhdwEl/Mpc42+eEHVN9I2JHutFz
         EsonpOc2HwyVch8/DNuez6zPL0DwtMRBB4FqamMXSBOTXWnfAfoSHvkWCMHjETeVyxG6
         Nevg==
Received: by 10.50.95.167 with SMTP id dl7mr2138550igb.6.1334146538002;
        Wed, 11 Apr 2012 05:15:38 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id bh8sm7300922igc.9.2012.04.11.05.15.37
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 05:15:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120411121259.GB19568@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195175>

Date: Mon, 30 May 2011 22:45:43 -0500

fast-import keeps tree structures for reuse in pools arranged by size:
one for trees with 0 entries, one for 8-entry trees, one for 16-entry
trees, and so on up to 784-entry trees, plus another pool for larger
trees.  Use the DIV_ROUND_UP macro to determine which pool a
given-sized tree belongs in to avoid some confusing bit-twiddling.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 fast-import.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index ebb27006..fc1b549d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -785,7 +785,7 @@ static struct branch *new_branch(const char *name)
 
 static unsigned int hc_entries(unsigned int cnt)
 {
-	cnt = cnt & 7 ? (cnt / 8) + 1 : cnt / 8;
+	cnt = DIV_ROUND_UP(cnt, 8);
 	return cnt < avail_tree_table_sz ? cnt : avail_tree_table_sz - 1;
 }
 
@@ -805,7 +805,7 @@ static struct tree_content *new_tree_content(unsigned int cnt)
 		else
 			avail_tree_table[hc] = f->next_avail;
 	} else {
-		cnt = cnt & 7 ? ((cnt / 8) + 1) * 8 : cnt;
+		cnt = DIV_ROUND_UP(cnt, 8) * 8;
 		f = pool_alloc(sizeof(*t) + sizeof(t->entries[0]) * cnt);
 		f->entry_capacity = cnt;
 	}
-- 
1.7.10
