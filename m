From: Pete Wyckoff <pw@padd.com>
Subject: Re: is git-p4 compatible with p4/linux?
Date: Fri, 19 Apr 2013 07:55:13 -0400
Message-ID: <20130419115513.GA7966@padd.com>
References: <7BF81DF9-941D-400B-8304-6DA5F5C82D4F@aivor.com>
 <20130419000947.GB9048@padd.com>
 <14D98038-C656-47B9-ABF2-CC12914F0C75@aivor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Tomlinson <alex@aivor.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 13:55:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT9uY-0006JG-Bo
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 13:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968301Ab3DSLzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 07:55:18 -0400
Received: from honk.padd.com ([74.3.171.149]:39423 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968123Ab3DSLzR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 07:55:17 -0400
Received: from arf.padd.com (unknown [50.55.134.154])
	by honk.padd.com (Postfix) with ESMTPSA id 310743362;
	Fri, 19 Apr 2013 04:55:16 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 08CF02D191; Fri, 19 Apr 2013 07:55:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <14D98038-C656-47B9-ABF2-CC12914F0C75@aivor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221760>

alex@aivor.com wrote on Thu, 18 Apr 2013 20:34 -0500:
> Perhaps it is a configuration item on the server and/or client.   It seems we
> are running the same version of p4.  But just to be sure, check yours against
> mine:
> 
> $ cksum $(which p4)
> 3254530484 2420552 /usr/bin/p4
> 
> If yours if different, can you email a copy of your p4 executable to me
> so I can check if it works differently than mine?

It is the same binary.  Assuming you're running p4d 2013.1 too?

    $ p4 info
    [..]
    Server version: P4D/LINUX26X86_64/2013.1/610569 (2013/03/19)

I'm using these p4 client settings:

    Options:        noallwrite noclobber nocompress unlocked nomodtime normdir
    SubmitOptions:  submitunchanged
    LineEnd:        unix

Running "strace -vf -s 2000 p4 print -q symlink" shows that the
newline is embedded in the response from p4d:

    read(7, "...\0\0\0symlink-target\n\0func\0\23...", 4096) = 277

Also the file depot/symlink,v in the p4d depot area includes the
\n in the RCS file too, somewhat surprisingly:

    $ cat depot/symlink,v
    head     1.6;
    [..]
    @@
    text
    @symlink-target
    @

> I will also check with coworkers here to see how their client behaves.
> > This code only happens on utf16 files.  But running it by hand,
> > I cannot reproduce the different behavior:
> > 
> >    $ p4 print -q //depot/f-ascii
> >    three
> >    line
> >    text
> > 
> >    $ p4 print -o - -q //depot/f-ascii
> >    three
> >    line
> > 
> >    $ ls ./-
> >    ls: cannot access ./-: No such file or directory
> > 
> > I'm again confused.  Any hints you can give would be helpful.
> 
> This "second issue" is a non-issue.  It seems "-o -" does send to
> stdout for files.  For symlinks, it creates a symlink named "-".
> Example:
> 
> $ ls -l pcre
> lrwxrwxrwx 1 atomlinson atomlinson 12 Apr 18 17:17 pcre -> ../libs/pcre/
> $ ls -l ./- ./xxx
> /bin/ls: cannot access ./-: No such file or directory
> /bin/ls: cannot access ./xxx: No such file or directory
> $ p4 print -q -o - pcre
> $ p4 print -q -o xxx pcre
> $ ls -l ./- ./xxx
> lrwxrwxrwx 1 atomlinson atomlinson 12 Apr 18 20:25 ./- -> ../libs/pcre/
> lrwxrwxrwx 1 atomlinson atomlinson 12 Apr 18 20:25 ./xxx -> ../libs/pcre/

Me too.  That's annoying behavior, but not used by git-p4 fortunately.
The "-o -" option is only used for odd utf16 files where "p4 print"
generates invalid output.

		-- Pete
