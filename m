From: John Keeping <john@keeping.me.uk>
Subject: Re: Segfault with merge-tree on multiple Git versions
Date: Wed, 27 Mar 2013 15:58:50 +0000
Message-ID: <20130327155850.GN2286@serenity.lan>
References: <51531059.8000407@atechmedia.com>
 <87boa47saw.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Charlie Smurthwaite <charlie@atechmedia.com>
To: thomas <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 27 16:59:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKsl7-0005G5-I6
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 16:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589Ab3C0P7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 11:59:00 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:48175 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab3C0P7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 11:59:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 79C036064EE;
	Wed, 27 Mar 2013 15:58:59 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a5UJ-CsANzhu; Wed, 27 Mar 2013 15:58:58 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 08B786064E2;
	Wed, 27 Mar 2013 15:58:52 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <87boa47saw.fsf@linux-k42r.v.cablecom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219261>

On Wed, Mar 27, 2013 at 04:53:27PM +0100, thomas wrote:
> Charlie Smurthwaite <charlie@atechmedia.com> writes:
> 
> > I am experiencing a segmentation fault in various versions of Git using
> > different repositories. Specifically, I have reproduced it using a
> > public repo and the latest stable Git version. Other repos trigger the
> > error on different versions.
> >
> > Full info can be found below. Thanks,
> >
> > Charlie
> >
> >
> > Test repository:
> > https://github.com/atech/mail
> >
> > Test Command
> > git merge-tree 26bb22a052fef9f74063afd4fc6fc11fe200b19f
> > 8d6bdf012941d876b2279994e02f1bb0d5c26e7d
> > d5ef97ac407d945f231cd7c8fb1cfe48b3a12083
> 
> I happened to walk past on IRC and found I could easily reproduce it, so
> I bisected:
> 
>   35ffe7583108ab236dcf81226690388491d9962f is the first bad commit
>   commit 35ffe7583108ab236dcf81226690388491d9962f
>   Author: Junio C Hamano <gitster@pobox.com>
>   Date:   Thu Dec 13 15:51:29 2012 -0800
> 
>       merge-tree: fix d/f conflicts
>       
>       The previous commit documented two known breakages revolving around
>       a case where one side flips a tree into a blob (or vice versa),
>       where the original code simply gets confused and feeds a mixture of
>       trees and blobs into either the recursive merge-tree (and recursing
>       into the blob will fail) or three-way merge (and merging tree contents
>       together with blobs will fail).
>       
>       Fix it by feeding trees (and only trees) into the recursive
>       merge-tree machinery and blobs (and only blobs) into the three-way
>       content level merge machinery separately; when this happens, the
>       entire merge has to be marked as conflicting at the structure level.
>       
>       Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks like a simple typo in merge-tree.c::unresolved:

-- >8 --
merge-tree: fix typo in merge-tree.c::unresolved

When calculating whether there is a d/f conflict, the calculation of
whether both sides are directories generates an incorrect references
mask because it does not use the loop index to set the correct bit.
Fix this typo.

Signed-off-by: John Keeping <john@keeping.me.uk>

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index e0d0b7d..bc912e3 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -245,7 +245,7 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
 	unsigned dirmask = 0, mask = 0;
 
 	for (i = 0; i < 3; i++) {
-		mask |= (1 << 1);
+		mask |= (1 << i);
 		if (n[i].mode && S_ISDIR(n[i].mode))
 			dirmask |= (1 << i);
 	}
