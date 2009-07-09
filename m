From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have
 an up-to-date cache entry
Date: Thu, 9 Jul 2009 11:53:22 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain> <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain> <7vab3d3dpc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 20:54:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOyl5-0006Ar-HX
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 20:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbZGISyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 14:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbZGISyI
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 14:54:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48981 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752086AbZGISyH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 14:54:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69IrNXh008271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jul 2009 11:53:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69IrMTK022174;
	Thu, 9 Jul 2009 11:53:22 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vab3d3dpc.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123002>



On Thu, 9 Jul 2009, Junio C Hamano wrote:
> 
> Would dir/a be marked as uptodate in the index, if somebody preloads the
> index, after the above sequence?  I hope not.

Index preloading does not care about directories. It does the standard

	if (ie_match_stat(index, ce, &st, CE_MATCH_RACY_IS_DIRTY))
		continue;

and since it's all threaded (and the whole _point_ is that it's threaded), 
it can't do anything fancier. Our lstat cache is _not_ thread-safe.

But preloading isn't even the only thing to do that. All the merge logics 
also just do "ie_match_stat()", as does git checkout, although maybe the 
directory gets validated separately for those cases before recursion.

Looking at "ce_mark_uptodate()", I think diff-lib.c is the only one that 
actually does that whole "has_symlink_leading_path()" thing (in 
"check_removed()").

I guess we could make out lstat cache thread-safe, and have the callers 
pass in a per-thread "struct cache_def *". That would work well enough for 
preloading (and everybody else could just use some random static one and 
pass that in).

Added Kjetil to cc.

			Linus
