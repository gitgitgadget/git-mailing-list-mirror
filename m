From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Locking binary files
Date: Tue, 23 Sep 2008 17:44:46 +0400
Message-ID: <20080923134446.GM21650@dpotapov.dyndns.org>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com> <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mario Pareja <mpareja.dev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 15:46:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki8DJ-0005MJ-Vh
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 15:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbYIWNox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 09:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbYIWNox
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 09:44:53 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:42228 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbYIWNow (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 09:44:52 -0400
Received: by ik-out-1112.google.com with SMTP id c30so1182326ika.5
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FQKun+g++wT0WlJEAKb1miGCQfnjZ/0YS2z+mDNj3MQ=;
        b=B/COmX7FkD9IJhK/tE4V4IdBV1mjLY0F/DL12v6L4jBt8p+ozFiiyMxWt64F6lD67i
         pb90bIv/sZ4rRqjlMFj8kPXp+MJ5oZlXyt8qBqrOE/dDIMMkSm5X+SKw7qpbhyFAHhjd
         e2/NleErLT+zyxjkiRzHmEPHvS87mgnIj1b/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a83WK8jfoF+XjaUZLiXrryevwhGsyYISX2+bWD1S+4VDDwFTjjMkgymUvgOP0mZR9n
         eCRsIY4JxDRMSv5BrwpkcS68g8dlhWfWWe4NUqxkXK2U/ea8YHJSBWn3vrAnOP3moKfE
         jYYqcZSh6QDl9Wkr3BfKm72lnvlhqibIpKTfA=
Received: by 10.210.37.16 with SMTP id k16mr1852359ebk.131.1222177490398;
        Tue, 23 Sep 2008 06:44:50 -0700 (PDT)
Received: from localhost (ppp85-141-151-27.pppoe.mtu-net.ru [85.141.151.27])
        by mx.google.com with ESMTPS id 23sm2375308eya.7.2008.09.23.06.44.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 06:44:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96561>

On Tue, Sep 23, 2008 at 02:39:41AM -0400, Mario Pareja wrote:
> 
> How else can one developer be sure that time spent editing a
> binary file will not be wasted because another developer submitted a
> change?

That sounds to me more like a communication problem than anything
related to Git itself.

> 
> To achieve the effects of locking, a "central" repository must be
> identified.  Regardless of the distributed nature of git, most
> _companies_ will have a "central" repository for a software project.
> We should be able to mark a file as requiring a lock from the
> governing git repository at a specified address.  Is this made
> difficult because git tracks file contents not files?

The problem exists regardless the distributed nature of git. Let's
consider a single repository with only two branches: A and B. Now, one
developer has decided to edit some binary file called pretty.img on A.
Should this file be locked only on the branch A or on both branches? The
answer is if A is going to merge to B then this file on B too and remain
locking till A is merged to B. In fact, it may be *absolutely* pointless
to lock the file on the developer's topic branch, because another
developer can edit it on another topic branch without noticing that this
lock exists at all. So, it may be enough to lock it only B enough, but
this is impossible to Git to know, because Git does not understand
_your_ particular workflow, and without any locking scheme is rather
meaningless.

Perhaps, a more general solution can be based exactly on the content,
not on the name, i.e. in some share directory on the server I create
a file with name based on SHA-1 of the binary file where I put comment
explaining why I locked it. Obviously, this lock is purely advisory,
but it is good, in some situation you really may want to edit two
files with the same SHA-1 on different branches that never get merge.
Moreover, this lock is never deleted. So, it could make sense instead
of having a separate file per lock to organize it in some more compact
storage, which may look like history of editing binary files... But it
is just an idea how I would do that.

Dmitry
