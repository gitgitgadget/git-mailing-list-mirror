From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: tracking perms/ownership
Date: Thu, 23 Aug 2007 16:30:21 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708231626580.30176@woody.linux-foundation.org>
References: <1187716461.5986.71.camel@beauty> <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty> <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty>
 <7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Josh England <jjengla@sandia.gov>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 01:31:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOM8y-0004uh-9y
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 01:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbXHWXbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 19:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761999AbXHWXbM
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 19:31:12 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56571 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761969AbXHWXbL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 19:31:11 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7NNUOC1006494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Aug 2007 16:30:25 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7NNUL3F032538;
	Thu, 23 Aug 2007 16:30:22 -0700
In-Reply-To: <7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.751 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56539>



On Thu, 23 Aug 2007, Junio C Hamano wrote:
>
> "Josh England" <jjengla@sandia.gov> writes: 
> > Looking at the index struct, it already has fields in it for file mode
> > uid and gid (woohoo!).
> 
> I can see that storing textual names in gitattributes and having
> the root user run git so that it can chown(), would work.

Well, the nice thing is that even non-root can actually resolve merge 
conflicts and generally use the archive, even if non-root obviously cannot 
then actually set the files to those users/groups!

So handling ownership outside of the actual filesystem, in a separate file 
that git tracks, actually allows you to do things that you couldn't 
otherwise sanely do.

It obviously does have downsides:

> But this is only about checkout.  After you chown a file in the
> work tree and run update-index, next write-tree would not record
> it, as there is no place in tree objects to record uid/gid.

This is a direct consequence of allowing non-root to actually work with 
such a repository: the git-tracked ownership information simply is 
separate, and "git update-index" and friends will never do anything about 
it, since they just can't rely on the *filesystem* user/group information 
anyway (because normal users would never be allowed to set it, anyway).

		Linus
