X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] change the unpack limit treshold to a saner value
Date: Wed, 6 Dec 2006 17:08:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612061700120.3542@woody.osdl.org>
References: <Pine.LNX.4.64.0612061420410.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 7 Dec 2006 01:08:33 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612061420410.2630@xanadu.home>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33541>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs7kV-0006Br-0t for gcvg-git@gmane.org; Thu, 07 Dec
 2006 02:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937849AbWLGBI2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 20:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937901AbWLGBI2
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 20:08:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:32963 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937849AbWLGBI1
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 20:08:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB718DID014183
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 6
 Dec 2006 17:08:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB718Cq8023758; Wed, 6 Dec
 2006 17:08:13 -0800
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org



On Wed, 6 Dec 2006, Nicolas Pitre wrote:
> 
> This is why I think the current default treshold should be 3 instead of 
> the insane value of 5000.  But since it feels a bit odd to go from 5000 
> to 3 I setled on 10.

Definitely not.

We have a much easier time handling many loose packed objects than many 
pack-files. For many reasons, but two really obvious ones:

 - pack-file indexes get read in on startup, and we maintain an explicit 
   list of them. Having lots of pack-files adds overhead that doesn't 
   exist for lots of loose objects.

 - loose files are spread out over 256 subdirectories to make lookup 
   easier, packfiles are not (and always create an index file too).

So in general, as a trivial heuristic, you probably want about 512 times 
as many loose objects as you want pack-files, i fonly because of the 
latter issue, because you can much more easily handle lots of loose 
objects than lots of pack-files. So it's _not_ a factor of 3. Or even 10.

But since there _is_ reason to do pack-files too, and since using too big 
a value means that you never end up keeping a pack-file _at_all_ if you 
pull often, I'd suggest that rather than use a limit of 512 you go for 
something like 100-200 objects as the threshold (of course, the proper one 
would depend on the distribution of the size of your pack-files, but I'll 
just hand-wave and say that together with occasional re-packing, something 
in that range is _generally_ going to be a good idea).

