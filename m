From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] cleans up builtin-mv
Date: Fri, 18 Aug 2006 12:01:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608181143040.30274@chino.corp.google.com>
References: <Pine.LNX.4.63.0608172230470.25827@chino.corp.google.com>
 <Pine.LNX.4.63.0608181137000.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0608180956100.29405@chino.corp.google.com>
 <200608182035.47208.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 21:02:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE9be-00050p-PX
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 21:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWHRTBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 15:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWHRTBs
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 15:01:48 -0400
Received: from smtp-out.google.com ([216.239.45.12]:58648 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751476AbWHRTBr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 15:01:47 -0400
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by smtp-out.google.com with ESMTP id k7IJ1fGJ020983;
	Fri, 18 Aug 2006 12:01:41 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=t8oGRJcj1EoaG8a2IjHNGTAWqzQJ/KpDwdeuKNOzD2l/PWE7kxx8OyzH673RNRjKO
	7UpYwh68PGMyOom1TUFQg==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps35.corp.google.com with ESMTP id k7IJ1YrC009812;
	Fri, 18 Aug 2006 12:01:34 -0700
Received: by localhost (Postfix, from userid 24081)
	id 0B7DA87D71; Fri, 18 Aug 2006 12:01:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 0628B87D70;
	Fri, 18 Aug 2006 12:01:34 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200608182035.47208.Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25689>

On Fri, 18 Aug 2006, Josef Weidendorfer wrote:

> Can you explain your reasoning in more detail?
> C compiles to native code. Bash itself first has to
> parse the script. How on earth can this be faster than native code?
> 
> I simply do not understand this discussion about implementation language,
> especially in this case where most of the work is probably done changing
> git's index (the add's and rm's of tree entries). Of course it could have
> been done in /bin/sh, but it wasn't (it started as git-rename.perl).
> 

It's not faster than native code, it's faster than the current 
implementation of builtin-mv.  And when you're working with terabytes of 
data like I am, I would prefer to use something fast.

> Hmm... I suppose Dscho's argument was that this "... >=0" is a standard way
> to code an assignment inside of an expression.
> 

That argument is unjustified since the only advantage of putting it in an 
expression is to not evaluate it if the lstat failed (and not fail by 
means of ENOENT because copy_pathspec guarantees all results have strlen > 
0).  So "length" is set unnecessarily only if lstat fails which should 
never happen if copy_pathspec does it's job with correct arguments.  I'm 
willing to sacrifice that if the _working_ case is faster (and 
significantly faster) especially since this is an iteration and is 
directly tied to the command's speed.

The comparison to 0 simply creates a cmpl $0, x(%ebp) that will always be 
true and a jump to a label that never needed to exist.

Likewise, the additional declaration and initilization of a completely 
redundant case call to strlen slows us down FOR EVERY ITERATION OF THE 
MOVE:
	movl	%eax, x(%ebp)
	movl	(x*2)(%ebp), %eax
	movl	$-1, %ecx
	movl	%eax, (x*4)(%ebp)
	movb	%0, %al
	cld
	movl	(x*4)(%ebp), %edi
	repnz
	scasb
	movl	%ecx, %eax
	notl	%eax
	decl	%eax

And then repeat that same call again because of its miscall later on when 
it's already been assigned to a variable.

		David
