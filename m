From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have
 an up-to-date cache entry
Date: Thu, 9 Jul 2009 09:59:10 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907090954090.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain>
 <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 18:59:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOwy4-0002YG-Ld
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 18:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbZGIQ70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 12:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbZGIQ7Z
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 12:59:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42116 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750902AbZGIQ7Z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 12:59:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69GxBgL030984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jul 2009 09:59:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69GxAgX003808;
	Thu, 9 Jul 2009 09:59:11 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122991>



On Thu, 9 Jul 2009, Junio C Hamano wrote:
> > +
> > +	/* Try to look it up as a directory */
> > +	pos = cache_name_pos(path, len);
> > +	if (pos >= 0)
> > +		return 0;
> 
> How can this find an exact entry for the path?  Assuming that the name
> hash cache_name_exists() is not out of sync?

Hopefully it would never trigger. But I'd rather write robust code that 
doesn't make any fancy assumptions. Keep it simple - and keep it working 
even if surprising things happen. 

> > +		if (!ce_uptodate(ce))
> > +			break;	/* continue? */
> 
> I think this should be continue, as the directory D you are interested in
> may have two files, one modified, the other uptodate.

The thing is, the directory may have subdirectories, and there may be 
tens of thousands of files there. And maybe this gets called by code that 
hasn't done any cache preloading at all, so nothing will be up-to-date.

Do we want to loop over thousands of entries? Or do we want to loop as 
little as possible, and just say "most of the time the first entry will be 
representative".

But I did put the 'continue' in a comment, because it's not a correctness 
issue, it's a gut feel. 

			Linus
