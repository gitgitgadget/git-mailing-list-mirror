From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: encrypted repositories?
Date: Fri, 17 Jul 2009 12:38:16 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907171226460.13838@localhost.localdomain>
References: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 17 21:39:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRtHI-0005SC-98
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 21:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbZGQTit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 15:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbZGQTit
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 15:38:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41619 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751397AbZGQTis (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 15:38:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6HJcG1F028892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 17 Jul 2009 12:38:17 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6HJcGhv008155;
	Fri, 17 Jul 2009 12:38:16 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.465 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123483>



On Fri, 17 Jul 2009, Matthias Andree wrote:
>
> Assume you have a repository where you want to work on embargoed information,
> so that not even system administrators of the server you're pushing to can get
> a hold of the cleartext data.

If the server can't ever read it, you're basically limited to just one 
story:

 - use rsync-like "stupid" transports to upload and download things.

 - a "smart" git server (eg the native git:// style protocol is not going 
   to be possible)

and you strictly speaking need no real git changes, because you might as 
well just do it by uploading an encrypted tar-file of the .git directory. 
And there is literally no upside in doing anything else - any native git 
support is almost entirely pointless.

You could make it a _bit_ more useful perhaps by adding some helper 
wrappers, probably by just implementing a new transport name (ie instead 
of using "rsync://", you'd just use "crypt-tgz://" or something).

Now, that said, there are probably situations where maybe you'd allow the 
server to decrypt things _temporarily_, but you don't want to be encrypted 
on disk, and no persistent keys on the server, then that would open up a 
lot more possibilities.

Of course, that still does require that you trust the server admin to 
_some_ degree - anybody who has root would be able to get the keys by 
running a debugger on the git upload/download sequence when you do a 
upload or download.

Maybe that kind of security is still acceptable to you, though? 

IF that is the case, then at least in theory we could add support for 
"encryption key exchange" to the native git protocol, and then you could 
have encryption over the network access (ssh obviously already does that, 
but I'm including things like the anonymous git:// protocol too), and 
you'd have encrypted data on disk, but git-upload-pack would be able to 
decrypt things in order to do deltas etc.

But see above: in order for that to work, you do have to allow the pack 
upload and download processes on the server to decrypt things (in memory). 
So it would not be "absolutely secure".

			Linus
