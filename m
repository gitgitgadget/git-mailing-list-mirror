From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn failure when symlink added in svn
Date: Sat, 28 Apr 2007 11:13:06 -0700
Message-ID: <m2odl8fjv1.fsf@ziti.fhcrc.org>
References: <m2647zh2zc.fsf@gmail.com> <20070414201003.GA28389@muzzle>
	<m2slb1c8ps.fsf@fhcrc.org> <loom.20070427T005115-751@post.gmane.org>
	<alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org>
	<loom.20070428T144858-521@post.gmane.org>
	<7virbgjthr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Klink <ak-git@cynops.de>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 28 20:14:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhrRT-0000Mw-BW
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 20:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163431AbXD1SNx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 14:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163301AbXD1SNf
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 14:13:35 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:54012 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163300AbXD1SNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 14:13:11 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1518719nzf
        for <git@vger.kernel.org>; Sat, 28 Apr 2007 11:13:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=DqEP7AFK6tj/o6d1kIgelLU3swIdrPmqgcuZaL5eKpQnk2HJCXIDQusqfGDO2iUIndXnqOlBc5bSh7LJs2XG8KA2Gw56pIbujuknylU0yEHVk2nTRWiYQfV0xGe8SIFLN1/xoU6UFg4FsyFn7i3aiFfverV8iOhE0fJFKLHarhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=GoaGN2vMOOkqVkeQo8m0KE5qwGW/q8h5hn0uFqO2dDspO+f6q7HfcORPeTwGpAgOOjlM4E9HOQMD4JJYpwCusHRz0Q9dAqTgStPqp7AQydwTfKAureNr7UDsg645YMp9+hPkIANpODEhxM/c7mmHh+IESBNhtRIH2veRUM/m/lI=
Received: by 10.115.58.1 with SMTP id l1mr1425462wak.1177783990410;
        Sat, 28 Apr 2007 11:13:10 -0700 (PDT)
Received: from ziti.fhcrc.org ( [24.19.44.95])
        by mx.google.com with ESMTP id n20sm2352531pof.2007.04.28.11.13.08;
        Sat, 28 Apr 2007 11:13:09 -0700 (PDT)
In-Reply-To: <7virbgjthr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat, 28 Apr 2007 10:31:28 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45791>

Junio C Hamano <junkio@cox.net> writes:

> Is it really the redirection that is the problem?
>
> The process seeks $fh back to the beginning, reads 5 bytes from
> it (to ensure that is 'link '), and then forks to feed $fh to
> git-hash-object.
>
> Now what do you really want to hash here?  I do not know what
> this "file that begins with 'link '" magic is about, but I
> suspect that the child may or may not start reading from byte
> offset 5 of that file, depending on how the low-level I/O is
> tied to Perl.
>
> Here is a little test script to imitate what the part in
> close_file sub is doing.  What does it output on MacOS (or
> whatever systems that are having the same problem)?
>
> On a Linux box, it appears that it reads the remainder of the
> file and the test script says "child says: >>12345", so I am
> assuming that is what close_file sub wants to do.  If my
> suspicion is correct, you would get "child says: >>link 12345",
> in which case sysseek() commented out below would help,
> perhaps.

On OS X, I get:

    ziti:~/temp seth$ ./perltest1.pl 
    read[5]: link 
    child says: child: at 5

And uncommenting the sysseek call, I get:

    ziti:~/temp seth$ ./perltest1.pl 
    read[5]: link 
    child says: child: at 5
    child says: >>12345

+ seth
