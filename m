From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] replace unsinged long with time_t
Date: Thu, 6 Nov 2008 10:13:46 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811061000430.3419@nehalem.linux-foundation.org>
References: <1225993728-4779-1-git-send-email-david@statichacks.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Bryson <david@statichacks.org>
X-From: git-owner@vger.kernel.org Thu Nov 06 19:15:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky9Ns-00079T-C4
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 19:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbYKFSNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 13:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbYKFSNx
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 13:13:53 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33049 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750733AbYKFSNx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Nov 2008 13:13:53 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA6IDknx024374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Nov 2008 10:13:47 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA6IDkQw006288;
	Thu, 6 Nov 2008 10:13:46 -0800
In-Reply-To: <1225993728-4779-1-git-send-email-david@statichacks.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.937 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100259>



On Thu, 6 Nov 2008, david@statichacks.org wrote:
> 
> Here is a patch set from the Janitor page to replace unsigned long with time_t.

I actually don't much like this.

"time_t" is one of those totally broken unix types. The standards say that 
it's an "arithmetic" type, but leaves it open to be just about anything. 
Traditionally, it's a signed integer (bad), and in theory it could even be 
a floating point value, I think.

And in _all_ such cases, it's actually better to cast it to "unsigned 
long" than keep time in a system-dependent format that is most likely 
either _already_ "unsigned long", or alternatively broken.

IOW, "unsigned long" is practically always either the same, or better 
than, time_t. Do you actually have a platform where that isn't the case?

And we do end up casting it to "unsigned long" in the end anyway - the 
date format in the commit is fundamentally not a signed one, and we use 
"%lu" to print those things. Again, if we were to use "time_t", we'd now 
have a huge and fundamental confusion about how to print them out, and 
what to do if they were negative.

So "time_t" really is a pretty damn worthless type. It's not _quite_ as 
broken as "socklen_t" (which is just a broken name for "int", and anybody 
who declares it to be anythign else is a total moron), but it's close.

In theory, some platform might have a 64-but "unsigned long long" time_t 
even if the architecture is 32-bit (apparently windows used to do that if 
you included <time64.h>, for example), but since we wouldn't take 
advantage of that anyway, even then there is no real advantage.

				Linus
