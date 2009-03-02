From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Mon, 02 Mar 2009 14:12:32 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0903021404000.17877@perkele.intern.softwolves.pp.se>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
 <49ABB529.1080500@viscovery.net>
 <alpine.DEB.2.00.0903021137110.17877@perkele.intern.softwolves.pp.se>
 <49ABD24B.5060005@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 02 14:14:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le7y9-0001MG-0v
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 14:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbZCBNMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 08:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbZCBNMh
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 08:12:37 -0500
Received: from smtp.getmail.no ([84.208.20.33]:57696 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837AbZCBNMh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 08:12:37 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KFV00901RCYQS00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 14:12:34 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFV00ISORCWKA10@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 14:12:32 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFV00IBORCWSVB0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 14:12:32 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 0D1A62FC03; Mon,
 02 Mar 2009 14:12:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 0A3E02FC02; Mon, 02 Mar 2009 14:12:32 +0100 (CET)
In-reply-to: <49ABD24B.5060005@viscovery.net>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111937>

Johannes Sixt:

> Can you set the local codepage per program? (I don't know.)

The locale is set per thread, and gets reset when the program exits. So 
setting the codepage to UTF-8 before outputting should work. That should 
also work for displaying the log to the terminal if you have UTF-8 log 
messages.

Converting it to wchar_t and using wprintf and similar should be safer, 
though (and I have no idea what happens if you try to pipe the output to 
something else).

> - What encoding should 'ls-files' use for its output? Certainly not always 
> UTF-8: stdout should use the local code page so that the file names are 
> interpreted correctly by the terminal window (it expects the local code 
> page).

That is exactly why trying to mix "protocol" data ("plumbing" in Git's case) 
and user output will always come back and bite you, one way or another. I 
haven't really the faintest how pipes work with Unicode on Windows. 
Somewhere along the line there will probably be some conversions, which 
would cause interesting issues.

Better not use pipes, then. Heh. I sense that there is a slight problem with 
the architecture of Git and trying to get it to behave on Windows... :-)

> - What encoding should 'update-index' expect from its input? Can you be 
> sure that other programs generate UTF-8 output?

Theoretically, if all the internal stuff is hacked around to output Unicode, 
and the thread codepage is set up to use UTF-8, it should "just work". And 
if run directly from the shell, it should still be converted to whatever the 
system is set up to emit. That would mean, however, that a Git program that 
internally runs

   git-foo | git-bar | git-gazonk

might behave differently compared to if a user would enter it on the 
command-line.

-- 
\\// Peter - http://www.softwolves.pp.se/
