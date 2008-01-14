From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: performance problem: "git commit filename"
Date: Mon, 14 Jan 2008 13:00:38 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801141250340.2806@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org> <7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
 <7vd4s6qal0.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org> <7vr6glnrvp.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801140902140.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801141132250.2806@woody.linux-foundation.org>
 <7vodbojhkj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 22:04:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEWU6-0002zq-Dw
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 22:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbYANVDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 16:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYANVDy
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 16:03:54 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52071 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751736AbYANVDx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2008 16:03:53 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0EL0dtj023616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jan 2008 13:00:40 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0EL0c3N014011;
	Mon, 14 Jan 2008 13:00:38 -0800
In-Reply-To: <7vodbojhkj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70477>



On Mon, 14 Jan 2008, Junio C Hamano wrote:
> 
> If we are using different types anyway, we might want to start
> using time_t (a worse alternative is ulong which we use for
> timestamps everywhere else, which we probably want to convert to
> time_t as well).

Careful.

There are two issues, one trivial one and one important one:
 (a) trivially, right now, the code depends on the fact that the in-memory 
     structure is actually smaller than the on-disk one, to avoid having 
     to estimate the size of the allocation for the in-memory array. That 
     was a matter of gettign a quickly working and efficient patch (we do 
     *not* want to allocate those initial "struct cache_entry" entries one 
     by one, we want to allocate one big block!)

     This should be pretty easy to fix up, by just taking the sizes and 
     number of entries (which we do know) into account of the initial 
     allocation. However, it's made a bit more interesting by the 
     differing alignment of the "name" part (and the fact that we align 
     each individual on-disk and in-memory structure).

 (b) More importantly, the on-disk structures DO NOT CONTAIN the whole 
     stat information! The classic example of this is "ce_size": it's 
     32-bit, but it works even if you have a file that is larger than 32 
     bits in size! It just means that from a stat comparison standpoint, 
     we only compare the low 32 bits!

     This means that if you make "ce_size" be a "loff_t", for example, you 
     still need to then *compare* it in just an "unsigned int",  because 
     the upper bits aren't zero - they are "nonexistent".

that (b) is important, and is why some of the code changed from

	-       if (ce->ce_ino != htonl(st->st_ino))
	+       if (ce->ce_ino != (unsigned int) st->st_ino)

ie note how this didn't just remove the "htonl()", it replaced it by a 
"truncate to 'unsigned int'"!

So the fact that the types aren't necessarily the "native" types is 
actually *important*.

> Is there still a reason to insist that ce_flags should be a
> single field that is multi-purposed for storing stage, namelen
> and other flags?  Wouldn't the code become even simpler and
> safer if we separated them into individual fields?  For example,
> a piece like this:

No reason for that part, except I wanted to make this particular initial 
patch be as minimal as possible.

> I somehow had this impression that it was a huge deal to you
> that we do not have to read and populate each cache entry when
> reading from the existing index file, and thought that was the
> reason why we mmap and access the fields in network byte order.
> If that was my misconception, then I agree this is a good change
> to make everything else easier to write and much less error
> prone.

I was a bit worried about it, but I did make sure that the allocation is 
done as one single allocation, and I did time it. Doing a 

	git update-index --refresh

seems to be identical before and after, so the costs of conversion are 
either very small or are possibly counteracted by the fact that we then 
can avoid the byte-order conversion of individual words less at run-time.

		Linus
