From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH] revert: Implement --abort processing
Date: Wed, 1 Jun 2011 14:00:06 -0500
Message-ID: <20110601190006.GB9730@elie>
References: <1306944446-11031-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 21:00:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRqeW-0003qB-FW
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 21:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759293Ab1FATAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 15:00:16 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33345 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759187Ab1FATAP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 15:00:15 -0400
Received: by gyd10 with SMTP id 10so46830gyd.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1xdYRPlBqDcHj3jFxZNUKPnVe3FhyYljTvaJ8Hqq64c=;
        b=aBy89YaaT/OqHFfU1XcGXhqEY8i0l6BaYunafmz5UDdL9olJizTVNsJ/PsEU4gXrOs
         CHcVdho865kFZFBFglr4ibwexRPgcdDqnwFCC07NU6cCt053XDtSwd/UUEabrt6sAvDm
         1G6/BVnrHWYHQvqkUJk3tHF4lw+1Fm0ehPyB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MI2ytYT3pB8LhBehz8F+fK8EdXPe393OTj7It5Th0siLVwHJ3P5wYmLj6QH6TWTj6u
         8eSUfhyE8+vNjWFkuDV9QaHSd8DJKncrptOgmKoJUgvRz9p+YaHj+OHDdn/TbwWr8S/u
         odluFPafVi64z/d4Oj/GGGdPKoGMqrhZsYUTI=
Received: by 10.150.183.3 with SMTP id g3mr6302784ybf.264.1306954814547;
        Wed, 01 Jun 2011 12:00:14 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.sbcglobal.net [69.209.65.98])
        by mx.google.com with ESMTPS id t4sm326655ybe.27.2011.06.01.12.00.12
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 12:00:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1306944446-11031-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174891>

Ramkumar Ramachandra wrote:

> To abort, perform a "rerere clear" and "reset --hard" to the ref
> specified by the HEAD file introduced earlier in the series.

The above doesn't explain why, so it makes it harder to answer:

>  Should I be
>  re-implementing "reset --hard" like this?

So I'll try to fill in the blanks.  Wouldn't it be better to call
"reset --merge" code?  That is what "git merge --abort" does.

Let's consider an example.

Suppose I have run "git cherry-pick foo" and run into a conflict.  Now
I start to fix things up the way I like, but I suddenly realize that
the cause was cherry-picking the wrong commit; it's better to start
over and do that.  So I try to abort.

I have some changes to files that did not participate in the automatic
cherry-pick:

 1. for unrelated reasons, I bumped the version number in the Makefile
 as a reminder not to forget later, without commiting it or marking
 with "git add";

 2. I (manually) moved a declaration to a different header file to
 reflect differences between the codebase at the time of foo^ and HEAD,
 to get it to compile.  Which works, so I mark it with "git add" for
 incorporation into the corrected cherry-pick commit.

With "git reset --merge", (1) is left alone, while (2) is backed out,
unmerged entries are of course clobbered, and hazy cases in which I
make some changes, "git add", and then make more changes without "git
add" cause the operation to error out.  It would be nicer if git could
read my mind, but at first glance this seems like an okay second-best.

Are there other considerations or situations that would lead to a
different conclusion?  (Not a rhetorical question.)

Hope that helps,
Jonathan
