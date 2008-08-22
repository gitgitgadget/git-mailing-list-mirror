From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Linux 2.6.27-rc3: kernel BUG at mm/vmalloc.c - bisected
Date: Fri, 22 Aug 2008 14:16:51 -0700
Message-ID: <20080822141651.fe16ed99.akpm@linux-foundation.org>
References: <48A36838.3050309@hp.com>
	<20080819124602.9e8e69f7.akpm@linux-foundation.org>
	<48AEDD3D.4060507@hp.com>
	<20080822092549.ddcb7e79.akpm@linux-foundation.org>
	<20080822171651.GP10544@machine.or.cz>
	<20080822105136.a8432875.akpm@linux-foundation.org>
	<7v7ia8ahgu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@suse.cz, Alan.Brunelle@hp.com, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:18:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWe1k-0008GL-EO
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbYHVVRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbYHVVRc
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:17:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37712 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754518AbYHVVRb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2008 17:17:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7MLGpso002872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Aug 2008 14:16:52 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m7MLGpRr017035;
	Fri, 22 Aug 2008 14:16:51 -0700
In-Reply-To: <7v7ia8ahgu.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.837 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93369>

On Fri, 22 Aug 2008 14:05:21 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Fri, 22 Aug 2008 19:16:51 +0200
> > Petr Baudis <pasky@suse.cz> wrote:
> >
> >> On Fri, Aug 22, 2008 at 09:25:49AM -0700, Andrew Morton wrote:
> > ...
> >> > urgh, it's irritating when git-bisect directs you to a merge commit - it
> >> > hasn't done it for me for ages.
> >> 
> >> Hmm, but doesn't that happen only when it's actually really the merge
> >> commit that introduces the bug? Both parents of the merge commit were
> >> marked as good by the user, so...
> >
> > A merge commit doesn't contain any kernel changes?  It's the individual
> > commits (aka "patches") which were in that merge which broke stuff. 
> > Confused.
> >
> > We're trying to dive inside that merge commit to find out which of the
> > real commits caused the regression.
> 
> You may find neither parents were buggy, but the result of the merge is.
> 
> A trivial example is when one branch changes the semantics of an existing
> function and converts all the call sites to the updated semantics, while
> the other branch adds a new call site that still relies on the old
> behaviour of that function.  The merge most likely won't textually
> conflict, and neither git merge nor quilt patch would report conflicts,
> but the end result is that the new call site added by the latter branch
> now gets an unexpected outcome from the function and can misbehave.  You
> cannot blame the breakage to either branch for such a breakage.

Sure, but

a) whoever added a change like that without also causing the build to
   break is slappable and

b) there are now two commits (one in each branch) either one of
   which, when applied on top of the other branch will introduce the
   regression.

   That's useful infomation, but we don't know how to get
   git-bisect to give it to us.


It's pretty simple.  If git-bisect tells us that the regression was
introduced by a merge commit, we want to perform a bisection within
that merge's individual commits.
