From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Use setenv(), fix warnings
Date: Sun, 26 Feb 2006 20:37:56 +0200
Message-ID: <20060226203756.05dcfb26.tihirvon@gmail.com>
References: <20060226171346.33ad3e47.tihirvon@gmail.com>
	<7vmzge570u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 19:36:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDQl6-0001t4-UI
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 19:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWBZSg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 13:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWBZSg2
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 13:36:28 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:26441 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750951AbWBZSg1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 13:36:27 -0500
Received: by zproxy.gmail.com with SMTP id l1so727537nzf
        for <git@vger.kernel.org>; Sun, 26 Feb 2006 10:36:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=bEOVTAhoi+PB9lQhd+ZeqV9uE246TEAn+FqA79XnrtpodWLtsOMkAXfJGU2b6//FHHTXhAAPvsAakiedLfp4ooHx0+Oe2/qG4+O9SXKw1sx2InEURb+XTAo7Qg7RI0VDy2dDWa43WCeRt9QHmXSyx3gVSBQVzDorVlAS1KVmU6o=
Received: by 10.65.183.18 with SMTP id k18mr4458041qbp;
        Sun, 26 Feb 2006 10:36:26 -0800 (PST)
Received: from garlic.home.net ( [82.128.228.98])
        by mx.gmail.com with ESMTP id f15sm2556498qba.2006.02.26.10.36.24;
        Sun, 26 Feb 2006 10:36:25 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzge570u.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.12; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16786>

On Sun, 26 Feb 2006 10:06:41 -0800
Junio C Hamano <junkio@cox.net> wrote:

> Timo Hirvonen <tihirvon@gmail.com> writes:
> 
> >   - Use setenv() instead of putenv()
> >   - Fix -Wundef -Wold-style-definition warnings
> >   - Make pll_free() static
> 
> I think the last one makes sense, and I can see why some people
> may prefer -Wundef but I am not sure about the first one.  Care
> to defend why we should prefer setenv()?  IIRC, initially we did
> not use setenv() anywhere because certain platforms only had
> putenv().

I was confused by putenv(3) man page.  I thought it wanted malloc'ed
strings (no 'const' in the parameter -> warning).  It appears that
statically allocated strings are accepted but _automatic_ variables
aren't.  I noticed setenv is now in compat/ so I though it was good idea
to use it.

Sorry for the noise.

> > diff --git a/fsck-objects.c b/fsck-objects.c
> > @@ -483,7 +483,7 @@ int main(int argc, char **argv)
> >  	if (standalone && check_full)
> >  		die("Only one of --standalone or --full can be used.");
> >  	if (standalone)
> > -		putenv("GIT_ALTERNATE_OBJECT_DIRECTORIES=");
> > +		setenv("GIT_ALTERNATE_OBJECT_DIRECTORIES", "", 1);
> 
> For platforms with only putenv we did this; here, what we really
> wanted to do was unsetenv.

putenv(3):
    "If the argument `string` is of the form `name`, and does not
    contain an `=' character, then the variable `name` is removed from
    the environment."

So the variable is emptied, not removed.  But usually empty environment
variables are treated as if they didn't exist...

-- 
http://onion.dynserv.net/~timo/
