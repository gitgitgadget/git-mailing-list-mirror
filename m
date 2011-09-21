From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git checkout under 1.7.6 does not properly list untracked
 files and aborts
Date: Wed, 21 Sep 2011 20:28:34 +1000
Message-ID: <20110921102834.GA21353@duynguyen-vnpc>
References: <4E6A7167.6070408@workspacewhiz.com>
 <4E779BA4.8070109@workspacewhiz.com>
 <4E78ACE2.60306@drmicha.warpmail.net>
 <4E78DACF.3030200@workspacewhiz.com>
 <4E7996AA.4040909@drmicha.warpmail.net>
 <4E79A04B.7080607@drmicha.warpmail.net>
 <20110921085842.GA29768@duynguyen-vnpc>
 <4E79AB5F.5020809@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 21 12:28:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6K2q-0004Fa-OO
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 12:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab1IUK2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 06:28:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40340 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab1IUK2n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 06:28:43 -0400
Received: by gyg10 with SMTP id 10so1000641gyg.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 03:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=96MqB6fpYJcjMh6P2UDTc1x/vksX4B0IypYtHOPE0RA=;
        b=S/pB/YKP4QDW0N2mMqBGJw7d4LOlwkkoaOr9+JVIihUJzMfmNSiSk4IXNMOHTLMNXk
         gGvsHvri0K/FcLnXA4K+ZjVfPDaqscPnUVSiEG75YjsL5ZicYZwK4H3pijTQHVxwwuni
         grdG2moArGy/LkR5nuDal2G+zHwi6Y1E4crho=
Received: by 10.150.150.6 with SMTP id x6mr793504ybd.325.1316600922756;
        Wed, 21 Sep 2011 03:28:42 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id e7sm19985297ang.17.2011.09.21.03.28.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Sep 2011 03:28:41 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 21 Sep 2011 20:28:34 +1000
Content-Disposition: inline
In-Reply-To: <4E79AB5F.5020809@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181835>

On Wed, Sep 21, 2011 at 11:16:15AM +0200, Michael J Gruber wrote:
> Thanks. I can confirm that with the above patch, the code compiles and
> fails my test. So it's the earlier of the two commits which introduces this.

I was afraid some logic had gone horribly wrong. Turns out I did not
catch up with unpack_trees() coding style and drop the error messages
so "git checkout" in this case becomes "git checkout -q".

This patch should fix it. Need another look before I submit a real
patch though.

diff --git a/unpack-trees.c b/unpack-trees.c
index cc616c3..79e9e88 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1102,12 +1102,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			 */
 			if (ce->ce_flags & CE_ADDED &&
 			    verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
-					return -1;
+				goto return_failed;
 
-			if (apply_sparse_checkout(ce, o)) {
-				ret = -1;
-				goto done;
-			}
+			if (apply_sparse_checkout(ce, o))
+				goto return_failed;
 			if (!ce_skip_worktree(ce))
 				empty_worktree = 0;
 
