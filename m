From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: new cvsps version fixes issues for cvs2git
Date: Wed, 25 May 2005 21:20:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505252111580.2307@ppc970.osdl.org>
References: <42954A6D.6020503@cobite.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Thu May 26 06:18:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db9no-0006pl-Gl
	for gcvg-git@gmane.org; Thu, 26 May 2005 06:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVEZESt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 00:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVEZESt
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 00:18:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:24804 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261191AbVEZESr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 00:18:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4Q4IejA023184
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 25 May 2005 21:18:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4Q4IdRe001482;
	Wed, 25 May 2005 21:18:39 -0700
To: David Mansfield <david@cobite.com>
In-Reply-To: <42954A6D.6020503@cobite.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 26 May 2005, David Mansfield wrote:
> 
> 4) patchset date/time problems.  the date/time handling was bogus.  some 
> of it was patched for some time in my tree, but not released.  also we 
> now report all dates in LOCALTIME.  use the TZ variable to get a 
> different time.  Note: 'cvs log' format is always UTC.
> 
> Linus, based on #4, you may want to set 'export TZ=UTC' before running, 
> and handle date/time conversion in cvs2git counting on that.  otherwise, 
> I think problems may occur with daylight savings (apr/oct).

cvs2git only wants UTC times, and doesn't do any conversion, since that's
the native git format (git considers all times to be UTC, but also records
a "what timezone was the thing done in" so that if you want to, you can
print it out not in localtime, but in "localtime as it was for the
committer"). Nothing else really makes sense - it's totally senseless to 
print it out as "in localtime of user".

Since the CVS information doesn't contain any timezone, it would be bogus
to use one, and the only sane git conversion is to always use UTC. Using 
the timezone of the converter is also bogus, since that just makes 
different converters get different results.

So I'd much rather see you add a flag that just always does the native CVS
time (ie UTC)?  Quite frankly, it's wrong to do anything else, exactly
because it makes no sense to print out dates in a timezone that has no
relevance (what relevance does Pacitic time have for somebody who
committed something at 8AM Eastern? _None_).

The fact is, if we depend on people doign "TZ=UTC", people will forget, 
and then people will have different conversions.

(My personal preference would be to _default_ to UTC, and instead have a
special flag that says "use localtime to print stuff out", since 
localtime really is the least relevant one most of the time)

			Linus
