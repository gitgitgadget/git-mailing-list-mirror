From: "James Sadler" <freshtonic@gmail.com>
Subject: Re: git filter-branch --subdirectory-filter
Date: Sat, 10 May 2008 13:31:37 +1000
Message-ID: <e5e204700805092031m14c3d6c2kb85b51af5a1ee8f7@mail.gmail.com>
References: <e5e204700805081801x314b02bek5d53a086b02dac83@mail.gmail.com>
	 <20080509013300.GA7836@sigill.intra.peff.net>
	 <e5e204700805090038k373bbabcyfb10d8c93ec5b3a7@mail.gmail.com>
	 <20080509080039.GA15393@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 10 05:32:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JufpM-000309-L3
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 05:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbYEJDbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 23:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbYEJDbk
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 23:31:40 -0400
Received: from hs-out-0708.google.com ([64.233.178.246]:22728 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbYEJDbi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 23:31:38 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1111312hsl.5
        for <git@vger.kernel.org>; Fri, 09 May 2008 20:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=EoVxM9O6v0CV3la7LAtusC82KXylygCkfbI0YKdaaMY=;
        b=vorI8wj0BlRwJ2lO0tDGTUVeX3Shtk7pgJD43OU0ZR6nksjKZrMNUVzkgxvqW1kpiuBO2ZSATVLWGtFInJmwZiFrTYygjOU83Ig2AXDZj18HvlXMy/15+S1yiszZDoDRNFz+OEW24Gb8dnSqOpd1TzgyBWCEyBpVV8tIn56tMZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HHAmVDx/iL6+sHbV/KLsyrAeccYaN6eAELYHB2nWFwX/SOfJsAT9Vea7TJKQ0AF770F5G9jVlePk5y2eNiJEMNMt8oM1Tv996FERuqs5Qkwkvur7aosMSyd2Cc8fDYpBvIFSmhdnHun0H775cLvpLe9M/dXFoVl+y1VscasjaVo=
Received: by 10.90.29.13 with SMTP id c13mr7513282agc.14.1210390297702;
        Fri, 09 May 2008 20:31:37 -0700 (PDT)
Received: by 10.90.114.9 with HTTP; Fri, 9 May 2008 20:31:37 -0700 (PDT)
In-Reply-To: <20080509080039.GA15393@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81643>

2008/5/9 Jeff King <peff@peff.net>:
> On Fri, May 09, 2008 at 05:38:12PM +1000, James Sadler wrote:
>
>> I originally tried --subdirectory-filter by itself to see if it would
>> do the job, but it filtered more commits than I thought it should
>> (some commits that touched the subdir were missing after filter-branch
>> was run).
>>
>> I then began to question my understanding of the semantics of
>> subdirectory-filter.
>>
>> Is it meant to:
>> A) Only keep commits where ALL of the changes in the commit only touch
>> content under $DIR?
>> B) Only keep commits where SOME of the changes in the commit touch
>> content under $DIR?
>>
>> I suspected that it was behaving as A.
>
> My understanding is that it should behave as B. E.g.:
>
>  git init
>  mkdir subdir1 subdir2
>  echo content 1 >subdir1/file
>  echo content 2 >subdir2/file
>  git add .
>  git commit -m initial
>  echo changes 1 >>subdir1/file
>  git commit -a -m 'only one'
>  echo more changes 1 >>subdir1/file
>  echo more changes 2 >>subdir2/file
>  git commit -a -m 'both'
>  git filter-branch --subdirectory-filter subdir1
>  git log --name-status --pretty=oneline
>
> should show something like:
>
>  b119e21829b6039aa8fe938fb0304a9a7436b84d both
>  M       file
>  db2ad8e702f36a1df99dd529aa594e756010b191 only one
>  M       file
>  dacb4c2536e61c18079bcc73ea81fa0fb139c097 initial
>  A       file
>

Behaving as B is definitely the desired behaviour, but I am not observing that.
I'll see if I can create a test case to demonstrate.  Unfortunately,
I don't have the right to distribute our repo so will have to attempt
to reproduce the
problem another way.

Does anybody have a script that can take an existing repo,
and create a new one with garbled-but-equivalent commits?  i.e.  file
and directory structure
is same with names changed, and there is a one-one relationship
between lines of text
in new repo and old one except the lines have been scrambled?  It would be
a useful tool for distributing private repositories for debugging reasons.

> IOW, all commits touch subdir1/file, which becomes just 'file'.
>
> It could be a bug in git-filter-branch. What version of git are you
> using?

I am using git version 1.5.5

>
> -Peff
>

-- 
James
