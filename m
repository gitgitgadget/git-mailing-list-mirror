From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bug: segfault during git-prune
Date: Thu, 28 Jun 2007 09:09:56 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706280901580.8675@woody.linux-foundation.org>
References: <200706281134.58453.andyparkins@gmail.com>
 <alpine.LFD.0.98.0706280844460.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 18:10:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3wZL-0004Ho-V1
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 18:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbXF1QKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 12:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbXF1QKG
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 12:10:06 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50538 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752413AbXF1QKE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jun 2007 12:10:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5SGA29Z021487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Jun 2007 09:10:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5SG9urb028841;
	Thu, 28 Jun 2007 09:09:57 -0700
In-Reply-To: <alpine.LFD.0.98.0706280844460.8675@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.626 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51117>



On Thu, 28 Jun 2007, Linus Torvalds wrote:
> 
> Yeah, git-fsck knows about subprojects. I bet git-prune just doesn't. 
> 
> And indeed.. Here's a patch for it, but the fact is, you really should 
> *not* prune that repository, because you'll prune away all the subproject 
> data, which you seem to have in the same repo!
> 
> (General rule: never *ever* prune a shared object repository!)

Btw, we could make the "reachable" code say that *if* you have the commit 
of a subproject in your current object directory, it will follow that 
commit recursively, and thus sharing an object store at the superproject 
level is "ok" as far as "git prune" is concerned.

We don't currently even have that kind of function, though. Calling 
"parse_commit()" will complain very loudly if the commit doesn't exist, 
but it's actually perfectly fine to not exist if it's in a separate 
subproject.

So if you actually want to use subprojects *and* prune them, *and* you 
want to keep all the subproject objects in the same big object database, 
you'd have to add some commit object "parse-if-you-can-find-it" thing, and 
use that.

It shouldn't be fundamentally hard, but it's _not_ what my patch did. My 
patch just says: "subprojects are separate projects, and we don't do 
reachability from superproject to subproject".

		Linus
