From: Jeff Garzik <jgarzik@pobox.com>
Subject: git-prune-script eats data
Date: Tue, 21 Jun 2005 20:51:53 -0400
Message-ID: <42B8B629.1040208@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 22 02:46:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DktNN-00047D-8Y
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 02:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVFVAv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 20:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVFVAv7
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jun 2005 20:51:59 -0400
Received: from mail.dvmed.net ([216.237.124.58]:15274 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262418AbVFVAv5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2005 20:51:57 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DktT9-00027Z-7f
	for git@vger.kernel.org; Wed, 22 Jun 2005 00:51:56 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok, I have a reproducible case (at least for me), of git-prune-script 
munching data. I'll just give reproduction instructions (everyone 
reading this can do what I did), and some output at the end.

$ cd /repos

$ mkdir libata-dev-test/.git

$ cd libata-dev-test

$ cp -al ../linux-2.6/.git/objects .git/

$ rsync -az --verbose --delete \
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git/ 
  .git/		# word-wrapped from previous line

$ git-checkout-script -f

$ git-fsck-cache
dangling commit 1b142a71f3b131317489edf806abfab4c347476c
dangling commit 51a7f407d9b600e3278449a12135a21ffb0791a2
dangling commit eb93f3e7284204379444137a660b64f9dbd2ec04
dangling commit fcf604172829176bc618663e8387c8943ff88b66

NOTE:  These dangling commits are NORMAL -- stuff that really does need 
pruning.

$ git-prune-script

$ git-fsck-cache
error: cannot map sha1 file c39ae07f393806ccf406ef966e9a15afc43cc36a
bad object in tag 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
bad sha1 entry '5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c'

$ rsync -az --verbose --delete \
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git/ 
  .git/		# word-wrapped from previous line
		# this second invocation downloads a TON of objects,
		# most/all of which are in the vanilla linux-2.6 tree
		# and should not have been pruned


