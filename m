From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.17-rc6-mm2
Date: Thu, 15 Jun 2006 19:46:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org>
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com>
 <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 04:46:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr4Lv-00041B-9B
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 04:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWFPCqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 22:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWFPCqY
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 22:46:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8678 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750712AbWFPCqX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 22:46:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5G2kLgt003890
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Jun 2006 19:46:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5G2kJLB003521;
	Thu, 15 Jun 2006 19:46:20 -0700
To: Goo GGooo <googgooo@gmail.com>
In-Reply-To: <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21926>



On Fri, 16 Jun 2006, Goo GGooo wrote:
> 
> That's confusing - I believed all protocols should behave the same way...?

Not really. The primary protocol is the native git one, and the others try 
to do a best effort, but the http protocol really can't do a very good 
job unless the server side has run "git update-server-info" to help the 
http client along.

I suspect that the -mm git tree simply doesn't do that. In fact, even the 
main tree didn't use to do it, but I finally just broke down and added the 
proper hook to make it always do it automatically when I push.

(In case Andrew wants to do that, the way to do it is:

	echo -e "#!/bin/sh\nexec git-update-server-info" > hooks/post-update
	chmod +x hooks/post-update

inside the git repository - all it will do is always execute that script, 
and this "git-update-server-info", after you've updated the repo).

Finally, the rsync protocol just copies all objects over, and since it 
doesn't even know _which_ objects it is getting, it doesn't do the normal 
tag following that the native git protocol does.

So to recap:
 - http is fundamentally weaker, and needs some server-side help to work
 - rsync is fine for the initial clone, but doesn't actually know what 
   it's doing, so the end result can actually even be a corrupted 
   repository, because you happened to rsync just as it was updating.
 - the native git protocol generally should be considered the golden 
   standard, where the other ones are just fallbacks in case of problems 
   (like firewalls that don't let git:// through, or more commonly hosted 
   servers that don't do the git protocol at all).

Which hopefully clarifies the issue a bit.

		Linus
