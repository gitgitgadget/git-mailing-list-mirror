From: Jan Wielemaker <J.Wielemaker@cs.vu.nl>
Subject: Re: subdirectory-filter does not delete files before the directory
 came into existence?
Date: Sun, 19 Dec 2010 10:34:49 +0100
Message-ID: <1292751289.21229.26.camel@ct>
References: <1292365295.6666.22.camel@ct>
	 <201012150003.30127.trast@student.ethz.ch>
	 <1292415733.11607.51.camel@hppc323.few.vu.nl>
	 <201012190323.59829.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Dec 19 10:51:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUFvO-00064t-5C
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 10:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab0LSJvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 04:51:08 -0500
Received: from fep32.mx.upcmail.net ([62.179.121.50]:42120 "EHLO
	fep32.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab0LSJux (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 04:50:53 -0500
X-Greylist: delayed 948 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Dec 2010 04:50:52 EST
Received: from edge03.upcmail.net ([192.168.13.238])
          by viefep20-int.chello.at
          (InterMail vM.8.01.02.02 201-2260-120-106-20100312) with ESMTP
          id <20101219093501.FXDL1667.viefep20-int.chello.at@edge03.upcmail.net>;
          Sun, 19 Dec 2010 10:35:01 +0100
Received: from [192.168.1.103] ([62.194.83.75])
	by edge03.upcmail.net with edge
	id kxaz1f01H1dWq6u03xb0qb; Sun, 19 Dec 2010 10:35:01 +0100
X-SourceIP: 62.194.83.75
In-Reply-To: <201012190323.59829.trast@student.ethz.ch>
X-Mailer: Evolution 2.30.3 
X-Cloudmark-Analysis: v=1.1 cv=kR4HTYXl3FXdRAFjS5RpcnDbDNViz/VYMWXR75RtSM0= c=1 sm=0 a=KVGVhWRK6BAA:10 a=IkcTkHD0fZMA:10 a=TSbVqHtbAAAA:8 a=bxOqMZPIrgJ9GVZcY1EA:9 a=VED2HGx4T-ySS6SV5EEA:7 a=rC9L10uGLkuIDU5E8d041XocRxYA:4 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163954>

On Sun, 2010-12-19 at 03:23 +0100, Thomas Rast wrote:
> Jan Wielemaker wrote:
> > The reported problems also apply to the next module.  What appears to
> > work is this:
> > 
> >   * Walk through the history, finding the commit where the directory
> >   is created.
> >   * use git tag -l --contains <commit that created dir> to get the 
> >   tags we want to keep.
> >   * get all tags, use comm and delete the tags not in the `contained'
> >   set above.
> > 
> > Not very friendly and I'm (with Thomas) about the status of these
> > findings.  I like to thank Thomas for giving me the right clue.
> 
> Now I finally remember where I knew this problem from:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/91708
> 
> (My memory really sucks.)

Funny.  That was me having problems with filtering out directories
as well :-)  I thought your patch was added using the --prune-empty
flag.  I guess you can comment on that.  I can confirm that I've got
nice and clean filtering using

  * git filter-branch --subdirectory-filter <dir> --prune-empty
--tag-name-filter cat -- --all
  
followed by the steps above.  I use qgit with the tree-view enabled
to find the place where the hierarchy changes from the complete one
to the only-this-dir one.  You can do a binary search for that and
you spot the exact commit easily by the gap in the history-line.  Then
I run this little bit of code:

#!/bin/bash

contains="$1"

git tag | sort > tags.all
git tag -l --contains $contains | sort > tags.keep

for t in `comm -23 tags.all tags.keep`; do
  git tag -d $t
done

Not ideal, but doable.

	Cheers --- Jan
