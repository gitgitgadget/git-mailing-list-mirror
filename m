From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] cleans up builtin-mv
Date: Fri, 18 Aug 2006 10:07:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608180956100.29405@chino.corp.google.com>
References: <Pine.LNX.4.63.0608172230470.25827@chino.corp.google.com>
 <Pine.LNX.4.63.0608172301520.25827@chino.corp.google.com>
 <Pine.LNX.4.63.0608181137000.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 19:07:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE7oq-0004Cf-3l
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 19:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWHRRHg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 13:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWHRRHg
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 13:07:36 -0400
Received: from smtp-out.google.com ([216.239.45.12]:32477 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964831AbWHRRHf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 13:07:35 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id k7IH7UMH006192;
	Fri, 18 Aug 2006 10:07:30 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=RRU1EMTtNe3Kh+8HuV64uRCB0DKsC8KEmmN10H47ecSNbLl4jwyolAzFB4nkIsqG0
	kvHsr0B7e0DtXMg1dyVhQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps75.corp.google.com with ESMTP id k7IH7PDL007624;
	Fri, 18 Aug 2006 10:07:25 -0700
Received: by localhost (Postfix, from userid 24081)
	id 642D587D71; Fri, 18 Aug 2006 10:07:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 2128987D70;
	Fri, 18 Aug 2006 10:07:25 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608181137000.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25681>

On Fri, 18 Aug 2006, Johannes Schindelin wrote:

> First, it _was_ a perl script, which you probably could find out by 
> checking your old git.
> 
> Second, it was rewritten to use Git.pm, and because _that_ did not work, 
> git-mv was rewritten as a builtin.
> 

It shouldn't have ever been a perl script, it should have been /bin/sh.  
Any shell implementation of this would be significantly faster than the 
current implementation.

> Not slower? I beg to differ, admitting it is only a few percent. But your 
> statement is obviously uncorrect.
> 

It _is_ slower since it takes considerably more time to do its job than 
any corresponding shell script.

> Well, the patch has an improvement factor of almost none. I actually read 
> the patch, and asked myself: why would anybody fix a non-problem?
> 

Because it's _wrong_.  Secondly, it's WRONG.

> > For example:
> > 	(length = strlen(source[i])) >= 0
> 
> Yes. Taken out of context, this sure sounds silly.
> 
> What you cleverly did not mention: It was inside a
> 
> 	if (!bad &&
> 		(length = strlen(source[i])) >= 0 &&
> 		!strncmp(destination[i], source[i], length) &&
> 		(destination[i][length] == 0 || destination[i][length] == '/'))
> 
> construct. So, we assign the "length" variable only if we have to. And the 
> ">= 0" trick is a common one. I could have done
> 		

This is not a plausible justification _at all_.  The idea that "length" is 
assigned only on the condition that lstat(path, ...) failed does not 
justify its comparison to >= 0 since this comparison is always true, nor 
does it justify the assignment of

	char *dir = source[i];
	int len = strlen(dir);

later.

> > strlen(source[i]) was assigned to a variable later in the function, this 
> > time called "len" instead.
> 
> Only if source[i] is a directory. So again, we only do it when we need to.
> 

You're completely ignoring the point, and more importantly, ignoring the 
code path.  Your implementation would have _always_ assigned 
strlen(source[i]) to "length" if lstat returned 0.  So at this point in 
the code, "length" is always equal to strlen(source[i]).  But your code 
introduces another call to strlen, another variable, and another 
assignment.

> Having said that, I do not have anything against the patch being applied, 
> but if I see more of these i-would-like-the-cupboard-here-not-there 
> patches, I will just not review them any more.
> 

My patch is correct and improves your code.  Any criticism for such a 
patch has purely personal motives, and not technical motives, assigned to 
it.

		David
