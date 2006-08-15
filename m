From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] use appropriate typedefs
Date: Tue, 15 Aug 2006 10:19:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608151000350.26891@chino.corp.google.com>
References: <Pine.LNX.4.63.0608142305290.23445@chino.corp.google.com>
 <7vveou8myg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 19:19:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD2Zo-0000hp-Mb
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 19:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWHORTh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 13:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWHORTh
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 13:19:37 -0400
Received: from smtp-out.google.com ([216.239.45.12]:58833 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030391AbWHORTg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 13:19:36 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id k7FHJSUj008801;
	Tue, 15 Aug 2006 10:19:28 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=Hhk9KfqTTSs23NnMgYRBdqJC54E2FEE9IfPPtmswoLCe2RH3q9qKxHGXBSuag9Zu2
	egRMFz3N/OhhZ3CP3ivog==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps75.corp.google.com with ESMTP id k7FHJGWC006891;
	Tue, 15 Aug 2006 10:19:16 -0700
Received: by localhost (Postfix, from userid 24081)
	id BF11987D71; Tue, 15 Aug 2006 10:19:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 6D2F887D70;
	Tue, 15 Aug 2006 10:19:16 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vveou8myg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25466>

On Tue, 15 Aug 2006, Junio C Hamano wrote:
> > diff --git a/builtin-apply.c b/builtin-apply.c
> > index be2c715..2862eb1 100644
> > --- a/builtin-apply.c
> > +++ b/builtin-apply.c
> > @@ -2097,7 +2097,7 @@ static void create_one_file(char *path, 
> >  	}
> >  
> >  	if (errno == EEXIST) {
> > -		unsigned int nr = getpid();
> > +		pid_t nr = getpid();
> 
> Since mkpath() is vararg, doesn't this make it necessary to cast
> its parameter several lines down?
> 

No, it is not necessary in the sense that any of these changes in this patch are 
necessary.  But since getpid() returns pid_t, every assignment should be cast as 
such.  pid_t can be typed as a short.

> > diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
> > index 215892b..6fed919 100644
> > --- a/builtin-tar-tree.c
> > +++ b/builtin-tar-tree.c
> > @@ -361,8 +361,8 @@ static const char *exec = "git-upload-ta
> >  
> >  static int remote_tar(int argc, const char **argv)
> >  {
> > -	int fd[2], ret, len;
> > -	pid_t pid;
> > +	int fd[2], len;
> > +	pid_t pid, ret;
> 
> Hmph.  You might have made finish_connect() to return pid_t so
> making "ret" of that type is consistent with that change, but it
> also gets return value from copy_fd() -- which is "did we error
> out?"  This part smells funny...
> 

I did make finish_connect return pid_t, so it is consistent.  Changing the use 
of ret is beyond the scope of a patch that changes types to typedefs.

> > diff --git a/connect.c b/connect.c
> > index 4422a0d..a4c02d1 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -735,9 +735,9 @@ int git_connect(int fd[2], char *url, co
> >  	return pid;
> >  }
> >  
> > -int finish_connect(pid_t pid)
> > +pid_t finish_connect(pid_t pid)
> >  {
> > -	int ret;
> > +	pid_t ret;
> 
> This function wants to wait for the given process and return
> zero on success otherwise the caller takes it as a sign for
> failure.  Most existing callers do not check the return value,
> which should be cleaned up, but we always call it with specific
> pid, not wildcard values like 0 or -1, so returning pid_t to say
> which child exited does not add value to the interface.  Please
> leave its function signature (and one of the callers,
> remote_tar() you changed above) as it is.
> 

Please cite where this function is specified to return zero on success and not 
the return value of waitpid which, after all, is the only assignment to the 
return value.  waitpid only returns when the status of the child is available or 
an error has occurred as a result of an interrupt.  The correct interface, in my 
opinion, for this function is to return what waitpid returns and allow it to 
indicate the pid of the child or interrupt to the caller.  The signature now 
suggests that.  If Linus did indeed write this, he did so to spin until the 
status of the child was known.

		David
