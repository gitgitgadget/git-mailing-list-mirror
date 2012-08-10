From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v3 01/13] Move index v2 specific functions to their
 own file
Date: Fri, 10 Aug 2012 17:40:15 +0200
Message-ID: <20120810154015.GF5127@tommy-fedora.scientificnet.net>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-2-git-send-email-t.gummerer@gmail.com>
 <7vtxwbn2qe.fsf@alter.siamese.dyndns.org>
 <87hasan7ty.fsf@thomas.inf.ethz.ch>
 <7vobmilro1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	mhagger@alum.mit.edu, pclouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 17:40:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzrK5-0003ho-Td
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 17:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab2HJPkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 11:40:21 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:60788 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab2HJPkT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 11:40:19 -0400
Received: by weyx8 with SMTP id x8so1074278wey.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kgkfA/OZvDXWx3c2Nfy5xqGo1t4XAIt5VRIjIcRaSTM=;
        b=d8H/00wkn7uCU86C3OKXvLxNUx7NlkLwI7yWQjBX+MwfIFzJjzUmccG2MNOB9yAopV
         VwSfmdWgKH3MukqY2zX7OczwrTNG4lg0Ln9m2AHralZQ+9CaYCbnu+H7jmkJrvmK4tYj
         Xkx2d/V+KiB+H6XtPdPU2xIzpcOBajnqkOSD7+gklVu9yS/to3g24IDaYCd97IP1c8MC
         jd1Jc95HQbZlIvNKWRvRuyYEbc/seUW3fowd5XTho07t4+R7r5eXc3gTDs0jQvweM9aT
         /L73/8GsR0xdJ4sd1q0krEF0vNB0YivAZTf6u4+PgcnVVQ1E/vPxZu8XngxCpM/y3/J3
         S4RQ==
Received: by 10.217.2.133 with SMTP id p5mr1800283wes.143.1344613218438;
        Fri, 10 Aug 2012 08:40:18 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id cl8sm8364144wib.10.2012.08.10.08.40.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Aug 2012 08:40:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vobmilro1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203228>

On 08/10, Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > But I think the idea always was that any write that changes the basic
> > layout of the file (so that you would read something wrong) will need a
> > full rewrite.  Otherwise we're too far in DB land.
> >
> > Most updates will be
> > of the "update the stat and/or sha1 of a file" kind, anyway.
> 
> Yes, I agree the v5 format documented in the series does not let you
> do anything other than the kind of updates without rewriting [*1*]
> 
> But that does not fundamentally change the story that a new format
> and a new way to access the index to cope with larger projects would
> want to come up with a solution to address the competing read/write
> issue, or at least help to make it easier to solve the issue in the
> future.
> 
> "That problem is not new" is not an answer when the question is "We
> still have the problem".
> 
> 
> [Footnote]
> 
> *1* While my gut feeling matches your guess that the kind of updates
> would be the majority, I do not think anybody did numbers to
> substanticate it, which we may want to see happen.

Hrm anther way to solve this may be the following. The idea would be
to just check if the index_file changed basically using the same
heuristic we already use to detect file changes.  (use the stat data,
mtime, size, etc.)

With this code we do not rely on the crc sums to check if the index
needs to be re-read anymore and don't have a problem if part of the
index changes, after we read it (we know the index changed from its
mtime and can just re-read it).  Another thing that would have to
change is that we can't use die if a crc is wrong, but some return
code, but that shouldn't be a problem.  I'm not sure I'm not missing
something here though.

do {
	fd = open()
	fstat(fd, &st_old);
	mmap = xmmap(fd);
	verify_various_fields(mmap);
	istate->ops->read_index(istate,
				mmap,
				mmap_size));
	fstat(fd, &st_new);
	close(fd);
} while (stat_data_doesnt_match(st_old, st_new));
