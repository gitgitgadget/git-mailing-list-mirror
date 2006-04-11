From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: cg-admin-rewritehist --tree-filter revives removed files
Date: Tue, 11 Apr 2006 21:26:39 +0200
Message-ID: <200604112126.39365.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 11 21:27:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTOVv-0003bG-TB
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 21:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWDKT04 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 15:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWDKT04
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 15:26:56 -0400
Received: from mail.nextra.at ([195.170.70.67]:48480 "EHLO mail.nextra.at")
	by vger.kernel.org with ESMTP id S1751085AbWDKT0z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Apr 2006 15:26:55 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by mail.nextra.at (8.13.6/8.13.6) with ESMTP id k3BJQjRQ018132
	for <git@vger.kernel.org>; Tue, 11 Apr 2006 21:26:47 +0200 (MEST)
X-Abuse-Info: Please report abuse to abuse@eunet.co.at, see http://www.eunet.at/support/service
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B3CD849863
	for <git@vger.kernel.org>; Tue, 11 Apr 2006 21:26:39 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18618>

I ran this on a small project:

  cg-admin-rewritehist --tree-filter ':' testbranch

Thereafter, the tree in testbranch has all files that had been removed in the 
original history. I used cg-switch testbranch to check this.

The main loop in cg-admin-rewritehist does this (among others) for each commit 
in the original history:

if [ "$filter_tree" ]; then
	git-checkout-index -f -u -a
	eval "$filter_tree"
	git-diff-index -r $commit | cut -f 2- | tr '\n' '\0' | \
		xargs -0 git-update-index --add --replace --remove
	git-ls-files --others | tr '\n' '\0' | \
		xargs -0 git-update-index --add --replace --remove
fi

Appearently, once files are checked out, they stay in the working directory 
and are readded in all subsequent iterations if the current commit's tree 
does not contain them.

I'm not proficient enough to fix this problem myself, so I hope for help from 
the list.

Thanks,
-- Hannes
