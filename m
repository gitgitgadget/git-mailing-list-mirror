From: Martin Fick <mfick@codeaurora.org>
Subject: git-repack.sh not server/multiuse safe?
Date: Wed, 5 Sep 2012 15:18:31 -0600
Organization: CAF
Message-ID: <201209051518.34009.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 23:18:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Mzv-0006eC-8a
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 23:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759519Ab2IEVSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 17:18:48 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:62973 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759440Ab2IEVSr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 17:18:47 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6826"; a="233273965"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Sep 2012 14:18:47 -0700
Received: from mfick-lnx.localnet (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id CB04C10004AB
	for <git@vger.kernel.org>; Wed,  5 Sep 2012 14:18:46 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204847>

I have been reading the git-repack.sh script and I have 
found a piece that I am concerned with.  It looks like after 
repacking there is a place when packfiles could be 
temporarily unaccessible making the objects within 
temporarily unaccessible.  If my evaluation is true, it 
would seem like git repacking is not "server" safe?

In particular, I am talking about this loop:

 # Ok we have prepared all new packfiles.

 # First see if there are packs of the same name and if so
 # if we can move them out of the way (this can happen if we
 # repacked immediately after packing fully.
 rollback=
 failed=
 for name in $names
 do
        for sfx in pack idx
        do
                file=pack-$name.$sfx
                test -f "$PACKDIR/$file" || continue
                rm -f "$PACKDIR/old-$file" &&
                mv "$PACKDIR/$file" "$PACKDIR/old-$file" ||  
{
                        failed=t
                        break
                }
                rollback="$rollback $file"
        done
        test -z "$failed" || break
 done



It would seem that one way to avoid this (at least on 
systems supporting hardlinks), would be to instead link the 
original packfile to old-file first, then move the new 
packfile in place without ever deleting the original one 
(from its original name), only delete the old-file link.  
Does that make sense at all?

Thanks,

-Martin


-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
