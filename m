From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 14:55:26 -0600
Message-ID: <20101207205526.GA25008@burratino>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <20101207162358.GT355@fearengine.rdu.redhat.com>
 <20101207174520.GB21483@burratino>
 <20101207175418.GU355@fearengine.rdu.redhat.com>
 <20101207180236.GC21483@burratino>
 <7vfwu9pbyj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Casey Dahlin <cdahlin@redhat.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 21:55:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ4Zc-0000yf-3h
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 21:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103Ab0LGUzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 15:55:39 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35310 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073Ab0LGUzi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 15:55:38 -0500
Received: by wyb28 with SMTP id 28so335643wyb.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 12:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QnOcZH5N9D9E+h3dnyQmLKc5X6JJMDcLBc4Y3hnErMM=;
        b=ddDz61R2UKx9GFlmcW+YcSftoMKvU8xtgAsz+zm4uyeimyanXiKDlEwgZSGyPFXoxX
         pJoOHqX3fYSK5dZs4qopeZjeBMF4USvShICSHIervJ8ycNHOzvgV8D4oWwsIn2t6vWRn
         Ym80D6mvrxq9k7fZN/5T6+GKK5u3JZt3jSLpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pWVZax2TNlvoTSr4FtW0CClKDkN3i9nRFWqhYavVp69Ulc27Vt+GEOH0egzaCR7PEK
         rKIkadD1BqSLX1NEy9/TvZ5+ewSUe0+Bhc8PYGgSQDsKXM0D22cA5GnHntwFQktiVlg3
         T/tdFhr4tU26nRKEr/GiOsozYUGZQfY0wbA/M=
Received: by 10.227.129.71 with SMTP id n7mr7896792wbs.128.1291755337611;
        Tue, 07 Dec 2010 12:55:37 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id f35sm4565101wbf.2.2010.12.07.12.55.35
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 12:55:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vfwu9pbyj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163130>

Junio C Hamano wrote:

> "git log -g HEAD"
> keeps track of what was at the tip of HEAD, be it pointing at a branch or
> pointing diretly at a commit in a detached state, no?

Yes.

1. Imagine I have an interesting branch and delete it:

	$ git branch interesting $(lots of hard work)
	$ git branch -D interesting

Oops.  If I want to recover that branch, I may have a lot of digging
to do in the HEAD reflog.  It may not be there are all.  Your patch
mitigates that by allowing a simple "I didn't mean that" command.

	$ git branch --undelete interesting

2. Great.  Another way to lose a line of development, as Casey
mentioned, is to not give it a branch name in the first place:

	$ git checkout HEAD^0
	...
	$ git checkout something-else

Oops.  Well, not so bad.  If I want to recover my old work, I can
simply use

	$ git checkout HEAD@{1}

3. Now suppose I was not paying attention and made the mistake
from (1) or (2) a week ago and didn't realize it.  Now I want to
get back that code.

If it was situation (1), I can remember the name of the branch
and do

	$ git branch --undelete interesting

No problem [1].  If it was situation (2), I need to dig through the
HEAD reflog.  As Jeff explained, it is possible to script something up
to help organize the search.  I think Casey was suggesting doing that
work at HEAD-reattachment time instead, so you could do

	$ git branch --undelete-detached-head=old-head

to recover the last line of development made without a branch;
my response was that if this ends up frequently being useful
then I suspect something is wrong with the workflow.

Hoping that is clearer,
Jonathan

[1] as long as the branch name was not reused
