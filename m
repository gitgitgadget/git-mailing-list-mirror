From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] git-log vs git-rev-list performance
Date: Sat, 29 Dec 2007 10:51:39 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712291038560.2778@woody.linux-foundation.org>
References: <e5bfff550712290418h22d7f7edqda519e7f4dcd25b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 19:52:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8gnB-0005k7-QW
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 19:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039AbXL2Svu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 13:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755011AbXL2Svu
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 13:51:50 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33544 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754796AbXL2Svt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Dec 2007 13:51:49 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBTIpfhe025760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 29 Dec 2007 10:51:42 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBTIpdVk006191;
	Sat, 29 Dec 2007 10:51:39 -0800
In-Reply-To: <e5bfff550712290418h22d7f7edqda519e7f4dcd25b8@mail.gmail.com>
X-Spam-Status: No, hits=-3.217 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69323>



On Sat, 29 Dec 2007, Marco Costalba wrote:
>
> [marco@localhost linux-2.6]$ time git log --topo-order --no-color
> --parents --boundary -z --log-size
> --pretty=format:"%m%HX%PX%n%an<%ae>%n%at%n%s%n%b" HEAD > /dev/null

Don't compare "--pretty=format" to the pre-formatted versions.

Use "--pretty=raw" for "git log" if you want to approximate "git 
rev-list --header". 

Or alternatively use the same "--pretty=format:" for git-rev-list.

If you start using anything else, you only have yourself to blame. OF 
COURSE it's more expensive to pretty-format the messages.

I get

	[torvalds@woody linux]$ time git rev-list \
		--pretty=format:"%m%HX%PX%n%an<%ae>%n%at%n%s%n%b" \
		--topo-order --parents --boundary --header \
		--log-size HEAD	> /dev/null

	real    0m1.596s
	user    0m1.556s
	sys     0m0.040s

	[torvalds@woody linux]$ time git log \
		--pretty=format:"%m%HX%PX%n%an<%ae>%n%at%n%s%n%b" \
		--topo-order --parents --boundary \
		--log-size HEAD > /dev/null

	real    0m1.597s
	user    0m1.548s
	sys     0m0.048s

so I'd say that with the same output, the timings are pretty much the 
same (except "git log" is more capable - "--log-size" does nothing for 
"git rev-list", for example).

But if you ask for different formats, they'll have different performance, 
even if you then use the same command (ie "git log" will be slower than 
"git log" depending on the command line arguments!)

		Linus
