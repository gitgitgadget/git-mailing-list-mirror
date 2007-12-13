From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Thu, 13 Dec 2007 08:35:43 +0100
Message-ID: <4760E0CF.1030805@viscovery.net>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>  <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>  <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com>  <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com>  <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com>  <20071212041002.GN14735@spearce.org>  <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>  <20071212052329.GR14735@spearce.org>  <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com>  <Pine.LNX.4.64.0712121814260.27959@racer.site> <31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com> <Pine.LNX.4.64.0712121931050.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jason Sewall <jasonsewall@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 13 08:36:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ic4-0007AX-KI
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 08:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbXLMHfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 02:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753645AbXLMHfr
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 02:35:47 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:10108 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452AbXLMHfq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 02:35:46 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J2ibz-0002HG-Jv; Thu, 13 Dec 2007 08:36:03 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 962BF69F; Thu, 13 Dec 2007 08:35:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0712121931050.27959@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68127>

Johannes Schindelin schrieb:
> When you select the context menu item "Split Hunk" in the diff area,
> git-gui will now split the current hunk so that a new hunk starts at
> the current position.
> 
> For this to work, apply has to be called with --unidiff-zero, since
> the new hunks can start or stop with a "-" or "+" line.

NACK! --unidiff-zero eats your data.

1. Prepare a modification that adds 2 lines that are *not* adjacent, like this:

	@@ -6,6 +6,8 @@ git-checkout [options] [<branch>] [<paths>...]
	 --
	 b=          create a new branch started at <branch>
	+first
	 l           create the new branch's reflog
	 track       arrange that the new branch tracks the remote branch
	+after track
	 f           proceed even if the index or working tree is not HEAD
	 m           merge local modifications into the new branch

2. Reduce context to zero.
3. Stage *second* hunk.

Result: It is staged at the wrong place:

	@@ -9,4 +9,5 @@ l           create the new branch's reflog
	 track       arrange that the new branch tracks the remote branch
	 f           proceed even if the index or working tree is not HEAD
	+after track
	 m           merge local modifications into the new branch
	 q,quiet     be quiet


Reason: --unidiff-zero can only look at the line numbers. And those are
wrong because it doesn't account for the shift in line numbers caused by the
first hunk.

-- Hannes
