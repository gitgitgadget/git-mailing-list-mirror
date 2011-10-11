From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Improving performance with pthreads in refresh_index().
Date: Tue, 11 Oct 2011 13:50:14 +0200
Message-ID: <4E942D76.7030908@drmicha.warpmail.net>
References: <1318325521-23262-1-git-send-email-klinkert@webgods.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: klinkert@webgods.de
X-From: git-owner@vger.kernel.org Tue Oct 11 13:50:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDaqm-0000GB-Di
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 13:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab1JKLuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 07:50:18 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57315 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750772Ab1JKLuR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2011 07:50:17 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C48F120A60;
	Tue, 11 Oct 2011 07:50:16 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 11 Oct 2011 07:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=AHasOv+4gJpJOfAzB3F/Vk
	fdlwg=; b=L9qdRy1UyOc02bScAvs4ZquG2nPhIBlraEoLg/yRurwcBuuQcXoRC/
	jX9r0+5SbYhuvcfIi3MKOko2IDEC8HR+vbomFFIk8jKMzMsOQkEbvgUUcz8ETXF1
	tglvQoFMmrszT8vH+bM9Kch5MH56osYT3HN5ZQjVFPtoVTI1xDDTg=
X-Sasl-enc: 4w+2qPYpqeyZSTfs040AKMOjcD1dxO5u1GpUzgJX3JP/ 1318333816
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2BD76402F9D;
	Tue, 11 Oct 2011 07:50:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <1318325521-23262-1-git-send-email-klinkert@webgods.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183292>

klinkert@webgods.de venit, vidit, dixit 11.10.2011 11:32:
> Git performs for every file in a repository at least one (with a cold cache)
> lstat(). In larger repositories operations like git status take a
> long time. In case your local repository is located on a remote server
> (e. g. mounted via nfs) it ends up in an *incredible* slow git.
> 
> With this patch you're able to determine a number of threads (maxthreads)
> in your config file to run these tons of lstats in threads. There
> won't be created any pthreads if you haven't set maxthreads. In my
> test cases a git status with this patch performs enormously faster (over
> two minutes before and approximately 25 seconds now). Of course, it
> has a positive impact on other git commands, too.

Can you specify under which circumstances one should get a speedup? Our
NFS isn't slow enough... but on a dead slow sshfs work tree I get the
following for "git status -s":

maxthreads: 0, preloadindex: false, time: 14.73
maxthreads: 1, preloadindex: false, time: 14.25
maxthreads: 2, preloadindex: false, time: 13.32
maxthreads: 3, preloadindex: false, time: 12.40
maxthreads: 4, preloadindex: false, time: 12.65
maxthreads: 5, preloadindex: false, time: 12.16
maxthreads: 8, preloadindex: false, time: 12.32
maxthreads: 10, preloadindex: false, time: 11.98
maxthreads: 15, preloadindex: false, time: 12.31
maxthreads: 20, preloadindex: false, time: 12.00
maxthreads: 0, preloadindex: true, time: 12.17
maxthreads: 1, preloadindex: true, time: 11.98
maxthreads: 2, preloadindex: true, time: 12.21
maxthreads: 3, preloadindex: true, time: 11.99
maxthreads: 4, preloadindex: true, time: 12.14
maxthreads: 5, preloadindex: true, time: 12.21
maxthreads: 8, preloadindex: true, time: 12.14
maxthreads: 10, preloadindex: true, time: 12.08
maxthreads: 15, preloadindex: true, time: 12.16
maxthreads: 20, preloadindex: true, time: 11.96

So it seams it gives me what preloadindex does, which is not much.

Note: I'm not saying the patch is bad. I'm just wondering whether that
is expected.

Michael
P.S.: It's actually sshfs with ssh to an NFSv3 client (server restricts
exports) :(
