From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH 2/3] Support for partial HTTP transfers
Date: Tue, 27 Sep 2005 08:36:36 -0700
Message-ID: <20050927153636.GA1377@reactrix.com>
References: <20050926175204.GC9410@reactrix.com> <7vd5mvedcs.fsf@assigned-by-dhcp.cox.net> <20050927000931.GA15615@reactrix.com> <7vfyrr3vwp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 17:41:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKHVl-00015B-7b
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 17:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVI0Pgv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 11:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbVI0Pgv
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 11:36:51 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:16857 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964975AbVI0Pgu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 11:36:50 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8RFabhb001585;
	Tue, 27 Sep 2005 08:36:37 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8RFaam3001583;
	Tue, 27 Sep 2005 08:36:36 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyrr3vwp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9400>

On Mon, Sep 26, 2005 at 10:46:30PM -0700, Junio C Hamano wrote:

> I think (O_CREAT|O_EXCL) in your code can be easily defeated by
> this sequence:
> 
>     one                 	two
> 
>     unlink prevfile
>     rename tmpfile, prevfile
>     unlink tmpfile
>     local = open tmpfile
>                                 unlink prevfile
>                                 rename tmpfile, prevfile
>                                 unlink tmpfile
>                                 local = open tmpfile
>                                 prevlocal = open prevfile
>     write local
>                                 copyfile prevlocal, local
>     write local
> 				???

The way I understand this sequence, one and two will not be writing to
the same file.  When two unlinks tmpfile, one will still be able to 
write to its local, but the body of the file that one is writing will
be removed when it closes local.

> Not that I think the multiple instances should be prevented at
> this low level --- if they stomp on each other at this level, it
> is very likely the they are doing duplicated work on the network
> side as well, and should be prevented from doing so at much
> higher level than this, I think.  That's why I said I do not
> mind BKL upfront in git-fetch.sh.

True, is that something I should include with the partial patch?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
