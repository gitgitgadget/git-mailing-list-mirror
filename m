From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Fri, 20 Feb 2015 13:37:34 -0700
Message-ID: <3770789.lx2BnZ41U2@mfick1-lnx>
References: <20150220065801.7CDC7140BE4@smtp.codeaurora.org> <1424456952.31528.6.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Stephen Morton <stephen.c.morton@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 21:37:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOuKS-0006yo-ER
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 21:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbbBTUhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 15:37:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37980 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbbBTUhf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 15:37:35 -0500
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5E9C4140310;
	Fri, 20 Feb 2015 20:37:35 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 4FA7F14036E; Fri, 20 Feb 2015 20:37:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick1-lnx.localnet (unknown [129.46.10.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 0876C140310;
	Fri, 20 Feb 2015 20:37:34 +0000 (UTC)
User-Agent: KMail/4.8.5 (Linux/3.2.0-75-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <1424456952.31528.6.camel@leckie>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264184>

On Friday, February 20, 2015 01:29:12 PM David Turner wrote:
>...
> For a more general solution, perhaps a log of ref updates
> could be used. Every time a ref is updated on the server,
> that ref would be written into an append-only log.  Every
> time a client pulls, their pull data includes an index
> into that log.  Then on push, the client could say, "I
> have refs as-of $index", and the server could read the
> log (or do something more-optimized) and send only refs
> updated since that index.

Interesting idea, I like it.

How would you make this reliable?  It relies on updates 
being reliably recorded which would mean that you would have 
to ensure that any tool which touches the repo follows this 
convention.  That is unfortunately a tough thing to enforce 
for most people.

But perhaps, instead of logging updates, the server could 
log snapshots of all refs using an atomically increasing 
sequence number.  Then missed updates do not matter, a 
sequence number is simplly an opaque handle to some full ref 
state that can be diffed against.  The snapshots need not 
even be taken inline with the client connection, or with 
every update for this to work.  It might mean that some 
extra updates are sent when they don't need to be, but at 
least they will be accurate.

I know in the past similar ideas have been passed around, 
but they typically relied on the server keeping track of the 
state of each client.  Instead, here we are talking about 
clients keeping track of state for a particular server.  
Clients already store info about remotes.

A very neat idea indeed, thanks!

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
