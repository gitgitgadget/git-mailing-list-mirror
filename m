From: Dave O <cxreg@pobox.com>
Subject: [PATCH] Don't update index while recursing (was Re: Segfault during
 merge)
Date: Fri, 8 May 2009 22:30:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905082224450.30999@narbuckle.genericorp.net>
References: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905071144370.18521@pacific.mpi-cbg.de> <alpine.DEB.2.00.0905072131470.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905082229520.4601@intel-tinevez-2-302>
 <alpine.DEB.2.00.0905081436070.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905090012410.4601@intel-tinevez-2-302> <alpine.DEB.2.00.0905081624230.30999@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 07:33:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2fBa-00072F-CA
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 07:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbZEIFa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 01:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbZEIFa7
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 01:30:59 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:49730 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751118AbZEIFa6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2009 01:30:58 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id n495UuVO020367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 9 May 2009 00:30:57 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <alpine.DEB.2.00.0905081624230.30999@narbuckle.genericorp.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118649>

On Fri, 8 May 2009, Dave O wrote:

> Once again, I don't really know what the implications of the index
> operations that are happening here are, but the update_stages() call
> in a recursive merge must be doing surprising.

After writing this, I took another look around merge-recursive.c, and
realized that all the calls to update_stages() except this one were
careful only to do it when o->call_depth was 0.  This simple patch seems
to fully rectify the problem.

---
  merge-recursive.c |   11 ++++++-----
  1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a3721ef..f5df9b9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -933,11 +933,12 @@ static int process_renames(struct merge_options *o,
  				       ren1_src, ren1_dst, branch1,
  				       branch2);
  				update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
-				update_stages(ren1_dst, NULL,
-						branch1 == o->branch1 ?
-						ren1->pair->two : NULL,
-						branch1 == o->branch1 ?
-						NULL : ren1->pair->two, 1);
+				if (!o->call_depth)
+					update_stages(ren1_dst, NULL,
+							branch1 == o->branch1 ?
+							ren1->pair->two : NULL,
+							branch1 == o->branch1 ?
+							NULL : ren1->pair->two, 1);
  			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
  				const char *new_path;
  				clean_merge = 0;
-- 
1.6.3.dirty
