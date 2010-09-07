From: "Schalk, Ken" <ken.schalk@intel.com>
Subject: RE: [PATCH 2/3] merge-recursive: Small code cleanup
Date: Tue, 7 Sep 2010 09:23:46 -0700
Message-ID: <EF9FEAB3A4B7D245B0801936B6EF4A254B6BBD@azsmsx503.amr.corp.intel.com>
References: <AANLkTimz8qSwefp137-D+vEbsf6soG51u0im9EC911_O@mail.gmail.com>
 <1283806070-22027-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "gitster@pobox.com" <gitster@pobox.com>,
	"oinksocket@letterboxes.org" <oinksocket@letterboxes.org>
To: Elijah Newren <newren@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 07 18:24:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot0xj-0005a3-P7
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757687Ab0IGQXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 12:23:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:36889 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933Ab0IGQXu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 12:23:50 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 07 Sep 2010 09:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.56,329,1280732400"; 
   d="scan'208";a="604652640"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
  by fmsmga002.fm.intel.com with ESMTP; 07 Sep 2010 09:23:49 -0700
Received: from azsmsx503.amr.corp.intel.com ([10.2.121.76]) by
 azsmsx601.amr.corp.intel.com ([10.2.121.193]) with mapi; Tue, 7 Sep 2010
 09:23:49 -0700
Thread-Topic: [PATCH 2/3] merge-recursive: Small code cleanup
Thread-Index: ActOBJhD2fBT+Mx0TLKnIkn7aFqiywApDp4g
In-Reply-To: <1283806070-22027-3-git-send-email-newren@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155706>

>Also, in d5af510 (RE: [PATCH] Avoid rename/add conflict when contents are
>identical 2010-09-01), a separate if-block was added to provide a special
>case for the rename/add conflict case that can be resolved (namely when
>the contents on the destination side are identical).  However, as a
>separate if block, it's not immediately obvious that its code is related to
>the subsequent code checking for a rename/add conflict.  We can combine and
>simplify the check slightly.

Originally I tried the fix the way you've re-structured it, just adding a test to the if around the rename/add conflict handling.  Unfortunately that didn't completely solve the problem in the case that originally motivated the fix (rename vs. rename+symlink, as in my initial post and my first attempt at adding a test to t/t3030-merge-recursive.sh).  That's why I changed it to a separate if block.

The problem comes down in the code inside the "if(try_merge)" block below.  It merges the source of the rename on the other side with the renamed file, rather than the destination.  In the case with the symlink on the other side, this code merged a symlink with a regular file which resulted in a conflict.  I was trying to eliminate both conflicts in this case by avoiding the final else that sets try_merge=1.

Your re-structuring will therefore only solve half the problem I was trying to solve.

I suppose an alternative solution would have been to change the "if(try_merge)" code to merge with the destination of the rename on the other side, if it exists and is the same type.  However that clearly would have had a much more significant impact on other merge cases, so it didn't seem like a good choice to me.

--Ken
